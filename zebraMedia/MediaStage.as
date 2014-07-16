package zebraMedia
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import zebra.Game;
	
	public class MediaStage extends Sprite
	{
		
		public function MediaStage(settingURL:String="resource/MediaSetting.xml")
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;			
			var game:Game = new Game(stage);
			new MediaSettingInit(settingURL);
			initialize();
		}
	
		
		public function initialize():void{}
		
	}

}