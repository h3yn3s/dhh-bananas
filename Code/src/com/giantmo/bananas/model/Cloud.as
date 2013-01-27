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
		public static const FRONT_WIDTH  : Number = 207;
		public static const FRONT_HEIGHT : Number = 81;
		
		public static const MIDDLE_WIDTH  : Number = 138;
		public static const MIDDLE_HEIGHT : Number = 66;
		
		public static const BACK_WIDTH  : Number = 83;
		public static const BACK_HEIGHT : Number = 40;
		
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