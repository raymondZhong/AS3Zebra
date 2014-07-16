package zebraui 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import zebraui.util.UIResource;
 

	public class UIFramework  
	{
		
		static public const resource:UIResource=new UIResource();
		static private var _stage:Stage;
		static private var _initialized:Boolean;

		
		private var _uiSettingData:XML;
		public var onReadyHandler:Function;
		
		public function UIFramework(stage:Stage,uiSWF:String,uiSettingData:XML) 
		{
			_initialized = true;
			_stage = stage;
			var load:Loader = new Loader()
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			load.load(new URLRequest(uiSWF));
			_uiSettingData = uiSettingData;
		}
		
		static public function get INITIALIZED():Boolean { return _initialized; };
	
		
		private function loadComplete(e:Event):void 
		{
			 resource.initialize(LoaderInfo(e.target).applicationDomain, _uiSettingData);
			 if (onReadyHandler) onReadyHandler();
		}
		
		
			
	}

}