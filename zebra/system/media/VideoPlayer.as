package zebra.system.media
{	
	import com.greensock.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import zebra.system.util.StringHelper;

    public final class VideoPlayer extends Sprite {
		public var seekBackground:DisplayObject;
		public var Button_Seek:flash.display.Sprite;
		public var Button_Sound:DisplayObject;
		public var Button_Play:DisplayObject;
		public var Button_PauseOrPlay:DisplayObject;
		public var Button_RePlay:DisplayObject;
		public var loadBar:DisplayObject;
		public var playBar:Sprite;
		public var buffer_MovieClip:DisplayObject;
		public var flvPlayTime:TextField;
		public var flvTotalTime:TextField;
		
		//public  var videoURL:String = "http://www.iscriptweb.com/common/video/xiaogang.flv";
		//public  var videoURL:String = "Video/xiaogang.flv";
		public  var videoURL:String
		private var connection:NetConnection;
        private var stream:NetStream;
		public  var video:Video;
		
		private var netsMetaData:Object = new Object();

		/**
		 * 视频总长度
		 */
		public var flvDurtion	:uint; 
		
        public function VideoPlayer() {
            connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, moveFromStage);
        }
		
		
		private var isDrag:Boolean = false;
		
		private function addToStage(e:Event):void {
			if (Button_RePlay != null) {
				Button_RePlay.addEventListener(MouseEvent.CLICK, replayvideo);
				}
			if (Button_PauseOrPlay != null) {
				Button_PauseOrPlay.addEventListener(MouseEvent.CLICK, pauseOrPlayWidthVideo);
			   }
			if (buffer_MovieClip != null) {
			buffer_MovieClip.visible = false;
			}
			if (playBar != null) {
				playBar.x = seekBackground.x;
				playBar.mouseChildren = false;
				playBar.mouseEnabled = false;
			}
			if(video!=null){
			video.smoothing = true;
            video.attachNetStream(stream);
            }
			stream.play(videoURL);
			stream.pause();
			if(Button_Sound!=null){
			Button_Sound.addEventListener(MouseEvent.CLICK, mute);
			}			
			if (loadBar != null) {
			loadBar.x = seekBackground.x;
			loadBar.addEventListener(MouseEvent.CLICK, seekFlv);
			}
			
			if (Button_Seek != null) {
			Button_Seek.visible = false;
			Button_Seek.x = seekBackground.x;
			Button_Seek.addEventListener(MouseEvent.MOUSE_DOWN, mousedown_);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseup_);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mousemove_);
			}
			
			}
 
		 private function replayvideo(e:MouseEvent):void {
			  reStartPlay();
			}
			
 
		private function mousedown_(e:MouseEvent):void {
			if (Button_Seek != null) {
			    isDrag = true;
 
			  }
			}
			
		private function mousemove_(e:MouseEvent):void {
			   if (Button_Seek != null && isDrag) {
				   var sp:Sprite =    Button_Seek as Sprite;
				     sp.startDrag(false, new Rectangle(loadBar.x,
					                                   Button_Seek.y,
					                                   loadBar.width - Button_Seek.width,
													   0));
				   }
			}
		
		private function mouseup_(e:MouseEvent):void {
			  if(Button_Seek!=null){
				   var sp:Sprite =    Button_Seek as Sprite;
				   sp.stopDrag();
				   if (isDrag) {
				   seekFlv(null);
			       }
				   isDrag = false;
				}
			}	
		
		private function pauseOrPlayWidthVideo(e:MouseEvent):void {
				  pauseOrPlay();
				}			
		
		private function mute(e:MouseEvent):void {
			 muteOrUnmute()
			}
			
		public function seekFlvTime(num:Number):void {
			stream.seek(num * flvDurtion);	
		}
		private function seekFlv(e:MouseEvent):void {
			
			
			 try 
			 {
				 if (e == null) {
					 stream.seek((seekBackground.mouseX-Button_Seek.mouseX) / seekBackground.width * flvDurtion);
					 }
				 if(seekBackground.mouseX<loadBar.width && e!=null){
				   stream.seek(seekBackground.mouseX / seekBackground.width * flvDurtion);	
				 }
				
				 
				//try 
				//{
				//	Button_Seek.x = seekBackground.x + (seekBackground.width - Button_Seek.width) * stream.time / flvDurtion; }catch(e){}
					}catch(e:*){}
			
			}
			
		private function moveFromStage(e:Event):void {
			   removeEventListener(Event.ENTER_FRAME, ENTERFRAME);
			}
				
		private function ENTERFRAME(e:Event):void { 
			if(flvPlayTime!=null){
			flvPlayTime.text =  StringHelper.format_MediaTime(stream.time);
			}
			if(flvTotalTime!=null){
			flvTotalTime.text = StringHelper.format_MediaTime(flvDurtion);
			}
			if(playBar!=null){
			playBar.width = 0;
			playBar.width = seekBackground.width * stream.time / flvDurtion;
			}
			if(loadBar!=null){
			loadBar.width = 0;
			loadBar.width = seekBackground.width * stream.bytesLoaded / stream.bytesTotal;	
			}
			if (!isDrag && Button_Seek != null && seekBackground != null) {
				     Button_Seek.x = seekBackground.x + (seekBackground.width - Button_Seek.width) * stream.time / flvDurtion; 
				}
				
			}
			
		
			private var _loopPlay:Boolean;
			
		
        private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Failed":
				    dispatchEvent(new Event(Event_Error_Connect));
					break;					
                case "NetConnection.Connect.Success":
                    connectStream();
					addEventListener(Event.ENTER_FRAME, ENTERFRAME);
                    break;
                case "NetStream.Play.StreamNotFound":
                    dispatchEvent(new Event(Event_Error));
				    break;
				case "NetStream.Buffer.Empty":
					dispatchEvent(new Event(Event_Buffer_Empty));
					if (buffer_MovieClip != null) {
						buffer_MovieClip.visible = true;
						}
				    break;
				case "NetStream.Buffer.Full":
					dispatchEvent(new Event(Event_Buffer_Full));
					if (buffer_MovieClip != null) {
					buffer_MovieClip.visible = false;
				    }
					break;
				case "NetStream.Play.Start":
				if(Button_Seek!=null){
				Button_Seek.visible = true;
				}	
				dispatchEvent( new Event(Event_Play_Start));
				    break;
				case "NetStream.Play.Stop":
					dispatchEvent(new Event(Event_Play_End));
					break;		
            }
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
              dispatchEvent(new  Event(Event_Error));
			//trace("securityErrorHandler: " + event);
        }

        private function connectStream():void {
            stream = new NetStream(connection);
			stream.bufferTime = bufferTime_;
			stream.soundTransform  =  new SoundTransform(volume_);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            //stream.client = new CustomClient();
            stream.client = netsMetaData;
			netsMetaData.onMetaData = metaObject;
			if(video==null){
			video = new Video();
			addChild(video);
			}            
        }
		
		
		
		private var  bufferTime_:Number = 5;
		private var  volume_:Number = 1;
		/**
		 *  设置和获得视频音量 秒
		 */
		public function set volume(val:Number):void {
			volume_ = val;
			//stream.soundTransform  =  new SoundTransform(volume_);
			TweenLite.to(stream, 2, {volume:volume_});
			}
		
		public function get volume():Number {
			  return volume_;
			}
			
		/**
		 * 设置和获得视频缓存时间
		 */
		public function set bufferTime(val:Number):void {
			bufferTime_ = val;
			stream.bufferTime = bufferTime_;
			}
		
		public function get bufferTime():Number {
			  return bufferTime_;
			}
			
		/*public function get loopPlay():Boolean 
		{
			return _loopPlay;
		}
		
		public function set loopPlay(value:Boolean):void 
		{
			_loopPlay = value;
			
			if(value){
			addEventListener(Event.ENTER_FRAME, LoopRePlay);
			}
		}
		
		
		
		private function  LoopRePlay(e:Event):void {
			  if (flvDurtion > 0) {
		 
			  if (stream.time >= (flvDurtion - 0.2)) {
			  	    removeEventListener(Event.ENTER_FRAME, LoopRePlay);
				    reStartPlay(); 
					setTimeout(function():void { 
						addEventListener(Event.ENTER_FRAME, LoopRePlay);
						}, 100);
					//trace(stream.time,">>>>>>>>>>>>>>>")
				  }
			   }
			      
			}
		*/
		
			
			
		/**
		 * 视频暂停或者播放
		 */	
		public function pauseOrPlay():void {
			  stream.togglePause();		
			}	
			
		/*	public function play():void {
					 stream.play(videoURL);
				}*/	
		 
		public function pause():void {
				stream.pause();
			}	
			
		public function close():void {
				 stream.close();
				}
			
		/**
		 * 静音或者发音
		 */
		public function muteOrUnmute():void {
			  if (volume == 0) {
				    volume = 1;
				  }else {
					  volume = 0;
				  } 
			}
		
		/**
		 * 从头开始播放
		 */
		public function reStartPlay():void {
			stream.seek(0);	
			}
			
			
		/**
		 * 改变视频地址并且播放
		 * @param	url  视频地址
		 */	
		public  function  changeVideoURLAndPlay(url:String):void {
			videoURL = url;
			stream.play(videoURL);
			}
			
			
		private function metaObject(o:Object):void
		{
			flvDurtion = o.duration;
		}
			
		public function dispose():void {
			stream.dispose();
			}	
		
		
		//{ Video Event 	
		/**
		 * 视频播放开始事件
		 */
		public static const Event_Play_Start:String = "Event_Play_Start";
		
		
		/**
		 * 视频播放结束事件
		 */
		public static const Event_Play_End:String = "Event_Play_End";
		
		/**
		 * 视频缓冲中事件
		 */
		public static const Event_Buffer_Empty:String = "Event_Buffer_Empty";
	   
		
		/**
		 * 视频缓存结束事件
		 */
		public static const Event_Buffer_Full:String = "Event_Buffer_Full";
	   
		
		/**
		 *  视频载入或者播放出错事件
		 */
		public static const Event_Error:String = "Event_Error";
		
		
		/**
		 * 网络断开事件
		 */
		public static const Event_Error_Connect:String = "Event_Error_Connect";
		
		//} 
		
    }
}

class CustomClient {
    public function onMetaData(info:Object):void {
        trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
    }
    public function onCuePoint(info:Object):void {
        trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    }
}




