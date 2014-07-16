package zebra.input 
{
 
	
	   import flash.display.Stage;
	   import flash.events.Event;
        import flash.events.EventDispatcher;
        import flash.events.MouseEvent;
        import flash.geom.Point;
         
        
        public class MouseInputCircle extends EventDispatcher
        {
                //顺时针和逆时针圆绘画完毕消息
                static public const EVENT_CWCOMPLETE:String         = "EVENT_CWCOMPLETE";
                static public const EVENT_CCWCOMPLETE:String         = "EVENT_CCWCOMPLETE";
                
                private var _isDown:Boolean = false;                        //判断鼠标是否按下
                
                //圆中心位置
                private var _circleCenter:Point = new Point();
                //圆的X偏差
                private var _circleXOff:Number;
                //圆的Y偏差
                private var _circleYOff:Number;
                
                private var _cw:Boolean;                                //顺时针标记
                private var _cwBeginDeg:Number;                        //顺时针开始角度
                private var _cwEndDeg:Number;                        //顺时针结束角度
                private var _cwComplete:Boolean;                //顺时针完成标记
                
                private var _ccw:Boolean;                                //逆时针标记
                private var _ccwBeginDeg:Number;                //逆时针开始角度
                private var _ccwEndDeg:Number;                        //逆时针结束角度
                private var _ccwComplete:Boolean;                //逆时针过半标记
                
                private var _stage:Stage;
                
                public function MouseInputCircle(
                                                                           stage:Stage,
                                                                           circleXOff:Number = 10,
                                                                           circleYOff:Number = -10,
                                                                           cwBeginDeg:Number = 140,
                                                                           cwEndDeg:Number = 40,
                                                                           ccwBeginDeg:Number = -140,
                                                                           ccwEndDeg:Number = -40)
                {
                        _stage = stage;
                        
                        _circleXOff = circleXOff;
                        _circleYOff = circleYOff;
                        _cwBeginDeg = cwBeginDeg;
                        _cwEndDeg = cwEndDeg;
                        _ccwBeginDeg = ccwBeginDeg;
                        _ccwEndDeg = ccwEndDeg;
                        
                        _cw = _cwComplete = _ccw = _ccwComplete = false;
                        
                        /*
                        //监听鼠标左键按下及松开，监听EnterFrame事件
                        this.addEventListener(Event.ENTER_FRAME,onEnter);                                
                        this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
                        this.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
                        */
                }
                
                public function onMouseDown(event:MouseEvent):void
                {
                        //鼠标左键被按下
                        _circleCenter.x = _stage.mouseX - _circleXOff;
                        _circleCenter.y = _stage.mouseY - _circleYOff;
                        _isDown = true;        
                        
                }
                        
                public function onMouseUp(event:MouseEvent):void
                {
                        //鼠标左键松开
                        _isDown = false;
                        //重置状态
                        _cw = _ccw = false;
                        _cwComplete = _ccwComplete = false;
                }
                
                public function onEnter(event:Event):void
                {                                
                        if(_isDown)
                        {
                                //获取鼠标位置与圆中心位置的差值
                                var dx:Number = _stage.mouseX - _circleCenter.x;
                                var dy:Number = _stage.mouseY - _circleCenter.y;
                                
                                //根据差值计算角度
                                var radians:Number = Math.atan2(dy,dx) * 180/ Math.PI;
                                
                                //根据角度判断是顺时针还是逆时针
                                if(radians > _cwBeginDeg && !_ccw)
                                {
                                        _cw = true;        
                                }
                                
                                if(radians < _ccwBeginDeg && !_cw)
                                {
                                        _ccw = true;
                                }
                                
                                //顺时针
                                if(_cw)
                                {
                                        if(radians < 0)
                                        {
                                                radians = 0 - radians;
                                        }
                                
                                        if(radians < _cwEndDeg)
                                        {
                                                //完成顺时针画圆
                                                _cwComplete = true;                
                                        }
                                }
                                
                                //逆时针
                                if(_ccw)
                                {
                                        if(radians > 0)
                                        {
                                                radians = 0 - radians;
                                        }
                                        
                                        if(radians > _ccwEndDeg)
                                        {
                                                //完成逆时针画圆
                                                _ccwComplete = true;
                                        }
                                
                                }
                                
                                if(_cwComplete)
                                {
                                        _cwComplete = false;
                                        _cw = false;
                                        this.dispatchEvent(new Event(EVENT_CWCOMPLETE));

                                }
                                
                                if(_ccwComplete)
                                {
                                        _ccwComplete = false;
                                        _ccw = false;
                                        this.dispatchEvent(new Event(EVENT_CCWCOMPLETE));
                                }
                        }
                }

        }
}