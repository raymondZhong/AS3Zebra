/**
* 
* LICENSE ******************************************************************************
* 
* ① 此类为携带版变形工具类，所有用到的类都集成在一起~，所以阅读起来可能会不太方便。
* ② 基本上实现对选中DisplayObject进行缩放，旋转，变形,可轻松添加和移除控制；
* ③ 用法示例 usage：
	var _transfom:TansformTool = new TansformTool(root as DisplayObjectContainer);
	_transfom.AddControl( mc );
	_transfom.Init();
	//移除控制：_transfom.AddControl( mc );
	//移除_transfom：_transfom.Clear();
* 
*/

package zebra.system.util
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.ui.Mouse;

	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.events.IEventDispatcher;
		
	public class TansformTool 
	{
		private var _matrix:MatrixClass;
		private var _math:MathClass;
		private var _state:StateClass;
		private var _shape_arrow:ArrowShapeClass;
		private var _isInBounds:ContainPointClass;
		
		private var _shape_bounds:ShapeClass ;
	
		private var _Object_list:Array;
		private var _select_index:int;	
		private var _container:DisplayObject;
		
		public function TansformTool($containner:DisplayObjectContainer = null) 
		{	
			if (!$containner)
			{
				throw Error("please set containner first!");
				return;
			}
			_container = $containner
			_matrix = new MatrixClass();
			_math = new MathClass();
			_state = new StateClass();
			_shape_arrow = new ArrowShapeClass();
			_shape_bounds = new ShapeClass();
			_isInBounds = new ContainPointClass();
			
			_Object_list = new Array();
			_select_index = -1;
			
		}
		
		public function Init():void
		{
			_container.stage.addChild(_shape_bounds);
			_container.stage.addChild(_shape_arrow);
			
			_container.stage.addEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			_container.stage.addEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			_container.stage.addEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}
		
		public function Clear():void
		{
			_shape_arrow.Clear();
			_shape_bounds.Clear();
			
			_container.stage.removeChild(_shape_arrow);
			_container.stage.removeChild(_shape_bounds);
			
			_container.stage.removeEventListener( MouseEvent.MOUSE_MOVE, EventHadler);
			_container.stage.removeEventListener( MouseEvent.MOUSE_DOWN, EventHadler);
			_container.stage.removeEventListener( MouseEvent.MOUSE_UP, EventHadler);
		}	
		
		public function AddControl($disOjbect:DisplayObject):void {
			var $_index:int = FindIndex($disOjbect);
			var $_internalPoint:Point = new Point(0, 0);
			var $_externalPoint:Point = ($disOjbect.parent).globalToLocal($disOjbect.localToGlobal($_internalPoint));
			var $_matrix_obj:Object = _matrix.GetMatrix($disOjbect, $_internalPoint);
			
			if ($disOjbect is DisplayObjectContainer) {
				($disOjbect as DisplayObjectContainer).mouseChildren=false;
			}
			
			if ($_index==-1) {
				_Object_list.push(
					{
						obj        : $disOjbect, 
						state      : _state.normal,
						areanum    : -1,
						mousePoint0 : new Point(0, 0),
						mousePoint1 : new Point(0,0),
						internalPoint  : $_internalPoint,
						externalPoint  : $_externalPoint,
						initMatrix : $_matrix_obj,
						matrix     : $_matrix_obj
					}
				);
			}
		}
		
		public function RemoveControl($object:DisplayObject):void {
			var $_index:int=FindIndex($object);
			if ($_index != -1) 
			{
				_Object_list.splice($_index,1);
			}
		}
		
		private function EventHadler(evt:MouseEvent):void 
		{
			var $_target:*= evt.target;
			var $_type:String = evt.type;
			var $_disOjbect:DisplayObject;	
			var $_selectObject:DisplayObject;	
			var $_matrix:Object;
			var $_obj_info:Object;
			var $_index:int ;
			var $_state:String;
			var $_area_num:int;
			var $_inexistence :int = -1;
			
			evt.updateAfterEvent();
			$_disOjbect = $_target as DisplayObject;	
			
			if ($_type == "mouseDown") 
			{
				if (_select_index != $_inexistence )
				{
					$_obj_info = _Object_list[_select_index];
					$_state = $_obj_info["state"];
					if ($_state==_state.area)
					{
						$_obj_info["mousePoint0"] = new Point(_container.mouseX, _container.mouseY);
						$_obj_info["state"] = _state.change;
						return;
					}
				}
				
				$_index = FindIndex($_disOjbect);
				if ($_index != $_inexistence)
				{
					$_obj_info = _Object_list[$_index];
					$_state = $_obj_info["state"];
					
					if ($_state == _state.select)
					{
						$_obj_info["mousePoint0"] = new Point(_container.mouseX, _container.mouseY);
						$_obj_info["state"] = _state.drag ;
						//$_target.startDrag();
						
					}else{
						GraphicsClear();
					}
				}
			}
			else if ($_type == "mouseUp") 
			{
				if (_select_index != $_inexistence )
				{
					$_obj_info = _Object_list[_select_index];
					$_state = $_obj_info["state"];
					
					if ($_state==_state.change)
					{
						$_disOjbect = $_obj_info["obj"];
						$_obj_info["state"] = _state.select;
						$_obj_info["matrix"] = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
						_container.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
						//dispatchEvent(new MouseEvent("mouseMove"));
						
						return;
					}
				}
				
				$_index = FindIndex($_disOjbect);
				if ($_index != $_inexistence)
				{	
					(_select_index != -1) && (_select_index != $_index) && (_Object_list[_select_index]["state"] =  _state.normal );
					
					$_obj_info = _Object_list[$_index];
					$_matrix = $_obj_info["matrix"];
					$_state = $_obj_info["state"];
					
					if ( $_state == _state.drag)
					{
						ArrowClear();
						$_obj_info["state"]  = _state.select;
						$_obj_info["matrix"] = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
						$_obj_info["externalPoint"] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
						//$_target.stopDrag();
					}else {
						$_obj_info["state"]  = _state.select;
						_select_index = $_index;
						
						$_disOjbect.parent.addChild($_disOjbect);
						_shape_bounds.parent.addChild(_shape_bounds);
						_shape_arrow.parent.addChild(_shape_arrow);
						
						$_obj_info["matrix"]["array"][4] = ($_disOjbect.parent).globalToLocal($_disOjbect.localToGlobal($_obj_info["internalPoint"]));
						GraphicsDraw($_matrix);
						
					}
				}else
				{
					(_select_index != $_inexistence) && (_Object_list[_select_index]["state"] =  _state.normal );
					_select_index = $_inexistence;
					GraphicsClear();
					ArrowClear();
				}
				
			}else if ($_type == "mouseMove") 
			{
				if (_select_index != $_inexistence)
				{
					$_obj_info  = _Object_list[_select_index];
					$_disOjbect = $_obj_info["obj"];
					$_matrix    = $_obj_info["matrix"];
					$_state     = $_obj_info["state"];
					$_area_num  = GetAreaNum($_matrix);
					
					if ($_state == _state.change)
					{
						$_area_num  = $_obj_info["areanum"];
						ArrowMove();
						SetChange(_select_index, $_area_num);
						$_matrix    = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
						GraphicsDraw($_matrix);
					}else if ($_state == _state.drag)
					{
						SetMove(_select_index);
						ArrowShow(_shape_arrow.Bmp_move);
						ArrowMove();
						$_matrix    = _matrix.GetMatrix($_disOjbect,$_obj_info["internalPoint"]);
						GraphicsDraw($_matrix);
					}else if ($_area_num!=$_inexistence)
					{
						$_obj_info["areanum"] = $_area_num;
						$_obj_info["state"] = _state.area;
						
						var $_tmp_bmp:BitmapData = GetArrowBmp($_matrix, $_area_num);
						var $_isOrigin:Boolean = $_area_num == 4 ? true : false;
						if ($_tmp_bmp != null) 
						{
							ArrowShow($_tmp_bmp,$_isOrigin);
							ArrowMove();
						}else 
						{
							ArrowClear();
						}
						
					}else
					{
						$_obj_info["state"] = _state.select;
						ArrowClear();
					}
				
				}
			}
			return;
		}
		//-----------------------------------------------------------------------
		private function SetMove($index:int):void
		{
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];
			var $_mousePoint1:Point = new Point(_container.mouseX, _container.mouseY);
			var $_matrix:Object =  $_obj_info["matrix"];
			$_disOjbect.x = $_matrix["tx"] + $_mousePoint1.x -$_mousePoint0.x;
			$_disOjbect.y = $_matrix["ty"] + $_mousePoint1.y -$_mousePoint0.y;
		}
		private function SetMidPoint($index:int):void 
		{	
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			$_obj_info["externalPoint"].x = _container.mouseX;
			$_obj_info["externalPoint"].y = _container.mouseY;
			$_obj_info["internalPoint"] = ($_disOjbect).globalToLocal(($_disOjbect.parent).localToGlobal($_obj_info["externalPoint"]));
		}
		private function SetChange($index:int, $area_num:int):void 
		{
			//   ------------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ------------------
			var $_type:String;
			if ($area_num == 4) 
			{
				$_type = "setMidPoint" ;
				SetMidPoint($index);
				return;
			}else if ($area_num == 0 || $area_num == 8 || $area_num == 2 || $area_num == 6) 
			{
				$_type = "scale";
			} else if ($area_num == 1 || $area_num == 7 ) 
			{
				$_type = "xscale";
			} else if ($area_num == 3 || $area_num == 5 )
			{
				$_type = "yscale";
			} else if ($area_num == 9 || $area_num == 10) 
			{
				$_type = "yskew";
			} else if ($area_num == 11 || $area_num == 12) 
			{
				$_type = "xskew";
			} else if ($area_num == 13) 
			{
				$_type = "rotation";
			} else{
				return;
			}
			
			var $_obj_info:Object = _Object_list[$index];
			var $_disOjbect:DisplayObject = $_obj_info["obj"];
			
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_internalPoint:Point = $_obj_info["internalPoint"];
			var $_externalPoint:Point = $_obj_info["externalPoint"];
			
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];
			var $_mousePoint1:Point = new Point(_container.mouseX, _container.mouseY);
			$_obj_info["mousePoint1"] =  $_mousePoint1;
			
			var $_minW:int = 8 ;
			var $_minH:int = 8 ;
			var $_objW:int ;
			var $_objH:int ;
			
			var $_tx:Number = $_matrix["tx"];
			var $_ty:Number = $_matrix["ty"];
			var $_scalex:Number = $_matrix["scalex"];
			var $_scaley:Number = $_matrix["scaley"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_angle0:Number;
			var $_angle1:Number;
			var $_tmp_obj:Object;
			
			switch ($_type) {
				case "xscale" :
					$_scalex = GetNewScaleX($index, $area_num);
					break;
					
				case "yscale" :
					$_scaley = GetNewScaleY($index, $area_num);
					break;
					
				case "scale" :
					$_scalex = GetNewScaleX($index, $area_num);
					$_scaley = GetNewScaleY($index, $area_num);
					break;
					
				case "rotation" :
					$_angle0 = _math.GetAngle($_mousePoint0, $_externalPoint);
					$_angle1 = _math.GetAngle($_mousePoint1, $_externalPoint);
					$_skewx  = $_skewx + $_angle1 - $_angle0;
					$_skewy  = $_skewy + $_angle1 - $_angle0;
					break;
				case "xskew" :
					$_tmp_obj = GetNewSkewY($index, $area_num);
					$_skewx  = $_tmp_obj["skewx"];
					$_scaley = $_tmp_obj["scaley"];
					break;
				case "yskew" :
					$_tmp_obj = GetNewSkewX($index, $area_num);
					$_skewy  = $_tmp_obj["skewy"];
					$_scalex = $_tmp_obj["scalex"];
					break;
				default :
					break;
			}
			$_objW = $_matrix["w"] * $_scalex;
			$_objH = $_matrix["h"] * $_scaley;
			($_objW < $_minW && $_objW > -$_minW) && ( $_scalex = $_minW / $_matrix["w"] * $_objW / Math.abs($_objW));
			($_objH < $_minH && $_objH > -$_minH) && ( $_scaley = $_minH / $_matrix["h"] * $_objH / Math.abs($_objH));
			_matrix.SetMatrix($_disOjbect, $_tx, $_ty, $_scalex, $_scaley, $_skewx, $_skewy);
			_matrix.SetMidPoint($_disOjbect, $_internalPoint, $_externalPoint);
			
		}
		//-----------------------------------------------------------------------
		private function GetNewSkewX($index:int, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 9 ? 1 : 7; 
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_scalex:Number = $_matrix["scalex"];
		
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];	
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];	

			var $_mp0:Point = _math.GetCrossPoint( $_mousePoint0, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp1:Point = _math.GetCrossPoint( $_mousePoint0, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp2:Point = _math.GetCrossPoint( $_mousePoint1, $_skewy, $_midPoint, $_skewx + 90);
			var $_mp3:Point = _math.GetCrossPoint( $_mousePoint1, $_skewy, $_areaPoint, $_skewx + 90);
			
			var $_angle:Number ;
			var $_angle0:Number = _math.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = _math.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[1], $_skewx + 90);
			var $_tmp_point1:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[7], $_skewx + 90);
			
			var $_s0:Number = _math.GetPos( $_array[1], $_array[7]);
			var $_s1:Number = _math.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = _math.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isLeft :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isRight :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			//trace($_s0, $_s1);
			
			if ($area_num == 9)
			{
				$_angle = $_angle0;
				($_isLeft) && ($_angle = $_angle1);
			}else if ($area_num == 10)
			{
				$_angle = $_angle1;
				($_isRight) && ($_angle = $_angle0);
			}
			//trace($_mp0,$_mp1,$_mp2,$_mp3);
			//trace($area_num,$_angle);
			
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewy  = $_angle;
				$_mp0 = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[0], $_skewx + 90);
				$_mp1 = _math.GetCrossPoint( $_midPoint, $_skewy, $_array[8], $_skewx + 90);
				$_scalex = _math.GetPos($_mp0, $_mp1) / $_matrix["w"];
			}
			
			return {skewy:$_skewy, scalex:$_scalex};
		}
		private function GetNewSkewY($index:int, $area_num:int):Object
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_num:int = $area_num == 11 ? 3 : 5; 
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix["skewx"];
			var $_skewy:Number = $_matrix["skewy"];
			var $_scaley:Number = $_matrix["scaley"];
			
			var $_midPoint:Point = $_array[4];
			var $_areaPoint:Point= $_array[$_num];
			var $_mousePoint0:Point = $_obj_info["mousePoint0"];	
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];	

			var $_mp0:Point = _math.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp1:Point = _math.GetCrossPoint( $_mousePoint0, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp2:Point = _math.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_midPoint, $_skewy);
			var $_mp3:Point = _math.GetCrossPoint( $_mousePoint1, $_skewx + 90, $_areaPoint, $_skewy);
			
			var $_angle:Number ;
			var $_angle0:Number = _math.GetAngle($_mp3, $_mp0);
			var $_angle1:Number = _math.GetAngle($_mp0, $_mp3);
			
			var $_tmp_point0:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[3], $_skewy);
			var $_tmp_point1:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[5], $_skewy);
			
			var $_s0:Number = _math.GetPos( $_array[3], $_array[5]);
			var $_s1:Number = _math.GetPos( $_midPoint, $_tmp_point0);
			var $_s2:Number = _math.GetPos( $_midPoint, $_tmp_point1);
			
			var $_isUp :Boolean = $_s2 > $_s0 && $_s2 > $_s1 ;
			var $_isDown :Boolean = $_s1 > $_s0 && $_s1 > $_s2 ;
			
			if ($area_num == 11)
			{
				$_angle = $_angle0;
				($_isUp) && ($_angle = $_angle1);
			}else if ($area_num == 12)
			{
				$_angle = $_angle1;
				($_isDown) && ($_angle = $_angle0);
			}
			
			//trace($_mp0,$_mp1,$_mp2,$_mp3);
			//trace($_angle);
			if (int($_mp0.x-$_mp1.x)!=0 || int($_mp0.y-$_mp1.y)!=0)
			{
				$_skewx  = $_angle-90;
				$_mp0 = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[0], $_skewy);
				$_mp1 = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_array[8], $_skewy);
				
				$_scaley =  _math.GetPos($_mp0, $_mp1) / $_matrix["h"];
				
			}
			return { skewx:$_skewx, scaley:$_scaley };
		}
		
		private function GetNewScaleX($index:int, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix.skewx;
			var $_skewy:Number = $_matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_areaPoint, $_skewx + 90);
			var $_mp1:Point = _math.GetCrossPoint( $_midPoint, $_skewy, $_mousePoint1, $_skewx + 90);
			
			var $_s0:Number = _math.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = _math.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = _math.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scalex:Number = $_matrix.scalex;
			($_s0 > 1 || $_s0 < -1) && ( $_scalex  = $_scalex *($_s1/$_s0) * $_vetor);	
			return $_scalex;
		}
		
		private function GetNewScaleY($index:int, $area_num:int):Number
		{
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			var $_obj_info:Object = _Object_list[$index];
			var $_matrix:Object = $_obj_info["matrix"];
			var $_array:Array = $_matrix["array"];
			var $_skewx:Number = $_matrix.skewx;
			var $_skewy:Number = $_matrix.skewy;
			
			var $_midPoint:Point = $_array[4];
			var $_mousePoint1:Point = $_obj_info["mousePoint1"];
			var $_areaPoint:Point= $_array[$area_num];
			
			var $_mp0:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_areaPoint, $_skewy);
			var $_mp1:Point = _math.GetCrossPoint( $_midPoint, $_skewx + 90, $_mousePoint1, $_skewy);
			
			var $_s0:Number = _math.GetPos( $_midPoint, $_mp0);
			var $_s1:Number = _math.GetPos( $_midPoint, $_mp1);
			var $_s3:Number = _math.GetPos( $_mp0, $_mp1);
			var $_vetor:int = ($_s3 > $_s1)&&($_s3 > $_s0) ? -1 :1;
			
			var $_scaley:Number = $_matrix.scaley;
			($_s0 > 1 || $_s0 < -1) && ($_scaley  = $_scaley *($_s1 / $_s0 ) * $_vetor) ;
			return $_scaley;
		}
		
		private function GetAreaNum($matrix:Object):int
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			
			var $_arr:Array = $matrix["array"];
			var $_testPoint:Point = new Point(_container.mouseX, _container.mouseY);
			var $_areaPoint:Point ;
			var $_isTrue:Boolean ;
			var $_obj_size0:uint = $matrix["w"] * $matrix["scalex"] * 0.25;
			var $_obj_size1:uint = $matrix["h"] * $matrix["scaley"] * 0.25;
			var $_block_size0:uint = 10;
			var $_block_size1:uint = 10;
			var $_block_size2:uint = 8;
			var $_block_size3:uint = 8;
			var $_block_size4:uint = 15;
			
			//trace($_block_size0);
			($_obj_size0 < 10) && ($_block_size0 = $_obj_size0);
			($_obj_size1 < 10) && ($_block_size1 = $_obj_size1);
			($_obj_size0 < 8) && ($_block_size2 = $_obj_size0);
			($_obj_size1 < 8) && ($_block_size3 = $_obj_size1);
			
			var $_p_arr0:Array = new Array(
				new Point($_arr[0].x - $_block_size0, $_arr[0].y),
				new Point($_arr[0].x + $_block_size0, $_arr[0].y),
				new Point($_arr[2].x - $_block_size0, $_arr[2].y),
				new Point($_arr[2].x + $_block_size0, $_arr[2].y)
			);
			
			var $_p_arr1:Array = new Array(
				new Point($_arr[6].x - $_block_size0, $_arr[6].y),
				new Point($_arr[6].x + $_block_size0, $_arr[6].y),
				new Point($_arr[8].x - $_block_size0, $_arr[8].y),
				new Point($_arr[8].x + $_block_size0, $_arr[8].y)
			);
			
			var $_p_arr2:Array = new Array(
				new Point($_arr[0].x , $_arr[0].y - $_block_size1),
				new Point($_arr[0].x , $_arr[0].y + $_block_size1),
				new Point($_arr[6].x , $_arr[6].y - $_block_size1),
				new Point($_arr[6].x , $_arr[6].y + $_block_size1)
			);
			
			var $_p_arr3:Array = new Array(
				new Point($_arr[2].x , $_arr[2].y - $_block_size1),
				new Point($_arr[2].x , $_arr[2].y + $_block_size1),
				new Point($_arr[8].x , $_arr[8].y - $_block_size1),
				new Point($_arr[8].x , $_arr[8].y + $_block_size1)
			);
			
			var $_p_bounds:Array = new Array($_arr[0],$_arr[6],$_arr[2],$_arr[8]);
			
			var $_len:int = $_arr.length;
			while ($_len--)
			{
				$_areaPoint = $_arr[$_len];
				$_isTrue = _isInBounds.IsInRect($_testPoint, $_areaPoint, $_block_size2, $_block_size3);
				if ($_isTrue)
				{
					return $_len;
				}
			}
			//----------------
			if (_isInBounds.IsInBouds($_testPoint, $_p_arr0)) 
			{
				return 9;
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr1)) 
			{
				return 10;
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr2)) 
			{
				return 11;
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_arr3)) 
			{
				return 12;
			} else if (_isInBounds.IsInBouds($_testPoint, $_p_bounds)) 
			{
				return -1;
			}
			//----------------
			var $_isTrue0:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[0], $_block_size4, $_block_size4);
			var $_isTrue1:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[2], $_block_size4, $_block_size4);
			var $_isTrue2:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[6], $_block_size4, $_block_size4);
			var $_isTrue3:Boolean = _isInBounds.IsInRect($_testPoint, $_arr[8], $_block_size4, $_block_size4);
			if ($_isTrue0 || $_isTrue1 || $_isTrue2 || $_isTrue3)
			{
				return 13;
			}
			
			return -1;
		}
		
		private function GetArrowBmp($matrix:Object, $areanum:int):BitmapData
		{
			//   $areanum--------------
			//   [0] 11 [3] 11 [6]
			//    9			   10
			//   [1]    [4]    [7]
			//    9            10
			//   [2] 12 [5] 12 [8] [13]
			//   ----------------------
			
			var $_skewx:Number = $matrix["skewx"];
			var $_skewy:Number = $matrix["skewy"];
			var $_angle:Number;
			var $_bmp:BitmapData;
			
			if ($areanum == 4 ) 
			{
				$_bmp = _shape_arrow["Bmp_cursor"];
			}else if ( $areanum == 0 || $areanum == 8 )
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 45 );
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 2 || $areanum == 6 ) 
			{
				$_angle = GetNearAngle(($_skewx + $_skewy )* 0.5 + 135);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 1 || $areanum == 7 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 3 || $areanum == 5 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_resize" + $_angle]);
			}else if ($areanum == 9 || $areanum == 10 ) 
			{
				$_angle = GetNearAngle($_skewx+270);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 11 || $areanum == 12 ) 
			{
				$_angle = GetNearAngle($_skewy);
				($_angle!=-1) && ($_bmp = _shape_arrow["Bmp_skew" + $_angle]);
			}else if ($areanum == 13 ) 
			{
				$_bmp = _shape_arrow["Bmp_rotation"];
			}
			
			return $_bmp;
			
		}
		
		private function GetNearAngle($angle:Number):Number
		{
			var $_arr:Array = new Array(0, 45, 90, 135, 180);
			var $_len:int = $_arr.length;
			var $_min:Number = Number.POSITIVE_INFINITY;
			var $_gap:Number;
			var $_re_num:Number = -1;
			
			$angle = $angle % 360;
			($angle < 0) && ($angle = 360 + $angle);
			($angle > 180) && ($angle =  $angle-180);
			
			while ($_len--)
			{
				$_gap = $angle-$_arr[$_len];
				($_gap < 0) && ($_gap = -$_gap);
				if ($_min > $_gap)
				{
					$_min = $_gap;
					$_re_num = $_arr[$_len];
				}
			}
			($_re_num == 180) && ($_re_num = 0);
			return $_re_num;
			
		}
		//----------------------------------------------------------------------------
		private function ArrowMove():void
		{
			_shape_arrow.x = _container.mouseX;
			_shape_arrow.y = _container.mouseY;
		}
		private function ArrowShow($bmp:BitmapData, $isOrigin:Boolean = false):void
		{
			//var $_bmp:BitmapData = _arr_bmp[$index];
			_shape_arrow.Show($bmp,$isOrigin);
			Mouse.hide();
		}
		private function ArrowClear():void
		{
			_shape_arrow.Clear();
			Mouse.show();
		}
		//----------------------------------------------------------------------------
			
		private function FindIndex($object:DisplayObject):int 
		{
			var $_len:int=_Object_list.length;
			while ($_len--) {
				var $_object:Object=_Object_list[$_len];
				if ($_object["obj"] == $object) {
					return $_len;
				}
			}
			return -1;
		}
		
		//----------------------------------------------------------------------
		
		private function GraphicsClear():void
		{
			_shape_bounds.Clear();
		}
		
		private function GraphicsDraw($matrix:Object):void
		{
			var $_block_size:Number = 3;
			var $_arr:Array = $matrix["array"];
			var $_len:int = $_arr.length;
			_shape_bounds.Clear();
			
			var $_tmp_arr:Array = new Array($_arr[0], $_arr[2], $_arr[8], $_arr[6]);
			_shape_bounds.CreateLine($_tmp_arr);
			while ($_len--)
			{
				
				if ($_len != 4)
				{
					_shape_bounds.CreateRect($_arr[$_len].x-$_block_size, $_arr[$_len].y-$_block_size, $_block_size*2, $_block_size*2);
					//_shape_bounds.CreateCircle($_arr[$_len].x, $_arr[$_len].y, $_block_size, 0x0, 1, 0xffffff);
				}
			}
			_shape_bounds.CreateCircle($_arr[4].x, $_arr[4].y, $_block_size, 0xffffff, 1, 0x0);
		}
		
	}
}

