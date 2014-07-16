package zebraui.components.button 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent; 

	public class DisplayButton extends AbstractButton 
	{
		
		protected var _normal_display:DisplayObject;
		protected var _down_display:DisplayObject;
		protected var _hover_display:DisplayObject;
		protected var _container:Sprite;
		
		override public function get state():String 
		{
			return super.state;
		}
		
		override public function set state(value:String):void 
		{
			_state = value;
			removeContainerAllChild();
			switch(value) {
				   case ButtonState.NORMAL:
                    _container.addChild( _normal_display);
				   break;
				   case ButtonState.HOVER:
				      _container.addChild( _hover_display);
				   break;
				   case ButtonState.DOWN:
				    _container.addChild(  _down_display);
				   break;			 
				 }
		}
		
		
		override public function get height():Number 
		{
			return _container.height;
		}
		
		override public function get width():Number 
		{
			return _container.width;
		}
		
	 
	 

		public function DisplayButton(normal:DisplayObject, hover:DisplayObject=null, down:DisplayObject=null ) 
		{
			_normal_display = normal;
			if (hover == null){ _hover_display = _normal_display;}else{_hover_display = hover;}
			if (down == null) { _down_display = _hover_display; } else { _down_display = down; }	
			super();
		}
		
		
		override protected function initialize():void 
		{
			super.initialize();
			_container = new Sprite();
			_container.addChild(_normal_display);
			addChild(_container);
		}
		 
		 
		override protected function onStateMouseDown(e:MouseEvent):void 
		{
			super.onStateMouseDown(e);
			if (isActive) {
				removeContainerAllChild();
			  // _container.addChild( _down_display);
			}
		}
		
		override protected function onStateRollOver(e:MouseEvent):void 
		{
			super.onStateRollOver(e);
			if (isActive){
				removeContainerAllChild();
			    _container.addChild( _hover_display);
			}
		}
		
		override protected function onStateRollOut(e:MouseEvent):void 
		{
			super.onStateRollOut(e);
			if (isActive) {				
				removeContainerAllChild();
			  _container.addChild( _normal_display);
			}
		}
		
		/**
		 * 移除所有子元素 FlashPlayer 9-11 
		 */
		private function removeContainerAllChild():void {
			var i:int=0
			for ( i = _container.numChildren - 1; i >= 0; i--)
			{
				_container.removeChildAt(i);
			}
		} 
		
		public function get currentDisplay():DisplayObject{return _container.getChildAt(0)}
		
	}

}