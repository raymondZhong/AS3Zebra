package zebra.loaders
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import zebra.content.GameAsset;
	import zebra.debug.Debug;
	import zebra.directEvent.DirectEventManager;
	import zebra.events.AssetLoaderEvent;
	import zebra.Game;
	
	[Event(name="progress",type="zebra.events.AssetLoaderEvent")]
	[Event(name="error",type="zebra.events.AssetLoaderEvent")]
	[Event(name="complete",type="zebra.events.AssetLoaderEvent")]
	
	public class AssetLoader extends EventDispatcher  implements ILoader
	{
		
		/**
		 * 装载进度
		 */
		public var progress:Number;
		private var _loader:AssetBaseLoader;
		private var _type:String;
		private var _cache:Boolean;
		private var _url:String;
		private var _content:*;
		
		public function AssetLoader(type:String,cache:Boolean)
		{
			progress = 0;
			_type = type;
			_cache = cache;
			
			switch (_type)
			{
				case AssetType.DISPLAYOBJECT: 
					_loader = new AssetDisplayLoader(this);
					AssetDisplayLoader(_loader).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					AssetDisplayLoader(_loader).contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
					AssetDisplayLoader(_loader).contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
					break;
				case AssetType.TEXT: 
					_loader = new AssetTextLoader(this);
					AssetTextLoader(_loader).contentLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					AssetTextLoader(_loader).contentLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
					AssetTextLoader(_loader).contentLoader.addEventListener(Event.COMPLETE, completeHandler);
					break;
			}
			_loader.state = AssetLoaderState.READY;
		
		}
		
		 private function matchAssetType(url:String):String {
			var type:String="";
				if (url.indexOf(".xml") != -1) type = AssetType.TEXT;
				if (url.indexOf(".swf") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".jpg") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".png") != -1) type = AssetType.DISPLAYOBJECT;
				if (url.indexOf(".gif") != -1) type = AssetType.DISPLAYOBJECT;
				if (type == "") type = AssetType.TEXT;
				return type;
			}
		
		public function load(urlOrRequest:*, param:Object = null):void
		{
			var _request:URLRequest;
			if (urlOrRequest is URLRequest)
			{
				_request = urlOrRequest;
			}
			else
			{
				_request = new URLRequest(urlOrRequest);
			}
			_url = _request.url;
			_loader.param = param;
			_loader.load(_request);
			
			if (_cache) {
				Game.Content.addAssetLoader(_request.url, _loader);
			}
		}
		
		private function progressHandler(e:ProgressEvent):void
		{
			_loader.state = AssetLoaderState.LOADING;
			progress = e.bytesLoaded / e.bytesTotal;
			dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.PROGRESS));
		}
		
		public function completeHandler(e:Event):void
		{
			progress = 1;
			_loader.state = AssetLoaderState.COMPLETED;
			//Debug.output("[加载成功]:"+_loader.request.url,1)
			var  receiveArray:Array = DirectEventManager(Game.DirectEvent).getReceiveData(GameAsset.channel);
			if(receiveArray!=null){
				for (var i:int = 0; i <receiveArray[0].length ; i++) 
				{
					if (receiveArray[0][i] == _loader.request.url) {
							if (receiveArray[1][i] is AssetLoaderAction)
							AssetLoaderAction(receiveArray[1][i]).assetloader = _loader;
						}
				}
			}
			Game.DirectEvent.send(_loader.request.url, _loader, GameAsset.channel);
			
			var event:AssetLoaderEvent = new AssetLoaderEvent(AssetLoaderEvent.COMPLETE);
				event.assetloader = _loader;
				dispatchEvent(event);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			var event:AssetLoaderEvent = new AssetLoaderEvent(AssetLoaderEvent.Errors);
				dispatchEvent(event);
				Debug.output("[加载错误]:"+_loader.request.url,1,"0xFFFF00","0x9F0050")
				unload();
		}
		
		public function get type():String
		{
			return _type;
		}
		
 
		/**
		 * 卸载建议所有装载在使用资源完后卸载loader。
		 */
		private function  unload():void {
			if (_loader) {
				switch (_type)
				{
					case AssetType.DISPLAYOBJECT: 
						AssetDisplayLoader(_loader).contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
						AssetDisplayLoader(_loader).contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
						AssetDisplayLoader(_loader).contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
						break;
					case AssetType.TEXT: 
						AssetTextLoader(_loader).contentLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
						AssetTextLoader(_loader).contentLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
						AssetTextLoader(_loader).contentLoader.removeEventListener(Event.COMPLETE, completeHandler);
						break;
				}
			}
		}
	
		public function dispose():void
		{
			_loader.state = AssetLoaderState.DISPOSED;
			unload();
		}
	
	}

}

