package zebraAir.sql 
{
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import zebra.system.util.ObjectHelper;
	/**
	 * ...
	 * @author raymondzhong
	 */
	public class SQLHelper 
	{
		
		public function SQLHelper() 
		{
			
		}
		
		/**
		 * 获得SQL执行后的确切数据
		 * @param	e
		 * @return
		 */
		static public function  getRecordRowData(e:SQLEvent,cls:Class=null):* {
			  var result:SQLResult = SQLStatement(e.target).getResult();
			  if (result==null || result.data == null) return null;
			  if (cls) {
				         return ObjectHelper.toClass(result.data[0], cls);
				  }
			  return result.data[0];
			}
			
		 
		static public function  getRowData(e:SQLEvent):* {
			  var result:SQLResult = SQLStatement(e.target).getResult();
			  if (result==null || result.data == null) return null;
			  return result.data[0];
			}
			
		/**
		 * 获得多行数据并转换成自己的Vecotr<T>
		 * @param	e
		 * @param	sourceTarget
		 * @return
		 */
		 static public function getMultiRowData(e:SQLEvent, sourceVecotr:*=null):*{
			   var result:SQLResult = SQLStatement(e.target).getResult();
			   if (sourceVecotr && (result == null || result.data == null)) return sourceVecotr;
			   if (result==null || result.data == null  ) return null;
			   if (sourceVecotr) {
				   var cls:Class = getVectorClass(getQualifiedClassName(sourceVecotr));
				   var _data:Vector.<*> = new Vector.<*>();
				   for (var i:int = 0; i <result.data.length ; i++) 
				   {
					   _data.push(ObjectHelper.toClass(result.data[i], cls));
				   }
				   if (sourceVecotr) {					   
					   return sourceVecotr.concat(_data);
				   }
				   return _data;
			   }
			   return result.data;
			}
			
			
			
		static public function  getResult(e:SQLEvent,cls:Class=null):SQLResult {
			  var result:SQLResult = SQLStatement(e.target).getResult();
			  return result;
			}
			
			
			
		static private function getVectorClassName(type:String):String {
			  var childType:String = String(type).replace("__AS3__.vec::Vector.<", "");
								childType = childType.replace("::", ".");
								childType = childType.replace(">", "");
								return childType;
			}
		
		static  private function getVectorClass(vectorType:String):Class {
			  return getDefinitionByName(getVectorClassName(vectorType)) as Class;
			  
			}
			
	}

}