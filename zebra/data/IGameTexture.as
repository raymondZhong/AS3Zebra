package zebra.data
{
	import flash.display.BitmapData;
	
	public interface IGameTexture
	{
		function containActionName(name:String):Boolean;
		
		/**
		 * 返回所有的动作名
		 */
		function get actionNames():Vector.<String>;
		
		/**
		 * 图片路径
		 * @return
		 */
		function get imagepath():String;
		
		/**
		 * 位图数据
		 */
		function get bitmapData():BitmapData;
		
		/**
		 * 位图数据映射
		 */
		function get maps():XML;
		
		function getNodeByActionName(actionName:String):XML;
		
		/**
		 * 根据名字获得位图组
		 * @param	actionName
		 * @return
		 */
		function getBitmapsByActionName(actionName:String):Vector.<BitmapData>;
	
	}

}