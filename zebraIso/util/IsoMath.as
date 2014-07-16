package zebraIso.util 
{

	public class IsoMath 
	{
		/**
		 * 弧度转换成角度
		 * @param	value
		 * @return
		 */
		static public function radTodeg(value:Number):Number {
			   return value * 180 / Math.PI;
			}
			
		/**
		 * 角度转化成弧度
		 * @param	value
		 * @return
		 */
		static public function degTorad(value:Number):Number {
			   return value * Math.PI / 180;
			}
			
	}

}