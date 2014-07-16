package zebra.system.swfExplorer.events
{
	
	import flash.events.Event;

	public final class SWFExplorerErrorEvent extends Event
	{
		
		public static const NO_DEFINITIONS:String = "noDefinitions";
		
		public function SWFExplorerErrorEvent(type:String)
		{
			
			super(type, false, false);
			
		}
		
		public override function clone ():Event
		{
			
			return new SWFExplorerErrorEvent ( SWFExplorerErrorEvent.NO_DEFINITIONS );
			
		}
		
		public override function toString():String
		{
			
			return '[LoaderExplorerEvent type=noDefinitions]';
			
		}
		
	}
}