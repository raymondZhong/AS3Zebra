package zebraui.components.form
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import zebraui.components.InteractiveUIComponent;
	import zebraui.components.core.BaseSpacer;
	import zebraui.components.text.Label;
	import zebraui.components.UIComponent;
	import zebraui.event.RadioEvent;
	
 
	import zebraui.UIFramework;
	
	
	[Event(name="select",type="zebraui.event.RadioEvent")]
	
	public class Radio extends InteractiveUIComponent
	{
		private var _spacer:BaseSpacer;
		private var _label:Label;
		private var _radioNormal:BitmapData;
		private var _radioHover:BitmapData;
		private var _radioSelected:BitmapData;
		private var _selected:Boolean;
		private var _text:String;
		private var _value:Object;
		
		override protected function initialize():void
		{
			_radioNormal = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Radio.Normal");
			_radioHover = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Radio.Normal");
			_radioSelected = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Radio.Selected");
			_spacer = new BaseSpacer(true);
			addChild(_spacer);
			_label = new Label();
			_label.text = "";
			_label.icon = _radioNormal;
			addChild(_label);
			
			_spacer.width = _label.width;
			_spacer.height = _label.height;
			
			super.initialize();
		}
		
		override protected function eventListener():void
		{
			ClickHandler = _selectHandlerLogic;
			HoverHandler = _hoverHandlerLogic;
			OutHandler = _outHandlerLogic;
			super.eventListener();
		}
		
		private function _outHandlerLogic(e:*):void
		{
			if (!_selected)
			{
				_label.icon = _radioNormal;
			}
		}
		
		private function _hoverHandlerLogic(e:*):void
		{
			if (!_selected)
			{
				_label.icon = _radioHover;
			}
		}
		
		private function _selectHandlerLogic(e:*):void
		{
			if (!_selected)
			{
				selected = true;
				var event:RadioEvent = new RadioEvent(RadioEvent.Select);
				event.selected = _selected;
				event.text = _label.text;
				event.value = _value;
				this.dispatchEvent(event);
			}
		}
		
 
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if (value)
			{
				_label.icon = _radioSelected;
			}
			else
			{
				_label.icon = _radioNormal;
			}
		
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			_label.text = value;
		}
		
		public function get value():Object
		{
			return _value;
		}
		
		public function set value(value:Object):void
		{
			_value = value;
		}
	
	}
}