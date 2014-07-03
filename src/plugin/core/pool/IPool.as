package plugin.core.pool 
{
	import plugin.core.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public interface IPool extends IDisposable
	{
		function push(o:*):void;
		function pop():*;
		function get size():int;
		function get resize():int;
		function get position():int;
	}
	
}