//====================================================
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
//====================================================

	internal class StateClass 
	{
		private const STATE_NORMAL:String="on_normal";
		private const STATE_SELECT:String="on_select";
		private const STATE_AREA:String="on_area";
		private const STATE_DRAG:String="on_drag";
		private const STATE_CHANGE:String = "on_change";
		
		
		public function get normal():String
		{
			return STATE_NORMAL;
		}
		
		public function get select():String
		{
			return STATE_SELECT;
		}
		
		public function get area():String
		{
			return	STATE_AREA;
		}
		
		public function get drag():String
		{
			return	STATE_DRAG;
		}
		
		public function get change():String
		{
			return	STATE_CHANGE;
		}
		
	}
	
//====================================================

	internal class BmpCode 
	{
		//--------------------------------
		public function decode($str:String):BitmapData 
		{
			var $_Bmp_array:Array = $str.split(" ");
			var $_w:int=$_Bmp_array[0];
			var $_h:int=$_Bmp_array[1];
			var $_Bmp_data:BitmapData = new BitmapData($_w,$_h,true,0x0);
			var $_Bmp_num:int=2;
			$_Bmp_data.lock();
			for (var i:int=0; i<$_w; i++) {
				for (var j:int=0; j<$_h; j++) {
					$_Bmp_data.setPixel32(i,j,uint("0x"+$_Bmp_array[$_Bmp_num]));
					$_Bmp_num++;
				}
			}
			$_Bmp_data.unlock();
			return $_Bmp_data;
		}
	}
	
