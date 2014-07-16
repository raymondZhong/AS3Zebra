package zebraui.components.layout
{
	
	import zebraui.components.container.IContainer;
	
	public class VBoxLayout extends LayoutManager
	{
		private var _vBoxLayoutModel:VBoxLayoutModel;
		public function VBoxLayout(container:IContainer = null, valign:String = "valign_top", halign:String = "halign_left", vgap:int = 0, margin:LayoutMargin = null)
		{
			 if (container)_container = container;
				this._vgap = vgap;
				this._margin = new LayoutMargin();
				_vAlign = valign;
				_hAlign = halign
				if (margin != null)
				{
					this._margin = margin;
				}
			_vBoxLayoutModel = new VBoxLayoutModel();
			
		}
		
		override public function updateAlign(valign:String = null, halign:String = null):void
		{
			super.updateAlign(valign, halign);
			if (__elements.length == 0 || _container == null) return;				
			_vBoxLayoutModel.clear();
			_vBoxLayoutModel.containerWidth = _container.width;
			_vBoxLayoutModel.containerHeight = _container.height;
			_vBoxLayoutModel.vgap = this.vgap;
			_vBoxLayoutModel.margin = _margin;
			for (var i:int = 0; i < __elements.length; i++)
			{
				if (i == 0)
				{
					__elements[i].x = _margin.left;
					__elements[i].y = _margin.top;
					
				}
				else
				{
					__elements[i].x= __elements[i - 1].x
					__elements[i].y = __elements[i - 1].y+__elements[i - 1].height+this.vgap;	
				}
				_vBoxLayoutModel.cmpList.push(__elements[i]);
			}
		
			
				 _vBoxLayoutModel.valign(this._vAlign);
				 _vBoxLayoutModel.halign(this._hAlign);
				 _vBoxLayoutModel.offX(_offx)
				 _vBoxLayoutModel.offY(_offy)
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
			return _preferWidth;
		}

		override public function get height():Number 
		{
			if(_autoHeight)return _vBoxLayoutModel.maxHeight+_margin.top+_margin.bottom;
			return _preferHeight;
		}
		
		
	}

}

import flash.display.DisplayObject;
import zebraui.components.layout.LayoutAlign;
import zebraui.components.layout.LayoutMargin;

internal  class VBoxLayoutModel {
	
	    public var  containerWidth:Number;
	    public var  containerHeight:Number;
		public var  margin:LayoutMargin;
		public var  vgap:Number;
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
				   if (cmp.height > _width){
				   _width = cmp.width;
				   _target = cmp;
				   }
			   }
			   return _target;
			}
		
		public function  get  maxWidth():Number {
			  var _width:Number = 0;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.height > _width)
				   _width = cmp.width;
			   }
			   return _width;
			}
			
		public function get maxHeight():Number {
			   var _height:Number = 0;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				  _height += cmp.height;
			   }
			   
			   _height += this.vgap * cmpList.length - 1;
			   return  _height;
			}	
			
		public function valign(value:String):void {
			var element:DisplayObject;
			var changevalue:Number = 0;
			if (cmpList.length == 0) return;
			switch(value) {
				  case LayoutAlign.VAlign_TOP:
					   changevalue = cmpList[0].y - margin.top;
					   for each ( element in cmpList) 
					   {
						      element.y += changevalue;
					   }
					  break;
				   case LayoutAlign.VAlign_CENTER:
					    changevalue =  (containerHeight - maxHeight) * .5;
					  
						if (cmpList.length == 1) 
						{
							cmpList[0].y = containerHeight/2 - cmpList[0].height/2
						}else {
						  for each ( element in cmpList) 
						   {
								element.y += changevalue;
						   }
					   }
					   
					  break;
				   case LayoutAlign.VAlign_BOTTOM:
					   changevalue = containerHeight - maxHeight;
					   for each ( element in cmpList) 
					   {
							 element.y += changevalue - vgap;
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
								  cmpList[i].x = margin.left;
							   }
							  break;
						   case LayoutAlign.HAlign_CENTER:							    
								for each ( var element:DisplayObject in cmpList) 
									   {
										   element.x = (containerWidth- element.width)*0.5
									   }
							  break;
						   case LayoutAlign.HAlign_RIGHT:
							   for (i = cmpList.length-1; i >=0 ; i--) 
							   {
								 cmpList[i].x =  containerWidth - cmpList[i].width - margin.right;
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