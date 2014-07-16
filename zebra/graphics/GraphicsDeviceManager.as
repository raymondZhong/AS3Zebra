package zebra.graphics 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import zebra.graphics.animation.BitmapBatchManager;

	
	

	
	public class GraphicsDeviceManager extends EventDispatcher
	{
		
		private var _gameStage:Stage;
		private var _bitmapBatchManger:BitmapBatchManager;
		
		public function GraphicsDeviceManager(stage:Stage) 
		{
			_gameStage = stage;
			_bitmapBatchManger = new BitmapBatchManager();
		}
		

		public function get fps():int { return _gameStage.frameRate; }
		
		public function get stage():Stage { return _gameStage; }
		
		public function get supportGPU():Boolean { return  false; }		
		
		public function get IsFullScreen():Boolean{
			  return _gameStage.displayState == StageDisplayState.FULL_SCREEN;
			}
			
		public function get bitmapBatchManger():BitmapBatchManager 
		{
			return _bitmapBatchManger;
		}
		 
		/**
		 * 转换为全局坐标
		 * @param	target
		 * @return
		 */
		public function toDevicePoint(target:DisplayObject):Point {
			   /*var result:Point = new Point(); 
			   while ( target != null) {
					    result.x += target.x;
						result.y += target.y;
						target = target.parent
					 }
			     return  result;*/
				 
			   return target.parent.localToGlobal(new Point(target.x, target.y));
			}
			
			
		public function toLocalOffsetPoint(target:DisplayObject):Point {
			   if(target.stage){
			   var stagePoint:Point = new Point(target.stage.mouseX, target.stage.mouseY);
			   var selfPoint:Point = toDevicePoint(target);
			   return  new Point(selfPoint.x - stagePoint.x, selfPoint.y - stagePoint.y);
			   }
			   return null
			}	
			
		/*
		 * public function toStagePoint():Point
		{
			return this.parent.localToGlobal(new Point(this.x, this.y));
		}
		*/
			
		//Mobiel
		/*******************************************************/	
		// public var DIP: int = Capabilities.screenDPI;
		 
		/*******************************************************/
		
	}

}