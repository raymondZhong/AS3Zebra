package zebra.ai.steer
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import zebra.math.Vector3DHelper;
	
	/**
	 * Base class for moving characters.
	 */
	public class Vehicle extends Sprite
	{
		
		//边界行为:是屏幕环绕(wrap)，还是反弹{bounce}
        protected var _edgeBehavior:String = WRAP;
       
		/**
		 * 质量
		 */
        protected var _mass:Number=1.0;
 
		
		 /**
		 * 最大速度
		 */
        protected var _maxSpeed:Number=10;
 
	     /**
		 * 坐标
		 */
        protected var _position:Vector3D;
 
		/**
		 * 速度
		 */
        protected var _velocity:Vector3D;
 
		
		//边界行为常量
		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";		
		
		
		/**
		 * Constructor.
		 */
		public function Vehicle()
		{
			_position = new Vector3D();
			_velocity = new Vector3D();
			draw();
		}
		
		/**
		 * Default graphics for vehicle. Can be overridden in subclasses.
		 */
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 1);
			graphics.lineStyle(0);
			graphics.moveTo(10, 0);
			graphics.lineTo(-10, 5);
			graphics.lineTo(-10, -5);
			graphics.lineTo(10, 0);
		}
		
		/**
		 * Handles all basic motion. Should be called on each frame / timer interval.
		 */
		public function update():void
		{
			//设置最大速度
			Vector3DHelper.truncate(_velocity, _maxSpeed);
			
			 //根据速度更新坐标向量
			_position = _position.add(_velocity);
			
			//处理边界行为
			if(_edgeBehavior == WRAP)
			{
				wrap();
			}
			else if(_edgeBehavior == BOUNCE)
			{
				bounce();
			}
			
			// update position of sprite
			//更新x,y坐标值
			x = position.x;
			y = position.y;
			
			// rotate heading to match velocity
			//处理旋转角度
			rotation = Vector3DHelper.getAngle(_velocity) * 180 / Math.PI;
		}
		
		//反弹
		private function bounce():void
		{
			if(stage != null)
			{
				if(position.x > stage.stageWidth)
				{
					position.x = stage.stageWidth;
					velocity.x *= -1;
				}
				else if(position.x < 0)
				{
					position.x = 0;
					velocity.x *= -1;
				}
				
				if(position.y > stage.stageHeight)
				{
					position.y = stage.stageHeight;
					velocity.y *= -1;
				}
				else if(position.y < 0)
				{
					position.y = 0;
					velocity.y *= -1;
				}
			}
		}
		
		//屏幕环绕
		private function wrap():void
		{
			if(stage != null)
			{
				if(position.x > stage.stageWidth) position.x = 0;
				if(position.x < 0) position.x = stage.stageWidth;
				if(position.y > stage.stageHeight) position.y = 0;
				if(position.y < 0) position.y = stage.stageHeight;
			}
		}
		
		/**
		 * 设置屏幕环绕的模式 (穿过屏幕/屏幕内环绕)
		 */
		public function set edgeBehavior(value:String):void
		{
			_edgeBehavior = value;
		}
		
		/**
		 * 设置屏幕环绕的模式 (穿过屏幕/屏幕内环绕)
		 */
		public function get edgeBehavior():String
		{
			return _edgeBehavior;
		}
		
		/**
		 * 质量
		 */
		public function set mass(value:Number):void
		{
			_mass = value;
		}
		public function get mass():Number
		{
			return _mass;
		}
		
		/**
		 * 最大速度
		 */
		public function set maxSpeed(value:Number):void
		{
			_maxSpeed = value;
		}
		public function get maxSpeed():Number
		{
			return _maxSpeed;
		}
		
		/**
		 * 坐标
		 */
		public function set position(value:Vector3D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}
		public function get position():Vector3D
		{
			return _position;
		}
		
		/**
		 * 速度
		 */
		public function set velocity(value:Vector3D):void
		{
			_velocity = value;
		}
		public function get velocity():Vector3D
		{
			return _velocity;
		}
		
		/**
		 * Sets x position of character. Overrides Sprite.x to set internal Vector3D position as well.
		 */
		override public function set x(value:Number):void
		{
			super.x = value;
			_position.x = x;
		}
		
		/**
		 * Sets y position of character. Overrides Sprite.y to set internal Vector3D position as well.
		 */
		override public function set y(value:Number):void
		{
			super.y = value;
			_position.y = y;
		}
		
	}
}