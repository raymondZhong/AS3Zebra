package zebraui.components.panel
{
	import com.google.zxing.common.BitArray;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import zebraMobileUI.util.Scale9GridBitmap;
	import zebraui.components.container.Box;
	import zebraui.components.layout.HBoxLayout;
	import zebraui.components.layout.LayoutAlign;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	public class TabPanel extends UIComponent
	{
		private var _bodyWidth:Number;
		private var _bodyHeight:Number;
		private var bd:BitmapData;
		private var rect:Rectangle;
		private var header9Sprite:Scale9GridBitmap;
		private var _scrollPanel:ScrollPanel;
		private var _tabContent:TabContent;
		private var _tabArr:Vector.<TabContent>;
		private var _menuArr:Vector.<TabHeader>
		private var _currentTab:int = -1;
		private var _currentContent:DisplayObject;
		private var _menuSp:Sprite;
		
		public function TabPanel(preferWidth:Number = 300, preferHeight:Number = 200)
		{
			super(preferWidth, preferHeight);
			_bodyWidth = _preferWidth;
			_bodyHeight = _preferHeight - 23;
			bd = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Panel.Body");
			rect = UIFramework.resource.getElementRectangle("Public", "PanelBody");
			_scrollPanel = new ScrollPanel(_bodyWidth, _bodyHeight);
			_scrollPanel.y = 23;
			header9Sprite = new Scale9GridBitmap(bd, rect);
			header9Sprite.y = _scrollPanel.y
			header9Sprite.width = _bodyWidth;
			header9Sprite.height = _bodyHeight;
			addChild(header9Sprite);
			addChild(_scrollPanel);
			_menuSp = new Sprite();
			addChild(_menuSp);
			_tabArr = new Vector.<TabContent>;
			_menuArr = new Vector.<TabHeader>;
		
		}
		
		public function addTab(_obj:*):void
		{
			var _tabCon:TabContent;
			switch (typeof(_obj))
			{
				case "string": 
					_tabCon = new TabContent();
					_tabCon.title = String(_obj);
					break;
				case "object": 
					_tabCon = _obj as TabContent;
					break;
			}
			addTabArr(_tabCon);
			UpDateContent();
		}
		
		public function addTabAt(_id:int, _title:String):void
		{
			var _tabCon:TabContent = new TabContent();
			_tabCon.title = _title;
			addTabArr(_tabCon, _id);
			UpDateContent();
		}
		
		public function GetTapAt(_key:*):TabContent
		{
			var _tabCon:TabContent;
			switch (typeof(_key))
			{
				case "string": 
					for (var i:int = 0; i < _tabArr.length; i++)
					{
						var _tabCont:TabContent = _tabArr[i];
						if (_tabCont.name == String(_key))
							_tabCon = _tabCont;
					}
					break;
				case "number": 
					var _seat:int = Math.min(_key, _tabArr.length - 1);
					_tabCon = _tabArr[_seat];
					break;
			}
			return _tabCon;
		}
		
		public function removeTab(_key:*):void
		{
			if (_tabArr.length > 1)
			{
				switch (typeof(_key))
				{
					case "string": 
						for (var i:int = 0; i < _tabArr.length; i++)
						{
							var _tabCont:TabContent = _tabArr[i];
							if (_tabCont.name == String(_key))
							{
								_tabArr.splice(i, 1);
								break;
							}
						}
						break;
					case "number": 
						var _seat:int = Math.min(_key, _tabArr.length-1);
						_tabArr.splice(_seat, 1);
						break;
				}
				UpDateContent();
			}
		}
		
		public function Open(_obj:*):void
		{
			switch (typeof(_obj))
			{
				case "string": 
					for (var i:int = 0; i < _tabArr.length; i++)
					{
						var _tabCont:TabContent = _tabArr[i];
						if (_tabCont.name == String(_obj))
						{
							_currentTab = i;
							UpDateContent();
						}
					}
					break;
				case "number": 
					_currentTab = _obj;
					UpDateContent();
					break;
			}
		}
		
		private function UpDateContent():void
		{
			removeMenuAllChild();
			for (var i:int = 0; i < _tabArr.length; i++)
			{
				var _tabcon:TabContent = _tabArr[i];
				var panelHeader:TabHeader = new TabHeader(40);
				panelHeader.text = _tabcon.title;
				panelHeader.id = i;
				panelHeader.isClose = _tabcon.isClose;
				panelHeader.mouseDownHands = HesderDownHands;
				panelHeader.delBtnHands = DeleteBtnHands;
				panelHeader.x = _menuSp.width;
				panelHeader.y = 0;
				_menuSp.addChild(panelHeader);
				_menuArr.push(panelHeader);
			}
			if (_currentTab == -1)
			{
				_currentTab = 0;
			}
			for (var m:int = _currentTab; m >= 0; m--)
			{
				if (m < _menuArr.length && _menuArr[m])
				{
					_currentTab = m;
					_menuArr[_currentTab].state = "Down";
					return;
				}
			}
			
			;
		
		}
		
		private function DeleteBtnHands(e:TabHeader):void
		{
			removeTab(e.text);
		}
		
		private function HesderDownHands(e:TabHeader):void
		{
			var _tabCon:TabContent = GetTapAt(e.text);
			_scrollPanel.clear();
			_scrollPanel.clear();
			if (_currentTab != -1 && _currentTab != e.id && _menuArr[_currentTab])
			{
				_menuArr[_currentTab].state = "Normal";
				
			}
			if (_tabCon.tabContent)
			{
				_scrollPanel.append(_tabCon.tabContent);
			}
			_currentTab = e.id;
		}
		
		private function removeMenuAllChild():void
		{
			while (_menuSp.numChildren > 0)
			{
				_menuSp.removeChildAt(0);
			}
			_menuArr = new Vector.<TabHeader>;
			_scrollPanel.clear();
			_scrollPanel.clear();
			//_menuSp.clear();
		}
		
		private function addTabArr(_tabcon:TabContent, _id:int = -1):void
		{
			if (!_tabcon)
				return;
			var _seat:int;
			for (var i:int = 0; i < _tabArr.length; i++)
			{
				var _tabCont:TabContent = _tabArr[i];
				if (_tabCont.name == _tabcon.name)
				{
					if (_id == -1)
					{
						_tabArr[i] = _tabcon;
					}
					else
					{
						_tabArr.splice(i, 1);
						if (i < _id)
						{
							_id--
						}
						_seat = Math.min(_id, _tabArr.length);
						_tabArr.splice(_seat, 0, _tabcon);
					}
					return;
				}
				
			}
			if (_id == -1)
			{
				_tabArr.push(_tabcon);
			}
			else
			{
				_seat = Math.min(_id, _tabArr.length);
				_tabArr.splice(_seat, 0, _tabcon);
			}
		
		}
	
	}

}