//====================================================
	
	internal class ArrowShapeClass extends Shape 
	{
		
		private const _STR_MOVE:String = "19 19 0 0 0 0 0 0 0 b8b8b8b 15000000 b2e2e2e 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 b464646 34050505 fffcfcfc 34000000 b8b8b8b 0 0 0 0 0 0 0 0 0 0 0 0 0 b000000 340f0f0f ffffffff f9000000 ffffffff 34000000 bd1d1d1 0 0 0 0 0 0 0 0 0 0 0 b000000 342c2c2c fff1f1f1 fe000000 ff030303 fe000000 ffdcdcdc 340f0f0f b000000 0 0 0 0 0 0 0 0 0 b000000 34191919 fffbfbfb ff060606 ff000000 ff080808 ff000000 ff080808 ffededed 34000000 b000000 0 0 0 0 0 0 0 b000000 34000000 ffffffff ffefefef fff6f6f6 fff2f2f2 ff030303 fff9f9f9 fff1f1f1 fff2f2f2 ffffffff 34000000 b8b8b8b 0 0 0 0 0 b747474 34000000 ffffffff ff000000 fff4f4f4 690a0a0a 690a0a0a ff000000 690c0c0c 69000000 fff2f2f2 ff000000 fffbfbfb 340a0a0a b000000 0 0 0 b747474 34050505 ffffffff ff000000 ff010101 fff3f3f3 ffffffff ffffffff ff020202 fffcfcfc ffffffff fff1f1f1 ff050505 ff000000 ffffffff 34000000 b5d5d5d 0 0 15000000 fffcfcfc ff040404 ff040404 ff020202 ff000000 ff030303 ff000000 ff040404 ff010101 ff050505 ff000000 ff020202 ff020202 ff000000 fffbfbfb 15000000 0 0 b2e2e2e 34000000 ffffffff ff000000 ff000000 fff8f8f8 fffefefe fff9f9f9 ff0b0b0b fff7f7f7 ffffffff fff9f9f9 ff000000 ff050505 fffefefe 340a0a0a b171717 0 0 0 ba2a2a2 34000000 fff9f9f9 ff080808 fff4f4f4 69020202 69000000 ff020202 690c0c0c 69000000 fff3f3f3 ff000000 ffffffff 34000000 b000000 0 0 0 0 0 b000000 34535353 fff8f8f8 fffafafa fff4f4f4 fff4f4f4 ff000000 ffffffff fffafafa fffafafa fffcfcfc 340a0a0a b464646 0 0 0 0 0 0 0 b000000 34222222 ffffffff ff000000 ff000000 ff020202 ff000000 ff020202 fffefefe 34000000 b000000 0 0 0 0 0 0 0 0 0 b8b8b8b 34000000 ffffffff fe000000 ff000000 fe060606 fff9f9f9 34272727 b464646 0 0 0 0 0 0 0 0 0 0 0 b000000 340a0a0a ffffffff f9000000 ffffffff 34000000 b000000 0 0 0 0 0 0 0 0 0 0 0 0 0 b000000 34000000 ffffffff 34000000 b171717 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 b5d5d5d 15000000 b171717 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_ROTATION:String = "19 16 0 0 0 0 0 bd1d1d1 15000000 b000000 0 0 0 0 0 0 0 0 0 0 0 0 b000000 36000000 ffffffff 34000000 ba2a2a2 0 0 0 0 0 0 0 0 0 0 0 21080808 ffffffff ff000000 fffefefe 340f0f0f b2e2e2e 0 0 0 0 0 0 0 0 0 b8b8b8b 41000000 ffffffff ff000000 ff000000 fffdfdfd 34141414 b2e2e2e 0 0 0 0 0 0 0 b000000 361c1c1c fff4f4f4 ffffffff ff000000 ff000000 ff0a0a0a fff1f1f1 341d1d1d b000000 0 0 0 0 0 b171717 36000000 ffffffff ff020202 ff000000 ff000000 ff010101 ff000000 ff000000 fffbfbfb 153d3d3d 0 0 0 0 b000000 36262626 fffafafa ff020202 ff060606 fff4f4f4 ff070707 ff000000 ff020202 ffffffff 3f000000 21000000 b000000 0 0 0 20101010 fffbfbfb ff080808 ff000000 fff8f8f8 ffffffff ff000000 ff020202 fffdfdfd 3f000000 41080808 fffefefe 35000000 b171717 0 0 2a000000 ffffffff ff000000 ffffffff 5d080808 fffcfcfc ff000000 fffefefe 34000000 2b2f2f2f ffffffff ff000000 ffffffff 20000000 0 0 2a000000 ffffffff ff060606 fff6f6f6 34191919 34000000 fff9f9f9 34000000 b000000 2c000000 ffffffff ff000000 fffbfbfb 2a121212 0 0 2a0c0c0c ffffffff ff000000 ffffffff 2a1e1e1e b000000 150c0c0c b171717 0 2c000000 ffffffff ff010101 ffffffff 2a000000 0 0 2a060606 ffffffff ff000000 ffffffff 3f000000 bd1d1d1 0 0 b2e2e2e 41000000 ffffffff ff050505 fff8f8f8 2a2a2a2a 0 0 20000000 fff7f7f7 ff030303 ff000000 ffffffff 3f101010 2b060606 2c000000 410c0c0c ffffffff ff000000 ff030303 fff5f5f5 20181818 0 0 b8b8b8b 34000000 ffffffff ff010101 ff050505 fffcfcfc fffefefe ffffffff fffefefe ff000000 ff0a0a0a fff7f7f7 34000000 b5d5d5d 0 0 0 b000000 34000000 ffffffff ff000000 ff000000 ff000000 ff000000 ff010101 ff010101 ffffffff 34000000 b2e2e2e 0 0 0 0 0 b8b8b8b 35000000 ffffffff fffbfbfb ffffffff ffffffff fff9f9f9 ffffffff 34000000 bb9b9b9 0 0 0 0 0 0 0 b000000 20181818 2a000000 2a121212 2a0c0c0c 2a000000 20181818 b000000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_RESIZE0:String = "18 11 0 0 0 0 b000000 15000000 b171717 0 0 0 0 0 0 0 b8b8b8b 33000000 ffffffff 33141414 b000000 0 0 0 0 0 b000000 34050505 ffffffff f1000000 ffffffff 34050505 b000000 0 0 0 b000000 34272727 fff7f7f7 fa000000 ff000000 fa060606 fffefefe 34000000 bffffff 0 b000000 34191919 fff9f9f9 ff060606 ff000000 ff050505 ff010101 ff030303 ffffffff 34000000 b5d5d5d 20202020 fff8f8f8 ff080808 ff000000 ff000000 ff030303 ff030303 ff000000 ff000000 ffffffff 20000000 20080808 ffffffff ffffffff fffefefe fffefefe ff010101 fffafafa ffffffff ffffffff ffffffff 20000000 b464646 20000000 2a373737 49000000 ffffffff ff000000 ffffffff 48000000 2a060606 20000000 b747474 0 0 0 2a121212 ffffffff ff000000 ffffffff 29060606 0 0 0 0 0 0 2a000000 fff9f9f9 ff070707 fff5f5f5 29191919 0 0 0 b000000 20181818 2a000000 49070707 ffffffff ff000000 ffffffff 48000000 2a060606 20000000 ba2a2a2 20383838 fffbfbfb ffffffff fffcfcfc fff9f9f9 ff030303 fffafafa ffffffff fffefefe ffffffff 20000000 20000000 ffffffff ff000000 ff010101 ff000000 ff000000 ff020202 ff010101 ff000000 ffffffff 20000000 b000000 34313131 fff5f5f5 ff0a0a0a ff000000 ff030303 ff000000 ff000000 fff8f8f8 342c2c2c b000000 0 bffffff 34000000 ffffffff fa000000 ff000000 fa030303 ffffffff 34141414 b2e2e2e 0 0 0 b000000 340a0a0a ffffffff f1000000 ffffffff 34000000 b000000 0 0 0 0 0 b2e2e2e 33000000 ffffffff 33000000 b171717 0 0 0 0 0 0 0 b464646 15000000 b000000 0 0 0 0 ";
		private const _STR_RESIZE135:String = "14 14 0 0 0 0 b2e2e2e 20000000 2a060606 2a0c0c0c 2a000000 2a060606 2a000000 2a434343 20000000 b464646 0 0 0 0 15181818 fffcfcfc fffdfdfd ffffffff fffdfdfd fffefefe fffefefe ffffffff fff7f7f7 20181818 0 0 0 0 b171717 340a0a0a fffefefe ff020202 ff000000 ff000000 ff0b0b0b ff000000 ffffffff 2a000000 0 0 0 0 0 b000000 340a0a0a ffffffff ff010101 ff000000 ff000000 ff070707 fff9f9f9 2a181818 b747474 15000000 b171717 0 0 0 153d3d3d 54000000 ffffffff ff040404 ff000000 ff020202 fff8f8f8 2a2a2a2a 20000000 ffffffff 34000000 bffffff 0 b000000 34000000 ffffffff ff000000 ffffffff ff000000 ff060606 fffbfbfb 2a000000 2a000000 ffffffff ffffffff 34000000 15797979 34000000 ffffffff ff020202 fffbfbfb 54060606 fffcfcfc ff000000 ffffffff 2a000000 2a121212 ffffffff ff050505 fffefefe 541b1b1b fff8f8f8 ff000000 ffffffff 34000000 15000000 340f0f0f ffffffff ffffffff 2a060606 2a060606 fffefefe ff000000 ff030303 ffffffff ff000000 ffffffff 34000000 b2e2e2e 0 b000000 34404040 fff7f7f7 20202020 2a0c0c0c ffffffff ff000000 ff010101 ff000000 ffffffff 54030303 153d3d3d 0 0 0 b171717 15313131 b171717 2a373737 fffbfbfb ff030303 ff040404 ff000000 ff000000 fffefefe 340a0a0a b171717 0 0 0 0 0 2a000000 ffffffff ff020202 ff080808 ff000000 ff000000 ff000000 ffffffff 34000000 b464646 0 0 0 0 20000000 ffffffff fffbfbfb ffffffff fffafafa ffffffff ffffffff ffffffff ffffffff 15000000 0 0 0 0 b000000 20585858 2a000000 2a060606 2a000000 2a060606 2a000000 2a060606 20000000 b8b8b8b 0 0 0 0 ";
		private const _STR_RESIZE90:String = "11 18 0 0 0 0 b000000 20080808 20000000 b000000 0 0 b000000 20404040 20000000 b5d5d5d 0 0 0 0 0 0 0 b000000 34363636 fffafafa fffbfbfb 20202020 0 0 20303030 fff8f8f8 fffcfcfc 34191919 b000000 0 0 0 0 0 b000000 34272727 fffafafa ff090909 fff5f5f5 2a0c0c0c 0 0 2a000000 ffffffff ff000000 ffffffff 34000000 b171717 0 0 0 bffffff 34000000 ffffffff ff060606 ff000000 ffffffff 49000000 2a000000 2a0c0c0c 49000000 fffefefe ff020202 ff080808 fff8f8f8 340a0a0a b5d5d5d 0 b171717 34141414 fffefefe ff020202 ff010101 ff020202 ffffffff fffdfdfd ffffffff fffdfdfd ffffffff fffafafa ff000000 ff020202 ff000000 ffffffff 34000000 bd1d1d1 15000000 ffffffff ff000000 ff000000 ff010101 ff000000 ff010101 ff020202 ff030303 ff000000 ff000000 ff050505 ff000000 ff000000 ff050505 ff020202 fffefefe 15000000 b000000 341d1d1d fffefefe ff000000 ff000000 ff070707 fff9f9f9 fffdfdfd ffffffff ffffffff ffffffff fff4f4f4 ff040404 ff000000 ff070707 fffdfdfd 34000000 b747474 0 b000000 340a0a0a ffffffff ff060606 ff000000 ffffffff 49000000 2a000000 2a242424 49000000 ffffffff ff000000 ff000000 fff9f9f9 340f0f0f b000000 0 0 0 b8b8b8b 34000000 ffffffff ff000000 ffffffff 2a000000 0 0 2a000000 ffffffff ff000000 fffdfdfd 34191919 b000000 0 0 0 0 0 b000000 34050505 ffffffff fffbfbfb 20101010 0 0 20000000 ffffffff fffefefe 34363636 b000000 0 0 0 0 0 0 0 b000000 20000000 20303030 b171717 0 0 b5d5d5d 20000000 20000000 bd1d1d1 0 0 0 0 ";
		private const _STR_RESIZE45:String = "14 14 b2e5d00 20081800 2a243100 2a061200 2a434900 2a060c00 2a242a00 2a060600 20080800 b462e00 0 0 0 0 20203000 fff5f7e2 ffffffed fff9fae8 fffafbe9 fffcfded fff5f6e8 fffffff4 fff7f7ef 15796d31 0 0 0 0 2a0c1200 fffbfcec ff010200 ff040500 ff010200 ff010100 ff050500 fff9f9f1 340f0a00 b462e00 0 0 0 0 2a1e2400 fff5f6e4 ff010200 ff060700 ff010200 ff080800 fff5f5eb 34191900 b464600 0 0 0 0 0 2a556100 fff2f4df ff050600 ff010200 ff040500 fff8f9e9 541b1e00 150c1800 0 0 0 b2e2e00 150c0c00 b170000 2a061200 ffffffec ff010300 ff030500 ffffffed ff010200 fffeffed 340a0f00 b465d00 0 bd1d100 34050500 fffffff4 20080800 2a061200 ffffffec ff010300 fffafce7 54181e00 fff7f9e4 ff050700 fff9fae8 34141900 15182400 34050a00 fffdfeee fffafbeb 2a060c00 2a181e00 fffbfcea fffcfdeb 34050a00 150c1800 34050a00 fffdfeec ff010200 fff9faea 541b1e00 fff8f9e9 ff060700 fffafbeb 2a060c00 20303000 fff4f4e8 34363600 b171700 0 bb9b900 34050500 fff9f9ed ff010200 fffffff3 ff050600 ff010200 fffffff3 2a060c00 b2e2e00 15242400 b5d5d00 0 0 0 156d6d00 54030300 fffdfdf1 ff010100 ff010100 ff010100 fffffff3 2a1e2400 0 0 0 0 0 b171700 34050500 fff9f9ef ff020200 ff010100 ff0c0d00 ff010200 fffdfef0 2a0c1200 0 0 0 0 ba28b17 34050000 fffffff8 ff010100 ff010100 ff010100 ff030400 ff070800 fff8f9e9 2a060c00 0 0 0 0 150c0000 fffffffa fff8f8f0 fffefef4 fffffff4 fff7f7eb fffffff3 ffeaebdb ffffffef 20081000 0 0 0 0 bd1b946 20080800 2a060600 2a0c0c00 2a0c0c00 2a1e2400 2a060c00 2a060c00 20283800 b174600 ";
		private const _STR_SKEW0:String = "18 11 0 0 0 b000000 20202020 20000000 b000000 0 0 0 0 0 0 bffffff 340f0f0f fffcfcfc ffffffff 3f000000 20000000 b000000 0 0 0 b747474 34050505 ffffffff ff000000 fffbfbfb ffffffff ffffffff 20000000 0 0 b000000 34000000 ffffffff ff000000 ff060606 fffafafa ff060606 ffffffff 2a000000 0 0 20000000 ffffffff ff040404 ff000000 ff111111 fff0f0f0 ff0b0b0b fffdfdfd 2a000000 0 0 2a000000 fff8f8f8 ff030303 ffffffff ff000000 ffffffff ff000000 ffffffff 2a000000 0 0 20383838 fffafafa fffafafa ffffffff ff000000 ffffffff ff020202 ffffffff 2a000000 0 0 b747474 20000000 49000000 ffffffff ff000000 ffffffff ff000000 fffefefe 2a000000 0 0 0 0 2a373737 fff9f9f9 ff040404 fffdfdfd ff000000 fffefefe 2a000000 0 0 0 0 2a000000 ffffffff ff030303 fffbfbfb ff010101 fffcfcfc 2a121212 0 0 0 0 2a000000 ffffffff ff050505 fff9f9f9 ff040404 ffffffff 49000000 20383838 b000000 0 0 2a000000 ffffffff ff000000 ffffffff ff000000 ffffffff ffffffff ffffffff 20000000 0 0 2a0c0c0c fffdfdfd ff030303 fffefefe ff010101 fffcfcfc ff000000 ffffffff 20000000 0 0 2a000000 ffffffff ff000000 ffffffff ff000000 ff010101 ff000000 3f1c1c1c b000000 0 0 2a000000 ffffffff ff000000 ffffffff ff030303 ff000000 ffffffff 20000000 0 0 0 20000000 fffefefe fffbfbfb ffffffff ff000000 ffffffff 34000000 b5d5d5d 0 0 0 b747474 20080808 3f080808 fffafafa ffffffff 340f0f0f b000000 0 0 0 0 0 0 b000000 20484848 20000000 b000000 0 0 0";
		private const _STR_SKEW45:String = "15 16 0 0 0 b2e2e2e 20000000 20383838 b000000 0 0 0 0 0 0 0 0 0 0 b000000 20585858 3f040404 fffafafa ffffffff 34141414 b2e2e2e 0 0 0 0 0 0 0 0 b2e2e2e 34000000 ffffffff fffafafa ff000000 ff070707 fffafafa 340a0a0a b171717 0 0 0 0 0 0 0 20000000 ffffffff ff000000 ffffffff ffffffff ff030303 ff000000 ffffffff 34000000 ba2a2a2 0 0 0 0 0 0 2a1e1e1e ffffffff ff040404 ff000000 ffffffff fffefefe ff040404 ff000000 fffdfdfd 34000000 b2e2e2e 0 0 0 0 0 2a000000 ffffffff ff000000 ff070707 ff000000 fffbfbfb ffffffff ff000000 ff000000 ffffffff 34000000 b8b8b8b b000000 20202020 20000000 b171717 2a0c0c0c fff9f9f9 ff0a0a0a fff6f6f6 ff000000 ff020202 fffefefe ffffffff ff020202 ff000000 ffffffff 3f000000 3f202020 ffffffff ffffffff 20000000 20000000 ffffffff ff000000 ffffffff fff4f4f4 ff060606 ff000000 ffffffff ffffffff ff000000 ff000000 ffffffff fffcfcfc ff000000 fffcfcfc 2a181818 b5d5d5d 34000000 ffffffff 3f000000 3f202020 fffdfdfd ff000000 ff040404 ffffffff fff4f4f4 ff080808 ff000000 ffffffff ff000000 fffdfdfd 2a181818 0 b000000 15242424 b000000 be8e8e8 34000000 ffffffff ff010101 ff000000 ffffffff fff8f8f8 ff000000 ff060606 ff040404 fff7f7f7 2a2a2a2a 0 0 0 0 0 b000000 340f0f0f fffefefe ff050505 ff000000 ffffffff fff7f7f7 ff010101 ff090909 fffdfdfd 2a000000 0 0 0 0 0 0 b000000 34191919 fffcfcfc ff000000 ff040404 fff8f8f8 ffffffff ff000000 ffffffff 20000000 0 0 0 0 0 0 0 b2e2e2e 34000000 ffffffff ff000000 ff040404 fffcfcfc fffcfcfc 34141414 b000000 0 0 0 0 0 0 0 0 b000000 341d1d1d fff9f9f9 fffafafa 3f101010 20000000 b2e2e2e 0 0 0 0 0 0 0 0 0 0 b171717 20000000 20101010 b000000 0 0 0 ";
		private const _STR_SKEW90:String = "11 18 0 0 0 0 0 0 0 0 0 0 b171717 20000000 20000000 b747474 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20202020 fffafafa ffffffff 41000000 21000000 b000000 0 0 0 b2e2e2e 21000000 2c171717 2c000000 2c000000 2c060606 2c000000 2c000000 2b000000 49000000 ffffffff ff0a0a0a ff000000 ffffffff 36000000 b000000 0 0 20080808 ffffffff fff6f6f6 ffffffff fffbfbfb ffffffff fffafafa fffafafa ffffffff ffffffff fffefefe ffffffff ff000000 ff000000 ffffffff 36090909 b000000 b2e2e2e 40000000 fff9f9f9 ff060606 ff000000 ff0b0b0b ff010101 ff000000 ff010101 ff000000 ff030303 ff000000 ff000000 ff000000 ff000000 ff010101 ffffffff 20080808 20181818 fff9f9f9 ffffffff ffffffff ffffffff fffcfcfc ffffffff ffffffff fffafafa ffffffff fff9f9f9 ffffffff fff8f8f8 ffffffff fffcfcfc ffffffff fffefefe 20000000 20000000 fff6f6f6 ff000000 ff070707 ff030303 ff000000 ff000000 ff000000 ff030303 ff000000 ff0d0d0d ff000000 ff060606 ff000000 ff010101 ffffffff 3f000000 b000000 b2e2e2e 34000000 fff7f7f7 ff010101 ff030303 fffefefe ffffffff fffbfbfb fffafafa fffefefe ffffffff fff7f7f7 ffffffff fffafafa ffffffff fffdfdfd 21080808 0 0 bb9b9b9 34000000 ffffffff ff000000 ff050505 fff6f6f6 490a0a0a 2a000000 2a000000 2a000000 2a000000 2a000000 2a000000 2a000000 20000000 b000000 0 0 0 b5d5d5d 34050505 fffcfcfc fffcfcfc ffffffff 21000000 0 0 0 0 0 0 0 0 0 0 0 0 0 b2e2e2e 20000000 2a373737 20000000 b171717 0 0 0 0 0 0 0 0 0 0 ";
		private const _STR_SKEW135:String = "16 15 0 0 0 0 0 0 b747474 20000000 2a181818 2a0c0c0c 2a000000 20000000 bffffff 0 0 0 0 0 0 0 b000000 35050505 ffffffff ffffffff ffffffff fffefefe fffdfdfd 34000000 b464646 0 0 0 0 0 0 17000000 ffffffff ff000000 ff060606 ff000000 ff0c0c0c ff000000 ffffffff 20000000 0 0 0 0 0 0 b000000 41040404 ffffffff ffffffff ff000000 ff050505 fff8f8f8 ffffffff 3f101010 b000000 0 0 0 0 0 bd1d1d1 3f000000 ffffffff ff000000 ff040404 fff7f7f7 ffffffff ff000000 ffffffff 20080808 0 0 0 0 b000000 34191919 ffffffff ff040404 ff030303 fff1f1f1 ffffffff ff070707 ff000000 ffffffff 20000000 0 0 0 b171717 340a0a0a fffdfdfd ff020202 ff000000 ffffffff fffcfcfc ff020202 ff000000 ffffffff 35000000 b000000 0 0 b2e2e2e 34000000 ffffffff ff030303 ff000000 ffffffff fffdfdfd ff020202 ff060606 fff6f6f6 340f0f0f b000000 0 0 b000000 340a0a0a ffffffff ff080808 ff000000 ffffffff fff9f9f9 ff040404 ff000000 fffbfbfb 34272727 b000000 0 0 b000000 34000000 ffffffff ff000000 ff010101 fffefefe ffffffff ff030303 ff010101 fffbfbfb 34272727 b000000 0 0 0 20101010 fffbfbfb ff000000 ff010101 fffcfcfc ffffffff ff000000 ff000000 fffdfdfd 34000000 b464646 0 0 0 0 20000000 ffffffff ff000000 ffffffff ffffffff ff000000 ff040404 fffdfdfd 3f000000 ba2a2a2 0 0 0 0 0 b000000 41272727 fff9f9f9 fffefefe ff000000 ff080808 fffefefe fffdfdfd 3f141414 b000000 0 0 0 0 0 0 21080808 fffefefe ff030303 ff000000 ff000000 ff0c0c0c ff000000 fffafafa 20000000 0 0 0 0 0 0 b000000 36000000 ffffffff ffefefef ffffffff fff7f7f7 fffbfbfb ffffffff 20000000 0 0 0 0 0 0 0 b171717 20000000 2a2a2a2a 2a000000 2a1e1e1e 2a000000 20101010 b000000 0 0 0 0 0";
		private const _STR_CURSOR:String = "14 17 ffffffff fff8f8f8 ffffffff fff4f4f4 ffffffff fff6f6f6 ffffffff fffafafa fffefefe ffffffff ffffffff ffffffff fff1f1f1 ffffffff ffffffff 0 0 0 ffffffff ff000000 ff010101 ff020202 ff000000 ff040404 ff000000 ff020202 ff000000 ff000000 ff060606 ff000000 ff020202 fffcfcfc 0 0 0 0 ffffffff ff000000 ff000000 ff070707 ff000000 ff000000 ff000000 ff010101 ff020202 f0000000 ff060606 fffbfbfb 0 0 0 0 0 0 ffffffff ff000000 ff060606 ff040404 ff000000 ff010101 ff000000 ff070707 ff000000 fffafafa 0 0 0 0 0 0 0 0 ffffffff ff000000 ff070707 ff000000 ff000000 ff000000 ff000000 f00e0e0e ff000000 ffffffff ffffffff 0 0 0 0 0 0 0 ffffffff ff000000 ff0a0a0a ff060606 ff000000 ff060606 f0000000 ff000000 ff101010 ff000000 ffffffff ffffffff 0 0 0 0 0 0 fffdfdfd ff000000 ff000000 ff000000 ff0f0f0f fff9f9f9 ffffffff ff000000 ff040404 ff000000 ffffffff 0 0 0 0 0 0 0 ffffffff ff000000 ff050505 fffdfdfd ffffffff fffefefe fff8f8f8 ffffffff ffffffff ffffffff 0 0 0 0 0 0 0 0 fffcfcfc ff020202 ffffffff fffbfbfb ff0b0b0b ff000000 ff060606 fffafafa ffffffff 0 0 0 0 0 0 0 0 0 ffffffff fffafafa ff000000 ff000000 ffffffff ff000000 ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff ff000000 ffffffff ffffffff ffffffff ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff ff000000 ff050505 fff9f9f9 ff010101 ff000000 ffffffff 0 0 0 0 0 0 0 0 0 0 ffffffff fffdfdfd ff010101 ff000000 ff000000 ffffffff ffffffff 0 0 0 0 0 0 0 0 0 0 0 ffffffff ffffffff fffefefe fffdfdfd fffdfdfd 0";
		
		private var _Bmp_resize0:BitmapData;
		private var _Bmp_resize45:BitmapData;
		private var _Bmp_resize90:BitmapData;
		private var _Bmp_resize135:BitmapData;
		private var _Bmp_skew0:BitmapData;
		private var _Bmp_skew45:BitmapData;
		private var _Bmp_skew90:BitmapData;
		private var _Bmp_skew135:BitmapData;
		private var _Bmp_move:BitmapData;
		private var _Bmp_rotation:BitmapData;
		private var _Bmp_cursor:BitmapData;
		private var _Bmpcode_class:BmpCode;
		
		private var _shape_arrow:Shape;
		
		public function ArrowShapeClass() 
		{
			_shape_arrow = this;
			_Bmpcode_class = new BmpCode();
		}
		
		public function Show($bmp:BitmapData, $isOrigin:Boolean = false):void
		{
			var $_tmp_x:uint= $bmp.width * 0.5;
			var $_tmp_y:uint= $bmp.height * 0.5;
			var $_tmp_w:uint=$bmp.width;
			var $_tmp_h:uint=$bmp.height;
			var $_matr:Matrix = new Matrix(1, 0, 0, 1, -$_tmp_x, -$_tmp_y );
			if ($isOrigin)
			{
				_shape_arrow.graphics.clear();
				_shape_arrow.graphics.beginBitmapFill($bmp,null,true);
				_shape_arrow.graphics.drawRect(0, 0, $_tmp_w, $_tmp_h);
				_shape_arrow.graphics.endFill();
			}else{
				_shape_arrow.graphics.clear();
				_shape_arrow.graphics.beginBitmapFill($bmp,$_matr,true);
				_shape_arrow.graphics.drawRect(-$_tmp_x, -$_tmp_y,$_tmp_w,$_tmp_h);
				_shape_arrow.graphics.endFill();
			}
			
		}
		
		public function Clear():void
		{
			_shape_arrow.graphics.clear();
		}
		
		public function get Bmp_resize0():BitmapData 
		{
			if (_Bmp_resize0 == null) {
				_Bmp_resize0=_Bmpcode_class.decode(_STR_RESIZE0);
			}
			return _Bmp_resize0;
		}
		public function get Bmp_resize45():BitmapData 
		{
			if (_Bmp_resize45 == null) {
				_Bmp_resize45=_Bmpcode_class.decode(_STR_RESIZE45);
			}
			return _Bmp_resize45;
		}
		public function get Bmp_resize90():BitmapData 
		{
			if (_Bmp_resize90 == null) {
				_Bmp_resize90=_Bmpcode_class.decode(_STR_RESIZE90);
			}
			return _Bmp_resize90;
		}
		public function get Bmp_resize135():BitmapData 
		{
			if (_Bmp_resize135 == null) {
				_Bmp_resize135=_Bmpcode_class.decode(_STR_RESIZE135);
			}
			return _Bmp_resize135;
		}
		public function get Bmp_skew0():BitmapData 
		{
			if (_Bmp_skew0 == null) {
				_Bmp_skew0=_Bmpcode_class.decode(_STR_SKEW0);
			}
			return _Bmp_skew0;
		}
		public function get Bmp_skew45():BitmapData 
		{
			if (_Bmp_skew45 == null) {
				_Bmp_skew45=_Bmpcode_class.decode(_STR_SKEW45);
			}
			return _Bmp_skew45;
		}
		public function get Bmp_skew90():BitmapData 
		{
			if (_Bmp_skew90 == null) {
				_Bmp_skew90=_Bmpcode_class.decode(_STR_SKEW90);
			}
			return _Bmp_skew90;
		}
		public function get Bmp_skew135():BitmapData 
		{
			if (_Bmp_skew135 == null) {
				_Bmp_skew135=_Bmpcode_class.decode(_STR_SKEW135);
			}
			return _Bmp_skew135;
		}
		public function get Bmp_move():BitmapData 
		{
			if (_Bmp_move == null) {
				_Bmp_move=_Bmpcode_class.decode(_STR_MOVE);
			}
			return _Bmp_move;
		}
		public function get Bmp_rotation():BitmapData 
		{
			if (_Bmp_rotation == null) {
				_Bmp_rotation=_Bmpcode_class.decode(_STR_ROTATION);
			}
			return _Bmp_rotation;
		}
		public function get Bmp_cursor():BitmapData 
		{
			if (_Bmp_cursor == null) {
				_Bmp_cursor=_Bmpcode_class.decode(_STR_CURSOR);
			}
			return _Bmp_cursor;
		}
	}
	
