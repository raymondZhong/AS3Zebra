package zebra.content
{
	import flash.system.LoaderContext;
	import zebra.Game;
	import zebra.loaders.AssetDisplayLoader;
	import zebra.loaders.AssetLoader;
	import zebra.loaders.AssetLoaderState;
	import zebra.loaders.AssetTextLoader;
	import zebra.loaders.AssetType;
	import zebra.loaders.IAssetLoader;
	import zebra.loaders.ILoader;
	
	/**
	 * GameLoader 的资源可以放入到GameAsset
	 * 可以后续直接在这里取用。
	 * Texture
	 * Loader swf image xml
	 */
	public class GameAsset
	{
		
		static public const channel:String = "GameAssetChannel";
		
		static private var _defaultContext:LoaderContext;
		
		public static function get defaultContext():LoaderContext
		{
			if (_defaultContext == null)
			{
				_defaultContext = new LoaderContext(false, Game.currentApplicationDomain);
			}
			return _defaultContext;
		}
		
		static public function receive(url:String, action:*):void
		{
			Game.DirectEvent.receive(url, action, channel);
		}
		
		static public function destroy(url:String, action:*):void
		{
			Game.DirectEvent.destroy(url, action, channel);
		}
		
		static public function load(url:String, assetType:String = "auto", cache:Boolean=false ,param:Object = null):void
		{
			 var asset:AssetLoader
			 if (assetType == "auto") assetType = matchAssetType(url);
				 
			if (!cache) {	
					 asset= new AssetLoader(assetType,cache);
					 asset.load(url, param);					 				
				}else{
				var assetloader:IAssetLoader = Game.Content.getAssetLoader(url);
				if ( assetloader != null) {
						 new GameAssetLoadLogic(assetloader);
					}else {
						 trace("load skin 0")		
						 asset= new AssetLoader(assetType,cache);
						 asset.load(url, param);						
					}
				
			}
		}
		
		
		static private function matchAssetType(url:String):String {
			var type:String="";
				if (url.indexOf(".xml") != -1) type = AssetType.TEXT;
				if (url.indexOf(".swf") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".jpg") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".png") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".gif") != -1) type = AssetType.DISPLAYOBJECT;
				if (type == "") type = AssetType.TEXT;
				return type;
			}
		
		
			
			
	
		//{========Libary  Link ========================================================================
	/*		public function getClass(className:String):Class
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
	 }*/
		 //}========Libary  Link ========================================================================
	}

}

