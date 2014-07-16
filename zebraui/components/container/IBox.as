package zebraui.components.container 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public interface IBox extends  IContainer
	{
		/**
		 *  拖动操作
		 */
		function get scrollDrag():Boolean;
        function set scrollDrag(value:Boolean):void;		
		
		/**
		 * 内容源
		 */
/*		function get source():DisplayObject;
        function set source(value:DisplayObject):void*/
		
		function get processWidth():Number
        function set processWidth(value:Number):void
		
		function get processHeight():Number
        function set processHeight(value:Number):void
		
       //function full():void;
		
		
		
 
	}
	
}