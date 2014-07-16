package zebra.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	internal class BaseSprite extends Sprite
	{
		
		private var _disposed:Boolean;
		private var _IsRender:Boolean;
		public var addStageHandler:Function;
		public var removeStageHandler:Function;
		
		public function BaseSprite()
		{
			
			initialize();
			eventListener();
			this.addEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeStageLogic);
		}
		
		protected function initialize():void
		{
		
		}
		
		protected function eventListener():void
		{
		
		}
		
		protected function addToStageControl():void
		{
		
		}

		
		protected function removeStageControl():void
		{
		
		}
		
		private function _addToStageLogic(e:Event):void
		{
			addToStageControl();
			if (addStageHandler != null)
				addStageHandler(this);
			_IsRender = true;
		}
		
		private function _removeStageLogic(e:Event):void
		{			
			addToStageControl();
			_IsRender = false;
			if (removeStageHandler != null)removeStageHandler(this);
		}
		
		/**
		 * ·是否渲染过
		 */
		public function get IsRender():Boolean
		{
			return _IsRender;
		}
		
		public function get Disposed():Boolean
		{
			return _disposed;
		}
		
		protected function disposeControl(removeStageUse:Boolean=false):void
		{
			if (Disposed)return;
			if (!_disposed)
			{
				_disposed = true;
				addStageHandler = null;
			    removeStageHandler = null;
				dispose();
				if(!removeStageUse && this.parent)this.parent.removeChild(this);
				
			}
		}
		public function dispose():void{}
			
		
		/**
		 * 是否和鼠标接触
		 * @return
		 */
		public function hitMouse():Boolean
		{
			if (!visible || !this.mouseEnabled || this.stage==null)
				return false;
			var Gpoint:Point = toGlobalPoint();
			var rect:Rectangle = new Rectangle(Gpoint.x, Gpoint.y, this.width, this.height);
			return rect.containsPoint(new Point(this.stage.mouseX, this.stage.mouseY));
		}
		
		/**
		 * 转换成全局坐标
		 * @return
		 */
		public function toGlobalPoint():Point
		{
			return toStagePoint(this);
		}
		
		public function toGlobalBound():Rectangle
		{
			var point:Point = toGlobalPoint();
			return new Rectangle(point.x, point.y, width, height);
		}
		
		/**
		 * 返回全局坐标
		 * @param	target
		 * @return
		 */
		protected function toStagePoint(target:DisplayObject):Point
		{
			var result:Point = new Point();
			while (target != null)
			{
				result.x += target.x;
				result.y += target.y;
				target = target.parent;
			}
			return result;
		}
	
	}

}