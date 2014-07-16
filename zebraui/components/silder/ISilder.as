package zebraui.components.silder
{
	
	public interface ISilder
	{
		function get minValue():int
		function set minValue(value:int):void
		function get maxValue():int
		function set maxValue(value:int):void
		function get currentValue():int
		function set currentValue(value:int):void
		function get progress():Number
		function set progress(value:Number):void
		function get liveDragging():Boolean		
		function set liveDragging(value:Boolean):void
	
	}

}