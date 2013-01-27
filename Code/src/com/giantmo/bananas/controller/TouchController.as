package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Model;
	import com.giantmo.bananas.view.Bananas;
	
	import flash.geom.Point;
	
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author ...
	 */
	public class TouchController extends EventDispatcher
	{
		private var _game : Bananas;
		private var _model : Model;
		
		private var _dragging : Boolean;
		
		public function TouchController(game : Bananas, model : Model) 
		{
			_game = game;
			_model = model;
			
			_game.stage.addEventListener(TouchEvent.TOUCH, game_touchHandler);			
			//game.addEventListener(KeyboardEvent.KEY_DOWN, starling_keyPressed);
		}
		
		protected function game_touchHandler( event : TouchEvent ) : void
		{
			var touch : Touch = event.touches[0];
	
			switch (touch.phase) 
			{
				case TouchPhase.ENDED : 
					if(_model.gameActive)
					{
						if(_dragging)
						{
							this.dispatchEventWith( BananasEvent.DRAG_RELEASED, false, new Point(touch.globalX, touch.globalY) );
							_dragging = false;
						}
					}
					break;
				case TouchPhase.BEGAN : 
					// always check first whether the sound symbol was pressed
					// now compute whether the sound area / button was pressed
					var soundDistance : Number = new Number( Math.sqrt( Math.pow((touch.globalX - _game.soundView.SOUND_MIDDLE_X) , 2) + Math.pow((touch.globalY - _game.soundView.SOUND_MIDDLE_Y) , 2)));
					
					if (soundDistance < 70) 
					{
						this.dispatchEventWith( BananasEvent.SOUND_PRESSED);
						return;
					}
					
					if(_model.gameActive)
					{
						_dragging = true;
						
						// only begin the drag if started "near" a gorilla
						var touchPoint : Point = new Point (touch.globalX, touch.globalY);
						
						// compute the "central" point of the current gorilla
						var gorillaMidPoint : Point = new Point ( ( _game.gorrilaViews[_model.currentPlayer].bounds.topLeft.x + 
																	_game.gorrilaViews[_model.currentPlayer].bounds.bottomRight.x) / 2, // that was x
																  ( _game.gorrilaViews[_model.currentPlayer].bounds.topLeft.y +
																	_game.gorrilaViews[_model.currentPlayer].bounds.bottomRight.y) / 2); // that was y
																	
						// now compute the difference between the touch and the gorilla using pythagoras
						// if > 70, don't start the drag...
						var distance : Number = new Number( Math.sqrt( Math.pow((touchPoint.x - gorillaMidPoint.x) , 2) + Math.pow((touchPoint.y - gorillaMidPoint.y) , 2)));
						
						if (distance < Constants.GORILLA_TOUCH_RADIUS )
						{
							this.dispatchEventWith( BananasEvent.DRAG_STARTED, false, new Point(touch.globalX, touch.globalY) );
						}
					}
					break;
				case TouchPhase.MOVED : 
					if(_model.gameActive)
					{
						this.dispatchEventWith( BananasEvent.DRAGGED, false, new Point(touch.globalX, touch.globalY) );
						break;				
					}
				default:
			} 			
		}
		
		/*protected function starling_keyPressed (event : KeyboardEvent) : void
		{
			
		}*/
	}
}