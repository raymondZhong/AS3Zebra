package zebraIso.data.xmlmapper 
{ 
	public class Resource 
	{
		public var 	texture:Vector.<Textures> ;
		
		public function addTexture(path:String):String {
			var currentId:String =  "t" + (getMaxTextureId() + 1);
			   var child:Textures = new Textures();
				   child.id = currentId;
				   child.path = path;
				   this.texture.push(child);
				   return currentId;
			}
			
			
		public function getMaxTextureId():int {
			  if (texture.length == 0) return 0;
			  return int(texture[texture.length - 1].id.replace("t", ""));
			}
			
		public function getTextureById(tid:String):Textures{
			for each (var item:Textures in texture) 
			{
				if (item.id == tid) return item;
			}
			
			return null;
				 
			}	
		
		public function getTextureXMLPath(textureId:String):String {
			for each (var item:Textures in texture) 
			{
				if (item.id == textureId) return  item.path;
			}
			return null;
			}
		
	}

}