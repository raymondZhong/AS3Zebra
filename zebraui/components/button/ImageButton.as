package zebraui.components.button 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent; 

	public class ImageButton extends AbstractButton 
	{
		
		protected var _normal_bitmapdata:BitmapData;
		protected var _down_bitmapdata:BitmapData;
		protected var _hover_bitmapdata:BitmapData;
		protected var _bitmap:Bitmap;
		
		override public function get state():String 
		{
			return super.state;
		}
		
		override public function set state(value:String):void 
		{
			_state = value;
			switch(value) {
				   case ButtonState.NORMAL:
                     _bitmap.bitmapData = _normal_bitmapdata;
				   break;
				   case ButtonState.HOVER:
				     _bitmap.bitmapData = _hover_bitmapdata;
				   break;
				   case ButtonState.DOWN:
				     _bitmap.bitmapData = _down_bitmapdata;
				   break;			 
				 }
		}
		

		public function ImageButton(normal:*, hover:*=null, down:*=null ) 
		{
			if (normal is Bitmap) normal = Bitmap(normal).bitmapData;
			if (hover is Bitmap) hover = Bitmap(hover).bitmapData;
			if (down is Bitmap) down = Bitmap(down).bitmapData;
			_normal_bitmapdata = normal;
			if (hover == null){ _hover_bitmapdata = _normal_bitmapdata;}else{_hover_bitmapdata = hover;}
			if (down == null) { _down_bitmapdata = _hover_bitmapdata; } else { _down_bitmapdata = down; }	
			super();
		}
		
		
		override protected function initialize():void 
		{
			super.initialize();
			_bitmap = new Bitmap(this._normal_bitmapdata);
			addChild(_bitmap);
		}
		 
		override public function get width():Number 
		{
			return _bitmap.width;
		}
		

		override public function get height():Number 
		{
			return _bitmap.height;
		}
		

		
		
		override protected function onStateMouseDown(e:MouseEvent):void 
		{
			super.onStateMouseDown(e);
			if (isActive){
			   _bitmap.bitmapData = _down_bitmapdata;
			}
		}
		
		override protected function onStateRollOver(e:MouseEvent):void 
		{
			super.onStateRollOver(e);
			if (isActive){
			   _bitmap.bitmapData = _hover_bitmapdata;
			}
		}
		
		override protected function onStateRollOut(e:MouseEvent):void 
		{
			super.onStateRollOut(e);
			if (isActive){
			  _bitmap.bitmapData = _normal_bitmapdata;
			}
		}
		
		
	}

}