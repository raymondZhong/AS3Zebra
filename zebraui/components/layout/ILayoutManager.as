package zebraui.components.layout
{
	import flash.display.DisplayObject;
	import zebraui.components.container.IContainer;
	import zebraui.components.UIComponent;
	
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
		
		function set container(value:IContainer):void;
		
		function get container():IContainer;
		
		function set autoHeight(value:Boolean):void;		
		function get autoHeight():Boolean;	
		function set autoWidth(value:Boolean):void;		
		function get autoWidth():Boolean;
		
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
		
		/**
		 * 自动伸缩
		 */
		//function get flex():Boolean;
		//function set flex(value:Boolean):void
		
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
		
		function get width():Number;
		function get height():Number;
		
		function setPreferWidth(value:Number):void;
		
		function setPreferHeight(value:Number):void;
	}
}