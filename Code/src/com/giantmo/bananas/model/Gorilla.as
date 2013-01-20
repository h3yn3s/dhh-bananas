package com.giantmo.bananas.model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author ...
	 */
	public class Gorilla 
	{
		// CONSTANTS
		public static const WIDTH  : Number = 42;
		public static const HEIGHT : Number = 70;
				
		
		// PROPERTIES
		public var id : int;
		public var lives : int;
		
		/** Flag if the gorilla is currently the one allowed to play. */
		public var active : Boolean;
				
		public var bounds : Rectangle;
				
		// CONSTRUCTOR
		public function Gorilla() 
		{
			bounds = new Rectangle();
			lives  = 3;
		}
		
	}

}