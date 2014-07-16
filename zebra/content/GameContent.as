package zebra.content
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.Font;
	import flash.utils.getQualifiedClassName;
	import zebra.core.GameModel;
	import zebra.Game;
	import zebra.loaders.IAssetLoader;
	import zebra.system.util.FlashCookie;
	
	public class GameContent
	{
		private var _viewContent:GameViewContent;
		private var _modelContent:GameModelContent;
		private var _objectContent:ObjectContent;
	//	private var _assetinfoContent:GameAssetInfoContent;
		private var _assetLoaderContent:GameAssetLoaderContent;
		private var _singleClass:GameSingleClass;
		private var _cookies:FlashCookie;
		
		public function GameContent()
		{
			_viewContent = new GameViewContent(this);
			_modelContent = new GameModelContent(this);
			_objectContent = new ObjectContent(this);
			_assetLoaderContent = new GameAssetLoaderContent(this);
			_singleClass = new GameSingleClass(this);
			_cookies = new FlashCookie("@zebraGame");
		}	
		
		public function addSingleClass(cls:*):void {
			   _singleClass.add(cls);
			}
			
		public function getSingleClass(cls:*):* {
			   return _singleClass.get(cls);
			}
			
		public function removeSingleClass(cls:*):void {
			   _singleClass.remove(cls);
			}
		
		public function addView(view:*):void
		{
			_viewContent.add(view);
		}
		
		public function addUpdateView(view:*):void
		{
			var key:String = toClassStr(view);
			if (_viewContent.contain(key))
				_viewContent.update(view);
			else
				_viewContent.add(view);
		}
		
		public function getView(classORpackname:*):*
		{
			return _viewContent.get(classORpackname);
		}
		
		public function removeView(classORpackname:*):void
		{
			_viewContent.remove(classORpackname);
		}
		
		public function addModel(model:*):void
		{
			var key:String = toClassStr(model);
			_modelContent.add(model);
		}
		
		public function getModel(classORpackname:*):*
		{
			return _modelContent.get(classORpackname);
		}
		
		public function removeModel(classORpackname:*):void
		{
			_modelContent.remove(classORpackname)
		}		
			
		public function addObject(key:String, object:Object):void { 
			      _objectContent.add(key, object);
			}
			
		public function removeObject(key:String):void {
			  return _objectContent.remove(key);
			}
			
		public function getObject(key:String):*{
			    return _objectContent.get(key);
			}	
		 
			
		public function addAssetLoader(key:String, assetLoader:IAssetLoader):void { 
			      _assetLoaderContent.add(key, assetLoader);
			}
			
		public function removeAssetLoader(key:String):void {
			  return _assetLoaderContent.remove(key);
			}
			
		public function getAssetLoader(key:String):IAssetLoader{
			    return _assetLoaderContent.get(key);
			}	
		 
			
		public function clear():void {
			_objectContent.clear();
			_modelContent.clear();
			_viewContent.clear();
			_assetLoaderContent.clear();
			}	
		
		private function toClassStr(cls:*):String
		{
			return getQualifiedClassName(cls).split("::").join(".");
		}
		 
		//{========Libary  Link ========================================================================
		public function getClass(className:String):Class
		{
			return Game.currentApplicationDomain.getDefinition(className) as Class;
		}
		
		public function getMovieClipByClass(className:String):MovieClip
		{
			var cls:Class = getClass(className);
			return MovieClip(new cls())
		}
		
		public function getSimpleButtonByClass(className:String):SimpleButton
		{
			var cls:Class = getClass(className);
			return SimpleButton(new cls())
		}
		
		public function getBitmapDataByClass(className:String):BitmapData
		{
			var cls:Class = getClass(className);
			return BitmapData(new cls())
		}
		
		public function getFont(className:String):Font
		{
			var FontClass:Class = getClass(className) as Class;
			Font.registerFont(FontClass);
			return Font(new FontClass());
		}
		
		public function get cookies():FlashCookie 
		{
			return _cookies;
		}
		//}========Libary  Link ========================================================================
	}
}