package zebraMobileUI.skinSetting 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import zebraMobileUI.MobileUIFramework;
	public class ButtonNode 
	{
		
		public function ButtonNode() 
		{
			
		}
		
		
		public var theme:String;
		public var touchNormal:String;
		public var touchTrigger:String;
		public var rect:String;
		
	 	public function getRectBound():Rectangle {
				var data:Array = rect.split(",");
				return new Rectangle(data[0], data[1], data[2], data[3]);
			} 
		
		public function getNormalBmd():* {
			var cls:* = MobileUIFramework.resource.applicationDomain.getDefinition(touchNormal);
			    return   BitmapData(new cls());
			}
		public function getTriggerBmd():* {
			var cls:* = MobileUIFramework.resource.applicationDomain.getDefinition(touchTrigger);
			    return   BitmapData(new cls());
			}
	}

}