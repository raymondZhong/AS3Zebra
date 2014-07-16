package zebraIso.display
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import zebraIso.data.IsoConfig;
	
	/**
	 * 等角世界坐标轴
	 */
	public class IsoCoordinate extends Sprite
	{
		
		/**
		 * Y轴
		 */
		protected var _height:Number;
		/**
		 * Z轴
		 */
		protected var _length:Number;
		/**
		 * X轴
		 */
		protected var _width:Number;
		
		//sin
		private var _degreesTop_Right:Number = 0.4472135954999579;
		private var _degreesTop_Left:Number = 0.4472135954999579;
		
		public function IsoCoordinate()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			draw();
		}
		
		public function draw(widthX:Number = 300, heightY:Number = 300, lengthZ:Number = 300):void
		{
			_width = widthX;
			_height = heightY;
			_length = lengthZ;
			var topPoint:Point = new Point(0, 0);
			var rightHeight:Number = _degreesTop_Right * _width;
			var rightWidth:Number = Math.sqrt(_width * _width - rightHeight * rightHeight);
			var rightPoint:Point = new Point(rightWidth, rightHeight);
			var leftHeight:Number = _degreesTop_Left * _length;
			var leftWidth:Number = -Math.sqrt(_length * _length - leftHeight * leftHeight);
			var leftPoint:Point = new Point(leftWidth, leftHeight);
			var bottomPoint:Point = new Point(leftWidth + rightWidth, leftHeight + rightHeight);
			this.graphics.clear();
			graphics.beginFill(0xE72D18, 1);
			graphics.lineStyle(2, 0xE72D18, 1);
			graphics.moveTo(topPoint.x, topPoint.y - IsoConfig.IsoGridSize / 2); //Top    Point
			graphics.lineTo(rightPoint.x, rightPoint.y - IsoConfig.IsoGridSize / 2); //Right  Point
			graphics.endFill();
			graphics.beginFill(0x00FF40, 1);
			graphics.lineStyle(2, 0x00FF40, 1);
			graphics.moveTo(topPoint.x, topPoint.y - IsoConfig.IsoGridSize / 2); //Top    Point
			graphics.lineTo(leftPoint.x, leftPoint.y - IsoConfig.IsoGridSize / 2); //Left  Point
			graphics.endFill();
			graphics.beginFill(0x0000A0, 1);
			graphics.lineStyle(2, 0x0000A0, 1);
			graphics.moveTo(topPoint.x, topPoint.y - IsoConfig.IsoGridSize / 2); //Top    Point
			graphics.lineTo(topPoint.x, Point.distance(topPoint, rightPoint) * -1); //Left  Point
			graphics.endFill();
		}
	
	}

}