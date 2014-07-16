package zebraIso.data.xmlmapper 
{
	public class Tiles 
	{
		
		public function Tiles() 
		{
			
		}
		
		public var  tile:Vector.<Tile>;
		
		public function addTile(value:Tile):void {
			//var value:Tile = new Tile();
			    //value.title = title;
				value.id = "tile"+String(getMaxTileId() + 1);
				value.tilechild = new Vector.<TileChild>();
				 tile.push(value);
			}
			
		public function delTile(value:Tile):void {
			   var index:int = tile.indexOf(value)
			   if (index != -1) {
				   tile.splice(index, 1);
				   }
			}	
			
		public function getMaxTileId():int
		{
			if (tile.length == 0)return 0;
			return int(tile[tile.length - 1].id.replace("tile", ""));
		}
	
		public function getTileById(tileId:String):Tile
		{
			 for each(var item:Tile in tile) {
					 if (item.id == tileId) return item;
					 }				 
			return null;
		}
		
	}

}