package zebraIso.graphics 
{
	public class SolidColorFill 
	{
		
		
		public var thickness:Number;		
		public var lineColor:uint;		
		public var lineAlpha:Number;
		
		public var fillColor:uint;
		public var fillAlpha:Number;
		
		
		
		public function SolidColorFill(linecolor:uint=0x000000,fillcolor:uint=0xC0C0C0, lineAlpha:Number=1,fillAlpha:Number=0.5,thickness:Number=1) 
		{
		 	this.thickness = thickness;
		 	this.lineColor = linecolor;
		 	this.fillColor = fillcolor;
		 	this.lineAlpha = lineAlpha;
		 	this.fillAlpha = fillAlpha;
		}
		
	}

}