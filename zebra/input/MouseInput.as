package zebra.input
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import zebra.events.GameMouseEvent;
	import zebra.events.TaskActionEvent;
	import zebra.Game;
	
	[Event(name="updateMousePosition",type="zebra.events.GameMouseEvent")]	
	
	public class MouseInput extends EventDispatcher
	{
		
		private var  _enabled:Boolean
		public function MouseInput()
		{
			_enabled = true;
			var mouseInputTaskAction:MouseInputTaskAction = new MouseInputTaskAction();
			mouseInputTaskAction.addEventListener(TaskActionEvent.COMPLETE, _updateMousePointLogic);
			Game.TimeUpdate.addTaskAction(mouseInputTaskAction);
		}
		
		/**
		 * 鼠标位置更新
		 * @param	e
		 */
		private function _updateMousePointLogic(e:TaskActionEvent):void
		{
			if(_enabled){
				if (prevPoint == null && currentPoint == null)
				{
					currentPoint = MouseInputTaskAction(e.target).mousePoint;
				}
				else
				{
					prevPoint = currentPoint;
					currentPoint = MouseInputTaskAction(e.target).mousePoint;
					if (!currentPoint.equals(prevPoint))
					{
						var mouseInputEvent:GameMouseEvent = new GameMouseEvent(GameMouseEvent.UpdateMousePosition);
						mouseInputEvent.prevPoint = prevPoint;
						mouseInputEvent.currentPoint = currentPoint;
						this.dispatchEvent(mouseInputEvent);
					}
				}
		   }
		}
		
		/**
		 * 上次鼠标坐标
		 */
		public var prevPoint:Point;
		
		/**
		 * 当前鼠标坐标
		 */
		public var currentPoint:Point;
		
		/**
		 * 鼠标更新坐标
		 */
		public function get changePoint():Point
		{
			if (prevPoint == null)
				return new Point(0, 0);
			return new Point(currentPoint.x - prevPoint.x, currentPoint.y - prevPoint.y);
		}
		
		/**
		 * 禁止使用
		 */
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			if(value)
			currentPoint = new Point(Game.graphicsDeviceManager.stage.mouseX, Game.graphicsDeviceManager.stage.mouseY)
			else
			prevPoint = currentPoint = null;
		}
	
	}

}