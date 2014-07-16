package zebra.system.reflection
{
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class Reflection
	{
		
		

		
		private var _classXML:XML;
		private var _class:Class;
		private var _classObject:*;
		private var _staticVariable:StaticVariable;
		private var _staticConstant:StaticConstant;
		private var _staticMethod:StaticMethod;
		private var _staticAccessor:StaticAccessor;
		private var _accessor:Accessor;
		private var _constant:Constant;
		private var _variable:Variable;
		private var _method:Method
		private var _namespacepath:String;
		private var _className:String;
		
		public function Reflection(cls:*=null)
		{
			parse(cls);
		}
		
		protected function  parse(cls:*):void {
				 /* _describeTypeData.addClassPath(cls);
				 _classXML  = _describeTypeData.getDescribeTypeXML(cls);*/				
				 _classObject = cls;
				 _class =  getDefinitionByName(getClassPath(_classObject)) as Class;
				 _classXML = describeTypeFullXML(_class);
				 _staticVariable = new StaticVariable(_classObject,_classXML);
				 _staticConstant = new StaticConstant(_classObject, _classXML);
				 _staticMethod = new StaticMethod(_classObject, _classXML);
				 _staticAccessor = new StaticAccessor(_classObject, _classXML);
				 _accessor = new Accessor(_classObject, _classXML);
				 _constant = new Constant(_classObject, _classXML);
				 _variable = new Variable(_classObject, _classXML);
				 _method = new Method(_classObject, _classXML)
				 
				 
				 _namespacepath = String(_classXML.@name).replace("::",".");
				 
				var namespacefull:Array =  _namespacepath.split(".");
				_className = namespacefull[namespacefull.length - 1];
				 
			}
		
		
		/**
		 * 静态变量
		 */
		public function get staticVariable():StaticVariable 
		{
			return _staticVariable;
		}
		
		/**
		 * 静态常量
		 */
		public function get staticConstant():StaticConstant 
		{
			return _staticConstant;
		}
		
		/**
		 * 所有静态方法
		 */
		public function get staticMethod():StaticMethod 
		{
			return _staticMethod;
		}
		
		/**
		 * 静态属性构造器
		 */
		public function get staticAccessor():StaticAccessor 
		{
			return _staticAccessor;
		}
		
		/**
		 * 获得传入的对象
		 */
		public function get classObject():Class 
		{
			return _class;
		}
		
		/**
		 * 常规属性构造器
		 */
		public function get accessor():Accessor 
		{
			return _accessor;
		}
		
		/**
		 * 常规变量
		 */
		public function get variable():Variable 
		{
			return _variable;
		}
		
		public function get constant():Constant 
		{
			return _constant;
		}
		
		public function get method():Method 
		{
			return _method;
		}
		
		public function get namespacePath():String 
		{
			return _namespacepath;
		}
		
		public function get className():String 
		{
			return _className;
		}
		

		
		/**
		 *====Static======================================================================
		 */
		/**
		 * 类转换成详细的XML结构数据
		 * @param	cls
		 * @return
		 */
		static public function  describeTypeFullXML(cls:Class):XML {
			var  classPath:String = getClassPath(cls);
			var  targetClass:Class =  getDefinitionByName(classPath) as Class;
			if (!ReflectionDescribeTypePool.has(classPath)) {
			      ReflectionDescribeTypePool.add(classPath,describeType(targetClass))
				}			
			return ReflectionDescribeTypePool.get(classPath);
			}
		
		/**
		 * 获得类名
		 * @param	name
		 * @param	domain
		 * @return
		 */
		static public function getClassByName(name:String, domain:ApplicationDomain = null):Class
		{
			if (!domain)
			{
				domain = ApplicationDomain.currentDomain;
			}
			
			return domain.getDefinition(name) as Class;
		}
		
		
		/**
		 * 获得命名空间不带类名
		 * @param	o
		 * @return
		 */
		static public function getClassPackage( o:* ):String
		{
			var fullpath:String = getQualifiedClassName( o ) ;
				fullpath = fullpath.split( "::" ).join( "." ) ;
			var parts:Array = fullpath.split( "." ) ;
			if( parts.length > 1 )
			{
				parts.pop() ;
				return parts.join( "." ) ;
			}
			return "" ;
		}
		
		/**
		 * 获得类的整体路径
		 * @param	o
		 * @param	normalize
		 * @return
		 */
		static public function getClassPath( o:*, normalize:Boolean = true ):String
		{
			var fullpath:String = getQualifiedClassName( o );
			
			if( normalize )
			{
				fullpath = fullpath.split( "::" ).join( "." );
			}
			
			return fullpath;
		};
		
		
		/**
		 * 获得类名
		 * @param	o
		 * @param	path
		 * @return
		 */
		static public function getClassName(o:*, path:Boolean = false):String
		{
			var fullpath:String = getQualifiedClassName(o);
			
			if (path)
			{
				return fullpath;
			}
			else
			{
				fullpath = fullpath.split("::").join(".");
				var parts:Array = fullpath.split(".");
				
				if (parts.length > 1)
				{
					return parts.pop();
				}
				
				return fullpath;
			}
		}
	     
		 
		/**
		 * invoke handle
		 * @param	c
		 * @param	args
		 * @return
		 */
		static public function invoke( c:Class, args:Array = null ):*
		{
			if( !args )
			{
				return new c();
			}
			
			var a:Array = args;
			
			/* note:
			   if we ever need more than 32 args
			   will use CC for that special case
			*/
			switch( a.length )
			{
				case 0:
				return new c();
				
				case 1:
				return new c( a[0] );
				
				case 2:
				return new c( a[0],a[1] );
				
				case 3:
				return new c( a[0],a[1],a[2] );
				
				case 4:
				return new c( a[0],a[1],a[2],a[3] );
				
				case 5:
				return new c( a[0],a[1],a[2],a[3],a[4] );
				
				case 6:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5] );
				
				case 7:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6] );
				
				case 8:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7] );
				
				case 9:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8] );
				
				case 10:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9] );
				
				case 11:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10] );
				
				case 12:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11] );
				
				case 13:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12] );
				
				case 14:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13] );
				
				case 15:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14] );
				
				case 16:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15] );
				
				case 17:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16] );
				
				case 18:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17] );
				
				case 19:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18] );
				
				case 20:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19] );
				
				case 21:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20] );
				
				case 22:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21] );
				
				case 23:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22] );
				
				case 24:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23] );
				
				case 25:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24] );
				
				case 26:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25] );
				
				case 27:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26] );
				
				case 28:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27] );
				
				case 29:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28] );
				
				case 30:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29] );
				
				case 31:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30] );
				
				case 32:
				return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
							  a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30],a[31] );
				
				default:
				return null;
			   }
			}
			

	}

}