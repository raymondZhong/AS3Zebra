package zebraui.components.button
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle; 
	import zebraui.components.container.Box;
	import zebraui.components.container.Container;
	import zebraui.components.layout.HBoxLayout;
	import zebraui.components.layout.LayoutAlign;
	import zebraui.components.text.Label;
	import zebraui.effect.Effect;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class BaseButton extends AbstractButton
	{
		
		protected var _normal_bitmapdata:BitmapData;
		protected var _down_bitmapdata:BitmapData;
		protected var _hover_bitmapdata:BitmapData;
		protected var _disable_bitmapdata:BitmapData;
		private var _textLabel:Label;
		private var _buttonContainer:Box;
		protected var _buttonScale9Grid:Scale9GridBitmap;
		
		public function BaseButton(preferWidth:Number = 50, preferHeight:Number = 23)
		{
			this._disable_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.DISABLED);
			this._down_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.DOWN);
			this._hover_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.HOVER);
			this._normal_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.NORMAL);
			super(preferWidth, preferHeight);
		}
		
		override public function set theme(value:String):void
		{
			if (this.theme != value)
			{
				super.theme = value;
				this._disable_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.DISABLED);
				this._down_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.DOWN);
				this._hover_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.HOVER);
				this._normal_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.NORMAL);
				if (_flat)
					this._normal_bitmapdata = new BitmapData(this._normal_bitmapdata.width, this._normal_bitmapdata.height, true, 0xFFFFFF);
				state = this._state;
			}
		}
		
		override protected function initialize():void
		{			
			_auotsize = true;
			_buttonScale9Grid = new Scale9GridBitmap(_normal_bitmapdata, viewRectangle);
			_buttonScale9Grid.width = _preferWidth;
			_buttonScale9Grid.height = _preferHeight;
			addChild(_buttonScale9Grid);
			
			
			var hbox:HBoxLayout = new HBoxLayout();
				hbox.vAlign =   LayoutAlign.VAlign_CENTER;
				hbox.hAlign =   LayoutAlign.HAlign_CENTER;
			_buttonContainer = new Box(_preferWidth, _preferHeight-2);
			_buttonContainer.setLayout(hbox);
			addChild(_buttonContainer);			
			_textLabel = new Label();
			_textLabel.text = "";
			_buttonContainer.append(_textLabel);			
			super.initialize();
		}
		
		override protected function addToStageControl():void 
		{
			super.addToStageControl();
			this.width = _preferWidth;
			this.height = _preferHeight;
			_buttonContainer.width = _preferWidth;
			_buttonContainer.height = _preferHeight-2;
		}
		
		
		protected function get viewRectangle():Rectangle
		{
			return UIFramework.resource.getElementRectangle("Button", this.theme)
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_buttonScale9Grid.width = _preferWidth;
			_buttonContainer.width = _preferWidth;					
			
		}
		override public function get width():Number
		{
			return _preferWidth;
		}
		
			override public function get height():Number
		{
			return _preferHeight;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_buttonScale9Grid.height = _preferHeight;	
			_buttonContainer.height = _preferHeight-2;
		}
		
	
		override public function get enabled():Boolean
		{
			return super.enabled;
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
		}
		
		override public function get disabled():Boolean
		{
			return super.disabled;
		}
		
		override public function set disabled(value:Boolean):void
		{
			super.disabled = value;
			if (value)
			{
				_buttonScale9Grid.updateState(this._disable_bitmapdata);
				_state = ButtonState.DISABLED;
				_textLabel.disabled = value;
				Effect.gray(this);
			}
			else
			{
				_buttonScale9Grid.updateState(this._normal_bitmapdata);
				_state = ButtonState.NORMAL;
				_textLabel.disabled = value;
				Effect.reset(this);
			}
		}
		
		override public function get state():String
		{
			return _state;
		}
		
		/**
		 *  class ButtonState
		 */
		override public function set state(value:String):void
		{
			_state = value;
			switch (value)
			{
				case ButtonState.NORMAL: 
					_buttonScale9Grid.updateState(this._normal_bitmapdata, viewRectangle);
					IsClickOver = false;
					break;
				case ButtonState.HOVER: 
					_buttonScale9Grid.updateState(this._hover_bitmapdata, viewRectangle);
					break;
				case ButtonState.DOWN: 
					_buttonScale9Grid.updateState(this._down_bitmapdata, viewRectangle);
					break;
				case ButtonState.DISABLED: 
					_buttonScale9Grid.updateState(this._disable_bitmapdata, viewRectangle);
					break;
			}
		}
		
		override public function get text():String
		{
			return _textLabel.text;
		}
		
		override public function set text(value:String):void
		{
			_textLabel.text = value;
			_setbuttonPosition();
		
		}
		
		public function get icon():BitmapData
		{
			return _textLabel.icon;
		}
		
		public function set icon(value:BitmapData):void
		{
			_textLabel.icon = value;
			_setbuttonPosition();
		}
		
		private function _setbuttonPosition():void
		{
			if (_auotsize)
			{
				if (_textLabel.width + 20<=_preferWidth) {
					_buttonScale9Grid.width = _textLabel.width + 20;					
					}else {
					_preferWidth =  _textLabel.width + 20;	
					_buttonScale9Grid.width = _preferWidth;
					}
			}
			else
			{
				_buttonScale9Grid.width = _preferWidth;
			}
			_buttonContainer.width = _preferWidth;
		
		}
		
		override public function dispose():void
		{
			_textLabel.dispose();
			_buttonContainer.dispose();
			super.dispose()
		}
		
		override protected function onStateClick(e:MouseEvent):void
		{
			super.onStateClick(e);
			if (isActive && _flat && !_toggle)
			{
				_buttonScale9Grid.updateState(this._hover_bitmapdata);
			}
			if (isActive && _flat && _toggle && IsReleased)
			{
				_buttonScale9Grid.updateState(this._hover_bitmapdata);
			}
		}
		
		override protected function onStateMouseDown(e:MouseEvent):void
		{
			super.onStateMouseDown(e);
			if (isActive && !_toggle)
			{
				_buttonScale9Grid.updateState(this._down_bitmapdata);
			}
			
			if (isActive && _toggle)
			{
				if (IsReleased)
				{
					_buttonScale9Grid.updateState(this._down_bitmapdata);
				}
			}
		}
		
		override protected function onStateMouseUp(e:MouseEvent):void
		{
			super.onStateMouseUp(e);
			if (hitMouse())
			{
				if (isActive && !_toggle)
					_buttonScale9Grid.updateState(this._hover_bitmapdata);
				
				if (isActive && _toggle)
				{
					if (IsReleased)
					{
						_buttonScale9Grid.updateState(this._hover_bitmapdata);
					}
				}
			}
		}
		
		override protected function onStateRollOut(e:MouseEvent):void
		{
			super.onStateRollOut(e);
			if (isActive && !_toggle)
				_buttonScale9Grid.updateState(this._normal_bitmapdata);
			
			if (isActive && IsClickOver)
			{
				if (isActive && _flat && _toggle && IsReleased)
				{
					_buttonScale9Grid.updateState(this._normal_bitmapdata);
				}
				if (isActive && _flat && _toggle && IsPressed)
				{
					_buttonScale9Grid.updateState(this._down_bitmapdata);
				}
				if (isActive && !_flat && _toggle && IsPressed)
				{
					_buttonScale9Grid.updateState(this._down_bitmapdata);
				}
				if (isActive && !_flat && _toggle && IsReleased)
				{
					_buttonScale9Grid.updateState(this._hover_bitmapdata);
				}
			}
			
			if (isActive && !IsClickOver)
			{
				_buttonScale9Grid.updateState(this._normal_bitmapdata);
				
			}
		
		}
		
		 
		
		override protected function onStateRollOver(e:MouseEvent):void
		{
			super.onStateRollOver(e);
			
			if (isActive && !_toggle)
				_buttonScale9Grid.updateState(this._hover_bitmapdata);
			
			if (isActive && _toggle)
				_buttonScale9Grid.updateState(this._hover_bitmapdata);
			
			if (isActive && _toggle && _flat)
				_buttonScale9Grid.updateState(this._down_bitmapdata);
			
			if (isActive && _toggle && _flat && IsReleased)
				_buttonScale9Grid.updateState(this._hover_bitmapdata);
		}
		
		override public function set flat(value:Boolean):void
		{
			if (value)
			{
				this._normal_bitmapdata = new BitmapData(this._normal_bitmapdata.width, this._normal_bitmapdata.height, true, 0xFFFFFF);
			}
			else
			{
				this._normal_bitmapdata = UIFramework.resource.getButtonBitmapData(theme, ButtonState.NORMAL);
			}
			_buttonScale9Grid.updateState(this._normal_bitmapdata);
			_flat = value;
		}
		
		public function get textcolor():uint 
		{
			return _textLabel.color;
		}
		
		public function set textcolor(value:uint):void 
		{
			_textLabel.color = value;
		}
		
 
	
	}

}