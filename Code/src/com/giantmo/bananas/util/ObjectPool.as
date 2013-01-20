package com.giantmo.bananas.util
{
	public class ObjectPool
	{
		// ======================================
		// =====	PROPERTIES				=====
		// ======================================
		private var _buffer : Vector.<Object>;
		
		private var _length : int;
		
		private var _creationCallback : Function;
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function ObjectPool(initialSize : int, maximumSize : int, creationCallback : Function)
		{
			_buffer 			= new Vector.<Object>(maximumSize);
			_length 			= 0;
			_creationCallback	= creationCallback;
			
			
			// create the initially requested objects
			for(var idx : int = 0; idx < initialSize; idx++)
			{
				_buffer[_length] = creationCallback();
				_length++;
			}
		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		public function get hasItem() : Boolean
		{
			return _length > 0;
		}
		
		public function get isFull() : Boolean
		{
			return _length == _buffer.length;
		}
		
		public function get length() : int
		{
			return _length;
		}
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		public function get() : Object
		{
			if(_length == 0)
			{
				// create a new object if it is empty
				return _creationCallback();
			}
			
			// take one from the buffer
			_length--;
			var o   : Object = _buffer[_length];
			_buffer[_length]= null;
			
			return o;
		}
		
		public function put(o : Object) : Boolean
		{
			if(isFull)
				return false; // is full, we do not need it
			
			// put element into buffer if there is space...
			_buffer[_length] = o;
			_length++;
			
			return true;
		}
	}
}