package zebraIso.data 
{
	import flash.geom.Vector3D;
	
	/**
	 * 地面的区域
	 */
	public class IsoBound 
	{		
		
		
		private var  _topCell:Vector3D;
		private var  _bottomCell:Vector3D;
		
		public function IsoBound(grid0:Vector3D=null,grid1:Vector3D=null)
		{
			if (grid0 == null) grid0 = new Vector3D();
		    if (grid1 == null){grid1 = grid0.clone();}
			_topCell = new Vector3D(Math.min(grid0.x, grid1.x),0, Math.min(grid0.z, grid1.z));
			_bottomCell = new Vector3D(Math.max(grid0.x, grid1.x),0,Math.max(grid0.z, grid1.z));
		}
		
		
		public  function get column():int {
			  if (IsEmtry()) return 0;
			  return  int(_bottomCell.x - _topCell.x) + 1;
			};
		
		public  function get row():int { 
			 if (IsEmtry()) return 0;
			  return  int(_bottomCell.z - _topCell.z) + 1;
			};
		
		public  function get leftCell():Vector3D { 
			 if (IsEmtry()) new Vector3D(-1,-1);
			 return new Vector3D(_topCell.x,0,_bottomCell.z); 
			 // return new Vector3D(_topCell.z,0,_bottomCell.x);
			};
		
		public  function get rightCell():Vector3D { 
			if (IsEmtry()) new Vector3D(-1,-1);
			   return new Vector3D(_bottomCell.x,0,_topCell.z);
			};
		
		
		public  function set topCell(value:Vector3D):void {_topCell = value;};
		public  function get topCell():Vector3D { return  _topCell;};
		 
		 
		public  function set bottomCell(value:Vector3D):void { _bottomCell = value;};
		public  function get bottomCell():Vector3D { return _bottomCell;};
			
		public  function  IsEmtry():Boolean {
			  return  _topCell == null || _bottomCell == null;
			}	
		 
		/**
		 * 重叠
		 * @param	bound
		 * @return
		 */
		public function overlap(bound:IsoBound):Boolean {	
			   var data:Array = new Array();
			   var i:int = 0;
			   var j:int = 0;
			   for ( i = this._topCell.x; i <=this._bottomCell.x ; i++) 
			   {
				   for ( j = this._topCell.z; j <= this._bottomCell.z; j++) 
				   {
					   data.push(i + "," + j);
				   }
			   }
			   
			   for ( i = bound._topCell.x; i <=bound._bottomCell.x ; i++) 
			   {
				   for ( j = bound._topCell.z; j <= bound._bottomCell.z; j++) 
				   {
					  if ( data.indexOf(i + "," + j) != -1) return true;
				   }
			   }
			   
			   return false;
			   
			 
			}
			
		/**
		 * 包含
		 * @param	bound OR Vector3D
		 * @return
		 */
		public function container(bound:*):Boolean {	
			if(bound is IsoBound){
		     if (!(this.topCell.x <= bound.topCell.x))	return false;
		     if (!(this.topCell.z <= bound.topCell.z))	return false;
		     if (!(this.bottomCell.x >= bound.bottomCell.x))	return false;
		     if (!(this.bottomCell.z>=bound.bottomCell.z))	return false;
			 return true;
			}
			
			if (bound is Vector3D) {
			 if (!(this.topCell.x <= bound.x))	return false;
		     if (!(this.topCell.z <= bound.z))	return false;
		     if (!(this.bottomCell.x >= bound.x))	return false;
		     if (!(this.bottomCell.z>=bound.z))	return false;
			 return true;
			}
			return false;
		 
			//trace(this.topGrid.x,bound.topGrid.x,this.topGrid.x<=bound.topGrid.x)
			//trace(this.topGrid.z,bound.topGrid.z,this.topGrid.z<=bound.topGrid.z)
			//trace( this.bottomGrid.x,bound.bottomGrid.x,this.bottomGrid.x>=bound.bottomGrid.x)
			//trace( this.bottomGrid.z, bound.bottomGrid.z, this.bottomGrid.z >= bound.bottomGrid.z)
			//
			 //return  this.topGrid.x <= bound.topGrid.x && this.topGrid.z <= bound.topGrid.z &&  this.bottomGrid.x >= bound.bottomGrid.x && this.bottomGrid.z>=this.bottomGrid.z;
			}			
		
		public function toString():String {
			  return  "topCell:" + topCell+"::"+"bottomCell"+bottomCell;		
		}
		
		
	}

}