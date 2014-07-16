package zebraui.components.menu 
{
	import zebraui.components.core.BaseSpacer;
	import zebraui.components.InteractiveUIComponent;
	public class ToolStripItem extends InteractiveUIComponent
	{
		protected var spacer:BaseSpacer;
		public function ToolStripItem(preferWidth:Number = 0, preferHeight:Number = 0)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void 
		{
			spacer = new BaseSpacer(_preferWidth, _preferHeight)
			addChild(spacer);
			super.initialize();
		}
		
		
		
	}

}