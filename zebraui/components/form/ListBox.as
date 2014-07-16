package zebraui.components.form
{
	import flash.display.Bitmap;
	import zebraui.components.container.Box;
	import zebraui.components.core.BaseSpacer;
	import zebraui.components.layout.VBoxLayout;
	import zebraui.components.panel.ScrollPanel;
	import zebraui.components.silder.SilderPolicy;
	import zebraui.components.UIComponent;
	import zebraui.data.UIModel;
	import zebraui.event.ListBoxEvent;
	
	[Event(name="CellRender_Select",type="zebraui.event.ListBoxEvent")]
	
	public class ListBox extends FormUIComponent
	{
		private var body:ScrollPanel;
		private var cells:Vector.<ListBoxCellRender>;
		public var selectIndex:int = -1;
		
		public function ListBox(preferWidth:Number = 150, preferHeight:Number = 200)
		{
			var vbox:VBoxLayout = new VBoxLayout();
			vbox.autoHeight = true;
			body = new ScrollPanel(preferWidth, preferHeight);
			body.VSilderPolicy = SilderPolicy.AUTO;
			body.HSilderPolicy = SilderPolicy.OFF;
			body.scrollDrag = false;
			body.setLayout(vbox);
			body.getBackground().begFillColor(0xFFFFFF);
			body.getBorder().color = 0xD2D2D2;
			addChild(body)
			cells = new Vector.<ListBoxCellRender>();
			super(preferWidth, preferHeight);
		
		}
		
		override protected function removeStageControl():void
		{
			for each (var render:ListBoxCellRender in cells)
			{
				render.removeEventListener(ListBoxEvent.CellRender_Select, cellSelectLogic)
			}
			super.removeStageControl();
		}
		
		override public function set storeData(value:Vector.<UIModel>):void
		{
			super.storeData = value;
			for each (var render:ListBoxCellRender in cells)
			{
				render.removeEventListener(ListBoxEvent.CellRender_Select, cellSelectLogic)
			}
			cells = new Vector.<ListBoxCellRender>();
			body.clear();
			var hasIcon:Boolean = rootHasIcon();
			for (var i:int = 0; i < value.length; i++)
			{
				var cell:ListBoxCellRender = new ListBoxCellRender(value[i], i, hasIcon, preferWidth);
				cell.addEventListener(ListBoxEvent.CellRender_Select, cellSelectLogic)
				cells.push(cell);
				//cell.selected = true;
				body.append(cell);
			}
			selectIndex = -1;
		}
		
		private function rootHasIcon():Boolean
		{
			for each (var item:UIModel in _storeData)
			{
				if (item.bitmap != null)
					return true;
			}
			return false;
		}
		
		private function cellSelectLogic(e:ListBoxEvent):void
		{
			for each (var item:ListBoxCellRender in cells)
			{
				if (item != ListBoxCellRender(e.target))
					item.selected = false;
			}
			var event:ListBoxEvent = new ListBoxEvent(ListBoxEvent.CellRender_Select)
			event.selectIndex = e.selectIndex;
			event.selectData = e.selectData;
			dispatchEvent(event);
			selectIndex = e.selectIndex;
		}
		
		override public function get width():Number
		{
			return body.width;
		}
		
		override public function get height():Number
		{
			return body.height;
		}
		public function SetinitialSelectIndex(value:int):void
		{
			for (var i:int = 0; i < cells.length; i++)
			{
				if (i == value) cells[i].selected = true;
			}
		}
	
	}

}