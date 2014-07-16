package zebraIso.util
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoConfig;
	
	public class IsoUtil
	{
		// a more accurate version of 1.2247...
		//Y_CORRECT = 1.2247448713915892
		//public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		public static const Y_CORRECT:Number = 1.2247448713915892;
		
		/**
		 * Converts a 3D point in isometric space to a 2D screen position.
		 * @arg pos the 3D point.
		 */
		public static function isoToScreen(pos:Vector3D):Point
		{
			var screenX:Number = pos.x - pos.z;
			//var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) * .5;
			var screenY:Number = pos.y + (pos.x + pos.z) * .5;
			return new Point(screenX, screenY);
		}
		
 
		public static function screenToIso(point:Point):Vector3D
		{
			var xpos:Number = point.y + point.x * .5;
			var ypos:Number = 0;
			var zpos:Number = point.y - point.x * .5;
			return new Vector3D(xpos, ypos, zpos);
		}
		
		/**
		 * 坐标转换成Iso的地面格子
		 * @param	point
		 * @return
		 */
		public static function screenToIsoGrid(point:Point):Point {
			  var v:Vector3D = screenToIso(point);
			  return new Point(Math.round(v.x/IsoConfig.IsoGridSize),Math.round(v.z/IsoConfig.IsoGridSize))
			}
		
	
	}

}