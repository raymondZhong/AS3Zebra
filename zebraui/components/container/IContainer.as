package zebraui.components.container 
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.UIComponent;
	public interface IContainer 
	{

				
		function set x(value:Number):void;
		function get x():Number;
		
		function set y(value:Number):void;
		function get y():Number;
		
		function set width(value:Number):void;
		function get width():Number;
		
		function set height(value:Number):void;
		function get height():Number;
		function get preferWidth():Number;
	    function get preferHeight():Number;
	 
		function get elements():Vector.<DisplayObject>;
		
		function get container():DisplayObjectContainer;	
		function setLayout(layout:ILayoutManager):void;
		function getLayout():ILayoutManager;
		
		function append(cmp:DisplayObject):void
		function remove(cmp:DisplayObject):void
		function clear():void;
 
		/**
		 * 更新内容源
		 */
	 	function sourceUpdate():void;
		
		function get IsRender():Boolean; 
		
	}	
}