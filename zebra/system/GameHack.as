package zebra.system
{
	import flash.media.Sound;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	
	public class GameHack
	{
		
		public function GameHack()
		{
		
		}
		
		/**
		 * 放空声音维持在8帧
		 */
		public function keepframe():void
		{
			var frameSound:Sound = new Sound(new URLRequest(''));
				frameSound.play();
				frameSound.close();
		}
		
		/**
		 * 强制执行一次FlashPlayer GC.
		 */
		public function gc():void
		{
			try
			{
				new LocalConnection().connect("Zebra-b090fd9c-9f1a-4c08-a4ed-ce74efa80551");
				new LocalConnection().connect("Zebra-b090fd9c-9f1a-4c08-a4ed-ce74efa80551");
			}
			catch (e:*)
			{
			}
		}
	
	}

}