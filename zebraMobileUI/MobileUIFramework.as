package zebraMobileUI 
{
	import flash.display.Stage;
	import zebra.system.xml.XmlMapper;
	import zebraMobileUI.skinSetting.MobileResource; 
 
	public class MobileUIFramework 
	{
		
		
		static private var _resource:MobileResource;
		
		public function MobileUIFramework(stage:Stage,resourceXML:XML) 
		{
			_resource = new MobileResource(stage.loaderInfo.applicationDomain);			
			XmlMapper.bind(_resource, resourceXML);
		}
		
		static  public function get resource():MobileResource
		{
			return _resource;
		}
		
		
		
		
	}

}