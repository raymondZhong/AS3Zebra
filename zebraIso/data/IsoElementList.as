package zebraIso.data 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import zebraIso.display.IIsoRole;
	import zebraIso.display.IsoContainer;
	import zebraIso.display.primitive.IsoRectangles;
	import zebra.debug.Debug;
	
	/**
	 * Iso所有Iso元素管理,添加,移除,排序。
	 */
	public class IsoElementList 
	{
		private var _floorElements:Array;
		private var _airElements:Array;
		private var _container:DisplayObjectContainer;
		
		public function IsoElementList(container:DisplayObjectContainer) 
		{				
			_container = container;
			_floorElements = new Array();
			_airElements = new Array();
		}
		
		/**
		 * 所有isoContainer显示元素
		 */
		public function get isoChildren():Vector.<IsoContainer> {
			   var child:Vector.<IsoContainer> = new Vector.<IsoContainer>();
			   for each (var floorChild:IsoContainer in _floorElements) 
			   {
				   child.push(floorChild);
			   }
			   //for each (var airChild:IsoContainer in _airElements) 
			   //{
				   //child.push(airChild)
			   //}
			   return child;
			}
			
		public function get container():DisplayObjectContainer 
		{
			return _container;
		}
		
		/**
		 * 是否有重叠范围
		 * @param	bound
		 * @return
		 */
		public function  hasOverlapBound(bound:IsoBound):Boolean {
					var ele:IsoContainer
					//for each ( ele in _airElements) {
						//if (ele.getIsoBound().overlap(bound)) return true;
					//}
					for each ( ele in _floorElements) {
						if (ele.getIsoBound().overlap(bound)) return true;
					}
				return false;
			
			}
	 
		public function add(element:IsoContainer,bound:IsoBound=null):void {
			if (bound != null) {
				element.setIsoBound(bound);
				var ele:IsoContainer
				//for each ( ele in _airElements) {
					// Debug.output(ele.getIsoBound().overlap(bound),2)
					//if (ele.getIsoBound().overlap(bound)) return;
				//}
				for each ( ele in _floorElements) {
				 	//Debug.output(ele.getIsoBound().overlap(bound),2)
					if (ele.getIsoBound().overlap(bound)) return;
				}
				
				element.setIsoCoord(bound.topCell.x, bound.topCell.y, bound.topCell.z);
			}
			
			/*if(!element.inAir){
			   // _floorElements.push(element);
				}else {
				 //_airElements.push(element);
				}*/
				_container.addChild(element);
			//trace("numChildren",_container.numChildren)
			if(bound!=null){
				sortElements(element); 
			}
		}
		
		public function remove(element:IsoContainer):void {
			  var index:int = _floorElements.indexOf(element);
			  if(index!=-1){
			         _floorElements.splice(index, 1);				      
				 }else{
					 index = _airElements.indexOf(element);
					 if(index!=-1)_airElements.splice(index, 1);
				 }
			  _container.removeChild(element);
			 return;
		}
		
		
		/**
		 * 清空所有Iso元素
		 */
		public function clear():void {
				_floorElements = new Array();
				_airElements = new Array();
				var i:int = 0;
				for ( i = _container.numChildren - 1; i >= 0; i--)
					{
						_container.removeChildAt(i);
					}
				
			}
		 
		
		private function changeChildDepth(sourceRect:Rectangle,targetRect:Rectangle):String
		{			
			////A区
			if (sourceRect.x < targetRect.right && sourceRect.bottom <= targetRect.y)
				return "A";	//"A0";	
			if (sourceRect.right<= targetRect.x && sourceRect.y < targetRect.bottom)
				return "A";	//"A1";
			////B区
			if (sourceRect.x >= targetRect.right && sourceRect.y >= targetRect.y)
				return "B"; //"B0";
			if (sourceRect.right > targetRect.x && sourceRect.y >= targetRect.bottom)
				return "B";  //"B1";					
			if(sourceRect.bottom<=targetRect.y && sourceRect.x>=targetRect.right) return "C0";
			////C区	
			return "C";
		}	
			
		
		private function insertItem(newAddElement:IsoContainer):Array
		{
			//$target当然是需要插入的物体，
			//$arr原先的数组，不包括$target，
			//返回Array插入之后的新数组			
				var $arr:Array = []
				for (var j:int = 0; j < _container.numChildren; j++) 
				{
					if (_container.getChildAt(j) != newAddElement){
					 $arr.push(_container.getChildAt(j))
					}
				}
				

				var tempArr:Array = [];
				tempArr.push(newAddElement);

				var newElementIndex:int = 0;//记录newAddElement在数组中的位置
				
				 var currentIndex:int = 0;
				 var isbreak:Boolean;
					for (var i:int = 0; i < $arr.length; i++ ) {
					//循环
						var item:IsoContainer = $arr[i] as IsoContainer;
						var mark:String = changeChildDepth(IsoContainer(newAddElement).sceneRectangle,
														   item.sceneRectangle);
						
				    	//target 新加入的元素newAddElement
						//item 已经有的元素
						//target 在 item A区     表示已经遇到比自己后的物件,放弃h后面的检测，直接插入到数据中。
						
						//trace("i:"+i,mark,"<<<<<<<<<<<<<<")
						if (mark == "A") {
								  tempArr.splice( tempArr.indexOf(newAddElement) + 1 , 0, item);
								  currentIndex = i+1;
								  isbreak = true;
								  break;
							}				
							// target 在 item B区   表示比自己前的物件,继续向后比较.
						else if (mark == "B" || mark == "C0"  ) {
								 tempArr.splice( tempArr.indexOf(newAddElement) - 1 , 0, item);
							}
						//左下角的特殊区域，不能确定层次继续比较。
						//当人物向上移动的时候 左下角需要在物体前面
						else {
							/*
								 if (newAddElement is IIsoRole) {
									 trace(IIsoRole(newAddElement).currentDirection,">>>>>>>>>>>>>>>>>>>>>>>")
									    if (IIsoRole(newAddElement).currentDirection == 7) {
												tempArr.splice( tempArr.indexOf(newAddElement) - 1, 0, item);
												//currentIndex = i+1;
												//isbreak = true;
												//break;
											}else {
												tempArr.splice( tempArr.indexOf(newAddElement)-1, 0, item);	
											} 
									 }else {
											tempArr.splice( tempArr.indexOf(newAddElement)-1, 0, item);
									 }*/
							tempArr.splice( tempArr.indexOf(newAddElement)-1, 0, item);
							}
					}	
					
					if(isbreak){
						for (var k:int = currentIndex; k <$arr.length ; k++) 
							{
								tempArr.push($arr[k]);
							}
					}
				return tempArr
		}

		
		
		
		/**
		 * 排序
		 * 
		 * 尝试用物件的最下方的格子做排序
		 */
		public function sortElements(target:IsoContainer):void {
				  var d:Array =  insertItem(target);
				  var index:int = d.indexOf(target);			  
				  index = Math.min(index,_container.numChildren-1)
				 _container.setChildIndex(target, index);

				 _floorElements = d;
			
				 
				 
				/*_airElements.sortOn(["sortY", "sortX"], [Array.NUMERIC, Array.NUMERIC]);
				for(i = 0; i < _airElements.length; i++)
				{
					_container.setChildIndex(_airElements[i], i+_floorElements.length);
				}*/
				
			}
		


	 
	}
}