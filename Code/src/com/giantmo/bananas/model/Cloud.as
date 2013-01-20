package com.giantmo.bananas.model 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class Cloud 
	{
		// CONSTANTS
		public static const WIDTH  : Number = 207;
		public static const HEIGHT : Number = 81;
		
		// PROPERTIES
		public var velocity : Point;		
		public var position : Point;
		
		public function Cloud() 
		{
			position = new Point();
			velocity = new Point();			
		}
		
	}

}