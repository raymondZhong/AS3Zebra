package zebra.graphics.animation
{
	import flash.display.BitmapData;
	
	public interface IAnimation
	{
		function play(name:String=""):void;
		function pause():void;
		function stop():void;
		function set fps(value:int):void;
		function get fps():int;
		function get align():String;
		function set align(value:String):void;
		function get BitmapDataSource():Vector.<BitmapData>;
		function set BitmapDataSource(value:Vector.<BitmapData>):void;
		function get totalframes():int;		
		function get currentFrame():int;	
		function set currentFrame(value:int):void;	
		function dispose():void;
		function get IsHitMouse():Boolean;
	}

}