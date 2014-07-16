package zebra.graphics.animation 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import zebra.events.BitmapBatchEvent;
	public class BitmapBatchManager 
	{
		private var batchs:Vector.<BitmapBatch>;
		private var stages:Vector.<Stage>;
		private var prevBitmapBatch:BitmapBatch;
		
		public function BitmapBatchManager() 
		{
			batchs = new Vector.<BitmapBatch>();
			stages = new Vector.<Stage>();
		}
		
		
		public function add(target:BitmapBatch):void {
			  batchs.push(target);
			  if (stages.indexOf(target.stage) == -1) {
					stages.push(target.stage);
					target.stage.addEventListener(MouseEvent.CLICK, stageClickBitmapBatch);
					target.stage.addEventListener(MouseEvent.MOUSE_DOWN, stageDownBitmapBatch);
					target.stage.addEventListener(MouseEvent.MOUSE_MOVE,moveBitmapBatch)
			   }
			}
			
		private function moveBitmapBatch(e:MouseEvent):void 
		{
			var event:BitmapBatchEvent 
			var stage:Stage  = e.target.stage;
			var point:Point = new Point( stage.mouseX, stage.mouseY);
			var array:Array = stage.getObjectsUnderPoint(point);
			array.reverse();
			
			if (array.length == 0 && prevBitmapBatch != null) {
					 event = new BitmapBatchEvent(BitmapBatchEvent.BITMAPOUT);
					 prevBitmapBatch.dispatchEvent(event);
					if(prevBitmapBatch.OutHandler!=null) prevBitmapBatch.OutHandler(prevBitmapBatch);
					 prevBitmapBatch = null;
				}
			
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] is BitmapBatch){
					var batch:BitmapBatch = BitmapBatch(array[i])
			
					if ( prevBitmapBatch==batch &&  !batch.IsHitMouse ) {
						  	 event = new BitmapBatchEvent(BitmapBatchEvent.BITMAPOUT);
							 prevBitmapBatch.dispatchEvent(event);
							 if (prevBitmapBatch.OutHandler != null) prevBitmapBatch.OutHandler(prevBitmapBatch);
							  prevBitmapBatch = null;
							 return;
						} 
					if (batch.IsHitMouse) {
								 if( prevBitmapBatch!=batch){
								   prevBitmapBatch = batch;
								   event = new BitmapBatchEvent(BitmapBatchEvent.BITMAPHOVER);
								   batch.dispatchEvent(event);
								   if (batch.HoverHandler != null) batch.HoverHandler(batch);
								 }
							   return;
							
						}
						
				}
			}
		}
			
		private function stageClickBitmapBatch(e:MouseEvent):void 
		{
			var stage:Stage  = e.target.stage;
			if (!stage) return;
			var point:Point = new Point( stage.mouseX, stage.mouseY);
			var array:Array = stage.getObjectsUnderPoint(point);
			array.reverse();
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] is BitmapBatch && array[i].IsHitMouse) {
					 var event:BitmapBatchEvent = new BitmapBatchEvent(BitmapBatchEvent.BITMAPCLICK);
					 var batch:BitmapBatch = BitmapBatch(array[i]);
						 batch.dispatchEvent(event);
					 if(batch.ClickBeforeHandler!=null)batch.ClickBeforeHandler(batch);
					 if(batch.ClickHandler!=null)batch.ClickHandler(batch);
					  break;
					}
			}
		}
		
		
		
		private function stageDownBitmapBatch(e:MouseEvent):void 
		{
			var stage:Stage  = e.target.stage;
			var point:Point = new Point( stage.mouseX, stage.mouseY);
			var array:Array = stage.getObjectsUnderPoint(point);
			array.reverse();
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] is BitmapBatch && array[i].IsHitMouse) {
					var batch:BitmapBatch = BitmapBatch(array[i])
					var event:BitmapBatchEvent = new BitmapBatchEvent(BitmapBatchEvent.BITMAPDOWN);
					batch.dispatchEvent(event);
					if(batch.DownHandler!=null)batch.DownHandler(batch);
					  return;
					}
			}
		}
		
		
		
		public function remove(target:BitmapBatch):void {
			  var index:int =  batchs.indexOf(target)
			  if (index != -1) {
				    batchs.splice(index, 1);
				  }
			}
		
	}

}