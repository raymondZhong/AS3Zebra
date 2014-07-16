package zebra.graphics.animation 
{

	//import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Earthquake
	{
		private  const FRAME_RATE		: int = 25;			// adjustable, but looks pretty good at 25
		private  var timer			: Timer;
		
		private  var image			: *;
		private  var originalX		: int;
		private  var originalY		: int;
		
		private  var intensity		: int;
		private  var intensityOffset	: int;
		
		//public function Earthquake()
		//{
			// static class - do not instantiate
		//}
		
		// === A P I ===
		public  function Earthquake( _image:*, _intensity:Number = 10, _seconds:Number = 1 ): void
		{
			if ( timer )
			{
				timer.stop();
			}
			
			image = _image;
			originalX = image.x;
			originalY = image.y;
			
			intensity = _intensity;
			intensityOffset = intensity / 2;
			
			// truncations and integer math are faster
			var msPerUpdate:int = int( 1000 / FRAME_RATE );
			var totalUpdates:int = int( _seconds * 1000 / msPerUpdate );
			
			timer = new Timer( msPerUpdate, totalUpdates );
			timer.addEventListener( TimerEvent.TIMER, quake );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, resetImage );
			
			timer.start();
		}
		
		public  function temp(): void {}
		
		
		// === ===
		private  function quake( event:TimerEvent ): void
		{
			//trace( intensity );
			var newX:int = originalX + Math.random() * intensity - intensityOffset;
			var newY:int = originalY + Math.random() * intensity - intensityOffset;
			
			image.x = newX;
			image.y = newY;
		}
		
		private  function resetImage( event:TimerEvent = null ): void
		{
			image.x = originalX;
			image.y = originalY;
			
			cleanup();
		}
		
		private  function cleanup(): void
		{
			timer = null;
			image = null;
		}
		

	}

}