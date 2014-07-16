package zebraui.components.silder 
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class HSilderLite extends HSilderLiteDesinger
	{
		
		public function HSilderLite() 
		{
			super(); 
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
			bottomContainer.width = value;
			currentValue = _currentValue;
			
		}
					
		override public function get width():Number 
		{
			return bottomContainer.width;
		}
	}

}