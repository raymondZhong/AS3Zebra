package zebraIso.trigger 
{
	import flash.geom.Vector3D;
	import zebraIso.display.IsoContainer;

	public class IsoTrigger 
	{
		private var _isoTarget:IsoContainer;
		public function IsoTrigger(isotarget:IsoContainer) 
		{
			_isoTarget = isotarget;
		}
		
		
		
		/**
		 * 到达一个
		 */
		public function inPosition(pos:Vector3D):void {
				 
			}
			
			
		public function inCell(cel:Vector3D,time:uint=0):void {
			  
			}
		
		
		
		
		
	}

}