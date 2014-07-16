package zebraui.components.form
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import zebraui.components.core.BaseSpacer;
	import zebraui.components.InteractiveUIComponent;
	import zebraui.components.text.Label;
	import zebraui.data.UIModel;
	import zebraui.event.ListBoxEvent;
	import zebraui.UIFramework;
	
	[Event(name="CellRender_Select",type="zebraui.event.ListBoxEvent")]
	
	public class ListBoxCellRender extends InteractiveUIComponent
	{
		private var _spacer:BaseSpacer;
		private var _label:Label;
		private var _icon:BitmapData;
		private var _selected:Boolean;		
		protected var position:int;
		private var _model:UIModel;
		public var index:int;
		private var _rootHasIcon:Boolean;
		
		public function ListBoxCellRender(model:UIModel, pos:int, rootHasIcon:Boolean, preferWidth:Number = 100, preferHeight:Number = 23)
		{
			_model = model;
			_rootHasIcon = rootHasIcon;
			position = pos;
			HoverHandler = hoverHandler;
			OutHandler = outHandlerLogic;
			ClickHandler = clickHandlerLogic;
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			_spacer = new BaseSpacer()
			addChild(_spacer);
			_label = new Label();
			_label.text = _model.text
			_label.icon = _model.bitmap;
			//if (_rootHasIcon)
				//_label.x = 20;
			//else
			_label.x = 6;			
			_label.y = 2;
			addChild(_label);
		}
		
		override protected function addToStageControl():void
		{
			_spacer.width = _preferWidth;
			if (_label.height > _preferHeight) _preferHeight = _label.height;			
			_spacer.height = _preferHeight;
			super.addToStageControl();
		}
		
		public function get text():String
		{
			return _label.text;
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
		}
		
		public function get icon():BitmapData
		{
			return _label.icon;
		}
		
		public function set icon(value:BitmapData):void
		{
			_label.icon = value;
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
				getBackground().begFill(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.ItemRowBackground.Selected"));
				_label.color = 0xFFFFFF;
			}
			else
			{
				getBackground().clearFill();
				_label.color = 0x000000;
			}
		}
		
		public function get value():UIModel
		{
			return _model;
		}
		
		public function hoverHandler(e:*):void
		{
			if (!_selected)
			{
				getBackground().begFill(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.ItemRowBackground.Hover"));
				_label.color = 0xFFFFFF;
			}
		}
		
		private function outHandlerLogic(e:*):void
		{
			if (!_selected)
			{
				getBackground().clearFill();
				_label.color = 0x000000;
			}
		
		}
		
		private function clickHandlerLogic(e:*):void
		{
			if(!_selected){
				getBackground().begFill(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.ItemRowBackground.Selected"));
				_label.color = 0xFFFFFF;
				_selected = true;
				var event:ListBoxEvent = new ListBoxEvent(ListBoxEvent.CellRender_Select)
				event.selectIndex = position;
				event.selectData = _model;
				dispatchEvent(event);
			}
		}
		
		override public function get height():Number 
		{
			return _label.height + _label.y*2;
		}
		
	
	}

}