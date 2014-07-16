package zebra.thread.task 
{
	public interface ITaskAction 
	{
		
		function get IsStart():Boolean;
		function get IsFinish():Boolean;
		function set id(value:String):void;
		function get id():String;		
		function execute():void;
		function finish():void;
		function dispose():void;
		function stop():void;
		
	}
	
}