package zebra.input
{
	import flash.geom.Point;
	import zebra.Game;
	import zebra.thread.task.TaskAction;
	
	internal class MouseInputTaskAction extends TaskAction
	{
		
		public function MouseInputTaskAction()
		{
		
		}
		
		public var mousePoint:Point;
		
		override public function execute():void
		{
			super.execute();
			mousePoint = new Point(Game.graphicsDeviceManager.stage.mouseX, Game.graphicsDeviceManager.stage.mouseY);
			this.finish();
		}
	}
}