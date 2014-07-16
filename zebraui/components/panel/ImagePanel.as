package zebraui.components.panel
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import zebra.content.GameAsset;
	import zebraui.components.container.Box;
	import zebraui.components.InteractiveUIComponent;
	import flash.display.Bitmap;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class ImagePanel extends InteractiveUIComponent
	{
		private var bm:Bitmap;
		private var box:Box;
		private var _prevurl:String;
		private var _contentLoader:Loader;
		protected var background9Sprite:Scale9GridBitmap;
		protected var topMask:Bitmap;
		private var _autoSize:Boolean;
		public var imageScale:Number;
		public var imagePoint:Point;
		public var loadImageFinish:Function = null;
		
		public function ImagePanel(preferWidth:Number = 150, preferHeight:Number = 150)
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
			bm = new Bitmap();
			addChild(bm);
			box = new Box(_preferWidth - 10, _preferHeight - 10);
			box.x = 5;
			box.y = 5;
			addChild(box);
			topMask = new Bitmap(UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Image.TopMask"));
			topMask.x = 2;
			topMask.y = 2;
			topMask.width = _preferWidth - 4;
			topMask.height = _preferHeight - 4;
			addChild(topMask);
			super.initialize();
		}
		
		public function setUrl(url:String, autoSize:Boolean = false):void
		{
			_autoSize = autoSize;
			bm.bitmapData = null;
			bm.scaleX = 1;
			bm.scaleY = 1;
			bm.x = 0;
			bm.y = 0;
			box.clear();
			if (_contentLoader != null)
				_contentLoader.unloadAndStop();
			_contentLoader = new Loader();
			_contentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, getImageLogic);
			_contentLoader.load(new URLRequest(url));
			imagePoint = null;
		}
		
		public function setBitMapData(bitmapdata:BitmapData, autoSize:Boolean = false):void
		{
			_autoSize = autoSize;
			bm.bitmapData = null;
			bm.scaleX = 1;
			bm.scaleY = 1;
			bm.x = 0;
			bm.y = 0;
			box.clear();
			drawImage(bitmapdata);
		
		}
		
		public function getBitMapData():BitmapData
		{
			return bm.bitmapData;
		}
		
		private function getImageLogic(e:Event):void
		{
			drawImage(Bitmap(LoaderInfo(e.target).content).bitmapData);
		}
		
		private function drawImage(_bitmapdata:BitmapData):void
		{
			imagePoint = null;
			imageScale = 1;
			var ScalingW:Number = box.width / _bitmapdata.width;
			var ScalingH:Number = box.height / _bitmapdata.height;
			var Scaling:Number = Math.min(ScalingW, ScalingH);
			
			var bmWidth:Number = Scaling * _bitmapdata.width;
			var bmHeight:Number = Scaling * _bitmapdata.height;
			
			bm.bitmapData = _bitmapdata;
			if (_autoSize)
			{
				if (Scaling < 1)
				{
					bm.width = bmWidth;
					bm.height = bmHeight;
					imageScale = Scaling;
				}
				bm.x = (box.width - bm.width) / 2;
				bm.y = (box.height - bm.height) / 2;
			}
			box.append(bm);
			imagePoint = new Point(bm.x + 5, bm.y + 5);
			if (loadImageFinish != null)
			{
				loadImageFinish(this);
			}
		
		}
		
		public function hasImage():Boolean
		{
			return bm.bitmapData != null;
		}
		
		public function clear():void
		{
			if (bm.bitmapData)
			{
				bm.bitmapData.dispose();
			}
			box.clear();
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
	
	}

}