//====================================================
	
	internal class ContainPointClass 
	{
		private var _math:MathClass;
		
		public function ContainPointClass() 
		{
			_math = new MathClass();
		}
		
		public function IsInRect($testpoint:Point, $point:Point, $w:Number, $h:Number):Boolean
		{
			var $_min_x:Number = $point.x - $w ;
			var $_max_x:Number = $point.x + $w ;
			var $_min_y:Number = $point.y - $h ;
			var $_max_y:Number = $point.y + $h ;
			
			if ( $testpoint.x < $_min_x || $testpoint.x > $_max_x || $testpoint.y < $_min_y || $testpoint.y > $_max_y )
			{
				return false;
			}
			
			return true;
			
		}
		public function IsInBouds($testpoint:Point, $point_arr:Array):Boolean
		{
			//-------------------
			//   0   1
			//   2   3
			//-------------------
			
			var $_p0:Point = $point_arr[0];
			var $_p1:Point = $point_arr[1];
			var $_p2:Point = $point_arr[2];
			var $_p3:Point = $point_arr[3];
			
			var $_angle0:Number = _math.GetAngle($_p0, $_p1);
			var $_angle1:Number = _math.GetAngle($_p0, $_p2);
			
			var $_cp0:Point = _math.GetCrossPoint( $testpoint, $_angle0, $_p0, $_angle1 );
			var $_cp1:Point = _math.GetCrossPoint( $testpoint, $_angle0, $_p1, $_angle1 );
			var $_cp2:Point = _math.GetCrossPoint( $testpoint, $_angle1, $_p0, $_angle0 );
			var $_cp3:Point = _math.GetCrossPoint( $testpoint, $_angle1, $_p2, $_angle0 );
			
			var $_pos0:Number = _math.GetPos($_p0, $_p1);
			var $_pos1:Number = _math.GetPos($_p0, $_p2);
			
			var $_s0:Number = _math.GetPos($testpoint, $_cp0);
			var $_s1:Number = _math.GetPos($testpoint, $_cp1);
			var $_s2:Number = _math.GetPos($testpoint, $_cp2);
			var $_s3:Number = _math.GetPos($testpoint, $_cp3);
			
			if ($_s0>$_pos0 || $_s1>$_pos0 || $_s2>$_pos1 || $_s3>$_pos1) 
			{
				return false;
				
			}
			
			return true;
		}
		
	}
	
