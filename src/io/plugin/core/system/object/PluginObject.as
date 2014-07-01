package io.plugin.core.system.object 
{
	import io.plugin.core.interfaces.IDisposable;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class PluginObject implements IDisposable
	{
		
		private var _name: String;
		protected var _isDisposed:Boolean;
		
		public function PluginObject() 
		{
			_isDisposed = false;
		}
		
		public function dispose():void
		{
			_isDisposed = true;
		}
		
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
		
		public function set name( name: String ): void
		{
			_name = name;
		}
		
		public function get name(): String
		{
			return _name;
		}
		
		public function getObjectByName( name: String ): Object
		{
			return (name == _name) ? this : null;
		}
		
		public function getAllObjectsByName( name: String, objects:Vector.<Object> ): void
		{
			if ( name == _name )
			{
				objects.push( this );
			}
		}
		
		// MACROS
		protected function PLUGIN_GET_OBJECT_BY_NAME( source:Object, name: String, found: Boolean ): Object
		{
			if (source)
			{
				found = source.getObjectByName(name);
				if (found)
				{
					return found;
				}
			}
			return null;
		}
		
		protected function PLUGIN_GET_ALL_OBJECTS_BY_NAME( source:Object, name:String, objects:Vector.<Object>): void
		{
			if (source)
			{
				source.getAllObjectsByName(name, objects);
			}
		}
		
	}

}