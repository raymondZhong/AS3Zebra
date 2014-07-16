package zebra.plugs.mobile.core
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class Webkit
	{
		
		public function Webkit()
		{
		
		}
		
		static public function openUrl(url:String):void
		{
			var request:URLRequest = new URLRequest(url);
			navigateToURL(request);
		
		}
		//navigateToURL(new URLRequest("market://details?id=air.com.afterisk.sketchguessfree"));
		
		
		static public function market(packname:String):void {
			     openUrl("market://details?id="+packname);
			}
			
		//static public function openAndroidAPP(packname:String):void {
			     //openUrl("weixin://123123");
			//}	
			//
		//static public function openAppleAPP(packname:String):void {
			     //openUrl("myapp://"+packname);
			//}
	
		
	}

}