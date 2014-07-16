package zebraui.components.silder
{
	import zebraui.components.UIComponent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.button.ButtonState;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	
	public class VSilderLite extends VSilderLiteDesinger
	{
		
		public function VSilderLite()
		{
			super();
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
			blockButton.y   =  	(_currentValue-_minValue) / _valueBound * (bottomContainer.height - blockButton.height) + bottomContainer.y;
		}
		
	 
		
		override public function set height(value:Number):void 
		{
			super.width = value;
			bottomContainer.height = value;
			currentValue = _currentValue;
		}
					
		override public function get height():Number 
		{
			return bottomContainer.height;
		}
	}

}