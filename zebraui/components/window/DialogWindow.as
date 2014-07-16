package zebraui.components.window 
{
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import zebraui.components.container.Container;
	import zebraui.components.core.MaskSprite;
	import zebraui.components.layout.EmptyLayout;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.UIComponent;

	public class DialogWindow extends UIComponent
	{
	
		private var _shadow:Boolean;
		protected var  maskSprite:MaskSprite;
		protected var  _Isdialog:Boolean;		
		protected var _layout:ILayoutManager;	
		protected var _triggerResize:Boolean;
		protected var box:Container;
		
		public function DialogWindow(layout:ILayoutManager,preferWidth:Number=0, preferHeight:Number=0) 
		{
			_Isdialog = true;
			_triggerResize = true;
			maskSprite = new MaskSprite();
			addChild(maskSprite);
			box = new Container(preferWidth, preferHeight);
			box.setLayout(layout);
			addChild(box);
			super(preferWidth, preferHeight);
		}
		
		override protected function addToStageControl():void 
		{			
			maskSprite.visible = _Isdialog;
			stage.addChild(this);
			if(_triggerResize)
			stage.addEventListener(Event.RESIZE, stageResizeLogic);
			super.addToStageControl();
		}
		
		private function stageResizeLogic(e:Event):void 
		{
			box.width = stage.stageWidth;
			box.height = stage.stageHeight;
		}
		
		override protected function removeStageControl():void 
		{
			if(_triggerResize)
			stage.removeEventListener(Event.RESIZE, stageResizeLogic);
			super.removeStageControl();
		}
		
		
		public function get Isdialog():Boolean 
		{
			return _Isdialog;
		}
		
		public function set Isdialog(value:Boolean):void 
		{
			_Isdialog = value;
			maskSprite.visible = _Isdialog;
		}
		
		
		public function get shadow():Boolean
		{
			return _shadow;
		}
		
		public function set shadow(value:Boolean):void
		{
			_shadow = value;
			if (value)
			{
				box.filters = [new DropShadowFilter(6, 45, 0x000000, 0.3, 5, 5, 0.5, 1)];
			}
			else
			{
				box.filters = null;
			}
		}
		
	}

}