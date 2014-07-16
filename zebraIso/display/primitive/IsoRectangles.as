package zebraIso.display.primitive 
{
	import zebraIso.graphics.SolidColorFill;
	public class IsoRectangles extends IsoBox
	{
		
		public function IsoRectangles(width:Number=1,length:Number=1) 
		{
			super(width, 0, length)
			_colorfill = Vector.<SolidColorFill>([
													new SolidColorFill(0x005716,0x00E83A,1,0.7,2), 
													new SolidColorFill(0x005716,0x00E83A,1,0.7,2), 
													new SolidColorFill(0x005716,0x00E83A,1,0.7,2),  
													new SolidColorFill(0x005716,0x00E83A,1,0.7,2), 
													new SolidColorFill(0x005716,0x00E83A,1,0.7,2), 
													new SolidColorFill(0x005716, 0x00E83A, 1, 0.7, 2)
													]);
		}
		
		
		
		
	}

}