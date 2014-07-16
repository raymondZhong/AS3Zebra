package zebra.system.net 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author raymond
	 */
	public class HttpClient 
	{
			
		private var request:URLRequest;
		private var loader:URLLoader;
		public var getServerData:Function;	
		public var ioErrorHandler:Function;	
		
		public function HttpClient(url:String) 
		{
			loader = new URLLoader()			
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			request = new URLRequest(url);		
		
		}
		
		private function errorHandler(e:IOErrorEvent):void 
		{
			//trace("httpClient->error:", e);
			if (ioErrorHandler) {
				ioErrorHandler(e);
				}
		}
		
		private function completeHandler(e:Event):void 
		{
			 if (getServerData) {
					getServerData(loader.data);
				 }
			
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		public function pushHeader(header:URLRequestHeader):void {
			   request.requestHeaders.push(header);
			}
		
		
		public function post(data:URLVariables=null):void {
			request.method == URLRequestMethod.POST;
			request.data = data;
			loader.load(request);
		}
		
		public function get(data:URLVariables=null):void {
			request.method == URLRequestMethod.GET;
			request.data = data;
			loader.load(request);
		}
		
		
		public function postImage(value:*):void {			  
			  request.method = URLRequestMethod.POST;
			  request.contentType = "application/octet-stream";
			  request.data = value; 			  
			  loader.load(request);
			}
		
	}

}