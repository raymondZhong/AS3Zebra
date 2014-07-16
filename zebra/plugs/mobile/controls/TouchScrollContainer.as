package zebra.plugs.mobile.controls
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.ILayout;
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
	
	public class TouchScrollContainer extends ScrollContainer
	{
		private var _isTouchScroll:Boolean;
 
		public function TouchScrollContainer()
		{
				super();
				this.addEventListener("scrollStart",scrollStartHandler)
				this.addEventListener("scrollComplete",scrollCompleteHandler)
				this.addEventListener(Event.REMOVED_FROM_STAGE,removeStageHandler)
		}
		
		private function removeStageHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
			removeEventListener("scrollStart", scrollStartHandler);
			removeEventListener("scrollComplete", scrollCompleteHandler);
		}
		
		private function scrollStartHandler(e:Event):void 
		{
			 _isTouchScroll = true;
		}
		
		private function scrollCompleteHandler(e:Event):void 
		{
			 _isTouchScroll = false;
		}	  
		
		public function get isTouchScroll():Boolean 
		{
			return _isTouchScroll;
		}
		
	}

}