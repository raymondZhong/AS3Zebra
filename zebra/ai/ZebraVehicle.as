package zebra.ai
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import zebraui.baseShape.Ball;
	
	public class ZebraVehicle extends Sprite
	{
		//速度
		public var speed:int = 5;
		
		//目的坐标
		private var goalX:Number;
		private var goalY:Number;
		
		//移动编号坐标
		public var moveX:Number;
		public var moveY:Number;

		//上一次变化前的坐标
		private var prevMoveX:Number
		private var prevMoveY:Number
		
		
		public var completeHandler:Function;
		public var moveHandler:Function;
		
		public var changePosition:Object
		
		
		public function ZebraVehicle()
		{
			draw()
			changePosition = { x:this.x, y:this.y };
		}
		
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 1);
			graphics.lineStyle(0);
			graphics.moveTo(10, 0);
			graphics.lineTo(-10, 5);
			graphics.lineTo(-10, -5);
			graphics.lineTo(10, 0);
		}
				
		/**
		 * 到达
		 * @param	$x
		 * @param	$y
		 */
		public function arrive($x:Number,$y:Number):void
		{
			goalX = $x;
			goalY = $y;
			rotation = Math.atan2(goalY - y, goalX - x) / Math.PI * 180;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		
		public function fixRotation(goalX:Number,goalY:Number):void {
			rotation = Math.atan2(goalY - y, goalX - x) / Math.PI * 180;
			}
 
		/**
		 * 循环移动逻辑
		 * @param	event
		 */

		private function loop(event:Event):void
		{
			prevMoveX = x;
			prevMoveY = y;

			var moveBeforeDistance:Number =   Point.distance(new Point(goalX, goalY), new Point(x, y));
 
			//trace("distance:", moveBeforeDistance);
			if (moveBeforeDistance <= speed)
			{
				removeEventListener(Event.ENTER_FRAME, loop);
				x = goalX;
				y = goalY;
				moveX = x - prevMoveX;
				moveY = y - prevMoveY;				
				if (moveHandler) moveHandler(this);
			   // trace(moveX,moveY,">>>>>")
				if (completeHandler) completeHandler(this);
			}
			else
			{
				x = x + Math.cos(rotation / 180 * Math.PI) * speed;
				y = y + Math.sin(rotation / 180 * Math.PI) * speed;
				moveX = x - prevMoveX;
				moveY = y - prevMoveY;
				if (moveHandler) moveHandler(this);
				
				var moveAfterDistance:Number = Point.distance(new Point(goalX, goalY), new Point(x, y));
					if (moveAfterDistance >= moveBeforeDistance) {
						x = goalX;
						y = goalY;
					}
			    //trace(moveX,moveY,">>>>>")
			}
 
		}
 
		
		/**
		 * 停止移动
		 */
		public function stop():void {
			removeEventListener(Event.ENTER_FRAME, loop);
		}
 
	}
}