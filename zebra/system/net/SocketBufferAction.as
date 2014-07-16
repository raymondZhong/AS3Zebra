package zebra.system.net
{
	import zebra.Game;
	import zebra.system.collections.FlashBytesReader;
	import zebra.thread.task.TaskAction;
	
	/**
	 * 定时发送Buffer数据
	 */
	internal class SocketBufferAction extends TaskAction
	{
		private var _bufferList:Vector.<FlashBytesReader>;
		
		public function SocketBufferAction(bufferList:Vector.<FlashBytesReader>)
		{
			_bufferList = bufferList;
		}
		
		override public function execute():void
		{
			if (_bufferList.length == 0) return;
			for (var i:int = 0; i < 2; i++)
			{
				if (_bufferList.length > 0)
				{
					var bytes:FlashBytesReader = _bufferList.shift();
					Game.DirectEvent.send(bytes.mainId + "-" + bytes.childId, new SocketThreadParam(bytes), GameSocketThread.channel);
				}
			}
		}
	
	}

}