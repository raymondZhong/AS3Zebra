package zebra.ai.steer 
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author raymond
	 */
	public class SteeringManager 
	{
		
		public function SteeringManager() 
		{
			
		}
		
		public static const MAX_FORCE 			:Number = 5.4;
		
		// Wander
		public static const CIRCLE_DISTANCE 	:Number = 6;
		public static const CIRCLE_RADIUS 		:Number = 8;
		public static const ANGLE_CHANGE 		:Number = 1;
		
		// Seek / flee
		public var desired 						:Vector3D;
		
		// Wander
		private var wanderAngle					:Number;
		
		// Pursuit and evade
		public var distance 					:Vector3D = new Vector3D();
		public var targetFuturePosition 		:Vector3D = new Vector3D();
		
		// Manager itself
		public var steering 					:Vector3D;	
		public var host							:IBoid;
		
		public function SteeringManager(host :IBoid) {
			this.host			= host;
			this.desired		= new Vector3D(0, 0); 
			this.steering 		= new Vector3D(0, 0); 
			this.wanderAngle 	= 0; 
			
			truncate(host.getVelocity(), host.getMaxVelocity());
		}
		
		public function seek(target :Vector3D, slowingRadius :Number = 20) :void {
			steering.incrementBy(doSeek(target, slowingRadius));
		}
		
		public function flee(target :Vector3D) :void {
			steering.incrementBy(doFlee(target));
		}
		
		public function wander() :void {
			steering.incrementBy(doWander());
		}
		
		public function evade(target :IBoid) :void {
			steering.incrementBy(doEvade(target));
		}
		
		public function pursuit(target :IBoid) :void {
			steering.incrementBy(doPursuit(target));
		}
		
		private function doSeek(target :Vector3D, slowingRadius :Number = 0) :Vector3D {
			var force :Vector3D;
			var distance :Number;
			
			desired = target.subtract(host.getPosition());
			
			distance = desired.length;
			desired.normalize();
			
			if (distance <= slowingRadius) {
				desired.scaleBy(host.getMaxVelocity() * distance/slowingRadius);
			} else {
				desired.scaleBy(host.getMaxVelocity());
			}
			
			force = desired.subtract(host.getVelocity());
			
			return force;
		}
		
		private function doFlee(target :Vector3D) :Vector3D {
			var force :Vector3D;
			
			desired = host.getPosition().subtract(target);
			desired.normalize();
			desired.scaleBy(host.getMaxVelocity());
			
			force = desired.subtract(host.getVelocity());
			
			return force;
		}
		
		private function doWander() :Vector3D {
			var wanderForce :Vector3D, circleCenter:Vector3D, displacement:Vector3D;
			
			circleCenter = host.getVelocity().clone();
			circleCenter.normalize();
			circleCenter.scaleBy(CIRCLE_DISTANCE);
			
			displacement = new Vector3D(0, -1);
			displacement.scaleBy(CIRCLE_RADIUS);
			
			setAngle(displacement, wanderAngle);
			wanderAngle += Math.random() * ANGLE_CHANGE - ANGLE_CHANGE * .5;

			wanderForce = circleCenter.add(displacement);
			return wanderForce;
		}
		
		private function doEvade(target :IBoid) :Vector3D {
			distance = target.getPosition().subtract(host.getPosition());
			
			var updatesNeeded :Number = distance.length / host.getMaxVelocity();
			
			var tv :Vector3D = target.getVelocity().clone();
			tv.scaleBy(updatesNeeded);
			
			targetFuturePosition = target.getPosition().clone().add(tv);
			
			return doFlee(targetFuturePosition);
		}
		
		private function doPursuit(target :IBoid) :Vector3D {
			distance = target.getPosition().subtract(host.getPosition());
			
			var updatesNeeded :Number = distance.length / host.getMaxVelocity();
			
			var tv :Vector3D = target.getVelocity().clone();
			tv.scaleBy(updatesNeeded);
			
			targetFuturePosition = target.getPosition().clone().add(tv);
			
			return doSeek(targetFuturePosition);
		}
		
		
		public function truncate(vector :Vector3D, max :Number) :void {
			var i :Number;

			i = max / vector.length;
			i = i < 1.0 ? i : 1.0;
			
			vector.scaleBy(i);
		}
		
		public function getAngle(vector :Vector3D) :Number {
			return Math.atan2(vector.y, vector.x);
		}
		
		public function setAngle(vector :Vector3D, value:Number):void {
			var len :Number = vector.length;
			vector.x = Math.cos(value) * len;
			vector.y = Math.sin(value) * len;
		}
		
		public function update():void {
			var velocity :Vector3D = host.getVelocity();
			var position :Vector3D = host.getPosition();
			
			truncate(steering, MAX_FORCE);
			steering.scaleBy(1 / host.getMass());
			
			velocity.incrementBy(steering);
			truncate(velocity, host.getMaxVelocity());
			
			position.incrementBy(velocity);
		}
		
		public function reset() :void {			
			desired.x = desired.y = 0;
			steering.x = steering.y = 0;
		}
	}

}