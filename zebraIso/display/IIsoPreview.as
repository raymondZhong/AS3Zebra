package zebraIso.display
{
	import flash.display.DisplayObject;
	import flash.geom.Vector3D;
	import zebraIso.data.IsoBound;
	import zebraIso.data.xmlmapper.Tile;
	
	public interface IIsoPreview
	{
		function setTarget(target:DisplayObject, tile:Tile = null):void
		
		function clearTarget():void
		
		function setTile(tile:Tile):void
		function hasTile():Boolean
		function clearTile():void
		function getTile():Tile
		
		function setGridSize(widthX:uint, lengthZ:uint):void
		
		function setGridColor(color:uint):void
		
		function get isogrid():IsoGrid
		
		function get IsCenter():Boolean
		
		function set IsCenter(value:Boolean):void
		
		function get IsRender():Boolean
		
		function set x(value:Number):void
		
		function get x():Number
		
		function set y(value:Number):void
		
		function get y():Number
		
		function get param():*
		
		function set param(value:*):void
		
		function get IsBuild():Boolean
		
		function set IsBuild(value:Boolean):void
		
		function get filters():Array
		
		function set filters(value:Array):void
		
		function get bound():IsoBound
		
		function set bound(value:IsoBound):void
	
	}

}