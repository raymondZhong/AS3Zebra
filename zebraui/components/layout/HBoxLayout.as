package zebraui.components.layout
{
 
	import flash.display.DisplayObject;
	import zebraui.components.container.IContainer;
	
	
	/**
	 * HBoxLayout 对齐 对于整个容器  水平
	 */
	public final class HBoxLayout extends LayoutManager
	{
		private var _hBoxLayoutModel:HBoxLayoutModel
		
		public function HBoxLayout(container:IContainer=null, valign:String = "valign_top",halign:String="halign_left", hgap:int = 5, margin:LayoutMargin = null)
		{
			 if (container)_container = container;
			this._hgap = hgap;
			this._margin =  new LayoutMargin();
			_vAlign = valign;
			_hAlign = halign
			if (margin != null)
			{
				this._margin = margin;
			}
			
			_hBoxLayoutModel = new HBoxLayoutModel();
		}
		
 

		override public function updateAlign(valign:String = null, halign:String = null):void
		{
			super.updateAlign(valign, halign);
			if (__elements.length == 0 || _container==null) return;	
			_hBoxLayoutModel.clear();
			_hBoxLayoutModel.containerWidth = _container.width;
			_hBoxLayoutModel.containerHeight = _container.height;
			_hBoxLayoutModel.margin = _margin;
			for (var i:int = 0; i < __elements.length; i++)
			{
				if (i == 0)
				{
					__elements[i].x = _margin.left;
					__elements[i].y = _margin.top;
					
				}
				else
				{
					__elements[i].x = __elements[i - 1].x + __elements[i - 1].width + this.hgap;
					__elements[i].y = __elements[i - 1].y;	
				}
				_hBoxLayoutModel.cmpList.push(__elements[i]);
			}
		
			
				 _hBoxLayoutModel.valign(this._vAlign);
				 _hBoxLayoutModel.halign(this._hAlign);
				 _hBoxLayoutModel.offX(_offx)
				 _hBoxLayoutModel.offY(_offy)
				 
				//_container.preferHeight = _hBoxLayoutModel.maxHeight;
		}
		
		override public function set offX(value:Number):void
		{
			this._offx = value;
			updateAlign(_vAlign, _hAlign);
		}
		
		override public function set offY(value:Number):void
		{
			this._offy= value;
			updateAlign(_vAlign, _hAlign);
		}
		
		override public function get width():Number 
		{
			if(_autoWidth)return _hBoxLayoutModel.maxWidth+_margin.top+_margin.bottom;
			return _preferWidth;
		}
		
		override public function get height():Number 
		{
			return _preferHeight;
		}
		
		public function get  realHeight():Number {
				return _hBoxLayoutModel.maxHeight;				
		}
	
	}

}


import flash.display.DisplayObject;
import zebraui.components.layout.LayoutAlign;
import zebraui.components.layout.LayoutMargin;

internal  class HBoxLayoutModel {
	
	    public var  containerWidth:Number;
	    public var  containerHeight:Number;
		public var  margin:LayoutMargin;
		public var  cmpList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
	 
		public function clear():void {
			   containerWidth = 0;
			   containerHeight = 0;
			   margin = LayoutMargin.Empty;
			   cmpList= new Vector.<DisplayObject>();
			}
		
			
		public function get maxWidthElement():DisplayObject {
			   var _width:Number = 0;
			   var _target:DisplayObject;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.width > _width){
				   _width = cmp.width;
				   _target = cmp;
				   }
			   }
			   return _target;
			}	
			
		public function get maxWidth():Number {
			var element:DisplayObject = maxWidthElement;
			    if (element) {
					return element.width 
					} else {
					return 0	
					}
				
			}
		public function get maxHeightElement():DisplayObject {
			   var _height:Number = 0;
			   var _target:DisplayObject;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.height > _height){
				   _height = cmp.height;
				   _target = cmp;
				   }
			   }
			   return _target;
			}
		
		public function  get  maxHeight():Number {
			  var _height:Number = 0;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.height > _height)
				   _height = cmp.height;
			   }
			   return _height;
			}
			
			
		public function valign(value:String):void {
			var element:DisplayObject;
			var _maxHeightelement:DisplayObject  = maxHeightElement;
			switch(value) {
				  case LayoutAlign.VAlign_TOP:
					   for each ( element in cmpList) 
					   {
						      element.y = margin.top
					   }
					  break;
				   case LayoutAlign.VAlign_CENTER:
					   for each ( element in cmpList) 
					   {
							element.y = containerHeight / 2 - element.height / 2 +margin.top/2  - margin.bottom/2;
							 
					   }
					  break;
				   case LayoutAlign.VAlign_BOTTOM:
					   for each ( element in cmpList) 
					   {
							 element.y = containerHeight - margin.bottom - element.height;
					   }
					  break;
				  
				}
			}	
		     
		public function halign(value:String):void {				    
					var i:int = 0;
					var changevalue:Number = 0;
					switch(value) {
						  case LayoutAlign.HAlign_LEFT:
							   for (i = 0; i <cmpList.length ; i++) 
							   {
								 if (i == 0) {
									  changevalue =  cmpList[i].x - margin.left
									  cmpList[i].x += changevalue;
									 }else {
									  cmpList[i].x += changevalue;
									 }
							   }
							  break;
						   case LayoutAlign.HAlign_CENTER:							    
							   var  rowContentWidth:Number =  cmpList[cmpList.length - 1].x + cmpList[cmpList.length - 1].width-cmpList[0].x;
							   if (cmpList.length == 1) rowContentWidth =  cmpList[0].width;
							   var  innerWidth:Number = containerWidth - this.margin.left - this.margin.right;
							    changevalue = (innerWidth - rowContentWidth) * .5
								for each ( var element:DisplayObject in cmpList) 
									   {
										   element.x += changevalue;
									   }
							  break;
						   case LayoutAlign.HAlign_RIGHT:
							   for (i = cmpList.length-1; i >=0 ; i--) 
							   {
								 if (i == cmpList.length-1) {
									  changevalue = containerWidth - margin.right - (cmpList[i].x + cmpList[i].width);
									  cmpList[i].x += changevalue;
									 }else {
									  cmpList[i].x += changevalue;
									 }
							   }
							  break;
						  
						}
				}
			
			
			public function offX(value:Number):void {
						  for each ( var element:DisplayObject in cmpList) 
							   {
								   element.x +=value
							   }
							}
			public function offY(value:Number):void {
						  for each ( var element:DisplayObject in cmpList) 
							   {
								   element.y +=value
							   }
						  
					}
	}