package zebraui.baseShape 
{
	import flash.display.Shape;
	
	public class Diamond extends Shape
	{
		
		public function Diamond(width:Number,height:Number) 
		{
			_w = width*1.42;
			_h = height * 0.71;
			this.cacheAsBitmap = true;
		    render();
		}
		
		private var _w:Number = 0;
		private var _h:Number = 0;
		public function render():void {
			 graphics.clear();
			 graphics.beginFill(0xFF000000,0.00001)
			 graphics.lineStyle(1, 0x990000, 1);	
			 graphics.moveTo(_w / 2, 0);
			 graphics.lineTo(0, _h / 2);
			 graphics.lineTo(_w / 2, _h);
			 graphics.lineTo(_w, _h / 2);
 			 graphics.lineTo(_w / 2, 0);	
			 graphics.endFill();
			}
		
		
	}

}