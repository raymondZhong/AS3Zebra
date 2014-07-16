package zebraui.components.panel 
{
	import flash.display.BitmapData;
	import zebraui.components.UIComponent;

	
	public class Panel extends PanelDesigner
	{
		public function Panel(preferWidth:Number = 300, preferHeight:Number = 300)
		{
			super(preferWidth, preferHeight);
		}
		
		
		override protected function initialize():void 
		{
		 
			super.initialize();
		}
		
		public function get title():String 
		{
			return  header.title;
		}
		
		public function set title(value:String):void 
		{
			 header.title = value;
		}
		
		public function get icon():BitmapData 
		{
			return header.icon;
		}
		
		public function set icon(value:BitmapData):void 
		{
			header.icon = value;
		}
		
	}

}