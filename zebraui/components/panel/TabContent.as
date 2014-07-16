package zebraui.components.panel
{
	import flash.display.DisplayObject;
	
	public class TabContent
	{
		private var _id:int = 0;
		private var _name:String = "";
		private var _title:String = "";
		private var _isClose:Boolean = false;
		private var _tabContent:DisplayObject = null;
		
		public function TabContent()
		{
		
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
			if (_name == "")
				_name = value
		}
		
		public function get tabContent():DisplayObject
		{
			return _tabContent;
		}
		
		public function set tabContent(value:DisplayObject):void
		{
			_tabContent = value;
		}
		
		public function get isClose():Boolean
		{
			return _isClose;
		}
		
		public function set isClose(value:Boolean):void
		{
			_isClose = value;
		}
	
	}

}