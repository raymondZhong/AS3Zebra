package zebraui.event 
{
	import flash.events.Event;
	import zebraui.data.UIModel;
	
	public class ListBoxEvent extends Event 
	{
		
		public var selectIndex:int=-1;
		public var selectData:UIModel;
		static public const  CellRender_Select:String = "CellRender_Select";
		
		public function ListBoxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ListBoxEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ListBoxEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}