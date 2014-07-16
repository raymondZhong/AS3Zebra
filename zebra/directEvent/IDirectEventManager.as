package zebra.directEvent 
{

	public interface IDirectEventManager 
	{
		/**
		 * 接收
		 * @param	eventName
		 * @param	action
		 */
		function receive(eventName:String, action:*,scope:String="Global"):void;
		
		/**
		 * 发送
		 * @param	eventName
		 * @param	eventData
		 */
		function send(eventName:String, eventData:DirectEventParameter=null,scope:String="Global"):void;
		
		/**
		 * 销毁
		 * @param	eventName
		 * @param	action
		 */
		function destroy(eventName:String, action:*, scope:String = "Global"):void;
		
		
	}
	
}