//====================================================
	
	internal class MatrixClass 
	{
		private var _math:MathClass;
		
		public function MatrixClass():void
		{
			_math = new MathClass();
		}
		
		public function GetMatrix($obj:DisplayObject, $midPoint:Point=null):Object
		{
			
			var $_bounds:Object=$obj.getBounds($obj);
			var $_arr_point:Array = new Array();
			
			var $_w:Number;
			var $_h:Number;
			
			var $_i:uint = 0;
			var $_j:uint = 0;
			
			//-------------------
			//   0   3   6
			//   1   4   7
			//   2   5   8
			//-------------------
			
			for ($_i = 0; $_i < 3; $_i++)
			{
				$_w = $_bounds.width * $_i * 0.5;
				
				for ($_j = 0; $_j < 3; $_j++)
				{
					$_h = $_bounds.height * $_j * 0.5;
					var $_tmp_point:Point = new Point($_bounds.x + $_w, $_bounds.y + $_h);
					$_tmp_point = ($obj.parent).globalToLocal( $obj.localToGlobal($_tmp_point));
					
					$_arr_point.push($_tmp_point);
					
				}
			}
			if ($midPoint != null)
			{
				$_tmp_point = ($obj.parent).globalToLocal( $obj.localToGlobal($midPoint));
				$_arr_point[4] = $_tmp_point;
			}
			
			var $_scalex:Number = _math.GetPos( $_arr_point[0],$_arr_point[6] )/ $_bounds.width;
			var $_scaley:Number = _math.GetPos( $_arr_point[0],$_arr_point[2] )/ $_bounds.height;
			var $_skewx:Number  = _math.GetAngle( $_arr_point[0],$_arr_point[2] )-90;
			var $_skewy:Number  = _math.GetAngle( $_arr_point[0],$_arr_point[6] );
			
			var $_reObject:Object = 
			{
				array : $_arr_point,
				w : $_bounds.width,
				h : $_bounds.height,
				tx : $obj.x,
				ty : $obj.y,
				scalex : $_scalex,
				scaley : $_scaley,
				skewx : $_skewx,
				skewy : $_skewy
			}
			return $_reObject;
		}
		
		public function SetMidPoint($obj:DisplayObject, $internalPoint:Point, $externalPoint:Point):void 
		{
			var $_p1:Point =  $externalPoint ;
			var $_p2:Point = ($obj.parent).globalToLocal( $obj.localToGlobal( $internalPoint ) );
			$obj.x = $obj.x +($_p1.x - $_p2.x);
			$obj.y = $obj.y +($_p1.y - $_p2.y);
		}
		
		public function SetMatrix($obj:DisplayObject, $tx:Number=NaN, $ty:Number=NaN, $scalex:Number=NaN, $scaley:Number=NaN, $skewx:Number=NaN, $skewy:Number=NaN):void
		{
			var $_transform:Transform = $obj.transform;
			var $_newMatrix:Object = GetMatrix($obj);
			var $_skewMatrix:Matrix = new Matrix();
			
			isNaN($tx) && ($tx = $_newMatrix.tx);
			isNaN($ty) && ($ty = $_newMatrix.ty);
			isNaN($scalex) && ($scalex = $_newMatrix.scalex);
			isNaN($scaley) && ($scaley = $_newMatrix.scaley);
			isNaN($skewx ) && ($skewx = $_newMatrix.skewx);
			isNaN($skewy ) && ($skewy = $_newMatrix.skewy);
			
			$_skewMatrix.a = Math.cos($skewy*Math.PI/180) * $scalex;
			$_skewMatrix.d = Math.cos($skewx*Math.PI/180) * $scaley;
			$_skewMatrix.b = Math.tan($skewy*Math.PI/180) * $_skewMatrix.a;
			$_skewMatrix.c = Math.tan($skewx * Math.PI / 180) * $_skewMatrix.d * -1;
			$_skewMatrix.tx = $tx;
			$_skewMatrix.ty = $ty;
			
			$_transform.matrix = $_skewMatrix;
			//trace($_skewMatrix);
			
		}
	}
	
