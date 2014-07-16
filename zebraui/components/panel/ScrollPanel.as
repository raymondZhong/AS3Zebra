package zebraui.components.panel
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import zebraui.components.container.Box;
	import zebraui.components.silder.HSilderBar;
	import zebraui.components.silder.SilderPolicy;
	import zebraui.components.silder.VSilderBar;
	import zebraui.components.UIComponent;
	import zebraui.event.ScrollPanelEvent;
	import zebraui.event.SilderEvent;
	
	[Event(name="draging",type="zebraui.event.ScrollPanelEvent")]
	
	public class ScrollPanel extends AbstractScrollPanel
	{
		 
		public function ScrollPanel(preferWidth:Number = 200, preferHeight:Number = 200,vSilderPolicy:String="auto",hSilderPolicy:String="auto")
		{
			super(preferWidth, preferHeight,vSilderPolicy,hSilderPolicy);
		}
		
		
		override public function dispose():void
		{
			_body.dispose()
			super.dispose();
		}
		
	 
		
		 
	}

}