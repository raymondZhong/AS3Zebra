package zebraMedia
{
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse; 
	import zebra.content.GameAsset;
	import zebra.Game;
	import zebra.loaders.IAssetLoader;
	import zebra.system.xml.XmlMapper; 
	import zebraMedia.model.setting.MediaSettingVO;
	
	public class MediaSettingInit
	{
		public var setting:MediaSettingVO;
		
		public function MediaSettingInit(settingURL:String="resource/MediaSetting.xml")
		{
			GameAsset.receive(settingURL, readSetting);
			GameAsset.load(settingURL);			
			setting = new MediaSettingVO();	
		}
		
		
		private function readSetting(e:IAssetLoader):void
		{
			GameAsset.destroy(e.key, readSetting);
			XmlMapper.bind(setting, new XML(e.content));
			
			if (setting.fullscreen)
			{
				Game.graphicsDeviceManager.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			
			if (setting.mousehide)
			{
				Mouse.hide();
			}
			
			if (!setting.allowEscExitFullScreen) {				
				Game.graphicsDeviceManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			}
			
		}
		
		private function keyHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ESCAPE) e.preventDefault();
		}
	
	}

}


