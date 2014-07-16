package zebra.data 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class SubTextureParse 
	{
		
		public function SubTextureParse() 
		{
			
		}
		
		static public function parse(source:BitmapData, subtexture:XML):Vector.<BitmapData> {
			   var bms:Vector.<BitmapData> = new Vector.<BitmapData>();
		 
			   for (var i:int = 0; i <subtexture.SubTexture.length(); i++) 
				  {
					     var bmd:BitmapData = new BitmapData(subtexture.SubTexture[i].@width, subtexture.SubTexture[i].@height, true, 0xFFFFFFFF);
							 bmd.copyPixels(source,new Rectangle(subtexture.SubTexture[i].@x, subtexture.SubTexture[i].@y,subtexture.SubTexture[i].@width, subtexture.SubTexture[i].@height),new Point(0,0))
							 bms.push(bmd); 
				  }
			     
			   return bms;
			}
		
		
		
	}

}