package zebra.system.util
{
	import flash.net.ObjectEncoding;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class ObjectHelper
	{
		
		public function ObjectHelper()
		{
		
		}
		
		public static function toClass(object:Object, clazz:Class):*
		{
			var bytes:ByteArray = new ByteArray();
			bytes.objectEncoding = ObjectEncoding.AMF0;
			
			// Find the objects and byetArray.writeObject them, adding in the
			// class configuration variable name -- essentially, we're constructing
			// and AMF packet here that contains the class information so that
			// we can simplly byteArray.readObject the sucker for the translation
			
			// Write out the bytes of the original object
			var objBytes:ByteArray = new ByteArray();
			objBytes.objectEncoding = ObjectEncoding.AMF0;
			objBytes.writeObject(object);
			
			// Register all of the classes so they can be decoded via AMF
			var typeInfo:XML = describeType(clazz);
			var fullyQualifiedName:String = typeInfo.@name.toString().replace(/::/, ".");
			registerClassAlias(fullyQualifiedName, clazz);
			
			// Write the new object information starting with the class information
			var len:int = fullyQualifiedName.length;
			bytes.writeByte(0x10); // 0x10 is AMF0 for "typed object (class instance)"
			bytes.writeUTF(fullyQualifiedName);
			// After the class name is set up, write the rest of the object
			bytes.writeBytes(objBytes, 1);
			
			// Read in the object with the class property added and return that
			bytes.position = 0;
			
			// This generates some ReferenceErrors of the object being passed in
			// has properties that aren't in the class instance, and generates TypeErrors
			// when property values cannot be converted to correct values (such as false
			// being the value, when it needs to be a Date instead).  However, these
			// errors are not thrown at runtime (and only appear in trace ouput when
			// debugging), so a try/catch block isn't necessary.  I'm not sure if this
			// classifies as a bug or not... but I wanted to explain why if you debug
			// you might seem some TypeError or ReferenceError items appear.
			var result:* = bytes.readObject();
			return result;
		}
	
	}

}