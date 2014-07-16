package zebraMobileUI.skinSetting 
{
	import flash.system.ApplicationDomain;
	public class MobileResource
	{
		private var _applicationDomain:ApplicationDomain
		public function MobileResource(domain:ApplicationDomain) 
		{
			_applicationDomain = domain;
		}
		   
		
		public var buttonSetting:ButtonSetting;
		
		public function get applicationDomain():ApplicationDomain 
		{
			return _applicationDomain;
		}
		
		 
		
	}

}