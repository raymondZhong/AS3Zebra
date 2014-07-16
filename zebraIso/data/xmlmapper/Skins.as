package zebraIso.data.xmlmapper
{
	
	public class Skins
	{
		
		public function Skins()
		{
		
		}
		
		public var skin:Vector.<Skin>;
		
		public function addSkin(action:String, texture:String, offsetX:int, offsetY:int):void
		{
			var child:Skin = new Skin()
			child.id = "s" + (getMaxSkinId() + 1);
			child.action = action;
			child.offsetX = offsetX;
			child.offsetY = offsetY;
			child.tid = texture;
			this.skin.push(child);
		}
		
		public function getSkin(id:String):Skin
		{
			for each (var item:Skin in skin)
			{
				if (item.id == id)
					return item;
			}
			return null;
		}
		
		
		public function getMaxSkinId():int
		{
			if (skin.length == 0)
				return 0;
			return int(skin[skin.length - 1].id.replace("s", ""));
		}
	
	}

}