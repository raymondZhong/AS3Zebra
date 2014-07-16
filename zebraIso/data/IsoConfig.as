package zebraIso.data 
{
 
	public class IsoConfig 
	{
		 
		/**
		 *  屏幕正方形格子Size:45*45.
		 *  转换成45角度后Size:64*32.
		 */
		static public const  ScreenGridSize:Number = 45;
		
		/**
		 * 固定夹角 sinA=  (32>>1)/Math.sqrt(16*16+32*32)
		 */
		
		static public const degrees_Top_Right:Number = 0.4472135954999579;
		//static public function get edge():Number { return 0; }
		
		
		/**
		 * 菱形的边的长度(4边相同)
		 */
		static public function get edge():Number {
			var height:Number  = IsoConfig.IsoGridSize >> 1
			var width:Number = IsoConfig.IsoGridSize;
			return Math.sqrt(width * width + height * height);
			}
		
		/**
		 * 一个菱形宽度一半
		 */
		static public const  IsoGridSize:Number = 32;
		
		
	}

}