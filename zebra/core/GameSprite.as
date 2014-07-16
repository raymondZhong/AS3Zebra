package zebra.core
{
	import flash.events.MouseEvent;
	import zebra.events.GameMouseEvent;
	
	[Event(name="bitmapClick",type="zebra.events.GameMouseEvent")]
	[Event(name="bitmapHover",type="zebra.events.GameMouseEvent")]
	[Event(name="bitmapMove",type="zebra.events.GameMouseEvent")]
	[Event(name="bitmapOut",type="zebra.events.GameMouseEvent")]
	[Event(name="bitmapDown",type="zebra.events.GameMouseEvent")]
	[Event(name="bitmapUp",type="zebra.events.GameMouseEvent")]
	
	public class GameSprite extends BaseSprite
	{
		protected var _ClickHandler:Function;
		protected var _HoverHandler:Function;
		protected var _OutHandler:Function;
		
		protected var _MoveHandler:Function;
		protected var _DownHandler:Function;
		protected var _UpHandler:Function;
		public function GameSprite()
		{
			super()
		}
				
		//override protected function eventListener():void
		//{
			//addEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			//addEventListener(MouseEvent.MOUSE_MOVE, onStateMouseMove);
			//addEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			//addEventListener(MouseEvent.MOUSE_UP, onStateMouseUp);
			//addEventListener(MouseEvent.ROLL_OUT, onStateRollOut);
			//addEventListener(MouseEvent.CLICK, onStateClick);
			//super.eventListener();
		//}
		//
		
		
		override protected function addToStageControl():void 
		{
			super.addToStageControl();	
			addEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			addEventListener(MouseEvent.MOUSE_MOVE, onStateMouseMove);
			addEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onStateMouseUp);
			addEventListener(MouseEvent.ROLL_OUT, onStateRollOut);
			addEventListener(MouseEvent.CLICK, onStateClick);
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();
			removeEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			removeEventListener(MouseEvent.MOUSE_MOVE, onStateMouseMove);
			removeEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onStateMouseUp);
			removeEventListener(MouseEvent.ROLL_OUT, onStateRollOut);
			removeEventListener(MouseEvent.CLICK, onStateClick);
		}
		
		
		override public function dispose():void
		{
			_ClickHandler = null;
			_HoverHandler = null;
			_OutHandler = null;
			_MoveHandler = null;
			_DownHandler = null;
			_UpHandler = null;
			
			removeEventListener(MouseEvent.ROLL_OVER, onStateRollOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onStateRollOut);
			removeEventListener(MouseEvent.MOUSE_MOVE, onStateMouseMove);
			removeEventListener(MouseEvent.MOUSE_DOWN, onStateMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onStateMouseUp);
			removeEventListener(MouseEvent.CLICK, onStateClick);
			super.dispose();
		}
		
		protected function onStateMouseUp(e:MouseEvent):void
		{
			if (this.UpHandler != null){
				this.UpHandler(this)
				}
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapUp));
		}
		
		protected function onStateMouseDown(e:MouseEvent):void
		{
			if (this.DownHandler != null){
				this.DownHandler(this)
				}
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapDown));
		}
		
		protected function onStateMouseMove(e:MouseEvent):void
		{
			if (this.MoveHandler != null){
				this.MoveHandler(this)
				}
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapMove));
			
				
		}
		protected function onStateRollOver(e:MouseEvent):void
		{
			if (this.HoverHandler != null){
				this.HoverHandler(this);	
				}
				
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapHover));
		}
		
		protected function onStateRollOut(e:MouseEvent):void
		{
			
			if (this.OutHandler != null){
				this.OutHandler(this);
			}
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapOut));
		
		}
		
		protected function onStateClick(e:MouseEvent):void
		{
			if (ClickHandler != null){
				ClickHandler(this);
			}
				dispatchEvent(new GameMouseEvent(GameMouseEvent.BitmapClick));
		}
		
		public function get ClickHandler():Function 
		{
			return _ClickHandler;
		}
		
		public function set ClickHandler(value:Function):void 
		{
			_ClickHandler = value;
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
		
		public function get MoveHandler():Function 
		{
			return _MoveHandler;
		}
		
		public function set MoveHandler(value:Function):void 
		{
			_MoveHandler = value;
		}
		
		public function get DownHandler():Function 
		{
			return _DownHandler;
		}
		
		public function set DownHandler(value:Function):void 
		{
			_DownHandler = value;
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