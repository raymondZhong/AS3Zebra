package zebraIso.data
{
	import zebraIso.data.xmlmapper.Libarys;
	import zebraIso.data.xmlmapper.Resource;
	
	public class IsoResource
	{
		private var _contentRootPath:String
		public function IsoResource()
		{
		
		}
		public var resource:Resource;
		public var libary:Libarys;
		
		public function get contentRootPath():String 
		{
			return _contentRootPath;
		}
		
		public function set contentRootPath(value:String):void 
		{
			_contentRootPath = value;
		}
	}

}