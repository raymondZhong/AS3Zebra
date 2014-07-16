package zebra.data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class GameTexture implements IGameTexture
	{
		private var _bitmapdata:BitmapData;
		private var _maps:XML;
		private var _actionName:Vector.<String>;
		private var _actionBitmapData:Array;
		
		/**
		 * 游戏位图数据
		 * @param	keywords
		 * @param	bmd
		 * @param	maps
		 */
		public function GameTexture(bmd:*, maps:XML)
		{
			if (bmd is Bitmap) {_bitmapdata = Bitmap(bmd).bitmapData;}
			if (bmd is BitmapData){_bitmapdata = bmd;}
			_maps = maps;
			_actionBitmapData = new Array();
			_actionName = new Vector.<String>();
			for (var i:int = 0; i < _maps.SubTexture.length(); i++)
			{
				var name:String = StringCut(_maps.SubTexture[i].@name, 0, _maps.SubTexture[i].@name.length - 4)
				if (_actionName.indexOf(name) == -1)
				{
					_actionName.push(name);
					_actionBitmapData.push(parseActionToTextureAtlas(name));
				}
			}
		}
		
		/**
		 * 是否含有动作名
		 * @param	name
		 * @return
		 */
		public function containActionName(name:String):Boolean {
			return   actionNames.indexOf(name)!=-1;
			}
		 
		/**
		 * 返回所有的动作名
		 */
		public function get actionNames():Vector.<String>
		{
			
			return _actionName;
		}
		
		
		private function parseActionToTextureAtlas(name:String):Vector.<BitmapData> {
				 var nameLen:int = name.length; 
				 var newbd:BitmapData;
				 var textureAtlas:Vector.<BitmapData> = new Vector.<BitmapData>();
			     for (var i:int = 0; i < _maps.SubTexture.length(); i++) 
				 {
					 if (String(_maps.SubTexture[i].@name).length == (nameLen+4) && StringCut(_maps.SubTexture[i].@name, 0, nameLen) == name) {
						 newbd= new BitmapData(_maps.SubTexture[i].@width, _maps.SubTexture[i].@height);
						 newbd.copyPixels(_bitmapdata,
										  new Rectangle(_maps.SubTexture[i].@x, _maps.SubTexture[i].@y, _maps.SubTexture[i].@width, _maps.SubTexture[i].@height),
										  new Point(0, 0));
						 textureAtlas.push(newbd);
						}
				 }
				 
				 return textureAtlas;
			}
		
		
		/**
		 * 图片路径
		 * @return
		 */
		public function get imagepath():String {
			 return _maps.@imagePath;
			}
		
		
		/**
		 * 位图数据
		 */
		public function get bitmapData():BitmapData
		{
			return _bitmapdata;
		}
		
		/**
		 * 位图数据映射
		 */
		public function get maps():XML
		{
			return _maps;
		}
		
		public function getNodeByActionName(actionName:String):XML {
				for (var i:int = 0; i < _maps.SubTexture.length(); i++)
				{
					var name:String = StringCut(_maps.SubTexture[i].@name, 0, _maps.SubTexture[i].@name.length - 4)
					if (actionName == name) {						
						return _maps.SubTexture[i];
						}
				}	
			     return null;
			}
		 
		/**
		 * 根据名字获得位图组
		 * @param	actionName
		 * @return
		 */	
		public function getBitmapsByActionName(actionName:String):Vector.<BitmapData> {
			   var index:int = _actionName.indexOf(actionName);
			   if (index != -1) {
					 return  _actionBitmapData[index];
				   }
				  return null;
			}
			
		private function StringCut(source:String,startpoint:int=0, length:int=1):String {
			   return source.substr(startpoint, length);	
			}
			 
	}

}