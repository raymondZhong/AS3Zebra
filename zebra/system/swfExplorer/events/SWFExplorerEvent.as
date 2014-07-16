package zebra.system.swfExplorer.events
{
	
	import flash.events.Event;

	public final class SWFExplorerEvent extends Event
	{
		
		public static const COMPLETE:String = "parseComplete";
		
		public var definitions:Array;
		
		public function SWFExplorerEvent(type:String, classes:Array)
		{
			
			super(type, false, false);
			
			definitions = classes;
			
		}
		
		public override function clone ():Event
		{
			
			return new SWFExplorerEvent ( SWFExplorerEvent.COMPLETE, definitions );
			
		}
		
		public override function toString():String
		{
			
			return '[LoaderExplorerEvent type=parseComplete, definitions='+definitions+']';
			
		}
		
	}
}