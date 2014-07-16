package zebraIso
{
	import zebraIso.data.IsoResource;
	import zebra.system.xml.XmlMapper;
	
	public class IsoGame
	{
		public function IsoGame(resmap:XML)
		{
			resource = new IsoResource();
			XmlMapper.bind(resource, resmap);
		}
		
		static public var resource:IsoResource;
		
		
		static public var textureType:String = "png";
		
		/**
		 * 资源内容路径
		 */
		public function get contentRoot():String
		{
			return resource.contentRootPath;
		}
		
		/**
		 * 资源内容路径
		 */
		public function set contentRoot(value:String):void
		{
			resource.contentRootPath = value;
		}
	}

}