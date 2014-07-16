package zebraui.components.panel 
{
	import flash.events.MouseEvent;
	import zebraui.components.container.Container;
	import zebraui.components.layout.VBoxLayout;
	import zebraui.components.UIComponent;
	public class PanelDesigner extends UIComponent
	{
		public var header:PanelHeaderDesigner;
		public var body:PanelBodyDesigner;
		protected var container:Container;
		private var _IsDrag:Boolean;
		private var _dragEnable:Boolean;
		
		public function PanelDesigner(preferWidth:Number = 300, preferHeight:Number = 400)
		{
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void 
		{
			header = new PanelHeaderDesigner(_preferWidth);
			body = new PanelBodyDesigner(_preferWidth, _preferHeight - header.height)
			container = new Container(_preferWidth, _preferHeight);
			container.setLayout(new VBoxLayout());
			addChild(container);
			container.append(header);
			container.append(body);
			super.initialize();
		}
		
		override protected function addToStageControl():void 
		{
			header.addEventListener(MouseEvent.MOUSE_DOWN, activeStartDrag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, startDraging);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopStartDrag);
			super.addToStageControl();
		}
		
		override protected function removeStageControl():void 
		{
			header.removeEventListener(MouseEvent.MOUSE_DOWN, activeStartDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, startDraging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopStartDrag);
			super.removeStageControl();
		}
		
		
		private function startDraging(e:MouseEvent):void 
		{
			if (_IsDrag) {
				   startDrag();				
				}
		}
		
		private function stopStartDrag(e:MouseEvent):void 
		{
			if (_IsDrag) {
				_IsDrag = false;
				stopDrag();
				}
		}
		
		private function activeStartDrag(e:MouseEvent):void 
		{
			if(_dragEnable){
			_IsDrag = true;
			}
		}
		
		
		override public function set width(value:Number):void 
		{
			super.width = value;			
			header.width = _preferWidth;
			body.width = _preferWidth;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
			body.height =_preferHeight -header.height;
		}
		
		public function get dragEnable():Boolean 
		{
			return _dragEnable;
		}
		/**
		 * 允许拖动
		 */
		public function set dragEnable(value:Boolean):void 
		{
			_dragEnable = value;
		}
		
	}

}