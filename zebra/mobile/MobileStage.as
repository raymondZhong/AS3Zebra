package zebra.mobile
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import zebra.events.AssetLoaderEvent;
	import zebra.Game;
	import zebra.loaders.AssetLoaderQueue;
	import zebra.loaders.AssetType;
	import zebraMobileUI.MobileUIFramework;
	
	public class MobileStage extends Sprite
	{
		
		private var _uiFramework:MobileUIFramework;
		
		public function MobileStage()
		{
			
			stage.align = StageAlign.TOP_LEFT
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var game:Game = new Game(stage);
			new MobileFont();
			var loadqueue:AssetLoaderQueue = new AssetLoaderQueue();
				loadqueue.append("ui/mobileSetting.xml", AssetType.TEXT);
				loadqueue.append("ui/mobileSkin.swf");
				loadqueue.addEventListener(AssetLoaderEvent.COMPLETE, completeHandler)
				loadqueue.execute();
		}
		
		private function completeHandler(e:AssetLoaderEvent):void
		{
			 var loadqueue:AssetLoaderQueue = e.target as AssetLoaderQueue;			 
			 var data:XML = new XML(loadqueue.getAssetloader("ui/mobileSetting.xml").content);
			 _uiFramework = new MobileUIFramework(stage,data);
			 loadqueue.dispose();
			 startup();
		}
		
		protected  function  startup():void{}
	
	}

}