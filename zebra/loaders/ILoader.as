package zebra.loaders 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	
	[Event(name="progress",type="zebra.events.AssetLoaderEvent")]
	[Event(name="error",type="zebra.events.AssetLoaderEvent")]
	[Event(name = "complete", type = "zebra.events.AssetLoaderEvent")]
	
	public interface ILoader extends IEventDispatcher
	{
		  function completeHandler(e:Event):void
		  function load(urlOrRequest:*, param:Object = null):void;
		  function dispose():void;
	}
	
}