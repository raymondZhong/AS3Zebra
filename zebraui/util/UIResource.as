package zebraui.util
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	public class UIResource extends EventDispatcher
	{
		
		public function UIResource()
		{
		
		}
		
		private var _appliactionDomain:ApplicationDomain;
		private var _uiSettingData:XML;
		
		public function get uiSettingData():XML
		{
			return _uiSettingData;
		}
		
		public function getBitmapData(libClassName:String):BitmapData
		{	 
			var cls:Class = _appliactionDomain.getDefinition(libClassName) as Class;
		 
			return BitmapData(new cls());
		}
		
		
		public function getClass(libClassName:String):Class
		{
		//	var cls:Class = _appliactionDomain.getDefinition(libClassName) as Class;
			return _appliactionDomain.getDefinition(libClassName) as Class
		}
		
		
		public function getButtonBitmapData(theme:String,butonState:String):BitmapData
		{
			 return  getBitmapData("UIComponent."+theme+".Button."+butonState);
		}
		
		
		public function getMessageBitmapData(theme:String):BitmapData
		{
			 return  getBitmapData("UIComponent."+theme+".Message.Normal");
		}
		
		/**
		 * 返回每个元素的Rectangle数据
		 * @param	cmp
		 * @param	theme
		 * @return
		 */
	 	public function getElementRectangle(cmp:String,theme:String):Rectangle {
			  var  rectArray:Array = String(_uiSettingData.child(cmp).child(theme).@rectangle).split(",");
			  return  new Rectangle(rectArray[0], rectArray[1], rectArray[2], rectArray[3]);
			}
		 
	
		/**
		 * 初始化UIResource 管理
		 * @param	appliaction
		 * @param	uiSettingData
		 */
		public function initialize(appliaction:ApplicationDomain, uiSettingData:XML):void
		{
			_appliactionDomain = appliaction;
			_uiSettingData = uiSettingData;
		}
	}

}