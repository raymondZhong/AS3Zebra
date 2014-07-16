package zebraui.components.text
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import zebra.system.util.StringHelper;
	import zebraui.components.InteractiveUIComponent;
	
	public class Label extends InteractiveUIComponent
	{
		
		public function Label()
		{
		}
		
		private var _icon:BitmapData;
		private var _iconSymbol:Bitmap;
		private var _textObject:TextField;
		private var _text:String;
		private var _color:uint = 0x000000;
		private var _bold:Boolean;
		private var _italic:Boolean;
		private var _underline:Boolean;
		private var _embedfont:Boolean;
		
		/**
		 * "SimSun" 中文英文都最为清晰
		 */
		//private var _font:String = "SimSun";
		private var _font:String = "Arial";
		//private var _font:String="微软雅黑";
		private var _size:int = 12;
		private var _textFormat:TextFormat;
		
		private var _htmlText:String;
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			_textObject.text = value;
			_autoAglin();
		}
		
		public function get icon():BitmapData
		{
			return _icon;
		}
		
		public function set icon(value:BitmapData):void
		{
			if (_iconSymbol)
				_iconSymbol.bitmapData = null;
			_icon = value;
			if (value != null)
			{
				_iconSymbol = new Bitmap(value);
				if (!this.contains(_iconSymbol))
				{
					addChild(_iconSymbol);
				}
			}
			else
			{
				if (_iconSymbol != null)
				{
					if (this.contains(_iconSymbol))
					{
						removeChild(_iconSymbol);
					}
					_icon = null;
				}
			}
			
			_autoAglin();
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			_textObject.textColor = value;
		}
		
		public function get bold():Boolean
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void
		{
			_bold = value;
			_textFormat.bold = value;
			_textObject.defaultTextFormat = _textFormat;
			_textObject.setTextFormat(_textFormat);
		}
		
		public function get underline():Boolean
		{
			return _underline;
		}
		
		public function set underline(value:Boolean):void
		{
			_underline = value;
			_textFormat.underline = value;
			_textObject.defaultTextFormat = _textFormat;
			_textObject.setTextFormat(_textFormat);
		}
		
		/**
		 * 斜体
		 */
		public function get italic():Boolean
		{
			return _italic;
		}
		
		/**
		 * 斜体
		 */
		public function set italic(value:Boolean):void
		{
			_italic = value;
			_textFormat.italic = value;
			_textObject.defaultTextFormat = _textFormat;
			_textObject.setTextFormat(_textFormat);
		}
		
		public function get font():String
		{
			return _font;
		}
		
		public function set font(value:String):void
		{
			_font = value;
			_textFormat.font = value;
			_textObject.defaultTextFormat = _textFormat;
			_textObject.setTextFormat(_textFormat);
			_autoAglin()
		
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function set size(value:int):void
		{
			_size = value;
			_textFormat.size = value;
			_textObject.defaultTextFormat = _textFormat;
			_textObject.setTextFormat(_textFormat);
			_autoAglin();
		}
		
		override protected function initialize():void
		{
			_textObject = new TextField();
			_textObject.textColor = _color;
			_textObject.autoSize = TextFieldAutoSize.LEFT;
			_textObject.mouseEnabled = false;
			_textObject.tabEnabled = false;
			
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.LEFT;
			_textFormat.font = _font;
			_textFormat.size = _size;
			_textObject.defaultTextFormat = _textFormat;
			addChild(_textObject);
			
			super.initialize();
		}
		
		override public function get width():Number
		{
			//空文字TextField width=4; 整个Label宽多2像素
			if (StringHelper.isWhitespace(_textObject.text))
				return super.width - _textObject.width;
			return _textObject.width;
		}
		
		override public function get height():Number
		{
			//空文字TextField width=4; 整个Label宽多2像素
			if (icon && icon.height > _textObject.height)
			{
				return icon.height;
			}
			return _textObject.height;
		}
		
		public function setTextFormat(textFromat:TextFormat):void
		{
			_textObject.setTextFormat(textFromat);
		}
		
		private function _autoAglin():void
		{
			if (_icon != null)
			{
				if (_iconSymbol.height > _textObject.height)
				{
					_iconSymbol.y = 0;
					_textObject.y = _iconSymbol.height / 2 - _textObject.height / 2;
				}
				else
				{
					_textObject.y = 0;
					_iconSymbol.y = _textObject.height / 2 - _iconSymbol.height / 2
				}
				_textObject.x = _iconSymbol.width + 2;
			}
			else
			{
				_textObject.x = 0;
				_textObject.y = 0;
			}
		}
		
		override public function set disabled(value:Boolean):void
		{
			if (value)
			{
				this._textObject.textColor = 0xC0C0C0
			}
			else
			{
				this._textObject.textColor = _color;
			}
			super.disabled = value;
		}
		
		public function get embedfont():Boolean
		{
			return _embedfont;
		}
		
		public function set embedfont(value:Boolean):void
		{
			_embedfont = value;
			_textObject.embedFonts = _embedfont;
		
		}
		
		public function get htmlText():String
		{
			return _htmlText;
		}
		
		public function set htmlText(value:String):void
		{
			_htmlText = value;
			_textObject.htmlText = value;
			_autoAglin();
		}
		
		override public function dispose():void
		{
			
			if (this.contains(_textObject))
				removeChild(_textObject);
			if (_iconSymbol != null && this.contains(_iconSymbol))
				removeChild(_iconSymbol);
			super.dispose()
		}
	
	}

}