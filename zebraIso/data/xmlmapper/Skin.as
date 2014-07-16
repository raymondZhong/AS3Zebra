package zebraIso.data.xmlmapper
{
	import zebraIso.IsoGame;
	
	public class Skin
	{
		
		public function Skin()
		{
		
		}
		
		// <skin action="warp" offsetX="-61" id="s1" tid="t1" offsetY="-64"/>
		
		public var id:String;
		public var action:String;
		public var offsetX:int;
		public var offsetY:int;
		public var tid:String;
		
		private var _texture:Textures;
		
		/**
		 * 皮肤所在的纹理
		 * @return
		 */
		public function getTexture():Textures
		{
			if (_texture == null)
			{
				for each (var item:Textures in IsoGame.resource.resource.texture)
				{
					if (item.id == tid)
					{
						_texture = item;
						return _texture;
					}
				}
			}
			return _texture;
		}
	
	}

}