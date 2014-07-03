package plugin.core.pool {
	import flash.utils.Dictionary;

	/**
	 */
	public class Pool implements IPool {
		//------------------------------------------------------------------------------------------
		// PRIVATE VARIABLES
		//------------------------------------------------------------------------------------------
		
		private var _cache:Array        = new Array();
		private var _index:Dictionary   = new Dictionary();
		
		private var _type:Class;
		
		private var _size:int;
		private var _resize:int;
		private var _position:int;
		private var _warningAt:int;
		
		private var _params:Array;
		
		private var _isDisposed:Boolean;
		
		//------------------------------------------------------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------------------------------------------------------
		
		/**
		 */
		public function Pool( type:Class, params:Array, size:int = 50, resize:uint = 0, warningAt:int = 1000 ) {
			_type = type;
			_resize = resize;
			_params = params;
			_warningAt = warningAt;
			
			expand( _size );
		}
		
		//------------------------------------------------------------------------------------------
		// PUBLIC METHODS
		//------------------------------------------------------------------------------------------
		
		/**
		 */
		public final function pop():* {
			var o:*;
			
			if( _position == _size ) {
				if( _resize == 0 ) {
					throw new Error( "The pool is empty" );
				}
				
				expand( _resize );
			}
			
			o = _cache[ _position++ ];
			_index[ o ] = null;
			
			if ( _size >= _warningAt )
			{
				trace( "*** WARNING: " + _type + " object pool has exceeded " + _warningAt + " objects. ***" );
			}
			
			return o;
		}
		
		/**
		 */
		public final function push( o:* ):void {
			if( _index[ o ] === undefined ) {
				throw new Error( "The specified object does not belong to the pool" );
			}
			
			if( _index[ o ] === o ) {
				return;
			}
			
			_index[ o ] = o;
			_cache[ --_position ] = o;
			o.reset();
		}
		
		/**
		 */
		public final function dispose():void {
			var o:*;
			
			for each( o in _cache ) {
				o.dispose();
			}
			
			_cache     = null;
			_index     = null;
			_type	   = null;
			_size      = 0;
			_resize    = 0;
			_position  = 0;
			
			_isDisposed = true;
		}
		
		//------------------------------------------------------------------------------------------
		// PRIVATE METHODS
		//------------------------------------------------------------------------------------------
		
		/**
		 */
		private final function expand( count:int ):void {
			var o:*;
			var i:int = _size;
			var n:int = _size + count;
			
			while ( i < n ) {
				switch(_params.length )
				{
					case 0:
							o = new _type();
						break;
					case 1:
							o = new _type(_params[0]);
						break;
					case 2:
							o = new _type(_params[0], _params[1]);
						break;
					case 3:
							o = new _type(_params[0], _params[1], _params[2]);
						break;
					case 4:
							o = new _type(_params[0], _params[1], _params[2], _params[3]);
						break;
					case 5:
							o = new _type(_params[0], _params[1], _params[2], _params[3], _params[4]);
						break;
					case 6:
							o = new _type(_params[0], _params[1], _params[2], _params[3], _params[4], _params[5]);
						break;
					case 7:
							o = new _type(_params[0], _params[1], _params[2], _params[3], _params[4], _params[5], _params[6]);
						break;
					default:
						throw new Error( "Maximum parameters exceeded." );
				}
				
				
				_cache[ i ] = o;
				_index[ o ] = o;
				
				i++;
			}
			
			_size = n;
		}
		
		public function get isDisposed():Boolean 
		{
			return _isDisposed;
		}
		
		public function get size():int 
		{
			return _size;
		}
		
		public function get resize():int 
		{
			return _resize;
		}
		
		public function get position():int 
		{
			return _position;
		}
		
	}// EOC
}