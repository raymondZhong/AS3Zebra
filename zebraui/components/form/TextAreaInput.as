package zebraui.components.form
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import zebraui.components.container.Box;
	import zebraui.components.layout.VBoxLayout;
	import zebraui.components.panel.ScrollPanel;
	import zebraui.components.silder.VSilderBar;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	import zebraui.event.TextInputEvent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	[Event(name="textinput_change",type="zebraui.event.TextInputEvent")]
	
	public class TextAreaInput extends UIComponent
	{
		private var _textObject:TextField;
		private var _textScale9Grid:Scale9GridBitmap;
		private var _textFormat:TextFormat;
		private var _editable:Boolean;
		private var _VSilderBar:VSilderBar
		private var _process:Number = 1;
		private var _wheelBet:Number = 0.1;
		
		public function TextAreaInput(preferWidth:Number = 200, preferHeight:Number = 100)
		{
			_editable = true;
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_textScale9Grid = new Scale9GridBitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.TextInput.Normal"), UIFramework.resource.getElementRectangle("Public", "TextInput"));
			_textScale9Grid.width = _preferWidth;
			_textScale9Grid.height = _preferHeight;
			addChild(_textScale9Grid);
			
			_textObject = new TextField();
			_textObject.width = _textScale9Grid.width - 4;
			_textObject.height = _textScale9Grid.height - 4;
			_textObject.wordWrap = true;
			_textObject.multiline = true;
			_textObject.text = "";
			_textObject.type = TextFieldType.INPUT;
			
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.LEFT;
			_textFormat.font = "SimSun";
			_textFormat.size = 12;
			_textObject.defaultTextFormat = _textFormat;
			//addChild(_textObject);
			
			//var vbox:VBoxLayout = new VBoxLayout();
			//	vbox.autoHeight = true;
			//_textBody = new ScrollPanel(_textScale9Grid.width - 4, _textScale9Grid.height - 4, "auto");
			//	_textBody.x = 2;
			//_textBody.y = 2;
			//_textBody.setLayout(vbox);
			//_textBody.scrollDrag = true;
			//_textBody.append(_textObject);
			//addChild(_textBody);
			var _textBox:Box = new Box(_textScale9Grid.width - 4, _textScale9Grid.height - 4);
			_textBox.append(_textObject);
			_textBox.x = 2;
			_textBox.y = 2;
			addChild(_textBox);
			_VSilderBar = new VSilderBar();
			_VSilderBar.height = _preferHeight;
			_VSilderBar.x = _preferWidth - _VSilderBar.width;
			_VSilderBar.progress = 1;
			_VSilderBar.addEventListener(SilderEvent.DRAGING, _SilderEventHands);
			_VSilderBar.addEventListener(SilderEvent.PROGRESS, _SilderEventHands);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, thisWheelHands);
			//_VSilderBar. =
			addChild(_VSilderBar);
			RefreshScrollBar();
			super.initialize();
		}
		
		private function thisWheelHands(e:MouseEvent):void
		{
			_VSilderBar.progress += e.delta * 0.1 * -1 * _wheelBet;
			_process = _VSilderBar.progress;
			RefreshScrollBar();
		}
		
		private function _SilderEventHands(e:SilderEvent):void
		{
			_process = e.process;
			RefreshScrollBar();
		}
		
		private function RefreshScrollBar():void
		{
			if (_textObject.height > _textScale9Grid.height - 4)
			{
				_VSilderBar.visible = true;
				_textObject.y = (_textScale9Grid.height - 4 - _textObject.height) * _process;
				_textObject.width = _textScale9Grid.width - 4 - _VSilderBar.width;
			}
			else
			{
				_textObject.y = 0;
				_VSilderBar.visible = false;
				_textObject.width = _textScale9Grid.width - 4;
			}
		}
		
		/**
		 * 正则输入规则
		 */
		public function set restrict(value:String):void
		{
			_textObject.restrict = value;
		}
		
		override protected function addToStageControl():void
		{
			addEventListener(MouseEvent.CLICK, focusLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, lostfocusLogic);
			_textObject.addEventListener(KeyboardEvent.KEY_UP, _inputTextLogic);
			super.addToStageControl();
		}
		
		override protected function removeStageControl():void
		{
			removeEventListener(MouseEvent.CLICK, focusLogic);
			stage.removeEventListener(MouseEvent.MOUSE_UP, lostfocusLogic);
			_textObject.removeEventListener(KeyboardEvent.KEY_UP, _inputTextLogic);
			_VSilderBar.removeEventListener(SilderEvent.DRAGING, _SilderEventHands);
			_VSilderBar.removeEventListener(SilderEvent.PROGRESS, _SilderEventHands);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, thisWheelHands);
			super.removeStageControl();
		}
		
		private function _inputTextLogic(e:*):void
		{
			var event:TextInputEvent = new TextInputEvent(TextInputEvent.TEXTINPUT);
			event.text = this.text;
			this.dispatchEvent(event);
			_textObject.autoSize = TextFormatAlign.LEFT;
			RefreshScrollBar();
		}
		
		protected function lostfocusLogic(e:MouseEvent):void
		{
			if (!hitMouse())
			{
				
			}
		}
		
		protected function focusLogic(e:MouseEvent):void
		{
			stage.focus = _textObject;
			if (!this.enabled)
				return;
		
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_textScale9Grid.width = value;
			_textObject.width = _textScale9Grid.width - 4;
		}
		
		override public function get width():Number
		{
			return _textScale9Grid.width;
		}
		
		override public function set height(value:Number):void
		{
			super.width = value;
			_textScale9Grid.height = value;
			_textObject.height = _textScale9Grid.height - 4;
		}
		
		override public function get height():Number
		{
			return _textScale9Grid.height;
		}
		
		public function get text():String
		{
			return _textObject.text;
		}
		
		public function set text(value:String):void
		{
			_textObject.text = value;
			if (value != "")
			{
				_textObject.autoSize = TextFormatAlign.LEFT;
			}
			RefreshScrollBar();
		}
		
		public function get editable():Boolean
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void
		{
			_editable = value;
			this.enabled = true;
			if (value)
			{
				_textObject.type = TextFieldType.INPUT;
				_textObject.selectable = true;
			}
			else
			{
				_textObject.type = TextFieldType.DYNAMIC;
				_textObject.selectable = false;
			}
		
		}
	
	}

}