package utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Utils
	{
		public static function getClass(obj:Object):Class 
		{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
	}
}