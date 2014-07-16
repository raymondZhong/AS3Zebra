package zebraIso.data.map 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import zebraIso.data.IsoBound;
	import zebraIso.data.xmlmapper.Tile;
	import zebra.system.xml.XmlMapper;
	public class IsoMap 
	{
		public var sets:String;
		public var sceneX:int;
		public var sceneZ:int;
		public var node:String;
		private var _map2D:Array;
		public var elements:Vector.<IsoMapElement>;
		public var portal:Vector.<IsoPortal>;
		
		private var _path:String;
		private var _binary:Dictionary;
		
		/**
		 * 编辑器中用来保存map地址
		 * @param	value
		 */
		public function setPath(value:String):void { _path = value; }
		
		public function getPath():String { return _path; }
		public function getBinary():Vector.<Point> {
				var points:Vector.<Point> = new Vector.<Point>();				
					 for (var j:int = 0; j < sceneZ; j++) 
					 {
						 for (var i:int = 0; i <sceneX ; i++) 
						{
							if (_map2D[j][i] == 1)
							points.push(new Point(i, j));
						}
					}
					return points;
			}

		public function IsoMap(map:XML) { 		
			     XmlMapper.bind(this, map);
				 _binary = new Dictionary();
				 _map2D = strToArray2D(node, sceneX, sceneZ);	
			}
		 
		/**
		 * 创建个新地图XML数据
		 * @param	x
		 * @param	z
		 * @return
		 */
		static public function createNewMap(x:int,z:int):XML {
			var data:XML = <map/>
				data.@sets = "";
				data.@sceneX = x;
				data.@sceneZ = z;
				var str:String;	
				for (var i:int = 0; i < x; i++) 
				{
					for (var j:int = 0; j < z; j++)
					{
						if (i == 0 && j == 0) {
								str = "0";
							}else {
								str += ",0";	
							}
					}
				}
				data.@node = str;
				return data;
			}	
			
		/**
		 * 设置地图网格可否通行
		 * @param	bound
		 * @param	iswalkable
		 */	
		public function setWalkable(bound:IsoBound,iswalkable:Boolean):void {
				var mark:int =  iswalkable == false?1:0;
				var i:int;
				var j:int;				
					
				for ( j = bound.topCell.z; j <=bound.bottomCell.z ; j++) 
				{
					for ( i = bound.topCell.x; i <= bound.bottomCell.x ; i++) 
					{
						_map2D[j][i] = mark;
					}
				}
				
				for (j = 0; j <sceneZ; j++) 
				{
					for (i = 0; i <sceneX ; i++) 
					{
						if (i == 0 && j == 0 ) {
							node = String(_map2D[j][i]);
						}else {
							node += "," + _map2D[j][i];
						}
					}
				}
				
			}
	
		/**
		 * 字符串转换成2D数组
		 * @param	str
		 * @param	col
		 * @param	row
		 * @return
		 */
		private function strToArray2D(str:String,col:int,row:int):Array
		{
			var sourceStr:Array = str.split(",");
			var array2D:Array=new Array();
			for (var k:int=0; k<row; k++)
			{
				array2D.push(new Array());
			}
			for (var j:int=0; j<row; j++)
			{
				for (var i:int=0; i<col; i++)
				{
					array2D[j].push(sourceStr.shift());
				}
			}
			return array2D;
		}
	
		public function  appendElement(layout:int,tile:String,topx:int, topz:int, bottomx:int, bottomz:int):void {
			  var element:IsoMapElement = new IsoMapElement();
				  element.layout = layout;
				  element.tid = tile;
				  element.topX = topx;
				  element.topZ = topz;
				  element.bottomX = bottomx;
				  element.bottomZ = bottomz;
				  elements.push(element);
			}
			
		/**
		 * 清空elements 节点
		 */
		public function  clearElement():void {
			elements.length = 0;
		 }
		 
		 /**
		  * 添加传送点
		  * @param	leaveX
		  * @param	leaveY
		  * @param	enterX
		  * @param	enterY
		  * @param	map
		  */
		public function addPortal(leaveX:int,leaveZ:int,enterX:int,enterZ:int,map:String):void {
			 var newPortal:IsoPortal = new IsoPortal()
				 newPortal.leaveX = leaveX;
				 newPortal.leaveZ = leaveZ;
				 newPortal.enterX = enterX;
				 newPortal.enterZ = enterZ;
				 newPortal.map = map;
				portal.push(newPortal);
		}
		
		
		public function removePortalAt(index:uint):void {
			portal.splice(index, 1);			
		}
		
 		
	}

}