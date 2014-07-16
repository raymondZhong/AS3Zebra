package zebraIso.loaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import zebraIso.data.xmlmapper.Textures;
	import zebraIso.event.IsoLoaderEvent;
	import zebraIso.IsoGame;
	import zebra.data.GameTexture;
	import zebra.events.AssetLoaderEvent;
	import zebra.loaders.AssetLoaderQueue;
	import zebra.loaders.AssetType;
	
	public class TextureLoader extends IsoLoader
	{
		protected var _texture:Textures;
		
		/**
		 *  id or TextureObject
		 * @param	value
		 */
		public function load(value:*):void
		{
			if (value is String) {
				_texture = IsoGame.resource.resource.getTextureById(value);
				}
			if (value is Textures) {
				_texture = value;
				}
			
			var xmlPath:String;
			var imagePath:String;
			xmlPath = _texture.path;
			imagePath = xmlPath.replace(".xml", "." + IsoGame.textureType);			
			queue.append(IsoGame.resource.contentRootPath+xmlPath, AssetType.TEXT);
			queue.append(IsoGame.resource.contentRootPath+imagePath, AssetType.DISPLAYOBJECT);
			queue.addEventListener(AssetLoaderEvent.PROGRESS, loaderProgressHandler);
		    queue.addEventListener(AssetLoaderEvent.COMPLETE, loaderCompleteHandler);
			queue.execute();
		}
		
		override protected function loaderCompleteHandler(e:AssetLoaderEvent):void
		{
			
			queue.removeEventListener(AssetLoaderEvent.PROGRESS, loaderProgressHandler);
		    queue.removeEventListener(AssetLoaderEvent.COMPLETE, loaderCompleteHandler);
			if (_texture.gametexture == null)
			{
				var xml:XML;
				var image:BitmapData;
				for (var i:int = 0; i < queue.count; i++)
				{
					if (queue.getAssetloaderAt(i).type == AssetType.TEXT)
						xml = new XML(queue.getAssetloaderAt(i).content);
					else
						image = Bitmap(queue.getAssetloaderAt(i).content).bitmapData;
				}
				_texture.gametexture = new GameTexture(image,xml);
			}
			super.loaderCompleteHandler(e);
		}
		
		override public function dispose():void 
		{
			queue.removeEventListener(AssetLoaderEvent.PROGRESS, loaderProgressHandler);
		    queue.removeEventListener(AssetLoaderEvent.COMPLETE, loaderCompleteHandler);
			super.dispose();
		}
	
	}

}