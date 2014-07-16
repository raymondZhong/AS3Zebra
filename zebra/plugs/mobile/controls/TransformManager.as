package zebra.plugs.mobile.controls
{
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import zebra.plugs.mobile.MobileConstants;
	
	public class TransformManager extends Sprite
	{
		
		private var _list:Vector.<TransformContainer>
		
		public function TransformManager()
		{
			_list = new Vector.<TransformContainer>();
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		//空白处点击取消元素的工具状态
		private function touchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(Starling.current.stage);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				if (_currentActiveElement == null)
				{
					for (var i:int = 0; i < _list.length; i++)
					{
						TransformContainer(_list[i]).hideTool();
					}
				}
				
			}
		}
		
		private var _currentActiveElement:TransformContainer;
		
		//激活一个元素
		public function setActive(element:TransformContainer):void
		{
			for (var i:int = 0; i < _list.length; i++)
			{
				TransformContainer(_list[i]).hideTool();
			}
			_currentActiveElement = element;
			element.showTool();
			topDepth(element)
			setTimeout(function():void
				{
					_currentActiveElement = null;
				}, 100);
		}
		
		//最上层
		public function topDepth(element:TransformContainer):void
		{
			setChildIndex(element, this.numChildren - 1);
		}
		
		public function addElement(element:TransformContainer):void
		{
			_list.push(element);
			addChild(element);
			setActive(element);
		}
		
		public function removeElement(element:TransformContainer):void
		{
			var index:int = _list.indexOf(element)
			if (index != -1)
			{
				_list.splice(index, 1);
			}
			removeChild(element);
		}
	
	}

}