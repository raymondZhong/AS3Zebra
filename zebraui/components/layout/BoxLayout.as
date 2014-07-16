package zebraui.components.layout 
{
	import zebraui.components.container.IContainer;
	
	
	
	/**
	 * BoxLayout布局 对x轴或y轴进行填满
	 */
	public final class BoxLayout extends LayoutManager
	{
		/**
		 * BoxLayout 布局
		 * @param	container
		 * @param	align
		 * @param	hgap
		 * @param	vgap
		 * @param	margin
		 */
		public function BoxLayout(container:IContainer=null,axis:String="x_axis",hgap:int=5,vgap:int=5,margin:LayoutMargin=null) 
		{
			 if (container)_container = container;
			// margin = LayoutMargin.Empty;
			 this._hgap = hgap;
			 this._vgap = vgap;	
			 this._vAlign = axis;
			 if(margin!=null){
				this._margin  = margin;
			 }
		}
		
		override public function setPreferWidth(value:Number):void 
		{
			super.setPreferWidth(value);
		}
		override public function setPreferHeight(value:Number):void 
		{
			super.setPreferHeight(value);
		}
		
		/**
		 * LayoutAlign.X_AXIS or LayoutAlign.Y_AXIS
		 */
		public function set axis(value:String):void { 
					_vAlign = value;
					updateAlign(_vAlign,_hAlign);
			}
		/**
		 * LayoutAlign.X_AXIS or LayoutAlign.Y_AXIS
		 */
		public function get axis():String { return _vAlign; }
		 
		 
		override public function updateAlign(align:String = null,halign:String=null):void 
		{
			super.updateAlign(align, halign);
			if (__elements.length == 0 || _container == null) return;
			
			_width = _container.preferWidth;
			_height = _container.preferHeight;
			if(_vAlign != LayoutAlign.X_AXIS && _vAlign !=LayoutAlign.Y_AXIS)
			_vAlign = LayoutAlign.X_AXIS
			
			 var gap:Number = 0;
			 var i:int = 0
			 switch (_vAlign) {
				 case LayoutAlign.X_AXIS:
					 if(__elements.length>0){
						gap = (__elements.length - 1) * this._hgap;
						var width:Number =  (_container.width - gap -this._margin.left-this._margin.right) / __elements.length;
						for ( i = 0; i < __elements.length; i++) 
						{
							__elements[i].width = width;
							__elements[i].y = this._margin.top;
							__elements[i].height = _container.height-this._margin.top-this._margin.bottom;
							if(i==0){
							__elements[i].x = this._margin.left;
							}else {
							__elements[i].x = __elements[i - 1].x +	__elements[i - 1].width + this._hgap;
							}
							
						}
					 }
				break
				 case LayoutAlign.Y_AXIS:
					 if (__elements.length > 0) {
						 gap = (__elements.length - 1) * this._vgap;
						 var height:Number =  (_container.height - gap -this._margin.top-this._margin.bottom) / __elements.length;
						 for ( i = 0; i < __elements.length; i++) 
							{
								__elements[i].width = _container.width-this._margin.left-this._margin.right;
								__elements[i].x = this._margin.left;
								__elements[i].height = height;
								if(i==0){
								__elements[i].y = this._margin.top;
								}else {
								__elements[i].y = __elements[i - 1].y +	__elements[i - 1].height + this._vgap;
								}
							}
						}
				break
			}
			 
		}
		
	 
		 
			
		
	}

}