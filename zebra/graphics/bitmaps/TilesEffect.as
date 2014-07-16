package zebra.graphics.bitmaps 
{
        import flash.geom.Point;
        import flash.geom.Rectangle;
        import flash.utils.Dictionary;
		import zebra.system.util.RandomUtil;
        
        import feathers.controls.ScreenNavigator;
        
        import starling.animation.Tween;
        import starling.core.Starling;
        import starling.display.DisplayObject;
        import starling.display.DisplayObjectContainer;
        import starling.display.Image;
        import starling.textures.RenderTexture;
        import starling.textures.Texture;

        /**
         * 瓦片特效
         * @author YuanHao
         * 
         */        
        public class TilesEffect
        {
                private var  _spreadTransitions:Dictionary = new Dictionary();
                private var  _changeTransitions:Dictionary = new Dictionary();
                private var  _togetherTransitions:Dictionary = new Dictionary();
                private var  _texture:RenderTexture;
                private var  _togetherTexture:RenderTexture;
                private var _tileCount:uint;
                private var _hTileCount:uint;
                protected var tileContainer:DisplayObjectContainer;
                private var navigatorX:Number;
                private var navigatorY:Number;
                /**
                 * 扩散完成个数 
                 */                
                protected var spreadCompleteCount:uint;
                /**
                 * 聚合完成个数 
                 */                
                protected var togetherCompleteCount:uint;
                /**
                 * 所有扩散瓦片 
                 */                
                protected var spreadTiles:Vector.<Image>;
                /**
                 * 所有聚合瓦片 
                 */                
                protected var togetherTiles:Vector.<Image>;
                /**
                 * 扩散持续时间 
                 */                
                public var spreadDuration:Number = 0.4;
                /**
                 * 切换持续时间 
                 */                
                public var changeDuration:Number = 0.3;
                /**
                 * 聚合持续时间 
                 */                
                public var togetherDuration:Number = 0.4;

                public function get hTileCount():uint
                {
                        return _hTileCount;
                }

                public function get tileCount():uint
                {
                        return _tileCount;
                }

                /**
                 * 特效持续时间
                 * @return 
                 * 
                 */                
                public function get duration():Number
                {
                        return spreadDuration + togetherDuration + changeDuration;
                }
                public function set duration(value:Number):void
                {
                        
                }
                /**
                 *  
                 * @param navigator 导航对象
                 * @param scope 瓦片容器，默认为navigator
                 * @param tileCount 瓦片个数，建议hTilecount的倍数
                 * @param hTilecount 横排瓦片的数目
                 * 
                 */                
                public function TilesEffect(navigator:ScreenNavigator,tileContainer:DisplayObjectContainer = null,tileCount:uint = 9,hTilecount:uint = 3)
                {
                        if(!navigator)
                        {
                                throw new ArgumentError("ScreenNavigator不能为空。");
                        }
                        if(!tileContainer)
                        {
                                this.tileContainer = navigator;
                        }
                        else
                        {
                                this.tileContainer = tileContainer;
                        }
                        _tileCount = tileCount;
                        _hTileCount = hTilecount;
                        navigator.transition = onTransition;
                        navigatorX = navigator.x;
                        navigatorY = navigator.y;
                }
                public function onTransition(oldScreen:DisplayObject,newScreen:DisplayObject,onComplete:Function):void
                {
                        if(!oldScreen || !newScreen)
                        {
                                onComplete();
                                return;
                        }
                        oldScreen.visible = false;
                        newScreen.visible = false;
                        clearSpreadTransition();//清除扩散动画
                        clearChangeTransition();//清除切换动画
                        clearTogetherTransition();//清除聚合动画
                        addSpreadTransition(oldScreen,newScreen,onComplete);//添加扩散动画
                }
                /**
                 * 添加扩散动画
                 * @param screen
                 * 
                 */                
                protected function addSpreadTransition(oldScreen:DisplayObject,newScreen:DisplayObject,onComplete:Function):void
                {
                        spreadTiles = drawTiled(oldScreen);
                        var toPoints:Vector.<Point> = new Vector.<Point>();
                        var topointArea:Rectangle = new Rectangle();
                        var topointAreaCatch:Rectangle = new Rectangle();
                        for (var i:int = 0; i < spreadTiles.length; i++) 
                        {
                                tileContainer.addChild(spreadTiles[i]);
                                var tween:Tween = new Tween(spreadTiles[i],spreadDuration);//扩散特效
                                var fromeX:Number = spreadTiles[i].x;
                                var fromeY:Number = spreadTiles[i].y;
                                var toX:Number = Math.random()*(tileContainer.width - spreadTiles[i].width);
                                var toY:Number = Math.random()*(tileContainer.height - spreadTiles[i].height);
                                for (var j:int = 0; j < toPoints.length; j++) 
                                {
                                        topointAreaCatch.x = toX;
                                        topointAreaCatch.y = toY;
                                        topointAreaCatch.width = spreadTiles[i].width;
                                        topointAreaCatch.height = spreadTiles[i].height;
                                        topointArea.x = toPoints[j].x;
                                        topointArea.y = toPoints[j].y;
                                        topointArea.width = spreadTiles[i].width;
                                        topointArea.height = spreadTiles[i].height;
                                        while(topointArea.intersects(topointAreaCatch))
                                        {
                                                toX = Math.random()*(tileContainer.width - spreadTiles[i].width);
                                                toY = Math.random()*(tileContainer.height - spreadTiles[i].height);
                                                topointAreaCatch.x = toX;
                                                topointAreaCatch.y = toY;
                                        }
                                }
                                toPoints.push(new Point(toX,toY));
                                tween.onComplete = tileSpreadComplete;
                                tween.onCompleteArgs = [newScreen,onComplete];
                                tween.moveTo(toX,toY);
                                _spreadTransitions[spreadTiles[i]] = tween;
                                Starling.juggler.add(tween);
                        }
                }
                /**
                 * 单个瓦片扩散完成 
                 * 
                 */                
                private function tileSpreadComplete(newScreen:DisplayObject,onComplete:Function):void
                {
                        spreadCompleteCount++;
                        if(spreadCompleteCount == tileCount)
                        {
                                spreadComplete(newScreen,onComplete);
                        }
                }
                /**
                 * 扩散完成
                 * 
                 */                
                private function spreadComplete(newScreen:DisplayObject,onComplete:Function):void
                {
                        addchangeTransition(newScreen,onComplete);
                }        
                /**
                 * 添加切换动画 
                 * @param newScreen
                 * 
                 */                
                protected function addchangeTransition(newScreen:DisplayObject,onComplete:Function):void
                {
                        togetherTiles = drawTiled(newScreen);
                        for (var i:int = 0; i < spreadTiles.length; i++) 
                        {
                                var toX:Number = togetherTiles[i].x;
                                var toY:Number = togetherTiles[i].y;
                                var moveType:int = RandomUtil.intRange(0,4);
								//tool.getRandomFromArray([0,1,2,3]);
                                if(moveType == 0)
                                {
                                        togetherTiles[i].x = spreadTiles[i].x - togetherTiles[i].width;
                                        togetherTiles[i].y = spreadTiles[i].y;
                                }
                                if(moveType == 1)
                                {
                                        togetherTiles[i].x = togetherTiles[i].width;
                                        togetherTiles[i].y = spreadTiles[i].y;
                                }
                                if(moveType == 2)
                                {
                                        togetherTiles[i].x = togetherTiles[i].x;
                                        togetherTiles[i].y = spreadTiles[i].y - togetherTiles[i].height;
                                }
                                if(moveType == 3)
                                {
                                        togetherTiles[i].x = togetherTiles[i].x;
                                        togetherTiles[i].y = togetherTiles[i].height;
                                }
                                tileContainer.addChild(togetherTiles[i]);
                                var tween:Tween = new Tween(togetherTiles[i],changeDuration);//聚合特效
                                tween.onComplete = addTogetherTransition;
                                tween.onCompleteArgs = [togetherTiles[i],toX,toY,newScreen,onComplete];
                                tween.moveTo(spreadTiles[i].x,spreadTiles[i].y);
                                _changeTransitions[togetherTiles[i]] = tween;
                                Starling.juggler.add(tween);
                        }
                }
                /**
                 * 添加聚合动画 
                 * @param newScreen
                 * 
                 */                
                protected function addTogetherTransition(togetherTile:Image,toX:Number,toY:Number,newScreen:DisplayObject,onComplete:Function):void
                {
                        clearSpreadTransition();
                        clearChangeTransition();
                        tileContainer.addChild(togetherTile);
                        var tween:Tween = new Tween(togetherTile,togetherDuration);//聚合特效
                        tween.onComplete = tileTogetherComplete;
                        tween.onCompleteArgs = [newScreen,onComplete];
                        tween.moveTo(toX,toY);
                        _togetherTransitions[togetherTile] = tween;
                        Starling.juggler.add(tween);
                }
                /**
                 * 单个瓦片聚合完成 
                 * 
                 */                
                private function tileTogetherComplete(newScreen:DisplayObject,onComplete:Function):void
                {
                        togetherCompleteCount++;
                        if(togetherCompleteCount == tileCount)
                        {
                                togetherComplete(newScreen,onComplete);
                        }
                }
                /**
                 *聚合完成
                 * 
                 */                
                private function togetherComplete(newScreen:DisplayObject,onComplete:Function):void
                {
                        newScreen.visible = true;
                        clearTogetherTransition();
                        onComplete();
                }        
                /**
                 *  清除扩散动画 
                 * 
                 */                
                protected function clearSpreadTransition():void
                {
                        for(var key:String in _spreadTransitions)
                        {
                                Starling.juggler.remove(_spreadTransitions[key]);
                                _spreadTransitions[key] = null;
                                delete _spreadTransitions[key];
                        }
                        if(spreadTiles)
                        {
                                for (var i:int = 0; i < spreadTiles.length; i++) 
                                {
                                        tileContainer.removeChild(spreadTiles[i]);
                                        spreadTiles[i].dispose();
                                }
                        }
                        spreadTiles = null;
                        if(_texture)
                        {
                                _texture.dispose();
                        }
                        _texture = null;
                        spreadCompleteCount = 0;
                }
                /**
                 *  清除切换动画 
                 * 
                 */                
                protected function clearChangeTransition():void
                {
                        for(var key:String in _changeTransitions)
                        {
                                Starling.juggler.remove(_changeTransitions[key]);
                                _changeTransitions[key] = null;
                                delete _changeTransitions[key];
                        }
                }
                /**
                 *  清除聚合动画 
                 * 
                 */                
                protected function clearTogetherTransition():void
                {
                        for(var key:String in _togetherTransitions)
                        {
                                Starling.juggler.remove(_togetherTransitions[key]);
                                _togetherTransitions[key] = null;
                                delete _togetherTransitions[key];
                        }
                        if(togetherTiles)
                        {
                                for (var i:int = 0; i < togetherTiles.length; i++) 
                                {
                                        tileContainer.removeChild(togetherTiles[i]);
                                        togetherTiles[i].dispose();
                                }
                        }
                        togetherTiles = null;
                        if(_texture)
                        {
                                _texture.dispose();
                        }
                        _texture = null;
                        togetherCompleteCount = 0;
                }
                /**
                 * 绘制块 
                 * @param oldScreen
                 * @return 
                 * 
                 */                
                protected function drawTiled(screen:DisplayObject):Vector.<Image>
                {
                        var result:Vector.<Image> = new Vector.<Image>();
                        _texture = new RenderTexture(screen.width,screen.height,true);
                        _texture.draw(screen);
                        var region:Rectangle = new Rectangle();
                        for (var i:int = 0; i < tileCount; i++) 
                        {
                                var xIndex:uint = i%hTileCount;
                                var yIndex:uint = Math.floor(i/hTileCount) ;
                                region.x = xIndex * _texture.width/hTileCount;
                                region.y = yIndex * _texture.height/(tileCount/hTileCount);
                                region.width = _texture.width/hTileCount;
                                region.height = _texture.height/(tileCount/hTileCount);
                                var image:Image = new Image(Texture.fromTexture(_texture,region));
                                image.x = region.x + navigatorX;
                                image.y = region.y + navigatorY;
                                result.push(image);
                        }
                        return result;
                }
                public function dispose():void
                {
                        clearSpreadTransition();
                        clearTogetherTransition();
                        tileContainer = null;
                        _spreadTransitions = null;
                        _togetherTransitions = null;
                }
        }
}