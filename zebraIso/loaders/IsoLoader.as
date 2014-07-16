package zebraIso.loaders 
{
	import flash.events.EventDispatcher;
	import zebraIso.data.xmlmapper.Textures;
	import zebraIso.event.IsoLoaderEvent;
	import zebraIso.IsoGame;
	import zebra.events.AssetLoaderEvent;
	import zebra.loaders.AssetLoaderQueue;
	import zebra.loaders.AssetType;
 
	
	[Event(name="progress",type="zebraIso.event.IsoLoaderEvent")]
	[Event(name="error",type="zebraIso.event.IsoLoaderEvent")]
	[Event(name="complete",type="zebraIso.event.IsoLoaderEvent")]
	
	public class IsoLoader extends EventDispatcher
	{
		protected var queue:AssetLoaderQueue;		
		internal var _progress:Number;
		
		public function IsoLoader()
		{
			 _progress = 0;
			 queue = new AssetLoaderQueue();
		}
		
		
		protected function loaderCompleteHandler(e:AssetLoaderEvent):void 
		{
			dispatchEvent(new IsoLoaderEvent(IsoLoaderEvent.COMPLETE));
		}
		
		protected function loaderProgressHandler(e:AssetLoaderEvent):void 
		{
			_progress = queue.progress;
			var event:IsoLoaderEvent = new IsoLoaderEvent(IsoLoaderEvent.PROGRESS);
			event.progress = _progress;
			dispatchEvent(event);
		}
		
		public function get progress():Number 
		{
			return _progress;
		}
		
		public function dispose():void {
				queue.dispose();
		}
		
	}

}

