package zebraui.components.silder 
{ 	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import zebraui.components.button.ImageButton;
	import zebraui.UIFramework;
	public class HSilderBar extends HSilderBarDesinger
	{
			protected var topButton:ImageButton;
		protected var bottomButton:ImageButton;
		
		public function HSilderBar() 
		{
			super();
			var topNormal:BitmapData =  UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.topButton.Normal")
			var topHover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.topButton.Hover")
			topButton = new ImageButton(topNormal, topHover)
			
			
			var bottomNormal:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.bottomButton.Normal")
			var bottomHover:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.HSilderBar.bottomButton.Hover")
			bottomButton = new ImageButton(bottomNormal,bottomHover)
			addChild(topButton);
			addChild(bottomButton);		
			setChildIndex(blockButton, this.numChildren - 1);
			
			bottomContainer.x = topButton.x+topButton.width;
			bottomContainer.x  -= 10;
			bottomButton.x = bottomContainer.x+bottomContainer.width;
			bottomButton.x -= 10;
			blockButton.x = bottomContainer.x;
		}
		
			override protected function addToStageControl():void 
		{
			super.addToStageControl();
			topButton.addEventListener(MouseEvent.CLICK,topLogic)
			bottomButton.addEventListener(MouseEvent.CLICK,bottomLogic)
		}
		
		override protected function removeStageControl():void 
		{
			super.removeStageControl();	
			topButton.removeEventListener(MouseEvent.CLICK,topLogic)
			bottomButton.removeEventListener(MouseEvent.CLICK,bottomLogic)
		}
		
		private function bottomLogic(e:MouseEvent):void 
		{
			this.progress +=0.1
		}
		
		private function topLogic(e:MouseEvent):void 
		{
			this.progress -=0.1
		}
		
		override protected function silderDragLogic(e:MouseEvent):void 
		{
			super.silderDragLogic(e); 
			if (_IsDrag)
			{
				var rect:Rectangle = new Rectangle();
 
				rect.x = bottomContainer.x;
				rect.y = 1;
				rect.width = bottomContainer.width - blockButton.width;
				 
				blockButton.startDrag(false, rect);
				_progress = (blockButton.x-bottomContainer.x) / rect.width;
				
				_progress = _progress < 0 ? 0 : _progress;				
				_currentValue = _progress * _valueBound+_minValue;
				
				if (_liveDragging)
				{
					dispatchSilderDragingEvent()
				}
			}
		}
		
		override public function set currentValue(value:int):void 
		{
			super.currentValue = value;			 
			blockButton.x   =  	(_currentValue-_minValue) / _valueBound * (bottomContainer.width - blockButton.width) + bottomContainer.x;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			bottomContainer.width = value-topButton.width - bottomButton.width+20;
			bottomContainer.x = topButton.x+topButton.width;
			bottomContainer.x  -= 10;
			bottomButton.x = bottomContainer.x+bottomContainer.width;
			bottomButton.x -= 10;
			blockButton.x = bottomContainer.x;
			currentValue = _currentValue;
			
		}
					
		override public function get width():Number 
		{
			return bottomContainer.width;
		}
	}

}