package zebraui.components.menu 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zebraui.components.button.BaseButton;
	import zebraui.components.button.ButtonState;
	public class MenuButton extends BaseButton
	{
	 
		public function MenuButton(preferWidth:Number = 50, preferHeight:Number = 26)
		{
			super(preferWidth, preferHeight);			
		}
		
		override protected function initialize():void 
		{
			this._disable_bitmapdata =  new BitmapData(10,10,false,0x1E8823)
			this._down_bitmapdata = new BitmapData(10,10,false,0x1E8823)
			this._hover_bitmapdata = new BitmapData(10,10,false,0x9FC58B)
			this._normal_bitmapdata = new BitmapData(10,10,true,0xFFFFFF)
			super.initialize();
		}
		
		override protected function addToStageControl():void 
		{
			this.textcolor = 0x253717;
			super.addToStageControl();
		}
		
		override protected function get viewRectangle():Rectangle 
		{
			return new Rectangle(1,0,5,5);
		}
		
		
		 override protected function onStateRollOver(e:MouseEvent):void 
		 {
			 if(isActive)
			 this.textcolor = 0xFFFFFF;
			 super.onStateRollOver(e);
		 }
		 
		 override protected function onStateRollOut(e:MouseEvent):void 
		 {
			 if(isActive)
			 this.textcolor = 0x253717;
			 super.onStateRollOut(e);
		 }
		
		override protected function onStateClick(e:MouseEvent):void 
		{
			super.onStateClick(e);
			this.enabled = false;
			this.state = ButtonState.DOWN;
			this.textcolor = 0xFFFFFF;
		}

		
 
	}
	
	

}