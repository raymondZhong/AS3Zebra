package zebraui.components.panel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import zebraMobileUI.util.Scale9GridBitmap;
	import zebraui.baseShape.Cross;
	import zebraui.baseShape.Rect;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	import zebraui.event.ColorPickerEvent;
	
	[Event(name="CompleteColorSelection",type="zebraui.event.ColorPickerEvent")]
	public class ColorPicker extends UIComponent
	{
		private var picker:Sprite = new Sprite();
		private var colorClip:Sprite = new Sprite();
		private var pickerBd:BitmapData;
		private var rainbowWidth:Number;
		private var rainbowHeight:Number;
		private var background9Sprite:Scale9GridBitmap;
		private var _colorBox:TextField = new TextField();
		private var _color:uint;
		private var _cro:Cross;
		
		public function ColorPicker(preferWidth:Number = 240, preferHeight:Number = 300, color:uint = 0xFFFFFF)
		{
			super(preferWidth, preferHeight);
			_preferWidth = preferWidth < 10 ? 10 : preferWidth;
			_preferHeight = preferHeight < 40 ? 40 : preferHeight;
			rainbowWidth = _preferWidth - 10;
			rainbowHeight = _preferHeight - 40;
			_color = color;
			var bd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Image.Normal");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Public", "Image");
			background9Sprite = new Scale9GridBitmap(bd, rect);
			background9Sprite.width = _preferWidth;
			background9Sprite.height = _preferHeight;
			addChild(background9Sprite)
			this.addChild(picker);
			picker.x = 5;
			picker.y = 5;
			pickerBd = new BitmapData(rainbowWidth, rainbowHeight, false);
			colorClip.addChild(new Rect((rainbowWidth - 10) / 2 < 100 ? (rainbowWidth - 10) / 2 : 100, 25, 0xFFFFFF, _color));
			colorClip.x = 5;
			colorClip.y = _preferHeight - 30;
			addChild(colorClip);
			_colorBox.width = (rainbowWidth - 10) / 2 < 100 ? (rainbowWidth - 10) / 2 : 100;
			_colorBox.height = 25;
			_colorBox.x = _preferWidth - _colorBox.width - 5;
			_colorBox.y = _preferHeight - 30;
			_colorBox.border = true;
			_colorBox.background = true;
			_colorBox.backgroundColor = 0xFFFFFF;
			_colorBox.text = "#" + displayInHex(_color);
			addChild(_colorBox);
			_cro = new Cross();
			_cro.mouseChildren = _cro.mouseEnabled = false;
			drawPicker();
			picker.addChild(_cro);
			var mskSp:Sprite = new Sprite();
			mskSp.graphics.beginFill(0x000000);
			mskSp.graphics.drawRect(5, 5, rainbowWidth, rainbowHeight);
			mskSp.graphics.endFill();
			addChild(mskSp);
			picker.mask = mskSp;
			var po:Point = GetColorPoint(pickerBd, _color);
			_cro.x = po.x;
			_cro.y = po.y;
			picker.addEventListener(MouseEvent.MOUSE_MOVE, PickerMoveHands);
			picker.addEventListener(MouseEvent.CLICK, PickerClickHands);
		}
		
		private function drawPicker():void
		{
			
			var pickerBmp:Bitmap = new Bitmap();
			
			var container:Sprite = new Sprite();
			
			var rainbow:Shape = new Shape();
			
			container.addChild(rainbow);
			
			var shadeBlack:Shape = new Shape();
			
			container.addChild(shadeBlack);
			
			shadeBlack.y = rainbowHeight / 2;
			
			var shadeWhite:Shape = new Shape();
			
			container.addChild(shadeWhite);
			
			var mat:Matrix;
			
			var colors:Array;
			
			var alphas:Array;
			
			var ratios:Array;
			
			mat = new Matrix();
			
			colors = [0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF, 0x0000FF, 0xFF00FF];
			
			alphas = [1, 1, 1, 1, 1, 1];
			
			ratios = [5, 51, 102, 153, 204, 250];
			
			mat.createGradientBox(rainbowWidth, rainbowHeight);
			
			rainbow.graphics.lineStyle();
			
			rainbow.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			rainbow.graphics.drawRect(0, 0, rainbowWidth, rainbowHeight);
			
			rainbow.graphics.endFill();
			
			mat = new Matrix();
			
			colors = [0x000000, 0x000000];
			
			alphas = [1, 0];
			
			ratios = [0, 255];
			
			mat.createGradientBox(rainbowWidth, rainbowHeight / 2, toRad(-90));
			
			shadeBlack.graphics.lineStyle();
			
			shadeBlack.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			
			shadeBlack.graphics.drawRect(0, 0, rainbowWidth, rainbowHeight / 2);
			
			shadeBlack.graphics.endFill();
			
			mat = new Matrix();
			
			colors = [0xFFFFFF, 0xFFFFFF];
			
			alphas = [1, 0];
			
			ratios = [0, 255];
			
			mat.createGradientBox(rainbowWidth, rainbowHeight / 2, toRad(90));
			
			shadeWhite.graphics.lineStyle();
			
			shadeWhite.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			
			shadeWhite.graphics.drawRect(0, 0, rainbowWidth, rainbowHeight / 2);
			
			shadeWhite.graphics.endFill();
			
			colors = [0x000000, 0xFFFFFF];
			
			alphas = [1, 1];
			
			ratios = [5, 250];
			var bottomShape:Shape = new Shape;
			bottomShape.graphics.beginFill(0x000000, 1);
			bottomShape.graphics.drawRect(0, 0, rainbowWidth, 5);
			bottomShape.graphics.endFill();
			bottomShape.y = rainbowHeight - 5;
			container.addChild(bottomShape);
			pickerBd.draw(container);
			
			pickerBmp.bitmapData = pickerBd;
			
			picker.addChild(pickerBmp);
		
		}
		
		public function setCoordinate(_cx:Number, _cy:Number, _width:Number = 0):void
		{
			if (!this.stage)
				return;
			var sx:Number = _cx + _preferWidth < this.stage.stageWidth ? _cx : this.stage.stageWidth - _preferWidth;
			var sy:Number = _cy + _width + _preferHeight < this.stage.stageHeight ? _cy + _width : _cy - _preferHeight;
			super.setPosition(sx, sy);
		}
		
		public override function dispose():void
		{
			super.dispose();
			pickerBd.dispose();
			picker.removeEventListener(MouseEvent.MOUSE_MOVE, PickerMoveHands);
			picker.removeEventListener(MouseEvent.CLICK, PickerClickHands);
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		private function PickerMoveHands(e:MouseEvent):void
		{
			_cro.x = picker.mouseX;
			_cro.y = picker.mouseY;
			if (picker.mouseX == rainbowWidth)
			{
				return;
			}
			
			var c:uint;
			
			var ct:ColorTransform = new ColorTransform();
			var r:uint;
			
			var g:uint;
			
			var b:uint;
			
			c = pickerBd.getPixel(picker.mouseX, picker.mouseY);
			_color = c;
			ct.color = c;
			
			colorClip.transform.colorTransform = ct;
			r = extractRed(c);
			
			g = extractGreen(c);
			
			b = extractBlue(c);
			_colorBox.text = "#" + displayInHex(c);
		
		}
		
		private function GetColorPoint(_data:BitmapData, _color:uint = 0xFFFFFF):Point
		{
			var p:Point = new Point();
			if (!_data)
				return p;
			var m:int = 0;
			var n:int = 0;
			var thisColor:uint;
			for (var i:int = 0; i < 10; i++)
			{
				for (m = 0; m <= _data.width; m++)
				{
					for (n = 0; n <= _data.height; n++)
					{
						thisColor = _data.getPixel(m, n);
						if (Math.abs(thisColor - _color) <= i)
						{
							p.x = m;
							p.y = n;
							return p;
						}
					}
				}
			}
			return p;
		}
		
		private function PickerClickHands(e:MouseEvent):void
		{
			var event:ColorPickerEvent = new ColorPickerEvent(ColorPickerEvent.CompleteColorSelection);
			this.dispatchEvent(event);
		}
		
		private function toRad(a:Number):Number
		{
			
			return a * Math.PI / 180;
		
		}
		
		private function displayInHex(c:uint):String
		{
			
			var r:String = extractRed(c).toString(16).toUpperCase();
			
			var g:String = extractGreen(c).toString(16).toUpperCase();
			
			var b:String = extractBlue(c).toString(16).toUpperCase();
			
			var hs:String = "";
			
			var zero:String = "0";
			
			if (r.length == 1)
			{
				
				r = zero.concat(r);
			}
			
			if (g.length == 1)
			{
				
				g = zero.concat(g);
			}
			
			if (b.length == 1)
			{
				
				b = zero.concat(b);
			}
			
			hs = r + g + b;
			
			return hs;
		
		}
		
		private function extractRed(c:uint):uint
		{
			
			return ((c >> 16) & 0xFF);
		
		}
		
		private function extractGreen(c:uint):uint
		{
			
			return ((c >> 8) & 0xFF);
		
		}
		
		private function extractBlue(c:uint):uint
		{
			
			return (c & 0xFF);
		
		}
		
		public function get color():uint
		{
			return _color;
		}
	
	}

}