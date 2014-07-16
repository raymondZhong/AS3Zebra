package zebraui.components.silder
{
	import flash.events.MouseEvent;
	import zebraui.components.button.ButtonState;
	import zebraui.components.button.DisplayButton;
	import zebraui.components.UIComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import zebraui.components.button.ImageButton;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	internal class HSilderBarDesinger extends AbstractSilder
	{
		
		protected var normalSprite:Scale9GridBitmap;
		protected var hoverSprite:Scale9GridBitmap;
		protected var downSprite:Scale9GridBitmap;
		
		public function HSilderBarDesinger()
		{
			super()
			var normal:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.Block.Normal")
			var hover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.Block.Normal")
			var down:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.Block.Normal")
			var blockRect:Rectangle = UIFramework.resource.getElementRectangle("HSilderBar", "Block");
			normalSprite = new Scale9GridBitmap(normal, blockRect);
			hoverSprite = new Scale9GridBitmap(hover, blockRect);
			downSprite = new Scale9GridBitmap(down, blockRect);
			
			blockButton = new DisplayButton(normalSprite, hoverSprite, downSprite);
			blockButton.y = 1;
			setblockLength(50);
			
			var bottomRect:Rectangle = UIFramework.resource.getElementRectangle("HSilderBar", "Bottom");
			bottomContainer = new Scale9GridBitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.Bottom"), bottomRect);
			bottomContainer.width = 150;
			addChild(bottomContainer);
			addChild(blockButton);
		}
		
		public function setblockLength(value:Number):void {
			normalSprite.width = hoverSprite.width = downSprite.width = value;
		}
		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			blockButton.addEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,silderDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, silderStopDragLogic);
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();
			blockButton.removeEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,silderDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_UP, silderStopDragLogic);
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


