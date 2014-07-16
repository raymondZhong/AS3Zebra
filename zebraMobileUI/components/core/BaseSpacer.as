package zebraMobileUI.components.core 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class BaseSpacer extends Bitmap
	{
		
		public function BaseSpacer( transparent:Boolean=true, fillColor:uint=0xFFFFFF)
		{
			 var bmd:BitmapData = new BitmapData (1, 1, transparent, fillColor);
			 super(bmd);
			 width = 1;
			 height = 1;
		}
		
	}

}