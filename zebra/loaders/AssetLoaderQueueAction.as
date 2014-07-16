package zebra.loaders 
{
	import flash.events.Event;
	import zebra.events.AssetLoaderEvent;
	import zebra.Game;
	import zebra.thread.task.TaskAction;

	internal class AssetLoaderQueueAction extends TaskAction
	{
		private var _loadernode:LoaderQueueVO;
		private var _loaderqueue:AssetLoaderQueue;
		
		private var _assetloader:IAssetLoader;
		
		public function AssetLoaderQueueAction(loaderqueue:AssetLoaderQueue,loadernode:LoaderQueueVO) 
		{
			_loadernode = loadernode;
			_loaderqueue = loaderqueue;
		}
		
		
		override public function execute():void 
		{	
			super.execute();
			var assetloader:IAssetLoader = Game.Content.getAssetLoader(_loadernode.url)
			if (assetloader != null) {
				  _loadernode.loader = assetloader.loader;
				}						
				_loadernode.loader.addEventListener(AssetLoaderEvent.Errors, errorHandler);
				_loadernode.loader.addEventListener(AssetLoaderEvent.PROGRESS, progressHandler);
				_loadernode.loader.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
				_loadernode.loader.load(_loadernode.url, _loadernode.param);
				
		}
		
		override public function dispose():void 
		{
			stop();
			super.dispose();
		}
		
		override public function stop():void 
		{
			_loadernode.progress = 1;
			_loadernode.loader.removeEventListener(AssetLoaderEvent.Errors, errorHandler);
			_loadernode.loader.removeEventListener(AssetLoaderEvent.PROGRESS, progressHandler);
			_loadernode.loader.removeEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
			_loadernode.loader.dispose();
			super.stop();
		}
		
		
		public function progressHandler(e:AssetLoaderEvent):void 
		{
			_loadernode.progress = AssetLoader(e.target).progress;
			_loaderqueue.dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.PROGRESS));
		}
		
		override public function finish():void 
		{
			_loadernode.progress = 1;
			_loadernode.loader.removeEventListener(AssetLoaderEvent.Errors, errorHandler);
			_loadernode.loader.removeEventListener(AssetLoaderEvent.PROGRESS, progressHandler);
			_loadernode.loader.removeEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
			super.finish();
		}
		
		private function errorHandler(e:AssetLoaderEvent):void 
		{
			_assetloader = e.assetloader;
			this.finish();
		}
		
		private function completeHandler(e:AssetLoaderEvent):void 
		{
			_assetloader = e.assetloader;
			this.finish();
		}
		
		public function get loadernode():LoaderQueueVO
		{
			return _loadernode;
		}
		
		public function get assetloader():IAssetLoader 
		{
			return _assetloader;
		}
		
	}

}