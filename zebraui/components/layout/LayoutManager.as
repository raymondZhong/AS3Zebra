package zebraui.components.layout
{
	import flash.display.DisplayObject;
	import zebraui.components.container.IContainer;
 
 
	
	internal class LayoutManager  implements ILayoutManager
	{
 
		protected var _offx:Number;
		protected var _offy:Number;
		protected var _hgap:int;
        protected var _vgap:int;
		protected var _margin:LayoutMargin;
		protected var _vAlign:String;
		protected var _hAlign:String;
		protected var _flex:Boolean;
		protected var _preferWidth:Number;		
		protected var _preferHeight:Number;
		protected var _autoWidth:Boolean;
		protected var _autoHeight:Boolean;
		
		/**
		 * 布局容器对象
		 */
		protected var _container:IContainer;
		protected var __elements:Vector.<DisplayObject>	

		public function LayoutManager()
		{
			_offx = 0;
			_offy = 0;
		    __elements = new Vector.<DisplayObject>();		
			_margin = new LayoutMargin(5, 5, 5, 5);  
		}
		 
		/**
		 * 添加组件
		 * @param	cmp
		 */
		public function append(cmp:DisplayObject):void {
				if (_container) {
					__elements.push(cmp);
					_container.container.addChild(cmp);
					//if(_container.IsRender)
					updateAlign(_vAlign,_hAlign);
				}
			}
			
		/**
		 * 移除组件
		 * @param	cmp
		 */
		public function remove(cmp:DisplayObject):void {
				var index:int = __elements.indexOf(cmp);
				if (index != -1) {
					__elements.splice(index, 1);
					}
				if(_container.container.contains(cmp))
				_container.container.removeChild(cmp);
				
				if(_container && _container.IsRender)
				updateAlign(_vAlign,_hAlign);
			}
		 
		public function clear():void {
				for (var i:int = __elements.length-1; i >=0 ; i--) 
				{
					if (__elements[i].parent)__elements[i].parent.removeChild(__elements[i]);
				}
				__elements.length = 0;
				updateAlign(_vAlign,_hAlign);
			}
		public	function get elements():Vector.<DisplayObject> {
			return __elements;
			}
		/**
		 * 更新布局  垂直,水平
		 * @param	valign
		 * @param	halign
		 */
		 public function updateAlign(valign:String = null, halign:String = null):void {
				if(valign!=null)
			     _vAlign = valign;
				if (halign != null)
				_hAlign = halign;						 

			}
		/**
		 * X轴偏移
		 */
		public function set offX(value:Number):void { _offx = value; }
		public function get offX():Number { return _offx; }
		/**
		 * Y轴偏移
		 */
		public function set offY(value:Number):void { _offy = value; }
		public function get offY():Number { return _offy; }
		
		public function get margin():LayoutMargin 
		{
			return _margin;
		}
		
		public function set margin(value:LayoutMargin):void 
		{
			_margin = value;
			if(_container && _container.IsRender)
			updateAlign(_vAlign,_hAlign);			
		}
		
		public function get hgap():int 
		{
			return _hgap;
		}
		
		public function set hgap(value:int):void 
		{
			_hgap = value;		
			if(_container && _container.IsRender)
			updateAlign(_vAlign,_hAlign);
		}
		
		public function get vgap():int 
		{
			return _vgap;
		}
		
		public function set vgap(value:int):void 
		{
			_vgap = value;
			updateAlign(_vAlign,_hAlign);
		}
		
		
		public function get container():IContainer 
		{
			return _container;
		}
		
		public function set container(value:IContainer):void 
		{
			_container = value;
			_preferWidth = _container.preferWidth;
			_preferHeight = _container.preferHeight;
 		}
		
		public function get vAlign():String 
		{
			return _vAlign;
		}
		
		public function set vAlign(value:String):void 
		{
			_vAlign = value;	
			if(_container && _container.IsRender)
			updateAlign(_vAlign,_hAlign);
		}
		
		public function get hAlign():String 
		{	
			return _hAlign;
		}
		
		public function set hAlign(value:String):void 
		{
			
			_hAlign = value;
			if(_container &&_container.IsRender)
			updateAlign(_vAlign,_hAlign);
		}
		
	 	
		public function setPreferWidth(value:Number):void {
			  _preferWidth = value;
			}
			
		public function setPreferHeight(value:Number):void {
			  _preferHeight = value;
			} 
		
 		public function get width():Number { return  _preferWidth; }
		public function get height():Number { return _preferHeight; } 
		
		public function get autoWidth():Boolean 
		{
			return _autoWidth;
		}
		
		public function set autoWidth(value:Boolean):void 
		{
			_autoWidth = value;
		}
		
		public function get autoHeight():Boolean 
		{
			return _autoHeight;
		}
		
		public function set autoHeight(value:Boolean):void 
		{
			_autoHeight = value;
		}
			
	}
}