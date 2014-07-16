package zebra.loaders
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import zebra.events.AssetLoaderEvent;
	import zebra.events.TaskActionEvent;
	import zebra.events.TaskEvent;
	import zebra.Game;
	import zebra.thread.task.Task;
	
	[Event(name="progress",type="zebra.events.AssetLoaderEvent")]
	[Event(name="error",type="zebra.events.AssetLoaderEvent")]
	[Event(name="complete",type="zebra.events.AssetLoaderEvent")]
	[Event(name="childcomplete",type="zebra.events.AssetLoaderEvent")]
	
	public class AssetLoaderQueue extends EventDispatcher
	{
		private var _concurrent:int;
		private var _loaderList:Vector.<LoaderQueueVO>;
		private var _loadTask:Task;
		private var _count:int;
		private var _assetloaderList:Vector.<IAssetLoader>
		private var _cache:Boolean;
		
		public function AssetLoaderQueue(concurrent:int = 3, cache:Boolean = false)
		{
			_cache = cache;
			_concurrent = concurrent;
			_loaderList = new Vector.<LoaderQueueVO>();
			_loadTask = new Task();
			_loadTask.concurrent = _concurrent;
			_assetloaderList = new Vector.<IAssetLoader>();
		}
		
		public function append(urlOrRequest:*, type:String = "displayobject", param:Object = null):void
		{
			var loader:AssetLoader = new AssetLoader(type, _cache)
			var url:String;
			if (urlOrRequest is URLRequest)
			{
				url = URLRequest(urlOrRequest).url;
			}
			else
			{
				url = urlOrRequest;
			}
			if (!hasUrlLoader(url))
			{
				var node:LoaderQueueVO = new LoaderQueueVO();
				node.loader = loader;
				node.param = param;
				node.url = url;
				node.progress = 0;
				_loaderList.push(node);
			}
		}
		
		public function get progress():Number
		{
			var currentProgress:Number = 0;
			for each (var item:LoaderQueueVO in _loaderList)
			{
				currentProgress += item.progress
			}
			
			return currentProgress / _count;
		}
		
		/**
		 * 获得加载好对应游戏资源
		 * @param	url
		 * @return
		 */
		public function getAssetloader(url:String):IAssetLoader
		{
			for each (var item:IAssetLoader in _assetloaderList)
			{
				if (item.request.url == url)
					return item;
			}
			return null;
		}
		
		public function getAssetloaderAt(index:int):IAssetLoader
		{
			return _assetloaderList[index];
		}
		
		public function get count():int
		{
			return _count;
		}
		
		private function hasUrlLoader(url:String):Boolean
		{
			for each (var item:LoaderQueueVO in _loaderList)
			{
				if (item.url == url)
					return true;
			}
			return false;
		}
		
		public function execute():void
		{
			_count = _loaderList.length;
			for each (var item:LoaderQueueVO in _loaderList)
			{
				var action:AssetLoaderQueueAction = new AssetLoaderQueueAction(this, item);
				action.addEventListener(TaskActionEvent.COMPLETE, childcompleteHandler)
				_loadTask.addAction(action);
			}
			_loadTask.addEventListener(TaskEvent.COMPLETE, taskCompleteHandler)
			_loadTask.start();
		}
		
		public function dispose():void
		{
			_loadTask.stop();
			for each (var item:LoaderQueueVO in _loaderList)
			{
				item.loader.dispose();
			}
		}
		
		public function stop():void
		{
			_loadTask.stop();
		}
		
		private function childcompleteHandler(e:TaskActionEvent):void
		{
			AssetLoaderQueueAction(e.target).removeEventListener(TaskActionEvent.COMPLETE, childcompleteHandler)
			var event:AssetLoaderEvent = new AssetLoaderEvent(AssetLoaderEvent.CHILDCOMPLETE);
			event.assetloader = AssetLoaderQueueAction(e.target).assetloader
			_assetloaderList.push(event.assetloader);
			dispatchEvent(event);
		}
		
		private function taskCompleteHandler(e:TaskEvent):void
		{
			_loadTask.removeEventListener(TaskEvent.COMPLETE, taskCompleteHandler);
			dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.COMPLETE));
		}
	
	}

}
