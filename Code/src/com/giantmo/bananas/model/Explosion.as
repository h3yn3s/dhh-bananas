package com.giantmo.bananas.model
{
	import flash.geom.Point;

	public class Explosion
	{
		// CONSTANTS
		public static const RADIUS : Number = 40;
		
		// PROPERTIES
		public var position : Point;
		
		// CONSTRUCTOR
		public function Explosion()
		{
			position = new Point();
		}
	}
}