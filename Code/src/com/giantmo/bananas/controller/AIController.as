package com.giantmo.bananas.controller
{
	import com.giantmo.bananas.model.Constants;
	import flash.geom.Point;
	
	import flash.utils.setTimeout;
	
	import starling.events.EventDispatcher;
	import starling.utils.deg2rad;
	
	// ======================================
	// =====	METADATA				=====
	// ======================================
	
	/**
	 * Controller of the AI.
	 */
	public class AIController extends EventDispatcher
	{
		// ======================================
		// =====	CONSTANTS				=====
		// ======================================
		
		// ======================================
		// =====	PROPERTIES				=====
		// ======================================
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function AIController()
		{
		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		public function playMove() : void
		{
			trace( "AI IS GOING TO PLAY A MOVE" );
			setTimeout( play, 1000 ); // timeout to wait 1 second
		}
		
		// ======================================
		// =====	PROTECTED FUNCTIONS		=====
		// ======================================
		private function play() : void
		{
			// force should be anything between 0.5 & 0.57
			var force : Number = Constants.AI_MIN_FORCE + (Math.random() * Constants.AI_FORCE_RANGE);
			
			// compute velocity for the throw
			// x from -150 to -110
			// y from -150 to -10
			var x : Number = Constants.AI_VELOCITY_X + (Constants.AI_VELOCITY_X_DEVIATION - (Math.random() * (Constants.AI_VELOCITY_X_DEVIATION * 2)));
			var y : Number = Constants.AI_VELOCITY_Y + (Constants.AI_VELOCITY_Y_DEVIATION - (Math.random() * (Constants.AI_VELOCITY_Y_DEVIATION * 2)));
			var velocity : Point = new Point(x, y);
			
			trace( "WILL DRAG USING FORCE", force, "USING VELOCITY", velocity );
			
			// dispatch the event to release a banana
			this.dispatchEventWith( BananasEvent.DRAG_RELEASED, false, {force : force, velocity : velocity} );
		}
		
		// ======================================
		// =====	PRIVATE FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	EVENT HANDLERS			=====
		// ======================================
	}
}