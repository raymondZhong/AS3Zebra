package zebraIso.loaders 
{
	import zebraIso.data.xmlmapper.Tile;
	import zebraIso.data.xmlmapper.TileChild;
	import zebraIso.event.IsoLoaderEvent;
	import zebra.thread.task.TaskAction;

	internal class TileLoaderAction extends TaskAction
	{
		
		private var _tilechild:TileChild;
		private var _tileloader:TileLoader;
		private var _loader:SkinLoader
		public function TileLoaderAction(tileloader:TileLoader,tilechild:TileChild,progress:Number) 
		{
			_tileloader = tileloader
			_tilechild = tilechild;
			_loader = new SkinLoader();
			tileloader.skinloader.push(_loader);
		}
		
		override public function execute():void 
		{
			super.execute();
			_loader.addEventListener(IsoLoaderEvent.PROGRESS, progressHandler);
			_loader.addEventListener(IsoLoaderEvent.COMPLETE, completeHandler);
			_loader.load(_tilechild.skinId);
		}
		
		private function completeHandler(e:IsoLoaderEvent):void 
		{
			_tileloader._currentCompleteCount += 1;
			this.finish();
		}
		
		private function progressHandler(e:IsoLoaderEvent):void 
		{
			 _tileloader._progress = (e.progress + _tileloader._currentCompleteCount) / _tileloader._progressCount;		 
			 var event:IsoLoaderEvent = new IsoLoaderEvent(IsoLoaderEvent.PROGRESS);
			 event.progress = _tileloader._progress;
			 _tileloader.dispatchEvent(event);
		}
	}

}