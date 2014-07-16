package zebraMobileUI.components 
{
	import flash.display.Sprite;
	
	
	public class MobileComponent extends Sprite
	{
		
		
		protected var _theme:String = "default";
		protected var _preferWidth:Number;
		protected var _preferHeight:Number;
 
		
		public function MobileComponent() 
		{
			eventHandler();
		}
		
		protected function eventHandler():void 
		{
			
		}
		
		
		
		public function dispose():void {
			
		}
		
		
		public function get theme():String 
		{
			return _theme;
		}
		
		public function set theme(value:String):void 
		{
			_theme = value;
		}
		
	}

}