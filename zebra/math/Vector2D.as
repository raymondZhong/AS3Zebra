package zebra.math
{
	
	import flash.display.Graphics;
	
	/**
	 * 2D向量类
	 */
	public class Vector2D
	{
		private var _x:Number;
		private var _y:Number;
		
		//构造函数
		public function Vector2D(x:Number = 0, y:Number = 0):void
		{
			_x = x;
			_y = y;
		}
		
		//绘制一条线段
		public function draw(graphics:Graphics, color:uint = 0):void
		{
			graphics.lineStyle(0, color);
			graphics.moveTo(0, 0);
			graphics.lineTo(_x, _y);
		}
		
		//复制向量
		public function clone():Vector2D
		{
			return new Vector2D(x, y);
		}
		
		//将当前向量变成0向量
		public function zero():Vector2D
		{
			_x = 0;
			_y = 0;
			return this;
		}
		
		//判断是否是0向量
		public function isZero():Boolean
		{
			return _x == 0 && _y == 0;
		}
		
		//设置向量的大小
		public function set length(value:Number):void
		{
			var a:Number = angle;
			_x = Math.cos(a) * value;
			_y = Math.sin(a) * value;
		}
		
		public function get length():Number
		{
			return Math.sqrt(lengthSQ);
		}
		
		//获取当前向量大小的平方
		public function get lengthSQ():Number
		{
			return _x * _x + _y * _y;
		}
		
		//设置向量的方法
		public function set angle(value:Number):void
		{
			var len:Number = length;
			_x = Math.cos(value) * len;
			_y = Math.sin(value) * len;
		}
		
		public function get angle():Number
		{
			return Math.atan2(_y, _x);
		}
		
		//将当前向量转化成单位向量
		public function normalize():Vector2D
		{
			if (length == 0)
			{
				_x = 1;
				return this;
			}
			var len:Number = length;
			_x /= len;
			_y /= len;
			return this;
		}
		
		//截取当前向量
		public function truncate(max:Number):Vector2D
		{
			length = Math.min(max, length);
			return this;
		}
		
		//反转向量
		public function reverse():Vector2D
		{
			_x = -_x;
			_y = -_y;
			return this;
		}
		
		//判断当前向量是否是单位向量
		public function isNormalized():Boolean
		{
			return length == 1.0;
		}
		
		//向量积
		public function dotProd(v2:Vector2D):Number
		{
			return _x * v2.x + _y * v2.y;
		}
		
		//判断两向量是否垂直
		public function crossProd(v2:Vector2D):Number
		{
			return _x * v2.y - _y * v2.x;
		}
		
		//返回两向量夹角的弦度值
		public static function angleBetween(v1:Vector2D, v2:Vector2D):Number
		{
			if (!v1.isNormalized())
				v1 = v1.clone().normalize();
			if (!v2.isNormalized())
				v2 = v2.clone().normalize();
			
			return Math.acos(v1.dotProd(v2));
		}
		
		//返回向量的符号值
		public function sign(v2:Vector2D):int
		{
			
			return perp.dotProd(v2) < 0 ? -1 : 1;
		}
		
		//返回坐标向量
		public function get perp():Vector2D
		{
			return new Vector2D(-y, x);
		}
		
		//返回当前向量与V2的距离
		public function dist(v2:Vector2D):Number
		{
			return Math.sqrt(distSQ(v2));
		}
		
		//返回当前向量与V2的距离的平方
		public function distSQ(v2:Vector2D):Number
		{
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}
		
		//两向量相加
		public function add(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x + v2.x, _y + v2.y);
		}
		
		//两向量相减
		public function subtract(v2:Vector2D):Vector2D
		{
			return new Vector2D(_x - v2.x, y - v2.y);
		}
		
		//数与向量的乘积
		public function multiply(value:Number):Vector2D
		{
			return new Vector2D(_x * value, _y * value);
		}
		
		//数与向量的商
		public function divide(value:Number):Vector2D
		{
			return new Vector2D(_x / value, _y / value);
		}
		
		//判断两向量是否相等
		public function equals(v2:Vector2D):Boolean
		{
			return _x == v2.x && _y == v2.y;
		}
		
		//设置X坐标
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		//设置Y坐标
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		//返回对象的字符形式
		public function toString():String
		{
			return "[Vector2D(X:" + _x + ",y:" + _y + ")]";
		}
	}

}