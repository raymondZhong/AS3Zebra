package zebraIso.display.scene
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import zebraIso.data.IsoElementList;
	import zebraIso.display.primitive.IsoRectangles;
	
	public class IsoRectangleContianer extends Sprite
	{
		private var _IsoRectangleElementList:IsoElementList;
		
		public function IsoRectangleContianer()
		{
			_IsoRectangleElementList = new IsoElementList(this);
		}
		
		public function append(element:IsoRectangles):void
		{
			_IsoRectangleElementList.add(element);
		}
		
		public function remove(element:IsoRectangles):void
		{
			_IsoRectangleElementList.remove(element);
		}
		
		public function clear():void
		{
			_IsoRectangleElementList.clear();
		}
		
		public function sortElements():void
		{
			//_IsoRectangleElementList.sortElements();
		}
	}

}