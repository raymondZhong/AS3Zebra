package zebraMobileUI.components.text 
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import zebra.mobile.MobileFont;
	import zebraMobileUI.components.MobileComponent;
	
	public class Label extends MobileComponent
	{
		private var _textObject:TextField; 
		private var _textColor:uint;
		private var _bold:Boolean;
		private var _italic:Boolean;
		private var _underline:Boolean;
		
		private var _font:String;
		private var _size:int = 20;
		private var _textFormat:TextFormat;
		
		public function Label(text:String="") 
		{
			super();
			_textObject = new TextField();
			_textObject.htmlText = text;
			_textObject.selectable = false;			
			_textObject.autoSize = TextFieldAutoSize.LEFT;
			addChild(_textObject); 
			size = 24;
			setFont(MobileFont.XHT);
		}
		
		public function get textColor():uint 
		{
			return _textObject.textColor;
		}
		
		public function set textColor(value:uint):void 
		{
			_textObject.textColor = value;
		}
		
		public function get size():int 
		{
			return _size;
		}
		
		public function set size(value:int):void 
		{
			_size = value;
			var tf:TextFormat = new TextFormat();
			    tf.size = value;
				_textObject.setTextFormat(tf);
		}
		
		public function get bold():Boolean 
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;			
			var tf:TextFormat = new TextFormat();
			    tf.bold = value;
				_textObject.setTextFormat(tf);
		}
		
		public function get italic():Boolean 
		{
			return _italic;
		}
		
		public function set italic(value:Boolean):void 
		{
			_italic = value;			
			var tf:TextFormat = new TextFormat();
			    tf.italic = value;
				_textObject.setTextFormat(tf);
		}
		
		public function get underline():Boolean 
		{
			return _underline;
		}
		
		public function set underline(value:Boolean):void 
		{
			_underline = value;
			var tf:TextFormat = new TextFormat();
			    tf.underline = value;
				_textObject.setTextFormat(tf);
			
		}
		
		public function get htmlText():String 
		{
			return _textObject.htmlText;
		}
		
		public function set htmlText(value:String):void 
		{
			_textObject.htmlText = value;
			size = _size;
			if (_font&&_font.length > 0) setFont(_font);
		} 		
		
		public function get text():String 
		{
			return _textObject.text;
		}
		
		public function set text(value:String):void 
		{
			_textObject.text = value;
			size = _size;
			if (_font&&_font.length > 0) setFont(_font);
		} 
		
		public function setFont(name:String,embed:Boolean=true):void {
			_textObject.embedFonts = embed;
			_font = name;
			var tf:TextFormat = new TextFormat();
			    tf.font = name;
				_textObject.setTextFormat(tf);				
				_textObject.antiAliasType = AntiAliasType.ADVANCED;
			}
		
		
 
		
		public function setTextFormat(tf:TextFormat):void {
				_textObject.setTextFormat(tf);
			}
		
		
	}

}