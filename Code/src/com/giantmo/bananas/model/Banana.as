package com.giantmo.bananas.model 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class Banana
	{		
		// CONSTANTS
		public static const WIDTH  : Number = 20;
		public static const HEIGHT : Number = 20;
		
		// PROPERTIES		
		public var rotation : Number;		
		public var bounds 	: Rectangle;
		public var oldPosition : Point;
		
		public var wasInExplosion : Boolean;
		
		public var owner : int; // ID of the owning Gorilla
		
		public function Banana() 
		{
			bounds = new Rectangle(0, 0, 20, 20);
			oldPosition = new Point();
			
			rotation = 0;			
		}
		
	}

}