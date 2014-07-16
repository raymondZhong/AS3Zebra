package zebraui.components.toolbar
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import zebraui.UIFramework;
	
	public class Toolbar extends ToolbarDesigner
	{
		public function Toolbar(preferWidth:Number = 300, preferHeight:Number = 24)
		{
			var bmd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Toolbar.Background");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Toolbar", "DefaultTheme");
			super(bmd,rect,preferWidth, preferHeight);
		}
		
		
	}

}