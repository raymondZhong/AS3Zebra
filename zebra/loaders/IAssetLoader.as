package zebra.loaders
{
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
 
	
	public interface IAssetLoader  
	{
		 /**
		  * 装载参数
		  */
		  function get param():Object;
		  function set param(value:Object):void;
		  
		  /**
		   * 装载Url请求
		   */
		  function get request():URLRequest 
		  
		  /**
		   * loader的实体对象
		   */
		  function get loader():ILoader;
		  function get type():String;
		  function get state():int 		  
	      function set state(value:int):void;		  
		  function get content():*;
		  
		  function get key():String;
		  function load(request:URLRequest):void;
		  function dispose():void;		  
	}
	
}