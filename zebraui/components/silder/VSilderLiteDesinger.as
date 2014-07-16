package zebraui.components.silder
{
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
	
	internal class VSilderLiteDesinger extends AbstractSilder
	{
	  
		protected var normalSprite:Scale9GridBitmap;
		protected var hoverSprite:Scale9GridBitmap;
		protected var downSprite:Scale9GridBitmap;
		
		public function VSilderLiteDesinger()
		{
			super()
			var normal:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderLite.Block.Normal")
			var hover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderLite.Block.Hover")
			var down:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderLite.Block.Down")
			var blockRect:Rectangle = UIFramework.resource.getElementRectangle("VSilderLite", "Block");
			normalSprite = new Scale9GridBitmap(normal, blockRect);
			hoverSprite = new Scale9GridBitmap(hover, blockRect);
			downSprite = new Scale9GridBitmap(down, blockRect);
			
			blockButton = new DisplayButton(normalSprite, hoverSprite, downSprite);
			blockButton.x = 1;
			setblockLength(50);
			
			var bottomRect:Rectangle = UIFramework.resource.getElementRectangle("VSilderLite", "Bottom");
			bottomContainer = new Scale9GridBitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderLite.Bottom"), bottomRect);
			bottomContainer.height = 150;
			addChild(bottomContainer);
			addChild(blockButton);
		}
		
		public function setblockLength(value:Number):void
		{
			normalSprite.height = hoverSprite.height = downSprite.height = value;
		}
		
		override protected function addToStageControl():void
		{
			super.addToStageControl();
			blockButton.addEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, silderDragLogic);
			stage.addEventListener(MouseEvent.MOUSE_UP, silderStopDragLogic);
		}
		
		override protected function removeStageControl():void
		{
			super.removeStageControl();
			blockButton.removeEventListener(MouseEvent.MOUSE_DOWN, silderInitDragLogic);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, silderDragLogic);
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