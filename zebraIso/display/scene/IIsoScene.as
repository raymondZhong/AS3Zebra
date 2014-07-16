package zebraIso.display.scene
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import zebraIso.data.IsoBound;
	import zebraIso.display.IsoGrid;
	
	[Event(name="pick",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="selectActive",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="SelectExecute",type="zebraIso.event.IsoSceneEvent")]
	[Event(name="SelectRelease",type="zebraIso.event.IsoSceneEvent")]
	
	public interface IIsoScene extends IEventDispatcher
	{
		
		/**
		 * 获得地面范围
		 * @return
		 */
		function getIsoBound():IsoBound
		
		/**
		 * 显示坐标轴
		 */
		function get showCoordinate():Boolean
		
		/**
		 * 显示坐标轴
		 */
		function set showCoordinate(value:Boolean):void
		
		function get isoGrid():IsoGrid
		function get rectangleContianer():IsoRectangleContianer
		/**
		 * 全局坐标
		 * @return
		 */
		function toStagePoint():Point
		
		function setState(value:String):void
		
		/**
		 * 编辑模式的可编辑区域
		 * @param	value
		 */
		function setEditBound(value:IsoBound):void
		
		function set visible(value:Boolean):void		
		function get visible():Boolean
		
		function dispose():void
	}

}