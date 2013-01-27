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
		private var _duration : Number;
		private var _force : Number;
		private var _velocity : Point;
		private var _throwValuesDetermined : Boolean;
		private var _notThrownYet : Boolean;
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function AIController()
		{
			_duration = 0;
			_force = 0;
			_velocity = new Point();
			_throwValuesDetermined = false;
			_notThrownYet = true;
		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		
		public function tick(timePassed : Number) : void 
		{
			if (_throwValuesDetermined && _notThrownYet)
			{
				_duration += timePassed;
				
				if (_duration > Constants.AI_TIME_TO_AIM) 
				{
					_duration = 0;
					_notThrownYet = false;
					_throwValuesDetermined = false;
					// dispatch the event to release a banana
					this.dispatchEventWith( BananasEvent.DRAG_RELEASED, false, new Point(-_velocity.x, -_velocity.y) );
				} else {
					// start the drag
					this.dispatchEventWith( BananasEvent.DRAG_STARTED, false,  new Point(0,0));
					
					// act as if the computer is "dragging / aiming" using the banana...
					// compute it as % of the "time to aim" and go for the "opposite" direction (just as a human player)
					var draggingX : Number = (_duration / Constants.AI_TIME_TO_AIM) * ( -1 * _velocity.x);
					var draggingY : Number = (_duration / Constants.AI_TIME_TO_AIM) * ( -1 * _velocity.y);										
					this.dispatchEventWith( BananasEvent.DRAGGED, false, new Point(draggingX, draggingY) );				
				}
			}
		}
		
		public function playMove() : void
		{
			trace( "AI IS GOING TO PLAY A MOVE" );
			setTimeout( setThrowProperties, 500 ); // timeout to wait 1 second
		}
		
		// ======================================
		// =====	PROTECTED FUNCTIONS		=====
		// ======================================
		private function setThrowProperties() : void
		{
			// force should be anything between 0.5 & 0.57
			_force = Constants.AI_MIN_FORCE + (Math.random() * Constants.AI_FORCE_RANGE);
			
			// compute velocity for the throw
			// x from -150 to -110
			// y from -150 to -10
			var x : Number = Constants.AI_VELOCITY_X + (Constants.AI_VELOCITY_X_DEVIATION - (Math.random() * (Constants.AI_VELOCITY_X_DEVIATION * 2)));
			var y : Number = Constants.AI_VELOCITY_Y + (Constants.AI_VELOCITY_Y_DEVIATION - (Math.random() * (Constants.AI_VELOCITY_Y_DEVIATION * 2)));
			_velocity = new Point(x, y);
			
			trace( "WILL DRAG USING FORCE", _force, "USING VELOCITY", _velocity );			
			_throwValuesDetermined = true;
			_notThrownYet = true;
		}
		
		// ======================================
		// =====	PRIVATE FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	EVENT HANDLERS			=====
		// ======================================
	}
}