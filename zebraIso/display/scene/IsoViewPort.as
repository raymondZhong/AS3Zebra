package zebraIso.display.scene 
{ 
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class IsoViewPort extends Sprite
	{
		private var _bm:Bitmap;
		public function IsoViewPort(w:Number=300,h:Number=300) 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			_bm = new Bitmap(new BitmapData(1, 1, false, 0x400040));
			_bm.width = w;
			_bm.height = h;
			addChild(_bm);
			
		}
		
		public function setSize(w:Number, h:Number):void {
			 _bm.width = w;
			 _bm.height = h;
		}
		
		public function dispose():void {
			_bm.bitmapData.dispose();
			removeChild(_bm);
		}
		
		
	}

}