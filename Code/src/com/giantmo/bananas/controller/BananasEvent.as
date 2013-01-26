package com.giantmo.bananas.controller 
{
	public class BananasEvent 
	{
		/** A banana collides with a building. */
		public static const BANANA_COLLISION_BUILDING 		: String = "bananaCollisionBuilding";
		
		/** A banana collides with a gorilla. */
		public static const BANANA_COLLISION_GORILLA  		: String = "bananaCollisionGorilla";
		
		/** A banana flies out of world. */
		public static const BANANA_COLLISION_OUT_OF_WORLD 	: String = "bananaCollisionOutOfWorld";
		
		/** A cloud has flew out of the world */
		public static const CLOUD_LEFT_THE_WORLD			: String = "cloudLeftTheWorld";
		
		/** Notify if the drag has been released. */
		public static const DRAG_RELEASED : String = "dragReleased";
		
		/** Notify if the drag starts */
		public static const DRAG_STARTED : String = "dragStarted";
		
		/** Notify if touch was dragged... */
		public static const DRAGGED : String = "dragged";
		
		/** Notify that the user selected to start a game... */
		public static const START_GAME_SELECTED : String = "startGameSelected";
		
		/** Notifiy when the game is over */
		public static const GAME_OVER : String = "gameOver";
		
		/** Notify when the start screen should be displayed (again) */
		public static const RESTART_GAME : String = "restartGame";
	}
}