package zebraui.components.silder
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import zebraui.components.button.ImageButton;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.button.ButtonState;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	
	internal class SilderDesinger extends AbstractSilder
	{
  
		protected var viewRectangle:Rectangle;
		
		public function SilderDesinger()
		{
			var normal:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.BaseSilder.Block.Normal")
			var down:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.BaseSilder.Block.Down")
			blockButton = new ImageButton(normal, normal, down);
			viewRectangle = UIFramework.resource.getElementRectangle("Silder", "Block");
			
			bottomContainer = new Scale9GridBitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.BaseSilder.Bottom"), viewRectangle);
			bottomContainer.y = 5;
			addChild(bottomContainer);
			blockButton.x = -blockButton.width / 2;
			addChild(blockButton);
			super()
		}
		

		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			blockButton.addEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,silderDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, silderStopDragLogic);
			trace("add")
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();
			blockButton.removeEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,silderDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_UP, silderStopDragLogic);
			trace("remove")
		}
		
		protected function silderInitDragLogic(e:MouseEvent):void
		{
			_IsDrag = true;
			blockButton.state = ButtonState.DOWN;
			blockButton.enabled = false;
		}
		
		protected function silderDragLogic(e:MouseEvent):void
		{
			
		}
		
		protected function silderStopDragLogic(e:MouseEvent):void
		{
			if (_IsDrag)
			{
				_IsDrag = false;
				blockButton.stopDrag();
				dispatchSilderDragingEvent();
			}
			blockButton.state = ButtonState.NORMAL;
			blockButton.enabled = true;
		}
		
		
		
	
	}

}