package zebra.plugs.mobile.layout
{
	import feathers.controls.ScrollContainer;
	import starling.display.DisplayObject;
 
	public interface ILayoutManager
	{
		
		
		
		
		/**
		 * 追加组件
		 * @param	cmp
		 */
		function append(cmp:DisplayObject):void;
		
		/**
		 * 移除组件
		 * @param	cmp
		 */
		function remove(cmp:DisplayObject):void;
		  
		function clear():void;
		
		function get elements():Vector.<DisplayObject>;
		
		function set container(value:ScrollContainer):void;
		
		function get container():ScrollContainer;
	 
		
		/**
		 * X轴偏移
		 */
		
		function get offX():Number;
		function set offX(value:Number):void;
		/**
		 * Y轴偏移
		 */
		
		function get offY():Number;
		function set offY(value:Number):void;
		/**
		 * 内框间隔
		 */
		function get margin():LayoutMargin;
		function set margin(value:LayoutMargin):void;
		
		
		function get hAlign():String;
		function set hAlign(value:String):void
		
		function get vAlign():String;
		function set vAlign(value:String):void
		
		function get hgap():int;
		function set hgap(value:int):void
		
		function get vgap():int;
		function set vgap(value:int):void
		
		/**
		 * 更新布局对齐
		 * @param	valign
		 * @param	halign
		 */
		function updateAlign(valign:String = null, halign:String = null):void
		
		//function get width():Number;
		//function get height():Number;
		//
		//function setPreferWidth(value:Number):void;
		//
		//function setPreferHeight(value:Number):void;
	}
}