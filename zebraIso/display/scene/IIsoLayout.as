package zebraIso.display.scene 
{
	import zebraIso.data.IsoBound;
	import zebraIso.display.IsoContainer;
	
	public interface IIsoLayout 
	{
		 function append(element:IsoContainer,bound:IsoBound=null):void		 
		
		 function remove(element:IsoContainer):void
		 
		 function  hasOverlapBound(bound:IsoBound):Boolean
		 function clear():void
		 function get isoChildren():Vector.<IsoContainer>;
		 function sortElements(element:IsoContainer):void
		  function get world():IsoWorldDisplayObject 
	}
	
}