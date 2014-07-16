package zebra.ai.steer
{
	
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import zebra.math.Vector3DHelper;
	
	public class SteeredVehicle extends Vehicle
	{
		
		/**
		 * 最大转向力
		 */
		private var _maxForce:Number = 1;
		
		/**
		 * 到达行为的距离阈值(小于这个距离将减速)
		 */
		private var _arrivalThreshold:Number = 100;
		
		/**
		 * 转向力度
		 */
		private var _steeringForce:Vector3D;
		
		private var _wanderAngle:Number = 0;
		private var _wanderDistance:Number = 10;
		private var _wanderRadius:Number = 5;
		private var _wanderRange:Number = 1;
		
		//
		/**
		 * 误差值
		 */
		//public var inaccuracy:int = 0;
		
		private var _pathIndex:int = 0;
		private var _pathThreshold:Number = 20;
		
		
		public function SteeredVehicle()
		{
			_steeringForce = new Vector3D();
			super();
		}
		
		/**
		 * 最大转向力
		 */
		public function set maxForce(value:Number):void
		{
			_maxForce = value;
		}
		/**
		 * 最大转向力
		 */
		public function get maxForce():Number
		{
			return _maxForce;
		}
		
		/**
		 * 寻找  角色试图移动到一个指定点。该点可以是一个固定点也可以是把另一个角色作为目标的移动点。
		 * @param	target
		 */
		public function seek(target:Vector3D):void
		{
			//预得到的速度
			var desiredVelocity:Vector3D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = Vector3DHelper.multiply(desiredVelocity, _maxSpeed);
			var force:Vector3D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force); //加法
		}
		
		/**
		 * 避开  与寻找正好相反。角色试图避开一个给定点。同样，这个点也可以是固定点或者移动点。
		 * @param	target
		 */
		public function flee(target:Vector3D):void
		{
			var desiredVelocity:Vector3D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = Vector3DHelper.multiply(desiredVelocity, _maxSpeed);
			var force:Vector3D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.subtract(force); //减法
		}
		
		/**
		 * 到达  和寻找相同，除了角色的速度在接近目的地时会减慢，最终以一个渐变运动恰好停留在目标处。
		 * @param	target
		 */
		public function arrive(target:Vector3D):void
		{
			var desiredVelocity:Vector3D = target.subtract(_position);
			desiredVelocity.normalize();
			
			var dist:Number = Vector3D.distance(_position, target); // _position.dist(target);
			if (dist > _arrivalThreshold)
			{
				desiredVelocity = Vector3DHelper.multiply(desiredVelocity, _maxSpeed);
			}
			else
			{
				desiredVelocity = Vector3DHelper.multiply(desiredVelocity, _maxSpeed * dist / _arrivalThreshold);
			}
			
			var force:Vector3D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		
		/**
		 * 追捕   寻找的加强版。由于目标会做加速运动，所以角色会事先预测然后再移动到该点。很明显，由于固定点是不会有速度概念的，所以这里用目标代替点的概念。
		 * @param	target
		 */
		public function pursue(target:Vehicle):void
		{
			var dist:Number = Vector3D.distance(_position, target.position); // _position.dist(target);
			var lookAheadTime:Number = dist / _maxSpeed;
			//var predictedTarget:Vector3D = target.position.add(target.velocity.multiply(lookAheadTime));
			var predictedTarget:Vector3D = target.position.add(Vector3DHelper.multiply(target.velocity, lookAheadTime));
			seek(predictedTarget);
		}
		
		/**
		 * 躲避(evade)：与追捕正好相反。角色对目标的速度做出预测，然后尽可能躲避开来。
		 * @param	target
		 */
		public function evade(target:Vehicle):void
		{
			var dist:Number = Vector3D.distance(_position, target.position);
			var lookAheadTime:Number = dist / _maxSpeed;
			var predictedTarget:Vector3D = target.position.add(Vector3DHelper.multiply(target.velocity, lookAheadTime));
			flee(predictedTarget);
		}
		
		/**
		 * 漫游(wander)：随机但平滑又真实的运动。
		 */
		public function wander():void
		{
			var v:Vector3D = velocity.clone();
			v.normalize();
			var center:Vector3D = Vector3DHelper.multiply(v, _wanderDistance); //velocity.clone().normalize().multiply(_wanderDistance);
			var offset:Vector3D = new Vector3D(0);
			Vector3DHelper.setlength(offset, _wanderRadius);
			Vector3DHelper.setAngle(offset, _wanderAngle);
			_wanderAngle += Math.random() * _wanderRange - _wanderRange * .5;
			var force:Vector3D = center.add(offset);
			_steeringForce = _steeringForce.add(force);
		}
		
		//public function avoid(circles: Array): void
		//{
		//for(var i: int=0; i < circles.length; i++)
		//{
		//var circle: Circle = circles[ i ] as Circle;
		//var heading: Vector2D = _velocity.clone().normalize();
		// 障碍物和机车间的位移向量
		//var difference: Vector2D = circle.position.subtract(_position);
		//var dotProd:Number = difference.dotProd(heading);
		// 如果障碍物在机车前方
		//if(dotProd > 0)
		//{
		// 机车的“触角”
		//var feeler: Vector2D = heading.multiply(_avoidDistance);
		// 位移在触角上的映射
		//var projection: Vector2D = heading.multiply(dotProd);
		// 障碍物离触角的距离
		//var dist: Number = projection.subtract(difference).length;
		// 如果触角（在算上缓冲后）和障碍物相交
		// 并且位移的映射的长度小于触角的长度
		// 我们就说碰撞将要发生，需改变转向
		//if(dist < circle.radius + _avoidBuffer &&
		//projection.length < feeler.length)
		//{
		// 计算出一个转90度的力
		//var force: Vector2D = heading.multiply(_maxSpeed);
		//force.angle += difference.sign(_velocity) * Math.PI / 2;
		// 通过离障碍物的距离，调整力度大小，使之足够小但又能避开
		//force = force.multiply(1.0 - projection.length / feeler.length);
		// 叠加于转向力上
		//_steeringForce = _steeringForce.add(force);
		// 刹车——转弯的时候要放慢机车速度，离障碍物越接近，刹车越狠。
		//_velocity = _velocity.multiply(projection.length / feeler.length);
		//}
		//}
		//}
		//}
		
		/**
		 * 跟随路径
		 * @param	path
		 * @param	loop
		 */
		public function followPath(path:Array, loop:Boolean = false):void
		{
			var wayPoint:Vector3D = path[_pathIndex];
			if (wayPoint == null) return;
			var dist:Number = Vector3D.distance(_position, wayPoint);
			if (dist < _pathThreshold)
			{
				if (_pathIndex >= path.length - 1)
				{
					if (loop)
					{
						_pathIndex = 0;
					}
				}
				else
				{
					_pathIndex++;
				}
			}
			if (_pathIndex >= path.length - 1 && !loop)
			{
				arrive(wayPoint);
			}
			else
			{
				seek(wayPoint);
			}
		}
		
		/**
		 * update logic
		 */
		override public function update():void
		{
			//_steeringForce.truncate(_maxForce);			
			Vector3DHelper.truncate(_steeringForce, _maxForce);
			_steeringForce = Vector3DHelper.divide(_steeringForce, _mass);
			_velocity = _velocity.add(_steeringForce);
 
			
			_steeringForce = new Vector3D();
			super.update();
		}
		
		/**
		 *  到达行为的距离阈值(小于这个距离将减速)
		 */
		public function set arriveThreshold(value:Number):void
		{
			_arrivalThreshold = value;
		}
		
		/**
		 *  到达行为的距离阈值(小于这个距离将减速)
		 */
		public function get arriveThreshold():Number
		{
			return _arrivalThreshold;
		}
		
		public function set wanderDistance(value:Number):void
		{
			_wanderDistance = value;
		}
		
		public function get wanderDistance():Number
		{
			return _wanderDistance;
		}
		
		public function set wanderRadius(value:Number):void
		{
			_wanderRadius = value;
		}
		
		public function get wanderRadius():Number
		{
			return _wanderRadius;
		}
		
		public function set wanderRange(value:Number):void
		{
			_wanderRange = value;
		}
		
		public function get wanderRange():Number
		{
			return _wanderRange;
		}
	}

}