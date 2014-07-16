package zebra.math
{
	
	public class Vector3DHelper
	{
		
		import flash.geom.Vector3D;
		
		public function Vector3DHelper()
		{
		
		}
				
		/**
		 * 向量碰撞
		 * @param	sv
		 * @param	tv
		 * @param	value
		 * @return
		 */
		static public function hit(sv:Vector3D,tv:Vector3D,value:Number=5):Boolean
		{
			 if (  Math.abs(sv.x - tv.x) <= value &&  
				   Math.abs(sv.y - tv.y) <= value &&
				   Math.abs(sv.z - tv.z) <= value &&
				   Math.abs(sv.w - tv.w) <= value ) return true;
				   return false;
			 
		}
		
		/**
		 * 数与向量的商(除法)
		 * @param	vector
		 * @param	value
		 * @return
		 */
		static public function divide(vector:Vector3D,value:Number):Vector3D
		{
			return new Vector3D(vector.x / value, vector.y / value, vector.z / value);
		} 
		/**
		 *数与向量的乘积
		 * @param	vector
		 * @param	value
		 * @return
		 */
		static public function multiply(vector:Vector3D,value:Number):Vector3D
		{
			return new Vector3D(vector.x * value, vector.y * value, vector.z * value);
		}
		
		
		/**
		 * 截取当前向量
		 * @param	vector
		 * @param	max
		 */
		static public function truncate(vector:Vector3D, max:Number):void
		{
			var i:Number;
			i = max / vector.length;
			i = i < 1.0 ? i : 1.0;
			vector.scaleBy(i);
		}
 
		static public function setSpeed(vector:Vector3D, max:Number):void
		{
			truncate(vector, max);
		}
		
		/**
		 * 获得向量角度
		 * @param	vector
		 * @return
		 */
		static public function getAngle(vector:Vector3D):Number
		{
			return   Math.atan2(vector.y, vector.x);
			//return Math.atan2(vector.y, vector.x)
			//return  Fix360Radian(Math.atan2(vector.y, vector.x) * 180 / Math.PI)
		}
		
		
		/**
		 * 修复Flash角度值
		 * @param	angle
		 * @return
		 */
		static public function Fix360Radian(angle:Number):Number
		{
			var ag:Number = angle;
			if (angle < 0)
			{
				ag = 360 + angle;
			}
			if (angle > 360)
			{
				ag = angle % 360
			}
			return ag;
		}
		
		/**
		 * 设置向量角度
		 * @param	vector
		 * @param	value
		 */
		static public function setAngle(vector:Vector3D, value:Number):void
		{
			var len:Number = vector.length;
			vector.x = Math.cos(value) * len;
			vector.y = Math.sin(value) * len;
		}
		
		//设置向量的大小
		static public function setlength(vector:Vector3D,value:Number):void
		{
			var a:Number = getAngle(vector);
			vector.x = Math.cos(a) * value;
			vector.y = Math.sin(a) * value;
		}
		
		static 	public function getlength(vector:Vector3D):Number
		{
			return Math.sqrt(lengthSQ(vector));
		}
		
			//获取当前向量大小的平方
		static 	public function lengthSQ(vector:Vector3D):Number
		{
			return vector.x * vector.x + vector.y * vector.y;
		}
	
	}

}