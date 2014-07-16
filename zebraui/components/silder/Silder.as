package zebraui.components.silder
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.button.ButtonState;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	
	public class Silder extends SilderDesinger 
	{
		protected var _inner:Boolean;
		public function Silder()
		{
			super();
		}
		
		override protected function silderDragLogic(e:MouseEvent):void 
		{
			super.silderDragLogic(e); 
			if (_IsDrag)
			{
				var rect:Rectangle = new Rectangle();
				if (!_inner)
				{
					rect.x = -blockButton.width / 2
					rect.width = bottomContainer.width;
				}
				else
				{
					rect.x = 0;
					rect.width = bottomContainer.width - blockButton.width;
				}
				blockButton.startDrag(false, rect);
				
				if (!_inner)
				{
					_progress = (blockButton.x + blockButton.width / 2) / rect.width;
				}
				else
				{
					_progress = (blockButton.x) / rect.width;
				}
				
				_progress = _progress < 0 ? 0 : _progress;				
				_currentValue = _progress * _valueBound+_minValue;
				
				if (_liveDragging)
				{
					dispatchSilderDragingEvent();
				}
			}
		}

		
		/**
		 * Block在内部
		 */
		public function get inner():Boolean
		{
			return _inner;
		}
		
		/**
		 * Block在内部
		 */
		public function set inner(value:Boolean):void
		{
			_inner = value;
			if (value)
				blockButton.x = 0;
			else
				blockButton.x = -blockButton.width / 2;
		}

		
		override public function set currentValue(value:int):void 
		{
			super.currentValue = value;
			if (!_inner)
			{
				blockButton.x   =  	(_currentValue-_minValue)/_valueBound*(bottomContainer.width )- blockButton.width/2	
			}else				
			{
				blockButton.x   =  	(_currentValue-_minValue)/_valueBound*(bottomContainer.width- blockButton.width)
			}
		}
				
		override public function set width(value:Number):void 
		{
			super.width = value;
			bottomContainer.width = value;
		}
			
		override public function get width():Number 
		{
			return bottomContainer.width;
		}
		
	}

}