//====================================================
	
	internal class MathClass 
	{
		
		public function GetCrossPoint($target0:Point,$angle0:Number, $target1:Point,$angle1:Number):Point 
		{
			
			// var $target0:Point = new Point(0,0);
			// var $target1:Point = new Point(0,0);
			
			var $_k0:Number = 0;
			var $_k1:Number = 0;
			var $_x :Number = 0;
			var $_y :Number = 0;  
			
			var $_isExtra0:int = $angle0 % 180 == 0 ? 1 : $angle0 % 90 == 0 ? -1 : 0;
			var $_isExtra1:int = $angle1 % 180 == 0 ? 1 : $angle1 % 90 == 0 ? -1 : 0;
			
			($_isExtra0 ==  0) && ($_k0 =  Math.tan($angle0 * Math.PI / 180) );
			($_isExtra1 ==  0) && ($_k1 =  Math.tan($angle1 * Math.PI / 180) );
			
			var $_tmp_add:int = Math.abs($angle0) + Math.abs($angle1) ;
			if (  ($_tmp_add == 180 && $angle0*$angle1 < 0) || int($angle0) == int($angle1)) 
			{
				return null;
			}
			
			if (($_isExtra0 ==  0) && ($_isExtra1 ==  0)) 
			{
				
				$_x = (( $_k0 * $target0.x - $target0.y ) - ( $_k1 * $target1.x - $target1.y ) ) / ( $_k0 - $_k1 );
				$_y = (( $_k0 * $target1.y - $target1.x * $_k0* $_k1) - ( $_k1 * $target0.y - $target0.x * $_k0* $_k1) ) / ($_k0 - $_k1);
				
			}else if (($_isExtra0 ==  0) && ($_isExtra1 ==  1)) {
				
				$_y = $target1.y;
				$_x = ( $_y - $target0.y ) / $_k0  + $target0.x;
				
			}else if (($_isExtra0 ==  0) && ($_isExtra1 == -1)) {
				
				$_x = $target1.x;
				$_y = ( $_x - $target0.x ) * $_k0  + $target0.y;
				
			}else if (($_isExtra0 ==  1) && ($_isExtra1 ==  0)) {
				
				$_y = $target0.y;
				$_x = ( $_y - $target1.y ) / $_k1  + $target1.x;
				
			}else if (($_isExtra0 ==  1) && ($_isExtra1 ==  -1)) {
				
				$_y = $target0.y;
				$_x = $target1.x;
				
			}else if (($_isExtra0 == -1) && ($_isExtra1 ==  0)) {
				
				$_x = $target0.x;
				$_y = ( $_x - $target1.x ) * $_k1  + $target1.y;
				
			}else if (($_isExtra0 == -1) && ($_isExtra1 ==  1)) {
				
				$_x = $target0.x;
				$_y = $target1.y;
				
			}else {
				return null;
				//trace($_x, $_y);
				
			}
			//trace($angle0, $angle1);
			
			return (new Point( int($_x*1000)/1000, int($_y*1000)/1000 ));
		}
		
		public function GetAngle($target0:Point, $target1:Point):Number 
		{
			
			// var $target0:Point = new Point(0,0);
			// var $target1:Point = new Point(0,0);
			
			var $_tmp_x:Number = $target1.x - $target0.x;
			var $_tmp_y:Number = $target1.y - $target0.y;
			var $_tmp_angle:Number = Math.atan2( $_tmp_y, $_tmp_x ) * 180 / Math.PI;
			
			return $_tmp_angle;
		}
		
		public function GetPos($target0:Point, $target1:Point):Number 
		{
			
			var $_tmp_s:Number = Point.distance($target0, $target1);
			return 	$_tmp_s;
		}
		
	}
	
