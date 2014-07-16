package zebra.core 
{
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import zebra.Game;
	
	public class GameView extends BaseSprite
	{
		
		public function GameView() 
		{
			Game.Content.addView(this)
		}
		
	}

}