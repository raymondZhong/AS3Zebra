package zebraIso.data.xmlmapper 
{
	public class Tile 
	{		
		public var id:String;
		public var walk:Boolean; 
		public var title:String;
		public var tilechild:Vector.<TileChild>;
		public var x:int;
		public var z:int;
		
		public function Tile() {
			  x = 1;
			  z = 1;
			}
		
		public function addTileChild(skinId:String):void {
				 var tchild:TileChild = new TileChild();
					tchild.skinId = skinId;
					tilechild.push(tchild);
			}
			
		public function delTileChildAt(index:int):void {
			   if(index>-1){
				tilechild.splice(index,1)
			   }
			}	
			
		public function clearTileChild():void {
			  tilechild = new Vector.<TileChild>();
			}
			
		public function removeTileChild(skinId:String):void {
			  var index:int = -1;
			 for (var i:int = 0; i < tilechild.length; i++) 
			 {
				 if (tilechild[i].skinId == skinId) {
					 index = i;
					}
			 }
			 if (index != -1)  tilechild.splice(index, 1);			 
			}
	}

}