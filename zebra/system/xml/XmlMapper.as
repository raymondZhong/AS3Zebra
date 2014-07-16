package zebra.system.xml
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import zebra.core.GameModel;
	import zebra.system.reflection.Reflection;
	import zebra.system.reflection.VariableInfo;
	import zebra.system.util.StringHelper;
	
	
	/**
	 * Bind 只有 属性 和 Vector数组
	 *   Vector数组 为子节点
	 * */
	public class XmlMapper
	{
		
		public function XmlMapper()
		{
		
		}
		
		/**
		 * 类反序列成XML
		 * @param	superClass
		 * @return
		 */
		static public function serialization(superClass:*):XML {
			var ref:Reflection = new Reflection(superClass);
			var cls:Class;
			var name:String;
			var xml:XML = new XML( "<" + ref.className + "/>"  )
			for each (var info:VariableInfo  in  ref.variable.variableInfo) 
			{
				if (IsVector(info.type)) {
					serializationVectorChild(superClass,xml,info.key);
					}else {
						if (IsClass(info.type)) {
							serializationClassChild(superClass[info.key],xml,info.key)
							}else{						
							  xml["@"+info.key] = superClass[info.key]	
							}
					}
			}
			return xml;
		}
		
		static private function serializationClassChild(superClass:*, data:*, filed:String=""):void {
			 var xml:XML = new XML( "<" + filed + "/>"  ) 
			 data.appendChild(xml)
			 var ref:Reflection = new Reflection(superClass);
			 for each (var info:VariableInfo  in  ref.variable.variableInfo) 
			 {
 
				if (IsVector(info.type)) {
						serializationVectorChild(superClass,data[filed],info.key);
					}else {
						if (IsClass(info.type)) {
						 	serializationClassChild(superClass[info.key],data[filed],info.key)
							}else{						
							  xml["@"+info.key] = superClass[info.key]	
							}
					}
			 }
		}		
		
		static private function serializationVectorChild(superClass:*,data:*,filed:String):void {
				  for (var i:int = 0; i < superClass[filed].length; i++) 
				  {
					  var xml:XML = new XML( "<" + filed +"/>");
					  var ref:Reflection = new Reflection(superClass[filed][i])
					  for each (var info:VariableInfo in ref.variable.variableInfo) 
					  {
						  if (IsVector(info.type)) {
							  serializationVectorChild(superClass[filed][i], xml,info.key);
							  }else {
								 
								  if (IsClass(info.type)) {
									  serializationClassChild(superClass[filed][i][info.key],xml,info.key)
									}else {						
									   xml["@" + info.key] = superClass[filed][i][info.key];
									}
							  }
					  }
					  data.appendChild(xml);
				  }			
			}
 
		 
		 /**
		  * 类和xml数据绑定
		  * @param	superClass
		  * @param	storedata
		  */
		static public function bind(superClass:*, storedata:XML):void
		{	
			bindParseElement(superClass, storedata);		
		}
		
		static  private function bindParseElement(nodeClass:*, xmlNode:*):void {
			var ref:Reflection =  new Reflection(nodeClass);
			var cls:Class;
			   for each (var info:VariableInfo in ref.variable.variableInfo) 
			   {
				    if (IsVector(info.type)) {
							//初始化Vector类型
							cls = getDefinitionByName(info.type) as Class;
							var list:* = new cls();
							ref.variable.set(info.key, list);
							if(xmlNode)
							bindParseVector(nodeClass[info.key], xmlNode[info.key],info.key,info.type);
						}else {
						if (IsClass(info.type)) {
							//初始化类
							 cls = getDefinitionByName(info.type) as Class;
							 var ccls:* = new cls()
							 ref.variable.set(info.key, ccls);

							// if (xmlNode.hasOwnProperty(info.key)) 
								  bindParseElement(ccls, xmlNode[info.key])
							}else {	
								if(xmlNode["@" + info.key]!=null)								
								   ref.variable.set(info.key, formatData(xmlNode["@" + info.key]));	
							}
						}
					}
			 
			
			}
		
		static private function bindParseVector(superClass:*, xmlNode:*, filedNames:String, vectorType:String):void {
			 var vectorClass:Class  = getVectorClass(vectorType);
			  var vectorModelRef:Reflection = new Reflection( new vectorClass());
			  var cls:Class;
			  var len:int = xmlNode.length();
		      for (var i:int = 0; i < len; i++) 
			  {
				   var item:* = new vectorClass();
						superClass.push(item);
					 for each (var info:VariableInfo in vectorModelRef.variable.variableInfo) 
				     {
					    if (IsVector(info.type)) {						   
								cls = getDefinitionByName(info.type) as Class;
								item[info.key] =  new cls();
							 	bindParseVector(superClass[i][info.key], xmlNode[i][info.key], info.key, info.type);							
						   }else {
							
							  if (IsClass(info.type)) {
									 cls = getDefinitionByName(info.type) as Class;
									 var ccls:* = new cls()
									 item[info.key] = ccls;

									 if (xmlNode[i].hasOwnProperty(info.key))
										  bindParseElement(ccls, xmlNode[i][info.key])
								  
								  }else {

									if(xmlNode[i]["@" + info.key]!=null) 
									 item[info.key] = formatData(xmlNode[i]["@" + info.key]);
						
								 
								 }
							}
					 }
			  }
			}
			

		
	
		//====Tool======================================================================//
		static private function IsClass(type:String):Boolean {
			 if (IsVector(type)) return false;
			 return  type.indexOf("::") != -1;			
			}
		
		static private function IsVector(type:String):Boolean {
			  return  type.indexOf("Vector") != -1;
			}
					
		static private function getVectorClassName(type:String):String {
			  var childType:String = String(type).replace("__AS3__.vec::Vector.<", "");
								childType = childType.replace("::", ".");
								childType = childType.replace(">", "");
								return childType;
			}
		
		static private function getVectorClass(vectorType:String):Class {
			  return getDefinitionByName(getVectorClassName(vectorType)) as Class;
			}
 
		/**
		 * 主要处理 boolean 类型
		 * @param	str
		 * @return
		 */
		static private function formatData(str:*):*{
			  if (String(str).toLocaleLowerCase() == "false") return false;
			  if (String(str).toLocaleLowerCase() == "true") return true;
			  return str;
			}
		
		
  
	}

}