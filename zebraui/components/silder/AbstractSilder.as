package zebraui.components.silder
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import zebraui.components.button.AbstractButton;
	import zebraui.components.button.IButton;
	import zebraui.components.UIComponent;
	import zebraui.event.SilderEvent;
	
	
	[Event(name="draging",type="zebraui.event.SilderEvent")]
	[Event(name = "progress", type = "zebraui.event.SilderEvent")]
	
	public class AbstractSilder extends UIComponent implements ISilder
	{
		protected var _minValue:int;
		protected var _maxValue:int;
		protected var _valueBound:int;
		protected var _currentValue:int;
		protected var _progress:Number;		
		protected var _IsDrag:Boolean;
		protected var blockButton:AbstractButton;
		protected var bottomContainer:DisplayObject;
		/**
		 * 拖动中是否实时发送Event
		 */
		protected var _liveDragging:Boolean;
		
		public function AbstractSilder()
		{
			_minValue = 0;
			_maxValue = 100;
			_valueBound = _maxValue - _minValue;
			_currentValue = _minValue;
			_liveDragging = true;
			_progress = 0;
			super();
		}
		
		public function get minValue():int
		{
			return _minValue;
		}
		
		public function set minValue(value:int):void
		{
			_minValue = value;
			_currentValue = _minValue;
			_valueBound = _maxValue - _minValue;
		}
		
		public function get maxValue():int
		{
			return _maxValue;
		}
		
		public function set maxValue(value:int):void
		{
			_maxValue = value;			
			_valueBound = _maxValue - _minValue;
		}
		
		protected function get valueBound():int
		{
			return _maxValue - _minValue;
		}
		
		public function get currentValue():int
		{
			return _currentValue;
		}
		
		public function set currentValue(value:int):void
		{
			if(value< _minValue) value = _minValue
				if(value> _maxValue) value = _maxValue
				_currentValue = value;
				_progress    = (_currentValue -_minValue) / _valueBound;
			dispatchSilderProgressEvent();
		}
		
		/**
		 * 进度百分比
		 */
		public function get progress():Number
		{
			return _progress;
		}
		
		/**
		 * 进度百分比
		 */
		public function set progress(value:Number):void
		{
			if (value < 0)
				value = 0;
			if (value > 1)
				value = 1;
			_progress = value;
			currentValue  = _progress * _valueBound + _minValue;
			dispatchSilderProgressEvent();
		}
		
		public function get liveDragging():Boolean
		{
			return _liveDragging;
		}
		
		public function set liveDragging(value:Boolean):void
		{
			_liveDragging = value;
		}
		
		protected function dispatchSilderDragingEvent():void
		{
			var event:SilderEvent = new SilderEvent(SilderEvent.DRAGING)
				event.process = _progress;
				event.currentValue = currentValue;
				this.dispatchEvent(event);
		}
		
		protected function dispatchSilderProgressEvent():void
		{
			var event:SilderEvent = new SilderEvent(SilderEvent.PROGRESS)
				event.process = _progress;
				event.currentValue = currentValue;
				this.dispatchEvent(event);
		}

		
	}

}