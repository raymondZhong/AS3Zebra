package zebraui.components.form
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import zebraui.components.UIComponent;
	import zebraui.event.TextInputEvent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	[Event(name="textinput_change",type="zebraui.event.TextInputEvent")]
	
	public class TextInput extends UIComponent
	{
		private var _textObject:TextField;
		private var _textScale9Grid:Scale9GridBitmap;
		private var _textFormat:TextFormat;
		private var _editable:Boolean;
		
		public function TextInput(preferWidth:Number = 100, preferHeight:Number = 22)
		{
			_editable = true;
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_textScale9Grid = new Scale9GridBitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.TextInput.Normal"), 
												   UIFramework.resource.getElementRectangle("Public", "TextInput"));
			_textScale9Grid.width = _preferWidth;
			_textScale9Grid.height = _preferHeight;
			addChild(_textScale9Grid);
			
			_textObject = new TextField();
			_textObject.width = _textScale9Grid.width - 4;
			_textObject.height = _textScale9Grid.height - 4;
			_textObject.text = "";
			_textObject.type = TextFieldType.INPUT;
			_textObject.x = 2;
			_textObject.y = 2;
			
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.LEFT;
			_textFormat.font = "SimSun";
			_textFormat.size = 12;
			_textObject.defaultTextFormat = _textFormat;
			addChild(_textObject);
			
			super.initialize();
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
			super.removeStageControl();
		}
		
		private function _inputTextLogic(e:*):void
		{
			var event:TextInputEvent = new TextInputEvent(TextInputEvent.TEXTINPUT);
			event.text = this.text;
			this.dispatchEvent(event);
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