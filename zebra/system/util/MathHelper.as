package zebra.system.util
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author raymond
	 */
	public class MathHelper
	{
		
		public function MathHelper()
		{
		
		}
		
		
 
		
		
		
		/**
		 * 获得8方位 标值
		 * @param	num
		 * @return
		 */
		static public function getDir(num:Number):int
		{
			var value:Number = 0;  //22.5
			if (num >= 360 - 22.5+value || num <= 22.5+value)
			//if (num >= 0 || num <= 45)
				return 6;
			if (num >= 46+ value && num <= 67 + value)
				return 9;
			if (num >= 68 + value && num <= 113 + value)
				return 8;
			if (num >= 114 + value && num <= 150 + value)
				return 7;
			if (num >= 151 + value && num <= 196 + value)
				return 4;
			if (num >= 197 + value && num <= 242 + value)
				return 1;
			if (num >= 243 + value && num <= 288 + value)
				return 2;
			if (num >= 289 + value && num <= 360)
				return 3;
			return 8;
			//return 5;
		}
		
		//90°的人物角度匹配
		public function  getMove90Dir(parentNode:Vector3D, currentnode:Vector3D):int {
				//90°
				//左上  ↖
				if (parentNode.x-1 == currentnode.x && parentNode.z - 1 == currentnode.z) return 1;
				//上    ↑
				if (parentNode.x == currentnode.x && parentNode.z - 1 == currentnode.z) return  2;
				//右上  ↗
				if (parentNode.x + 1 == currentnode.x && parentNode.z - 1 == currentnode.z) return   3;
				//左    ←
				if (parentNode.x - 1 == currentnode.x && parentNode.z  == currentnode.z) return  4;
				//右    →
				if (parentNode.x + 1 == currentnode.x && parentNode.z  == currentnode.z) return  6;
				//左下  ↙
				if (parentNode.x-1 == currentnode.x && parentNode.z+1  == currentnode.z) return 7;
				//下    ↓
				if (parentNode.x == currentnode.x && parentNode.z+1  == currentnode.z) return 8;
				//右下  ↘
				if (parentNode.x+1 == currentnode.x && parentNode.z+1  == currentnode.z) return 9;
				return 8;
			}
			
			
		//45°的人物角度匹配
		public function  getMove45Dir(parentNode:Vector3D, currentnode:Vector3D):int {
				//45°
				//左上  ↖
				if (parentNode.x-1 == currentnode.x && parentNode.z - 1 == currentnode.z) return 2;//1;
				//上    ↑
				if (parentNode.x == currentnode.x && parentNode.z - 1 == currentnode.z) return  3;//2;
				//右上  ↗
				if (parentNode.x + 1 == currentnode.x && parentNode.z - 1 == currentnode.z) return  6;// 3;
				//左    ←
				if (parentNode.x - 1 == currentnode.x && parentNode.z  == currentnode.z) return 1;// 4;
				//右    →
				if (parentNode.x + 1 == currentnode.x && parentNode.z  == currentnode.z) return 9; // 6;
				//左下  ↙
				if (parentNode.x-1 == currentnode.x && parentNode.z+1  == currentnode.z) return 4;//7;
				//下    ↓
				if (parentNode.x == currentnode.x && parentNode.z+1  == currentnode.z) return 7; //8;
				//右下  ↘
				if (parentNode.x+1 == currentnode.x && parentNode.z+1  == currentnode.z) return 8; //9;
				return 8;
			}
		
		
		
		
		/**
		 * 两点直接的角度
		 * @param	p1
		 * @param	p2
		 * @return
		 */
		static public function getAngle(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			var radians:Number = Math.atan2(dy, dx);
			return rad2deg(radians);
			//return Fix360Radian(radians * 180 / Math.PI);
		}
		
		/**
		 * 修复Flash角度值
		 * @param	angle
		 * @return
		 */
		static public function Fix360Radian(angle:Number):Number
		{
			/*var ag:Number = angle;
			if (angle < 0)
			{
				ag = 360 + angle;
			}
			if (angle > 360)
			{
				ag = angle % 360
			}
			return ag;*/
			
				
			if (angle < 0) {
				angle = angle * -1;
			}else {
				angle = 360 - angle;
			}
			return angle;
		}
		
		/**
		 * 弧度转换成角度
		 * @param	rad
		 * @return
		 */
		static public  function rad2deg(rad:Number):Number
		{
			return rad / Math.PI * 180.0;            
		}
		
		/**
		 * 角度转换成弧度
		 * @param	rad
		 * @return
		 */
		static public  function deg2rad(deg:Number):Number
		{
			return deg * Math.PI / 180;       
		}
		
	}

}