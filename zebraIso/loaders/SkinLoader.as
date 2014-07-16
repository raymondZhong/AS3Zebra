package zebraIso.loaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import zebraIso.data.xmlmapper.Skin;
	import zebraIso.data.xmlmapper.Textures;
	import zebraIso.IsoGame;
	import zebra.data.GameTexture;
	import zebra.events.AssetLoaderEvent;
	import zebra.loaders.AssetType;
	
	public class SkinLoader extends TextureLoader
	{
		
		override public function load(skin:*):void
		{
			if (skin is String)
			{
				var _skin:Skin = IsoGame.resource.libary.skins.getSkin(skin);
				_texture = IsoGame.resource.resource.getTextureById(_skin.tid);
			}
			if (skin is Skin)
			{
				_texture = IsoGame.resource.resource.getTextureById(skin.tid);
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
			super.loaderCompleteHandler(e);
		}
		
		
		override public function dispose():void 
		{
			queue.removeEventListener(AssetLoaderEvent.PROGRESS, loaderProgressHandler);
			queue.removeEventListener(AssetLoaderEvent.COMPLETE, loaderCompleteHandler);
			super.dispose();
		}
		
		//override protected function loaderCompleteHandler(e:AssetLoaderEvent):void
		//{
			//if (_texture.gameTexture == null)
			//{
				//var xml:XML;
				//var image:BitmapData;
				//for (var i:int = 0; i < queue.count; i++)
				//{
					//if (queue.getAssetloaderAt(i).type == AssetType.TEXT)
						//xml = new XML(queue.getAssetloaderAt(i).content);
					//else
						//image = Bitmap(queue.getAssetloaderAt(i).content).bitmapData;
				//}
				//_texture.gameTexture = new GameTexture(image,xml);
			//}
			//super.loaderCompleteHandler(e);
		//}
	
	}

}