package zebra.plugs.mobile.controls
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class VScrollContainer extends Sprite
	{
		public var scrollContainer:ScrollContainer;
		private var _isScroll:Boolean;
		private var _element:DisplayObject;
 
		
		public function VScrollContainer(element:DisplayObject,width:Number=0,height:Number=0,layout:*=null)
		{
				var vl:VerticalLayout =  new VerticalLayout();
				
				scrollContainer = new ScrollContainer();
				scrollContainer.layout = vl;			 
				scrollContainer.width = width;
				scrollContainer.height = height;
				scrollContainer.addEventListener("scrollStart",scrollStartHandler)
				scrollContainer.addEventListener("scrollComplete",scrollCompleteHandler)
				this.addChild( scrollContainer ); 
				this.addEventListener(Event.REMOVED_FROM_STAGE,removeStageHandler)
				_element = element;
				scrollContainer.addChild(_element);
		}
		
		private function removeStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
			scrollContainer.removeEventListener("scrollStart", scrollStartHandler);
			scrollContainer.removeEventListener("scrollComplete", scrollCompleteHandler);
		}
		
		private function scrollStartHandler(e:Event):void 
		{
			 _isScroll = true;
		}
		
		private function scrollCompleteHandler(e:Event):void 
		{
			 _isScroll = false;
		}	  
		
		public function updateElement(element:DisplayObject):void
		{
			scrollContainer.removeChild(_element);
			if(element) _element = element
			scrollContainer.addChild(_element);
		}
		
		public function get isScroll():Boolean 
		{
			return _isScroll;
		}
	}

}