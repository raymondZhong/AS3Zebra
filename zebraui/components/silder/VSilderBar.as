package zebraui.components.silder
{
	import flash.display.BitmapData;
	import zebraui.components.button.ImageButton;
	import zebraui.components.UIComponent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.button.ButtonState;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	import zebraui.UIFramework;
	
	public class VSilderBar extends VSilderBarDesinger
	{
		protected var topButton:ImageButton;
		protected var bottomButton:ImageButton;
		
		public function VSilderBar()
		{
			super();
			var topNormal:BitmapData =  UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderBar.topButton.Normal")
			var topHover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderBar.topButton.Hover")
			topButton = new ImageButton(topNormal, topHover)
			
			
			var bottomNormal:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderBar.bottomButton.Normal")
			var bottomHover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.VSilderBar.bottomButton.Hover")
			bottomButton = new ImageButton(bottomNormal,bottomHover)
			addChild(topButton)
			addChild(bottomButton)
			setChildIndex(blockButton, this.numChildren - 1);			
			bottomContainer.y = topButton.height;
			bottomContainer.y  -= 10;
			bottomButton.y = bottomContainer.y+bottomContainer.height;
			bottomButton.y -= 10;
			blockButton.y = bottomContainer.y;
			
		}
		
		override protected function addToStageControl():void 
		{
			super.addToStageControl();
			topButton.ClickHandler = topLogic
			bottomButton.ClickHandler = bottomLogic;
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();	
			topButton.removeEventListener(MouseEvent.CLICK,topLogic)
			bottomButton.removeEventListener(MouseEvent.CLICK,bottomLogic)
		}
		
		private function bottomLogic(e:*):void 
		{
			this.progress += 0.1;
		}
		
		private function topLogic(e:*):void 
		{
			this.progress -= 0.1;
		}
		
		override protected function silderDragLogic(e:MouseEvent):void
		{
			super.silderDragLogic(e);
			if (_IsDrag)
			{
				var rect:Rectangle = new Rectangle();
				
				rect.x = 1;
				rect.y = bottomContainer.y;
				rect.width = 0;
				rect.height = bottomContainer.height - blockButton.height;
				
				blockButton.startDrag(false, rect);
				_progress = (blockButton.y-bottomContainer.y) / rect.height;
				
				_progress = _progress < 0 ? 0 : _progress;
				_currentValue = _progress * _valueBound + _minValue;
				
				if (_liveDragging)
				{
					dispatchSilderDragingEvent()
				}
			}
		}
		
		override public function set currentValue(value:int):void 
		{
			super.currentValue = value;	
			blockButton.y   =  	(_currentValue-_minValue) / _valueBound * (bottomContainer.height - blockButton.height) + bottomContainer.y;
		}
		
		override public function set height(value:Number):void 
		{
			super.width = value;
			bottomContainer.height = value- topButton.height- bottomButton.height+20;
			bottomContainer.y = topButton.height;
			bottomContainer.y  -= 10;
			bottomButton.y = bottomContainer.y+bottomContainer.height;
			bottomButton.y -= 10;
			blockButton.y = bottomContainer.y;
			progress = _progress;
		}
					
		override public function get height():Number 
		{
			return bottomContainer.height;
		}
	
	}

}