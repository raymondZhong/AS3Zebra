package zebraui.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import zebraui.components.UIComponent; 
	
	public class InteractiveUIComponent extends UIComponent
	{
		
		protected var _ClickBeforeHandler:Function;
		protected var _ClickHandler:Function;
		protected var _ClickAfterHandler:Function;
		protected var _HoverHandler:Function;
		protected var _OutHandler:Function;
		protected var _DownHandler:Function;
		protected var _HoldDownHandler:Function;
		protected var _UpHandler:Function;
		private var _IsDown:Boolean;
		public var holdMouse:Boolean;
		
		/**
		 * 按住间隔时间
		 */
		public var holdDownTime:uint = 50;
		
		public function InteractiveUIComponent(preferWidth:Number=0,preferHeight:Number=0) 
		{
			super(preferWidth,preferHeight);
		}
   
		override protected function addToStageControl():void 
		{
			super.addToStageControl();	
			addEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onStateRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			addEventListener(MouseEvent.CLICK, onStateClick);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStateMouseUpLogic);
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();
			removeEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onStateRollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			removeEventListener(MouseEvent.CLICK, onStateClick);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStateMouseUpLogic);
		}
		
		private var _prevTime:uint=0;
		private var _currentTime:uint = 0;
		private function _onEnterFrameLogic(e:Event):void 
		{
			if (_IsDown) {
				_currentTime = getTimer();
				if(_currentTime-_prevTime>holdDownTime){				
					  _prevTime = _currentTime;
					 if (HoldDownHandler != null)
					 HoldDownHandler(this);
				  }
				}
		}
		
		override public function dispose():void
		{
			 _ClickHandler = null;
			 _ClickAfterHandler = null;
			 _ClickBeforeHandler = null;
			 _HoverHandler = null;
			 _OutHandler = null;
			 _DownHandler = null;		
			 _HoldDownHandler = null;
			 _UpHandler = null;
			
			removeEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onStateRollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			removeEventListener(MouseEvent.CLICK, onStateClick);
			removeEventListener(Event.ENTER_FRAME, _onEnterFrameLogic);
			if (stage) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStateMouseUpLogic);
				}
			super.dispose();
		}
		
		protected function onStateClick(e:MouseEvent):void
		{
			_IsDown = false;
			if (holdMouse)removeEventListener(Event.ENTER_FRAME, _onEnterFrameLogic);
			if (enabled && !disabled)
			{
				
				if (ClickBeforeHandler != null)
					ClickBeforeHandler(this);
				if (ClickHandler != null)
					ClickHandler(this);
				if (ClickAfterHandler != null)
					ClickAfterHandler(this)
				
			}
		}
		
		protected function onStateMouseDown(e:MouseEvent):void
		{
			if (enabled && !disabled)
			{
				if (this.DownHandler != null)
					this.DownHandler(this);
					_IsDown = true;
					_currentTime = _prevTime = getTimer();
					if (holdMouse &&  !hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME, _onEnterFrameLogic);
			}
		}
		
		
		private function onStateMouseUpLogic(e:MouseEvent):void {
			if(_IsDown){
				_IsDown = false;
				onStateMouseUp(e)
				}
			}
		
		protected function onStateMouseUp(e:MouseEvent):void
		{
				if (holdMouse)removeEventListener(Event.ENTER_FRAME, _onEnterFrameLogic);
				if (enabled && !disabled)
				{
					if (this.UpHandler != null)
						this.UpHandler(this);9					
				}
			
		}
		
		protected function onStateRollOut(e:MouseEvent):void
		{
			if (enabled && !disabled)
			{
				if (this.OutHandler != null)
					this.OutHandler(this)	
					if (holdMouse)removeEventListener(Event.ENTER_FRAME, _onEnterFrameLogic);
			}
			_IsDown = false;
		}
		
		protected function onStateRollOver(e:MouseEvent):void
		{
			if (enabled && !disabled)
			{
				if (this.HoverHandler != null)
					this.HoverHandler(this)
			}
		}
		
		public function get ClickBeforeHandler():Function 
		{
			return _ClickBeforeHandler;
		}
		
		public function set ClickBeforeHandler(value:Function):void 
		{
			_ClickBeforeHandler = value;
		}
		
		public function get ClickHandler():Function 
		{
			return _ClickHandler;
		}
		
		public function set ClickHandler(value:Function):void 
		{
			_ClickHandler = value;
		}
		
		public function get ClickAfterHandler():Function 
		{
			return _ClickAfterHandler;
		}
		
		public function set ClickAfterHandler(value:Function):void 
		{
			_ClickAfterHandler = value;
		}
		
		public function get HoverHandler():Function 
		{
			return _HoverHandler;
		}
		
		public function set HoverHandler(value:Function):void 
		{
			_HoverHandler = value;
		}
		
		public function get OutHandler():Function 
		{
			return _OutHandler;
		}
		
		public function set OutHandler(value:Function):void 
		{
			_OutHandler = value;
		}
		
		public function get DownHandler():Function 
		{
			return _DownHandler;
		}
		
		public function set DownHandler(value:Function):void 
		{
			_DownHandler = value;
		}
		
		public function get HoldDownHandler():Function 
		{
			return _HoldDownHandler;
		}
		
		public function set HoldDownHandler(value:Function):void 
		{
			_HoldDownHandler = value;
		}
		
		public function get UpHandler():Function 
		{
			return _UpHandler;
		}
		
		public function set UpHandler(value:Function):void 
		{
			_UpHandler = value;
		}
		
		
		
	}

}