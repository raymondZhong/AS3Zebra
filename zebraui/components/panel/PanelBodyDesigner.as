package zebraui.components.panel 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import zebraui.components.container.Box;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class PanelBodyDesigner extends UIComponent
	{
		protected var body:Scale9GridBitmap;
		protected var box:Box;
		public function PanelBodyDesigner(preferWidth:Number = 300, preferHeight:Number = 24)
		{
			super(preferWidth, preferHeight);
		}
	
		override protected function initialize():void
		{
			super.initialize();
			var bm:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.Body");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Public","PanelBody");
			body = new Scale9GridBitmap(bm, rect);
			body.width = _preferWidth;
			body.height = _preferHeight;
			addChild(body);
			box = new Box(_preferWidth - 10, _preferHeight - 10);
			box.x = 5;
			box.y = 5;
			addChild(box);
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			body.width = _preferWidth;
			box.width = _preferWidth- 10;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			body.height = _preferHeight;
			box.height = _preferHeight - 10;
		}
		
		/**
		 * 允许内容拖动
		 */
		public function get scrollDrag():Boolean
		{
			return box.scrollDrag;
		}
		
		/**
		 * 允许内容拖动
		 */
		public function set scrollDrag(value:Boolean):void
		{
			box.scrollDrag = value;
		}
		
 
		
		public function append(target:DisplayObject):void
		{
			box.getLayout().append(target);
		}
		
		public function get elements():Vector.<DisplayObject>
		{
			return box.elements;
		}
		
		public function remove(target:DisplayObject):void
		{
			box.getLayout().remove(target);
		}
		
		public function clear():void
		{
			box.getLayout().clear();
		}
		
		
	}

}