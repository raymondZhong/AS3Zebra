package zebraui.components.form
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import zebraui.components.InteractiveUIComponent;
	import zebraui.components.core.BaseSpacer;
	import zebraui.components.text.Label;
	import zebraui.components.UIComponent;
	import zebraui.event.CheckboxEvent;
	import zebraui.UIFramework;
	
	[Event(name="select",type="zebraui.event.CheckboxEvent")]
	
	public class Checkbox extends InteractiveUIComponent
	{
		private var _spacer:BaseSpacer;
		private var _label:Label;
		private var _checkboxNormal:BitmapData;
		private var _checkboxHover:BitmapData;
		private var _checkboxSelected:BitmapData;
		private var _selected:Boolean;
		private var _text:String;
		private var _value:Object;
		
		override protected function initialize():void
		{			
			_checkboxNormal = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Checkbox.Normal");
			_checkboxHover = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Checkbox.Hover");
			_checkboxSelected = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Checkbox.Selected");
			_spacer = new BaseSpacer(true)
			addChild(_spacer)
			_label = new Label();
			_label.text = "";
			_label.icon = _checkboxNormal;
			addChild(_label)
			
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
				_label.icon = _checkboxNormal;
			}
		}
		
		private function _hoverHandlerLogic(e:*):void
		{
			if (!_selected)
			{
				_label.icon = _checkboxHover;
			}
		}
		
		private function _selectHandlerLogic(e:*):void
		{
			selected = !selected;
			var event:CheckboxEvent = new CheckboxEvent(CheckboxEvent.Select);
			event.selected = _selected;
			event.text = _label.text;
			event.value = _value;
			this.dispatchEvent(event);
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			_label.icon = null;
			if (value)
			{
				_label.icon = _checkboxSelected;
			}
			else
			{
				_label.icon = _checkboxNormal;
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