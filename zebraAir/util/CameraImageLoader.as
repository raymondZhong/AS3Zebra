package zebraAir.util 
{
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.CameraRoll;
	import flash.media.MediaPromise;
	import flash.utils.ByteArray;

	public class CameraImageLoader extends EventDispatcher
	{
		private var _loader:Loader;
		public var content:*;
		public var imageFile:File
		public function CameraImageLoader() 
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, asyncImageLoaded );
			//_loader.addEventListener(IOErrorEvent.IO_ERROR, cameraError );
				 
		}
		
		public function load(mediaPromise:MediaPromise):void {
			_loader.loadFilePromise(mediaPromise);
		}
		
		private function asyncImageLoaded(event:Event):void 
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, asyncImageLoaded);
			
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;	
			content = loaderInfo.content;
			
		    this.dispatchEvent(new Event(Event.COMPLETE));
			//if (CameraRoll.supportsAddBitmapData) {
					//content = loaderInfo;
					//var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height);
					//bitmapData.draw(loaderInfo.loader);
					//imageFile= File.applicationStorageDirectory.resolvePath("image" + new Date().time + ".jpg");
					//var stream:FileStream = new FileStream()
					//stream.open(imageFile,FileMode.WRITE);
					//var bytes:ByteArray = bitmapData.encode(bitmapData.rect, new JPEGEncoderOptions());
					//stream.writeBytes(bytes, 0, bytes.bytesAvailable);
					//stream.close();
			//}
			
		}
		
	}

}