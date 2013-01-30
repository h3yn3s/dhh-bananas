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
		
		public static const FRONT_CLOUD : String = "FrontCloud";
		public static const MIDDLE_CLOUD : String = "MiddleCloud";
		public static const BACK_CLOUD : String = "BackCloud";
		
		public static const CLOUD_TYPE_1 : int = 0;
		public static const CLOUD_TYPE_2 : int = 1; 
		public static const CLOUD_TYPE_3 : int = 2;
		
		// PROPERTIES
		public var velocity : Point;		
		public var position : Point;
		public var cloudType : int;
		public var cloudLayer : String;
		public var speed : Number;
		
		public function Cloud() 
		{
			position = new Point();
			velocity = new Point();	
			cloudType = 0;
			cloudLayer = new String();
			speed = 0;
		}
		
	}

}