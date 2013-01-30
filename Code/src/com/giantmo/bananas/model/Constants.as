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
		public static const WIND_ADJUSTMENT_DURATION : Number = 1.0;
		
		public static const NUMBER_OF_BUILDINGS : Number = 8;
		public static const BUILDING_MINIMUM_HEIGHT : Number = 150;
		public static const BUILDING_VARIABLE_HEIGHT : Number = 300;
		
		public static const NUMBER_OF_FRONT_CLOUDS : Number = 5;
		public static const NUMBER_OF_MIDDLE_CLOUDS : Number = 8;
		public static const NUMBER_OF_BACK_CLOUDS : Number = 13;
		
		public static const BANANA_SPEED_MODIFIER : Number = 5;
		public static const GORILLA_TOUCH_RADIUS : Number = 70;
		public static const GORILLA_ARM_REPOSITION_SPEED : Number = 450;
		public static const MAX_GORILLA_LIVES : int = 3;
		
		public static const CLOUD_FRONT_SPEED : Number = 1.0;
		public static const CLOUD_MIDDLE_SPEED : Number = 0.6;
		public static const CLOUD_BACK_SPEED : Number = 0.4;
		
		public static const AI_MIN_FORCE : Number = 0.5;
		public static const AI_FORCE_RANGE : Number = 0.07;
		public static const AI_VELOCITY_X : Number = -130;
		public static const AI_VELOCITY_X_DEVIATION : Number = 20;
		public static const AI_VELOCITY_Y : Number = -80;
		public static const AI_VELOCITY_Y_DEVIATION : Number = 70;
		public static const AI_TIME_TO_AIM : Number = 1.5;
		
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