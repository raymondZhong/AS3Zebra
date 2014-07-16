package zebraui.baseShape
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author find
	 */
	public class Cross extends Sprite
	{
		private var _color:uint;
		private var _thickness:Number;
		private var _breadth:Number;
		private var _distance:Number;
		private var _BgSp:Sprite;
		
		public function Cross(color:uint = 0x000000, thickness:Number = 2, breadth:Number = 5, distance:Number = 5)
		{
			_color = color;
			_thickness = thickness;
			_breadth = breadth;
			_distance = distance;
			_BgSp = new Sprite();
			addChild(_BgSp);
			draw();
		}
		
		private function draw():void
		{
			this.graphics.lineStyle(_thickness, _color);
			this.graphics.moveTo(-1 * (_breadth + _distance), 0);
			this.graphics.lineTo(-1 * _distance, 0);
			this.graphics.moveTo(0, -1 * (_breadth + _distance));
			this.graphics.lineTo(0, -1 * _distance);
			this.graphics.moveTo(_breadth + _distance, 0);
			this.graphics.lineTo(_distance, 0);
			this.graphics.moveTo(0, _breadth + _distance);
			this.graphics.lineTo(0, _distance);
			this.graphics.endFill();
			_BgSp.graphics.beginFill(0xFFFFFF, 0);
			_BgSp.graphics.drawRect( -1 * (_breadth + _distance), -1 * (_breadth + _distance), 2 * (_breadth + _distance), 2 * (_breadth + _distance));
			_BgSp.graphics.endFill();
		}
	
	}

}