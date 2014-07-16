package zebraui.components.menu 
{
	import zebraui.components.UIComponent;
	import flash.display.Bitmap;
	import zebraui.components.toolbar.ToolbarDesigner;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import zebraui.UIFramework;
	public class Menu extends MenuDesigner
	{
		
	    public function Menu(preferWidth:Number = 300, preferHeight:Number = 24)
		{
			var bmd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Menu.Background");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Menu", "Background");
			 super(bmd,rect, preferWidth, preferHeight);
		}
		//ToolStripMenuPanel
		public function addMenuItem(text:String):void
		{
			var button:MenuButton = new MenuButton();
				button.text = text;
			 appendLeft(button);
		} 
		
	}

}