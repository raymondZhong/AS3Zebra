package zebraIso.data.xmlmapper 
{
	import zebra.data.IGameTexture;
	public class Textures
	{
		private var _gametexture:IGameTexture;
 
		public var id:String;
		public var path:String;
		
		public function get gametexture():IGameTexture 
		{
			return _gametexture;
		}
		
		public function set gametexture(value:IGameTexture):void 
		{
			_gametexture = value;
		}
		
		
		
	}

}