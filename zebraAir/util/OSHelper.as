package zebraAir.util
{
	
	import flash.net.InterfaceAddress;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	import flash.system.Capabilities;
	import zebra.system.util.StringHelper;
	
	public class OSHelper
	{
		
		public function OSHelper()
		{
		
		}
		
		static public function getIP():String
		{
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces();
			if (interfaces != null)
			{
				for each (var interfaceObj:NetworkInterface in interfaces)
				{
					if(!StringHelper.isWhitespace(interfaceObj.hardwareAddress))
					return interfaceObj.addresses[0].address;
				}
			}			
			return "";
		
		}
		
		static public function GetAddressTest():void
		{
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces();
			
			if (interfaces != null)
			{
				trace("Interface count: " + interfaces.length);
				for each (var interfaceObj:NetworkInterface in interfaces)
				{
					trace("\nname: " + interfaceObj.name);
					trace("display name: " + interfaceObj.displayName);
					trace("mtu: " + interfaceObj.mtu);
					trace("active?: " + interfaceObj.active);
					trace("parent interface: " + interfaceObj.parent);
					trace("hardware address: " + interfaceObj.hardwareAddress);
					if (interfaceObj.subInterfaces != null)
					{
						trace("# subinterfaces: " + interfaceObj.subInterfaces.length);
					}
					trace("# addresses: " + interfaceObj.addresses.length);
					for each (var address:InterfaceAddress in interfaceObj.addresses)  
					{
						trace("  type: " + address.ipVersion);
						trace("  address: " + address.address);
						trace("  broadcast: " + address.broadcast);
						trace("  prefix length: " + address.prefixLength);
					}
				}
			}
		}
		
		static public function getMacAddress():String
		{
			var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<NetworkInterface> = networkInfo.findInterfaces();
			if (interfaces != null)
			{
				for each (var interfaceObj:NetworkInterface in interfaces)
				{
					if(!StringHelper.isWhitespace(interfaceObj.hardwareAddress))
					return interfaceObj.hardwareAddress;
				}
			}
			
			return "";
		
		}
	
	}

}