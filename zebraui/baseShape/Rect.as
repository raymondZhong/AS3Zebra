package zebraui.baseShape
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Rect extends Sprite
	{
		private var _lineColor:uint;
		public var bgColor:Number;
		public var bgAlhpa:Number = 1;
		public function Rect(width:Number, height:Number,lineColor:Number=0x1A1AFF,bgCol:Number=0xFFFFFF)
		{
			_w = width;
			_h = height;
			_lineColor = lineColor;
			bgColor = bgCol;
			render();
		}
		
		private var _w:Number = 0;
		private var _h:Number = 0;
		
		
		
		override public function get width():Number 
		{
			return _w;
		}
		
		override public function set width(value:Number):void 
		{
			_w = value;
			super.width = _w;
			render();
		}
		
		
		override public function get height():Number 
		{
			return _h;
		}
		
		override public function set height(value:Number):void 
		{
			_h = value;
			super.height = _h;
			render();
		}
		
		
		public function render():void
		{
			graphics.clear();
			graphics.beginFill(bgColor,bgAlhpa)
			graphics.lineStyle(1, _lineColor, 1);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
		}
	
	}

}