package zebra.system.util 
{
	import flash.net.*;
	import flash.utils.setTimeout;
	import flash.external.ExternalInterface;
	public class Javascript 
	{
		
		public function Javascript() 
		{
			
		}
		
		public static function QQ(qq:uint):void {
			  navigateToURL(new URLRequest('tencent://message/?uin='+qq),'_blank');
		  }
		
		  public static function OpenURL(url:String=null, target:String=null):void {
				if (url == null) { return; }
				if (target == null) {
					navigateToURL(new URLRequest(url), "_self");				
					}else {					
					navigateToURL(new URLRequest(url), "_blank"	);	
					}
		  }
		  
		  public static function Alert(str:String=""):void {
			   navigateToURL(new URLRequest("javascript:alert(\""+str+"\");"), "_self");
			  }
			  
			  
		  public static function  GoogleAnalytics(trackCode:String="",delay:Number=0):void {
			      setTimeout(RunGoogleAnalytics,delay,trackCode);
			  }
		  private static function  RunGoogleAnalytics(trackCode:String):void{			  
			  var _request:URLRequest = new URLRequest("javascript:pageTracker._trackPageview('"+trackCode+"');");
			  navigateToURL(_request,"_self");
			  }  
		
		 public static function  GoogleAsynAnalytics(trackCode:String="",jsMethond:String="GACode"):void {
			 //var _request:URLRequest = new URLRequest("javascript:pageTracker._trackPageview('"+trackCode+"');");
			 //var _request:URLRequest = new URLRequest("javascript:_gaq.push(['_trackPageview','" + trackCode + "']);");
			 if (jsMethond != null) {
				 ExternalInterface.call(jsMethond,trackCode);
				 }else{
			 var _request:URLRequest = new URLRequest("javascript:pageTracker._trackPageview('"+trackCode+"');");
				 navigateToURL(_request,"_self");}
			
			  
			 }
			  
		/*  public static function QuseryString(key:String):String {
				var qs:QueryString = QueryString.getInstance();
				return qs.getValue(key); 
			 }*/
		  
		  /**
		   * 刷新本页
		   * @param	url
		   * @param	target
		   */
		  public static function RefreshPage():void {
			   navigateToURL(new URLRequest("javascript:location.reload();"), "_self");
			  }
			  
		  /**
		   * 关闭页面
		   * @param	url
		   * @param	target
		   */
		
		  public static function ClosePage():void {
			   navigateToURL(new URLRequest("javascript:window.close()"),"_self");
			  }
			  
			  
		 public static function jsMethond(str:String):void {
		
			 //navigateToURL(new URLRequest("javascript:"++"),"_self");
			  }
	}

}