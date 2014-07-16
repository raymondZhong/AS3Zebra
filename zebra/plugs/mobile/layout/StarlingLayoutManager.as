package zebra.plugs.mobile.layout
{	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	
	//public class StarlingLayoutManager  implements ILayoutManager
	public class StarlingLayoutManager  
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
		protected var _container:DisplayObjectContainer;
		protected var _elements:Vector.<DisplayObject>	

		public function StarlingLayoutManager()
		{
			_offx = 0;
			_offy = 0;
		    _elements = new Vector.<DisplayObject>();		
			_margin = new LayoutMargin(5, 5, 5, 5);  
		}
		 
		/**
		 * 添加组件
		 * @param	cmp
		 */
		public function append(cmp:DisplayObject):void {
				if (_container) {
					_elements.push(cmp);
					_container.addChild(cmp);
					//updateAlign(_vAlign,_hAlign);
				}
			}
			
		/**
		 * 移除组件
		 * @param	cmp
		 */
		public function remove(cmp:DisplayObject):void {
				var index:int = _elements.indexOf(cmp);
				if (index != -1) {
					_elements.splice(index, 1);
					}
				if(_container.contains(cmp))
				_container.removeChild(cmp);
				updateAlign(_vAlign,_hAlign);
			}
		 
		public function clear():void {
				for (var i:int = _elements.length-1; i >=0 ; i--) 
				{
					if (_elements[i].parent)_elements[i].parent.removeChild(_elements[i]);
				}
				_elements.length = 0;
				updateAlign(_vAlign,_hAlign);
			}
			
		public	function get elements():Vector.<DisplayObject> {
			return _elements;
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
			if(_container)
			updateAlign(_vAlign,_hAlign);			
		}
		
		public function get hgap():int 
		{
			return _hgap;
		}
		
		public function set hgap(value:int):void 
		{
			_hgap = value;		
			if(_container)
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
		
		
		public function get container():DisplayObjectContainer 
		{
			return _container;
		}
		
		public function set container(value:DisplayObjectContainer):void 
		{
			_container = value;
 		}
		
		public function get vAlign():String 
		{
			return _vAlign;
		}
		
		public function set vAlign(value:String):void 
		{
			_vAlign = value;	
			if(_container)
			updateAlign(_vAlign,_hAlign);
		}
		
		public function get hAlign():String 
		{	
			return _hAlign;
		}
		
		public function set hAlign(value:String):void 
		{
			
			_hAlign = value;
			if(_container)
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
		
 
			
	}
}