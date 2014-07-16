package zebraui.components.panel
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import zebra.content.GameAsset;
	import zebraui.components.container.Box;
	import zebraui.components.InteractiveUIComponent;
	import flash.display.Bitmap;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class DisplayPanel extends InteractiveUIComponent
	{
	 
		private var box:Box;
		private var _prevurl:String;
		private var _contentLoader:Loader;
		protected var background9Sprite:Scale9GridBitmap;
		private var topMask:Bitmap;
		
		public function DisplayPanel(preferWidth:Number = 150, preferHeight:Number = 150)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			
			var bd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Image.Normal");
			var rect:Rectangle = UIFramework.resource.getElementRectangle("Public", "Image");
			background9Sprite = new Scale9GridBitmap(bd, rect);
			background9Sprite.width = _preferWidth;
			background9Sprite.height = _preferHeight;
			addChild(background9Sprite)
			box = new Box(_preferWidth - 10, _preferHeight - 10);
			box.x = 5;
			box.y = 5;
			addChild(box);
			topMask = new Bitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Image.TopMask"));
			topMask.x = 2;
			topMask.y = 2;
			topMask.width = _preferWidth - 4;
			topMask.height = _preferHeight - 4;
			topMask.visible = false;
			addChild(topMask);
			super.initialize();
		}
		
		public function append(target:DisplayObject):void
		{
			box.append(target);
		}
		
		public function remove(target:DisplayObject):void {
			box.remove(target);
		}
		public function clear():void {
			box.clear();
		}
				
		public function hasDisplay():Boolean
		{
			return box.elements.length > 0;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			background9Sprite.width = _preferWidth;
			box.width = value - 10;
			topMask.width = _preferWidth - 4;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			background9Sprite.height = _preferHeight;
			box.height = _preferHeight - 10;
			topMask.height = _preferHeight - 4;
		}
		
		public function get scrollDrag():Boolean 
		{
			return box.scrollDrag;
		}
		
		public function set scrollDrag(value:Boolean):void 
		{
			box.scrollDrag = value;
		}
		
		
	
	}

}