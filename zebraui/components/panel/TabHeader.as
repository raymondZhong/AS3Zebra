package zebraui.components.panel
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.baseShape.Cross;
	import zebraui.components.button.ButtonState;
	import zebraui.components.container.Box;
	import zebraui.components.InteractiveUIComponent;
	import zebraui.components.layout.HBoxLayout;
	import zebraui.components.layout.LayoutAlign;
	import zebraui.components.text.Label;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class TabHeader extends InteractiveUIComponent
	{
		private var _checkboxNormal:BitmapData;
		private var _checkboxHover:BitmapData;
		private var _checkboxDown:BitmapData;
		private var _laber:Label = new Label();
		private var _buttonContainer:Sprite;
		protected var _buttonScale9Grid:Scale9GridBitmap;
		private var _state:String;
		public var mouseDownHands:Function = null;
		public var delBtnHands:Function = null;
		private var _id:int;
		private var _isClose:Boolean = false;
		private var _deleteBtn:Cross;
		
		public function TabHeader(preferWidth:Number = 100, preferHeight:Number = 23)
		{
			_checkboxNormal = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.TabHeader.Nomal");
			_checkboxHover = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.TabHeader.Down");
			_checkboxDown = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.TabHeader.Down");
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_buttonScale9Grid = new Scale9GridBitmap(_checkboxNormal, viewRectangle);
			_buttonScale9Grid.width = _preferWidth;
			_buttonScale9Grid.height = _preferHeight;
			_buttonContainer = new Sprite();
			addChild(_buttonContainer);
			_buttonContainer.addChild(_buttonScale9Grid);
			_laber = new Label();
			_laber.text = "";
			_laber.mouseChildren = _laber.mouseEnabled = false;
			addChild(_laber);
			_deleteBtn = new Cross(0x000000, 2, 5, 0);
			_deleteBtn.rotation = 45;
			_deleteBtn.x = _preferWidth - 2;
			_deleteBtn.y = 8;
			addChild(_deleteBtn);
			_deleteBtn.visible = false;
		}
		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			_deleteBtn.addEventListener(MouseEvent.CLICK, deleteHands);
			_buttonContainer.addEventListener(MouseEvent.MOUSE_DOWN, BgMouseDown);
		}
		
		override protected function removeStageControl():void
		{
			super.removeStageControl();
			_deleteBtn.removeEventListener(MouseEvent.CLICK, deleteHands);
			_buttonContainer.removeEventListener(MouseEvent.MOUSE_DOWN, BgMouseDown);
		}
		
		private function deleteHands(e:MouseEvent):void
		{
			if (delBtnHands != null)
				delBtnHands(this);
		}
		
		protected function get viewRectangle():Rectangle
		{
			return UIFramework.resource.getElementRectangle("Public", "PanelHeader")
		}
		
		/*override public function get height():Number
		   {
		   //	return _container.height;
		   }
		
		   override public function get width():Number
		   {
		   //return _container.width;
		 }*/
		public function get text():String
		{
			return _laber.text;
		}
		
		public function set text(value:String):void
		{
			_laber.text = value;
			_preferWidth = _laber.width + 12;
			_buttonScale9Grid.width = _preferWidth;
			_deleteBtn.x = _preferWidth - 8;
		
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function set state(value:String):void
		{
			_state = value;
			//removeContainerAllChild();
			switch (value)
			{
				case ButtonState.NORMAL: 
					//_container.addChild(_checkboxNormal);
					_buttonScale9Grid.updateState(_checkboxNormal, viewRectangle);
					break;
				/*case ButtonState.HOVER:
				   //	_container.addChild(_checkboxHover);
				   _buttonScale9Grid.updateState(_checkboxHover, viewRectangle);
				 break;*/
				case ButtonState.DOWN: 
					//_container.addChild(_checkboxDown);
					_buttonScale9Grid.updateState(_checkboxDown, viewRectangle);
					if (mouseDownHands != null)
						mouseDownHands(this);
					break;
			}
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get isClose():Boolean
		{
			return _isClose;
		}
		
		public function set isClose(value:Boolean):void
		{
			_isClose = value;
			_deleteBtn.visible = value;
		}
		
		private function BgMouseDown(e:MouseEvent):void
		{
			super.onStateMouseDown(e);
			if (isActive && _state != ButtonState.DOWN)
			{
				_state = ButtonState.DOWN;
				_buttonScale9Grid.updateState(_checkboxDown, viewRectangle);
				if (mouseDownHands != null)
					mouseDownHands(this);
			}
		}
	
	/*override protected function onStateRollOver(e:MouseEvent):void
	   {
	   super.onStateRollOver(e);
	   if (isActive)
	   {
	   //	removeContainerAllChild();
	   _buttonScale9Grid.updateState(_checkboxHover, viewRectangle);
	   }
	 }*/
	
	/*override protected function onStateRollOut(e:MouseEvent):void
	   {
	   super.onStateRollOut(e);
	   if (isActive)
	   {
	   //	removeContainerAllChild();
	   _buttonScale9Grid.updateState(_checkboxNormal, viewRectangle);
	   }
	 }*/
	}

}