package zebraui.components.text
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat; 
	import zebraui.components.UIComponent;
	
	public class TextWord extends UIComponent
	{
		private var _textObject:TextField;
		
		public function TextWord(preferWidth:Number=1, preferHeight:Number=1)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			_textObject = new TextField();			
			_textObject.mouseWheelEnabled = false;
			//_textObject.wordWrap = true;
			_textObject.autoSize = TextFieldAutoSize.LEFT;
			_textObject.multiline = true;
			var textFormat:TextFormat = new TextFormat();
				textFormat.font = "宋体"
				textFormat.size = 12;
				textFormat.leading = 5;
				textFormat.letterSpacing = 0;
				_textObject.defaultTextFormat = textFormat;
				addChild(_textObject);
			super.initialize();
		}
		
		public function set color(value:uint):void
		{
			_textObject.textColor = value;
		}
		
		public function get color():uint
		{
			return _textObject.textColor;
		}
		
		public function setTextFormat(value:TextFormat):void
		{
			_textObject.setTextFormat(value);
		}
		
		override public function set width(value:Number):void
		{
			_textObject.width = value;
			super.width = value;
		}
		
		override public function get width():Number
		{
			return _textObject.width;
		}
		
		public function set text(value:String):void
		{
			_textObject.text = value;
		}
		
		public function get text():String
		{
			return _textObject.text;
		}
	}

}