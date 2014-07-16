package zebraIso.display.scene 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import zebraIso.data.IsoBound;
	import zebraIso.data.IsoElementList;
	import zebraIso.display.IsoContainer;

	
	public class IsoLayout extends Sprite implements IIsoLayout
	{
		
		private var _elementList:IsoElementList;
		internal var _world:IsoWorldDisplayObject; 
		public function IsoLayout()
		{
			_elementList = new IsoElementList(this);
		}
		
		public function append(element:IsoContainer,bound:IsoBound=null):void
		{
		    element.layout = this;
			_elementList.add(element,bound);
		}
		
		public function remove(element:IsoContainer):void
		{
			_elementList.remove(element);
		}
		public  function get isoChildren():Vector.<IsoContainer>
		{
			return _elementList.isoChildren;
		}
		
		public function get world():IsoWorldDisplayObject 
		{
			return _world;
		}
		
		 
		
		public function clear():void
		{
			_elementList.clear();
		}
		
		public function  hasOverlapBound(bound:IsoBound):Boolean {
			return _elementList.hasOverlapBound(bound);
		}
		
		public function sortElements(element:IsoContainer):void
		{
			 _elementList.sortElements(element);
		}
	}

}