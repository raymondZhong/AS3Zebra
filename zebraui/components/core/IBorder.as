package zebraui.components.core
{
	
	public interface IBorder
	{
		function get topColor():uint
		
		function set topColor(value:uint):void
		
		function get bottomColor():uint
		
		function set bottomColor(value:uint):void
		
		function get leftColor():uint
		
		function set leftColor(value:uint):void
		
		function get rightColor():uint
		
		function set rightColor(value:uint):void
		
		function get topVisible():Boolean
		
		function set topVisible(value:Boolean):void
		
		function get bottomVisible():Boolean
		
		function set bottomVisible(value:Boolean):void
		
		function get leftVisible():Boolean
		
		function set leftVisible(value:Boolean):void
		
		function get rightVisible():Boolean
		
		function set rightVisible(value:Boolean):void
		function set color(value:uint):void
		function get thickness():Number
		function set thickness(value:Number):void
	}

}