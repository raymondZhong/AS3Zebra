package zebraui.components.panel
{
	import zebraui.components.text.Label;
	import zebraui.components.toolbar.ToolbarDesigner;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import zebraui.UIFramework;
	
	public class PanelHeaderDesigner extends ToolbarDesigner
	{
		private var _titleLable:Label; 
		public function PanelHeaderDesigner(preferWidth:Number = 300, preferHeight:Number = 24)
		{
			var bmd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.Header");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Public", "PanelHeader");
			super(bmd, rect, preferWidth, preferHeight);
			this.mouseChildren = false;
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			_titleLable = new Label();
			_titleLable.text = "title";
			_titleLable.bold = true;
			appendCenter(_titleLable);
		}
		
		public function get title():String 
		{
			return _titleLable.text;
		}
		
		public function set title(value:String):void 
		{
			_titleLable.text = value;
		}
	
		
		public function get icon():BitmapData 
		{
			return _titleLable.icon;
		}
		
		public function set icon(value:BitmapData):void 
		{
			_titleLable.icon = value;
		}
	}

}