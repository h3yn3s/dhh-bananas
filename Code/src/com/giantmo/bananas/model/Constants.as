package com.giantmo.bananas.model 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class Constants 
	{
		public static const WORLD_BOUNDARY : Rectangle = new Rectangle(0, 0, 960, 640);
		public static const GRAVITY	: Number = 140;
		public static const MAX_WIND_FORCE : Number = 120;
		public static const WIND_RESISTANCE : Number = 0.02;
		public static const NUMBER_OF_BUILDINGS : Number = 8;
		public static const NUMBER_OF_CLOUDS : Number = 5;
		public static const BUILDING_MINIMUM_HEIGHT : Number = 150;
		public static const BUILDING_VARIABLE_HEIGHT : Number = 300;
		public static const BANANA_SPEED_MODIFIER : Number = 5;
		public static const GORILLA_TOUCH_RADIUS : Number = 70;
		public static const GORILLA_ARM_REPOSITION_SPEED : Number = 450;
		public static const MAX_GORILLA_LIVES : int = 1;
		
		public static const MAX_DRAG_FORCE_AXIS : Number = 200; // drag max 100px on x and y axis
		public static const MAX_DRAG_FORCE 		: Number = Math.sqrt( (MAX_DRAG_FORCE_AXIS * MAX_DRAG_FORCE_AXIS) + (MAX_DRAG_FORCE_AXIS * MAX_DRAG_FORCE_AXIS) ); // max angled force sqrt(x² + y²)
		
		public static const GAME_MODE_PVP : String = "pvp";
		public static const GAME_MODE_PVC : String = "pvc";
		
		public static const PLAYER_1 : int = 0;
		public static const PLAYER_2 : int = 1;		
		
		public function Constants() 
		{
			
		}
	}
}