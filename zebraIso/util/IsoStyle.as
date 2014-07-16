package zebraIso.util
{
	
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	public class IsoStyle
	{
		/**
		 * 建筑物件不容许放入样式
		 */
		static public const  BuilderError:ColorMatrixFilter  = new ColorMatrixFilter([1, 0, 0, 0, 999, 
																					  0, 1, 0, 0, 0, 
																					  0, 0, 1, 0, 0, 
																					  0, 0, 0, 1, 0]);
	 	
	}
}