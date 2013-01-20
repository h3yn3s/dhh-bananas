package com.giantmo.bananas.controller
{
	import com.giantmo.bananas.model.Constants;
	
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
			setTimeout( play, 500 ); // timeout to wait 0.5 second
		}
		
		// ======================================
		// =====	PROTECTED FUNCTIONS		=====
		// ======================================
		private function play() : void
		{
			// for now, calculate random force (0-1)
			var force : Number = Math.random();
			
			// for now, calculate random angle that is ok in average
			var angle : Number = deg2rad( -180 );
			
			trace( "WILL DRAG AT ANGLE", angle, "WITH FORCE", force );
			
			// dispatch the event to release a banana
			this.dispatchEventWith( BananasEvent.DRAG_RELEASED, false, {force : force, angle : angle} );
		}
		
		// ======================================
		// =====	PRIVATE FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	EVENT HANDLERS			=====
		// ======================================
	}
}