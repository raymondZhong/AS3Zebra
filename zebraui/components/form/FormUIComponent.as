package zebraui.components.form 
{
	import zebraui.components.UIComponent;
	import zebraui.data.UIModel;
	public class FormUIComponent extends UIComponent
	{
		protected  var _storeData:Vector.<UIModel>
		public function FormUIComponent(preferWidth:Number=0, preferHeight:Number=0) 
		{
			_storeData = new Vector.<UIModel>();
			super(preferWidth, preferHeight);
		}
		
		public function get storeData():Vector.<UIModel> 
		{
			return _storeData;
		}
		
		public function set storeData(value:Vector.<UIModel>):void 
		{
			_storeData = value;
		}
		
	}

}