package zebraui.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import zebraui.components.core.Background;
	import zebraui.components.core.Border;
	import zebraui.components.core.IBackground;
	import zebraui.components.core.IBorder;
	import zebraui.effect.Effect;
 
	
	/**
	 * UIComponent 最原始的类
	 */
	public class UIComponent extends Sprite 
	{
		
		private var _disposed:Boolean;
		private var _borderEntity:Border;
		private var _disabled:Boolean;
		private var _enabled:Boolean;
		protected var _theme:String = "DefaultTheme";
		protected var _backgroundEntity:Background;
		private var _IsRemoved:Boolean;
		protected var _IsRender:Boolean;
		
		protected var _preferWidth:Number;
		protected var _preferHeight:Number;
		
		public var addStageHandler:Function;
		public var removeStageHandler:Function;
		
		/**
		 * 构造函数中初始化数据
		 */
		public function UIComponent(preferWidth:Number = 1, preferHeight:Number = 1)
		{
			_preferWidth =  preferWidth < 1 ? 1 : preferWidth;;
			_preferHeight = preferHeight < 1 ? 1 : preferHeight;;
			_enabled = true;			
			_backgroundEntity = new Background();
			_backgroundEntity.width = _preferWidth;
			_backgroundEntity.height = preferHeight;
			_borderEntity = new Border();
			_borderEntity.width = _preferWidth;
			_borderEntity.height = preferHeight;
			_borderEntity.thickness = 0;
			addChild(_backgroundEntity);
			addChild(_borderEntity);
			initialize();
			eventListener();
			this.addEventListener(Event.REMOVED_FROM_STAGE, _removeStageLogic);
			this.addEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);		
		}
		
		/* ====================================================================================
		 * Override
		 * ====================================================================================
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var displayobject:DisplayObject = super.addChild(child);
			if ((child is Border) || (child is Background))
			{
			}
			else
			{
				if (_backgroundEntity && _backgroundEntity.parent)
					setChildIndex(_backgroundEntity, 0);
				if (_borderEntity && _borderEntity.parent)
					setChildIndex(_borderEntity, this.numChildren - 1);
			}
			return displayobject;
		}
		
		/* ====================================================================================
		 * Properties
		 * ====================================================================================
		 */
		
		/**
		 * 可以交互状态，激活状态
		 */
		protected function get isActive():Boolean
		{
			return enabled && !disabled
		}
		
		public function get theme():String
		{
			if (_theme == null)
				_theme = "DefaultTheme"
			return _theme;
		}
		
		public function set theme(value:String):void
		{
			_theme = value;
			//updateRender();
		}
		
		/**
		 * 启用
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		/**
		 * 启用
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * 灰色效果
		 */
		public function set disabled(value:Boolean):void
		{
			_disabled = value;
			if (value)
			{
				Effect.gray(this);
			}
			else
			{
				Effect.reset(this);
			}
		}
		
		public function get disabled():Boolean
		{
			return _disabled;
		}
		
		public function get Disposed():Boolean
		{
			return _disposed;
		}
		
		override public function set width(value:Number):void
		{
			value = value < 1 ? 1 : value;
			_preferWidth = value;
			if (_borderEntity)
				_borderEntity.width = _preferWidth;
			if (_backgroundEntity)
				_backgroundEntity.width = _preferWidth;
				
		}
		
		 
		override public function set height(value:Number):void
		{
			value = value < 1 ? 1 : value;
			_preferHeight = value;
			if (_borderEntity)
				_borderEntity.height = _preferHeight;
			if (_backgroundEntity)
				_backgroundEntity.height = _preferHeight;
			
		}
		
		//override public function get width():Number
		//{
			//return _preferWidth;
		//}
			//override public function get height():Number
		//{
			//return _preferHeight;
		//}
		
		/* ====================================================================================
		 * Methods
		 * ====================================================================================
		 */
		
		/**
		 * 初始化组件,设置位图数据等
		 */
		protected function initialize():void
		{
		
		}
		

		
		protected function eventListener():void
		{
		
		}
		

		public function get preferWidth():Number
		{
			return _preferWidth;
		}
		
		public function get preferHeight():Number
		{
			return _preferHeight;
		}
		
		public function get IsRender():Boolean 
		{
			return _IsRender;
		}
				
		public function dispose():void
		{
			
		}
		
		private function _addToStageLogic(e:Event):void
		{
			//removeEventListener(Event.ADDED_TO_STAGE, _addToStageLogic);
			_IsRender = true;
			_IsRemoved = false;
			_backgroundEntity.width = this.width;
			_backgroundEntity.height = this.height;
			_borderEntity.width = this.width;
			_borderEntity.height = this.height;
			addToStageControl();
			if (addStageHandler != null)
				addStageHandler(this);
			setChildIndex(_backgroundEntity, 0);
			setChildIndex(_borderEntity, this.numChildren - 1);
		}
		
		protected function addToStageControl():void
		{
		
		}
		
		private function _removeStageLogic(e:Event):void
		{
			//removeEventListener(Event.REMOVED_FROM_STAGE, _removeStageLogic);
			_IsRemoved = true;
			_IsRender = false;
			removeStageControl();
			if (removeStageHandler != null)
				removeStageHandler(this);
		}
		
		protected function removeStageControl():void
		{
		
		}
		
		/**
		 * 获得UI Rectangle
		 * @return
		 */
		public function getUIBound():Rectangle
		{
			return new Rectangle(this.x, this.y, this.width, this.height);
		}
		
		/**
		 * 是否和鼠标接触
		 * @return
		 */
		public function hitMouse():Boolean
		{
			if (!visible || !this.mouseEnabled || this.stage==null)
				return false;
			var Gpoint:Point = toGlobalPoint();
			var rect:Rectangle = new Rectangle(Gpoint.x, Gpoint.y, this.width, this.height);
			return rect.containsPoint(new Point(this.stage.mouseX, this.stage.mouseY));
		}
		
		/**
		 * 转换成全局坐标
		 * @return
		 */
		public function toGlobalPoint():Point
		{
			var result:Point = new Point();
			var target:DisplayObject = this;
			while (target != null)
			{
				result.x += target.x;
				result.y += target.y;
				target = target.parent;
			}
			return result;
		}
		
		public function toGlobalBound():Rectangle
		{
			var point:Point = toGlobalPoint();
			return new Rectangle(point.x, point.y, width, height);
		}
		
		public function getBorder():IBorder
		{
			return _borderEntity;
		}
		
		public function getBackground():IBackground
		{
			return _backgroundEntity;
		}
		
		public function setPosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 移除所有子元素 FlashPlayer 9-11 
		 */
		//public function removeAllChild():void {
			//var i:int=0
			//for ( i = this.numChildren - 1; i >= 0; i--)
			//{
				//this.removeChildAt(i);
			//}
		//} 
	
	}

}