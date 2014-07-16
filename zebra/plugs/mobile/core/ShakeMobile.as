package zebra.plugs.mobile.core
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	import flash.utils.setTimeout;
	
	public class ShakeMobile extends EventDispatcher
	{
		//
		public const THRESHOLD:Number = 1.7;
		//测量
		private var isMeasuring:Boolean = false;
		//晃动
		private var isShaking:Boolean = false;
		
		private	var acc:Accelerometer;
		
		static public const SHAKING:String = "shaking";
		
		
		public function ShakeMobile()
		{
			acc = new Accelerometer();
			acc.addEventListener(AccelerometerEvent.UPDATE, onUpdate);
		}
		
	
		private var  _prevXTHRESHOLD:Number = -1.2;
		private var  _lastXTHRESHOLD:Number = 1.2;
		
		private var _prevAcc:Array = [0,0,0];
		private var _lastAcc:Array = [0,0,0];
		private var _measureIndex:int = 0;
		
		public var intervalTime:Number = 500;
		
		private function onUpdate(e:AccelerometerEvent):void
		{
		     if (isMeasuring) return;
			 isMeasuring = true;
			 // trace(e.accelerationX, e.accelerationY, e.accelerationZ)
			 
			 if (_measureIndex % 2 == 0) { 
				   _prevAcc = [e.accelerationX, e.accelerationY, e.accelerationZ]
				 } else {
				   _lastAcc = [e.accelerationX, e.accelerationY, e.accelerationZ] 
				 }
				 
			 if (_prevAcc[0] <= _prevXTHRESHOLD && _lastAcc[0] >= _lastXTHRESHOLD) {
				  isShaking = true;
				 }else if (_prevAcc[0] >= _lastXTHRESHOLD && _lastAcc[0] <= _prevXTHRESHOLD) {
					isShaking = true;
				 }
			 _measureIndex++;
			 if (isShaking) {
				   trace("摇一摇")
				   reset();
				   this.dispatchEvent(new Event(SHAKING));
				   setTimeout(function():void { isMeasuring = false }, intervalTime);
				}else{
					isMeasuring = false;
				}
		}
		
		
		public function reset():void {
				   _prevAcc = [0, 0, 0];
				   _lastAcc = [0, 0, 0];
				   _measureIndex = 0;		
			}
		
		public function disableShake():void {
		      isShaking = false;
			}
		
		public function dispose():void {
			isShaking = false;
			acc.removeEventListener(AccelerometerEvent.UPDATE, onUpdate);
		}
	
	}

}