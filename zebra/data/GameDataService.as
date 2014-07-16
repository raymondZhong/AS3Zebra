package zebra.data 
{
	import zebra.Game;
	public class GameDataService 
	{
		
		public function GameDataService() 
		{
			
		}
		
		public function get FlashvarsParams():Object {
			return  Game.graphicsDeviceManager.stage.loaderInfo.parameters;
			}
		 
		 
	}

}