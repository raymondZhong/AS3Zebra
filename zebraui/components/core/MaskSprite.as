package zebraui.components.core 
{
	import flash.events.Event;
	import zebraui.components.UIComponent;
	import flash.display.Bitmap;
	import zebraui.UIFramework;
	public class MaskSprite extends UIComponent
	{
		private var _maskBm:Bitmap;
		public function MaskSprite() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			_maskBm = new Bitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Mask"));
			addChild(_maskBm);
			super.initialize();
		}
		
		override protected function addToStageControl():void 
		{
			_maskBm.width = stage.stageWidth;
			_maskBm.height = stage.stageHeight;
			stage.addEventListener(Event.RESIZE, stageResizeLogic);
			super.addToStageControl();
		}
		
		override protected function removeStageControl():void 
		{
			stage.removeEventListener(Event.RESIZE, stageResizeLogic);
			super.removeStageControl();
		}
		
		private function stageResizeLogic(e:Event):void 
		{
			_maskBm.width = stage.stageWidth;
			_maskBm.height = stage.stageHeight;
		}
		
		
	}

}