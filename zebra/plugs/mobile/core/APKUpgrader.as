package zebra.plugs.mobile.core
{
	
	import air.net.URLMonitor;
	import com.illuzor.fileextension.FileExtension;
	import flash.desktop.NativeApplication;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.events.StatusEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import zebra.content.GameAsset;
	import zebra.loaders.AssetType;
	import zebra.loaders.IAssetLoader;
	import zebra.plugs.mobile.model.AppConfig;
	import zebra.system.xml.XmlMapper;
	
	public class APKUpgrader extends EventDispatcher
	{
		
		private var urlStream:URLStream;
		private var fileData:ByteArray
		private var _url:String;
		
		
		static public const DOWNLOADING:String = "downloading";
		static public const DOWNBEGIN:String = "downbegin";
		static public const DOWNCOMPLETE:String = "downcomplete";		
		static public const NETERROR:String = "net_error";
		static public const NEEDUPGRADER:String = "need_upgrader";
		static public const NOTNEEDUPGRADER:String = "not_need_upgrader";
		
		private var _progress:Number = 0;
		private var _localAppConfig:AppConfig;
		private var _serverAppConfig:AppConfig;
		
		public function APKUpgrader(currentAppConfig:AppConfig)
		{
			_localAppConfig = currentAppConfig;
			_url = _localAppConfig.configUrl+"?ver="+Math.random();
			var monitor:URLMonitor = new URLMonitor(new URLRequest(_url));
			monitor.addEventListener(StatusEvent.STATUS, checkHTTP);
			monitor.start();
		}
		
		//检查网络
		private function checkHTTP(e:StatusEvent):void
		{
			var monitor:URLMonitor = URLMonitor(e.target);
			if (monitor.available)
			{
				//网络正常
				trace("Internet is available");
				//upgraderLogic()
				
				GameAsset.load(_url, AssetType.TEXT);
				GameAsset.receive(_url,parseXMLLogic)
			}
			else
			{
				//网络不正常
				trace("No internet connection available");
			}
		
		}
		
		//解析数据
		private function parseXMLLogic(e:IAssetLoader):void 
		{
				 _serverAppConfig = new AppConfig();
			     XmlMapper.bind(_serverAppConfig, new XML(String(e.content)));
				 e.dispose();
				 
			var appXml:XML =  NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			if ( appXml.ns::versionNumber == _serverAppConfig.version) {
			     this.dispatchEvent(new Event(NOTNEEDUPGRADER));
				}else {
			     this.dispatchEvent(new Event(NEEDUPGRADER));
				 upgraderLogic(_serverAppConfig.store);
				}
		}
		
		//更新逻辑
		private function upgraderLogic(apk:String):void 
		{
			var urlReq:URLRequest = new URLRequest(apk);
				urlStream = new URLStream(); 
				fileData = new ByteArray(); 
				urlStream.addEventListener(ProgressEvent.PROGRESS,progressHandler)
				urlStream.addEventListener(Event.COMPLETE, completeHandler); 
				urlStream.load(urlReq);				
				this.dispatchEvent(new Event(DOWNBEGIN));
		}
		
		private function completeHandler(e:Event):void 
		{
			_progress = 1;
			urlStream.readBytes(fileData, 0, urlStream.bytesAvailable); 
			writeAirFile(); 
			this.dispatchEvent(new Event(DOWNCOMPLETE));
		}
		
		//写入文件
		private function writeAirFile():void { 
			var file:File =   new File(File.userDirectory.nativePath + "/download/"+_serverAppConfig.name+".apk");
			if (file.exists) file.deleteFile();
		    var fileStream:FileStream = new FileStream(); 
				fileStream.open(file, FileMode.WRITE); 
				fileStream.writeBytes(fileData, 0, fileData.length); 
				fileStream.close();				
			FileExtension.openFile(file);
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			_progress = e.bytesLoaded / e.bytesTotal;
			this.dispatchEvent(new Event(DOWNLOADING));
		}
		
		public function get progress():Number 
		{
			return _progress;
		}
		
		public function get localAppConfig():AppConfig 
		{
			return _localAppConfig;
		}
		
		public function get serverAppConfig():AppConfig 
		{
			return _serverAppConfig;
		}
	
	}

}