//====================================================
	
	internal class ShapeClass extends Shape
	{
		private var _shape:Shape;
		
		public function ShapeClass():void
		{
			_shape = this;
			_shape.graphics.clear();
		}
		
		public function Clear():void {
			_shape.graphics.clear();
		}
		
		public function CreateRect( $x:Number, $y:Number, $w:Number, $h:Number, $col:uint = 0x0 ,$borderAlpha:Number=1, $borderSize:Number=1,  $borderColor:uint=0xffffff ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderAlpha);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawRect($x, $y, $w, $h);
			_shape.graphics.endFill();
		}
		
		public function CreateRoundRect( $x:Number, $y:Number, $w:Number, $h:Number, $r:Number, $col:uint = 0x0, $borderSize:Number=1,  $borderColor:uint=0x0 ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawRoundRect($x, $y, $w, $h, $r);
			_shape.graphics.endFill();
		}
		
		public function CreateCircle( $x:Number, $y:Number, $r:Number, $col:uint = 0x0, $borderSize:Number=1,  $borderColor:uint=0x0 ):void 
		{
			_shape.graphics.lineStyle($borderSize, $borderColor);
			_shape.graphics.beginFill($col);
			_shape.graphics.drawCircle($x, $y, $r);
			_shape.graphics.endFill();
		}
		
		public function CreatCustomShap($array_point:Array, $bgColor:uint = 0x0, $bgApaha:Number = 1, $borderSize:Number = 1,  $borderColor:uint = 0x0, $borderApaha:Number=1 ):void 
		{
			var $_len:int = $array_point.length;
			if ($_len < 1 )
			{
				return;
			}
			
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderApaha);
			_shape.graphics.beginFill($bgColor, $bgApaha);
			
			_shape.graphics.moveTo($array_point[0].x, $array_point[0].y);
			for (var i:int = 1; i < $_len; i++ ) {
				_shape.graphics.lineTo($array_point[i].x, $array_point[i].y);
			}
			_shape.graphics.lineTo($array_point[0].x, $array_point[0].y);
			
			_shape.graphics.endFill();
			
		}
		
		public function CreateLine($array_point:Array,  $borderSize:Number = 1, $borderColor:uint = 0x0 , $borderApaha:Number=1):void 
		{
			//-------------------
			//   0   3
			//   1   2
			//-------------------
			var $_len:int = $array_point.length;
			if ($_len < 1 )
			{
				return;
			}
			
			_shape.graphics.lineStyle($borderSize, $borderColor,$borderApaha);
			_shape.graphics.beginFill(0x0, 0);
			
			_shape.graphics.moveTo($array_point[0].x, $array_point[0].y);
			for (var i:int = 1; i < $_len; i++ ) {
				_shape.graphics.lineTo($array_point[i].x, $array_point[i].y);
			}
			
			_shape.graphics.endFill();
			
		}
		
	}
	
//====================================================
	
	internal class SpriteClass extends Sprite
	{
		private var _sprite:Sprite;
		private var _shape:ShapeClass;
		
		public function SpriteClass():void
		{
			_sprite = this;
			_shape = new ShapeClass();
			
			_shape.Clear();
			_sprite.addChild(_shape);
			
		}
		
		public function get shape():ShapeClass {
			return _shape;
		}
		
	}