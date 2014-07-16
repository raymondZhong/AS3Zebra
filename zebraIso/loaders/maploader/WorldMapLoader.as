package zebraIso.loaders.maploader
{
	import flash.events.EventDispatcher;
	import zebra.events.TaskActionEvent;
	import zebra.events.TaskEvent;
	import zebraIso.display.IsoContainer;
	import zebraIso.display.scene.IsoWorld;
	import zebra.thread.task.Task;
	import zebraIso.event.WorldMapLoaderEvent;
	
	[Event(name="elementChildComplete",type="zebraIso.event.WorldMapLoaderEvent")]
	[Event(name="complete",type="zebraIso.event.WorldMapLoaderEvent")]
	
	public class WorldMapLoader extends EventDispatcher
	{
		private var _world:IsoWorld;
		private var _worldLoadTask:Task;
		
		public function WorldMapLoader()
		{
			_worldLoadTask = new Task();
			_worldLoadTask.addEventListener(TaskEvent.COMPLETE, taskCompleteLogic);
		}
 
		
		private function taskCompleteLogic(e:TaskEvent):void 
		{
			_worldLoadTask.removeEventListener(TaskEvent.COMPLETE, taskCompleteLogic);
			dispatchEvent(new WorldMapLoaderEvent(WorldMapLoaderEvent.COMPLETE));
		}
		
		public function load(world:IsoWorld):void
		{
			_world = world;
			for (var i:int = 0; i < _world.map.elements.length; i++)
			{
				var itemloader:MapLoaderAction = new MapLoaderAction(_world.currentLayout, _world.map.elements[i]);
					itemloader.addEventListener(TaskActionEvent.COMPLETE,completeHandlerLogic)
				_worldLoadTask.addAction(itemloader);
			}
			_worldLoadTask.start();
		}
		
		private function completeHandlerLogic(e:TaskActionEvent):void 
		{
			var action:MapLoaderAction = MapLoaderAction(e.target);
				action.removeEventListener(TaskActionEvent.COMPLETE, completeHandlerLogic);
			var event:WorldMapLoaderEvent = new WorldMapLoaderEvent(WorldMapLoaderEvent.ELEMENTCHILDCOMPLETE);
				event.container = action.container;
				event.element = action.element;
				dispatchEvent(event);
		}
	
	}

}