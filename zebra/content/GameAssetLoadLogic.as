package zebra.content
{
	import zebra.events.AssetLoaderEvent;
	import zebra.loaders.AssetLoaderState;
	import zebra.loaders.IAssetLoader;
	import zebra.loaders.ILoader;
	
	
	/**
	 * 检查放入AssetLoaderCache中的 loader 状态
	 * 
	 * 如果已经存在的loader 已经完成 直接send() 否者则监听加载完成
	 * 
	 */
	 internal class GameAssetLoadLogic
	{
		private var _assetloader:IAssetLoader;
		
		public function GameAssetLoadLogic(assetloader:IAssetLoader)
		{
			_assetloader = assetloader;
			
			if (_assetloader.state == AssetLoaderState.COMPLETED)
			{
				//trace("load skin 1")
				_assetloader.loader.completeHandler(null);
			}
			if (_assetloader.state == AssetLoaderState.READY || _assetloader.state == AssetLoaderState.LOADING)
			{
				_assetloader.loader.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
			}
		}
		
		private function completeHandler(e:AssetLoaderEvent):void
		{
			_assetloader.loader.removeEventListener(AssetLoaderEvent.COMPLETE, completeHandler);
			_assetloader.loader.completeHandler(null);
			
			//trace("load skin 2")
		}
	
	}

}