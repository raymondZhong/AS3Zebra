package zebraIso.data.xmlmapper 
{
	import zebraIso.IsoGame;
 
	public class TileChild 
	{
		
		public var skinId:String;
		private var _skin:Skin;
		
		public function getSkin():Skin 
		{
			if (_skin == null)
			{
				for each (var item:Skin in  IsoGame.resource.libary.skins.skin)
				{
					if (item.id == skinId)
					{
						_skin = item;
						return _skin;
					}
				}
			}
			return _skin;
		}
		
		
	}

}