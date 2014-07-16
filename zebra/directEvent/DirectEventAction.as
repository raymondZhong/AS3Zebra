package zebra.directEvent 
{
	import zebra.thread.task.TaskAction;
	 
	/**
	 * 消息对应执行的TaskAction Class
	 */
	public class DirectEventAction extends TaskAction
	{
		public var eventParameter:DirectEventParameter;
		public function DirectEventAction(){}
		
	}

}