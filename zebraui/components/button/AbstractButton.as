package zebraui.components.button
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import zebraui.components.InteractiveUIComponent;
 
	
	public class AbstractButton extends InteractiveUIComponent  implements IButton
	{
		protected var _state:String;
		protected var _toggle:Boolean;
		protected var _isPressed:Boolean;
		protected var _isReleased:Boolean;
		protected var _flat:Boolean;
		protected var _value:Object;
		protected var _auotsize:Boolean;
		
		/**
		 * 用户是否点击过
		 */
		public var IsClickOver:Boolean;
		
		public function AbstractButton(preferWidth:Number=50,preferHeight:Number=23) 
		{
		   super(preferWidth,preferHeight);
		}
		
		override protected function initialize():void
		{
			_state = ButtonState.NORMAL;
			this.buttonMode = true;
			this.useHandCursor = true;
			super.initialize();
		}
 
		
		
		override public function dispose():void
		{
				this.buttonMode = false;
				this.mouseChildren = false;
				this.tabChildren = false;
				this.mouseEnabled = false;
				this.tabEnabled = false;
				super.dispose();
		}
		
		public function setPressed():void {
			  _isPressed = true;
			  _isReleased = false;
			  this.state = ButtonState.DOWN;
			}	
		public function setReleased():void {
			  _isPressed = false;
			  _isReleased = true;
			  this.state = ButtonState.NORMAL;
			}
		
		public function get IsPressed():Boolean 
		{
			return _isPressed;
		}
		
		public function get IsReleased():Boolean 
		{
			return _isReleased;
		}
		
		override protected function onStateClick(e:MouseEvent):void 
		{
			if (enabled && !disabled)
			{
				IsClickOver = true;
			}
			super.onStateClick(e);
		}
		
		override protected function onStateMouseDown(e:MouseEvent):void 
		{
			if (enabled && !disabled)
			{
				 if (!_toggle) {
				 _state = ButtonState.DOWN;
				 }
			}
			super.onStateMouseDown(e);
		}
		
		override protected function onStateMouseUp(e:MouseEvent):void 
		{
			if (enabled && !disabled)
			{ 
				if (hitMouse()) {
					if (_toggle && !_isPressed  ) {
						setPressed();
						}else {
						setReleased();
						}
				
				if (!_toggle)
				_state = ButtonState.NORMAL;
				}
			}
			super.onStateMouseUp(e);
		}
 
		override protected function onStateRollOut(e:MouseEvent):void 
		{
			
			if (enabled && !disabled)
			{
			  if (!_toggle) {
					 _state = ButtonState.NORMAL;
				 }
			}
			super.onStateRollOut(e);
		}
		
		override protected function onStateRollOver(e:MouseEvent):void 
		{
			if (enabled && !disabled)
			{ 
				if (!_toggle)
				   _state = ButtonState.HOVER;
		    }
			super.onStateRollOver(e);
		}
		
		public function get state():String 
		{
			return _state;
		}
		
		public function set state(value:String):void 
		{
			_state = value;
		}
		
	
		/**
		 * 开关模式
		 */
		public function get toggle():Boolean 
		{
			return _toggle;
		}
		
		/**
		 * 开关模式
		 */
		public function set toggle(value:Boolean):void 
		{
			_toggle = value;
			_isPressed = false;
			_isReleased = value;
		}
		
		public function get flat():Boolean 
		{
			return _flat;
		}
		
		/**
		 *  平的按钮,没normal图像
		 */
		public function set flat(value:Boolean):void 
		{
			_flat = value;
		}
		
 
		public function get text():String 
		{
			return "";
		}
		
		public function set text(value:String):void 
		{
			 
		}
		
		public function get value():Object 
		{
			return _value;
		}
		
 
		
		
		public function set value(value:Object):void 
		{
			_value = value;
		}
		
		public function get auotsize():Boolean 
		{
			return _auotsize;
		}
		
		public function set auotsize(value:Boolean):void 
		{
			_auotsize = value;
		}
	 
	
	}

}