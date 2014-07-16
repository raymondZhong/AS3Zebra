package zebraui.baseShape
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author find
	 */
	public class Hr extends Sprite
	{
		
		private var _preferWidth:Number;
		private var _topLinethickness:Number;
		private var _bottomLinethickness:Number;
		private var _topLineColor:uint;
		private var _bottomLineColor:uint;
		private var topLine:Sprite;
		private var bottomLine:Sprite;
		/**
		 * @param _width 线条宽度;
		 * @param _topthickness 顶部线条厚度;
		 * @param _bottomthickness 底部线条厚度;
		 * @param _topColor 顶部线条颜色;
		 * @param _bottomColor 底部线条颜色;
		 * */
		public function Hr(_width:Number = 100, _topthickness:Number = 1, _bottomthickness:Number = 1, _topColor:uint = 0x000000, _bottomColor:uint = 0x808080)
		{
			_preferWidth = _width;
			_topLinethickness = _topthickness;
			_bottomLinethickness = _bottomthickness;
			_topLineColor = _topColor;
			_bottomLineColor = _bottomColor;
			topLine = new Sprite();
			bottomLine = new Sprite();
			addChild(topLine);
			addChild(bottomLine);
			draw();
		}
		
		private function draw():void
		{
			topLine.graphics.clear();
			topLine.graphics.lineStyle(_topLinethickness, _topLineColor);
			topLine.graphics.moveTo(0, 0);
			topLine.graphics.lineTo(_preferWidth, 0);
			topLine.graphics.endFill();
			bottomLine.y = _topLinethickness;
			bottomLine.graphics.clear();
			bottomLine.graphics.lineStyle(_bottomLinethickness, _bottomLineColor);
			bottomLine.graphics.moveTo(0, 0);
			bottomLine.graphics.lineTo(_preferWidth, 0);
			bottomLine.graphics.endFill();
		}
		
		public function dispose():void
		{
			topLine.graphics.clear();
			bottomLine.graphics.clear();
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		public override function get width():Number
		{
			return _preferWidth;
		}
		
		public override function set width(value:Number):void
		{
			_preferWidth = value;
			draw();
		}
		
		public function get topLinethickness():Number
		{
			return _topLinethickness;
		}
		
		public function set topLinethickness(value:Number):void
		{
			_topLinethickness = value;
			draw();
		}
		
		public function get bottomLinethickness():Number
		{
			return _bottomLinethickness;
		}
		
		public function set bottomLinethickness(value:Number):void
		{
			_bottomLinethickness = value;
			draw();
		}
		
		public function get topLineColor():uint
		{
			return _topLineColor;
		}
		
		public function set topLineColor(value:uint):void
		{
			_topLineColor = value;
			draw();
		}
		
		public function get bottomLineColor():uint
		{
			return _bottomLineColor;
		}
		
		public function set bottomLineColor(value:uint):void
		{
			_bottomLineColor = value;
			draw();
		}
	
	}

}