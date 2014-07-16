package zebraIso.loaders 
{
	import zebraIso.data.xmlmapper.Tile;
	import zebraIso.event.IsoLoaderEvent;
	import zebraIso.IsoGame;
	import zebra.events.TaskEvent;
	import zebra.thread.task.Task;
	public class TileLoader extends IsoLoader
	{
		private var _taskloader:Task;
		internal var _progressCount:Number;
		
		internal var _currentprogress:Number;
		
		internal var _currentCompleteCount:Number;
		
		private var _tile:Tile;
		
		internal var skinloader:Vector.<SkinLoader>;
		
		public function TileLoader() 
		{
			skinloader = new Vector.<SkinLoader>(); 
			_progressCount = 0;
			_currentprogress = 0;
			_currentCompleteCount = 0;
			super();
		}
		
				
		public function load(tile:*):void
		{
			if (tile is String)
			{
				_tile = IsoGame.resource.libary.tiles.getTileById(tile);
			}
			if (tile is Tile)
			{
				_tile = tile;
			}
			
			_taskloader = new Task();
			_progressCount = _tile.tilechild.length;
			 for (var i:int = 0; i < _tile.tilechild.length; i++) 
			 {
				 var action:TileLoaderAction = new TileLoaderAction(this,_tile.tilechild[i],_progress);
				 _taskloader.addAction(action);
			 }
			 _taskloader.addEventListener(TaskEvent.COMPLETE, taskCompleteHandler);
			 _taskloader.start();
		}
		
		private function taskCompleteHandler(e:TaskEvent):void 
		{
			 _taskloader.removeEventListener(TaskEvent.COMPLETE, taskCompleteHandler);
			 dispatchEvent(new IsoLoaderEvent(IsoLoaderEvent.COMPLETE));
		}
		
		override public function dispose():void 
		{
			 _taskloader.removeEventListener(TaskEvent.COMPLETE, taskCompleteHandler);
			_taskloader.stop();
			for each (var loader:SkinLoader in skinloader)
			{
				loader.dispose();
			}
		}
		
	}

}