package zebraui.components.core
{
	import flash.display.BitmapData;
	
	public interface IBackground 
	{
	 	function set width(value:Number):void;
		function set height(value:Number):void; 
		function set repeat(value:Boolean):void
		function get repeat():Boolean;
		function set visible(value:Boolean):void
		function get visible():Boolean;
		function begFill(bmd:BitmapData):void;
		function begFillColor(value:uint):void;
		function clearFill():void;
	}

}