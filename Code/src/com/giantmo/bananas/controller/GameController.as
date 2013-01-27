package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Banana;
	import com.giantmo.bananas.model.Building;
	import com.giantmo.bananas.model.Cloud;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Explosion;
	import com.giantmo.bananas.model.Gorilla;
	import com.giantmo.bananas.model.Model;
	import com.giantmo.bananas.model.PowerBar;
	import com.giantmo.bananas.view.Bananas;
	import com.giantmo.bananas.view.BuildingView;
	import com.giantmo.bananas.view.CloudView;
	import com.giantmo.bananas.view.ExplosionView;
	import com.giantmo.bananas.view.GorillaView;
	import starling.utils.deg2rad;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	/**
	 * ...
	 * @author ...
	 */
	public class GameController implements IAnimatable
	{
		// central game objects
		private var _model : Model;
		private var _bananas : Bananas;
				
		// controller
		private var _movementController : MovementController;
		private var _collisionController : CollisionController;
		private var _touchController : TouchController;
		private var _soundController : SoundController;
		private var _aiController : AIController;
		
		/** contains all relevant game object 
		 *  1) Gorillas
		 *  2) Flying Banana
		 *  3) Skyscrapers
		 *  4) Background
		 */
		public function GameController( model : Model, bananas : Bananas) 
		{
			_model = model;
			_bananas = bananas;
			
			// Add controller to juggler
			Starling.juggler.add( this );
			
			// initialize other controllers			
			_movementController = new MovementController( _model.banana, _model.clouds, _model.wind, _model.bananaThrow, _model.gorillas );
			
			_collisionController = new CollisionController( _model.banana, _model.gorillas, _model.buildings, _model.clouds, _model.explosions, Constants.WORLD_BOUNDARY );
			_collisionController.addEventListener(BananasEvent.BANANA_COLLISION_OUT_OF_WORLD, collision_bananaOutOfWorld);
			_collisionController.addEventListener(BananasEvent.BANANA_COLLISION_GORILLA, collision_bananaGorilla);
			_collisionController.addEventListener(BananasEvent.BANANA_COLLISION_BUILDING, collision_bananaBuilding);
			_collisionController.addEventListener(BananasEvent.CLOUD_LEFT_THE_WORLD, collision_cloudOutOfWorld);
			
			_touchController = new TouchController( bananas, model );
			_touchController.addEventListener( BananasEvent.DRAG_RELEASED, touch_dragReleasedHandler);
			_touchController.addEventListener( BananasEvent.DRAG_STARTED, touch_dragStartedHandler);
			_touchController.addEventListener( BananasEvent.DRAGGED, touch_draggedHandler);
			_touchController.addEventListener( BananasEvent.SOUND_PRESSED, touch_soundPressedHandler);
			
			_soundController = new SoundController( model );
			_soundController.addEventListener( BananasEvent.GAME_OVER, sound_gameOverHandler );
			
			// register start screen event
			bananas.addEventListener( BananasEvent.START_GAME_SELECTED, bananas_startGameHandler );
			
			// register the restart game event
			bananas.addEventListener( BananasEvent.RESTART_GAME, bananas_restartGameHandler );
						
			// create a first game
			createGame(Constants.GAME_MODE_PVP);
			
			// show start screen
			bananas.showStartScreen();			
			model.gameActive = false;
		}
		
		public function advanceTime (time:Number) : void
		{			
			/*if(time > 0.04)
			{
				time = 0.04;
			}*/
			
			// simulate the computer player
			if( _model.currentPlayer == 1 && _aiController != null )
			{
				_aiController.tick(time);
			}
			
			// move objects
			_movementController.tick( time );
			
			// object collision
			_collisionController.tick(_model.bananaThrow.bananaFlying);
						
			// now draw objects
			if (_model.bananaThrow.bananaFlying)
			{
				_bananas.bananaView.update();
			}
			
			var idx : int = 0;
			
			// draw gorillas
			for (idx = 0; idx < _bananas.gorrilaViews.length; idx++)
			{
				_bananas.gorrilaViews[idx].update();
			}
			
			// draw powerbar
			//if (_model.powerBar.gorillaIsAiming)
			//{
				_bananas.powerBarView.update();
			//}
			
			// draw buildings
			for (idx = 0; idx < _bananas.buildingViews.length; idx++)
			{
				_bananas.buildingViews[idx].update();
			}
			
			// draw clouds
			for (idx = 0; idx < _bananas.cloudViews.length; idx++)
			{
				_bananas.cloudViews[idx].update();
			}
			
			// draw explosions
			for (idx = 0; idx < _bananas.explosionViews.length; idx++)
			{
				_bananas.explosionViews[idx].update();
			}
			
			// pass it to the sound controller
			_soundController.tick(time);
		}
		
		public function createGame(mode : String) : void
		{
			// set the type of game this is
			_model.mode = mode;
			
			// remove all elements from the bananas view
			_bananas.clean();
			
			// remove explositions
			_model.explosions.length = 0;
			
			// add buildings
			var widthPerBuilding : Number = Constants.WORLD_BOUNDARY.width / Constants.NUMBER_OF_BUILDINGS;
			
			for (var idx : int = 0; idx < Constants.NUMBER_OF_BUILDINGS; idx++)
			{
				// calculate a random height
				var randomHeight : Number = int(Math.random() * Constants.BUILDING_VARIABLE_HEIGHT) + Constants.BUILDING_MINIMUM_HEIGHT;
				
				// spawn the building at this position
				spawnBuilding(
					idx, 
					new Rectangle(
						idx * widthPerBuilding, 
						Constants.WORLD_BOUNDARY.height - randomHeight, 
						widthPerBuilding, 
						randomHeight
					)
				);
			}
			
			// add windForce
			setWindForce( (Math.random() * Constants.MAX_WIND_FORCE) - (Constants.MAX_WIND_FORCE / 2) );
						
			createPowerBar();
			
			// add clouds
			for (idx = 0; idx < Constants.NUMBER_OF_CLOUDS; idx++)
			{
				// calculate a random height
				var randomX : Number = int(Math.random() * Constants.WORLD_BOUNDARY.width);
				// only show clouds in the upper 3/4 of the screen
				var randomY : Number = int(Math.random() * (Constants.WORLD_BOUNDARY.height - (Constants.WORLD_BOUNDARY.height / 4))); 
				
				// spawn the building at this position
				spawnCloud(idx, new Point(randomX, randomY));
			}
			
			// add gorillas
			spawnGorilla( 0, new Point( _model.buildings[1].bounds.x + _model.buildings[1].bounds.width / 2, _model.buildings[1].bounds.y));
			spawnGorilla( 1, new Point( _model.buildings[6].bounds.x + _model.buildings[6].bounds.width / 2, _model.buildings[6].bounds.y));
			
			// add the sound to the view
			_bananas.soundView.data = _model.bananaSound;
			
			// set current player
			_model.currentPlayer = 1;
		
			passNextPlayer();			
		}
		
		public function createPowerBar():void 
		{						
			// pass the data to the powerBar view
			_bananas.powerBarView.data = _model.powerBar;
			
			// set data on view		
			_bananas.addPowerBar( _bananas.powerBarView );
		}
		
		public function setWindForce( newForce : Number ) : void 
		{
			_model.wind.force = newForce;
		}
		
		public function spawnBanana(owner : int, position : Point, velocity : Point) : void
		{
			// get banana
			var banana : Banana = _model.banana;
			
			// initialize banana
			banana.owner		= owner;
			banana.bounds.x 	= position.x;
			banana.bounds.y 	= position.y;			
			banana.rotation 	= 0;
			banana.bounds.width = Banana.WIDTH;
			banana.bounds.height = Banana.HEIGHT;
			banana.oldPosition.x	= position.x;
			banana.oldPosition.y 	= position.y;
			banana.wasInExplosion	= false;
			
			// set data on view
			_bananas.bananaView.data = banana;
			
			// add banana view to game view
			_bananas.bananaVisible = true;
			
			// make banana flying
			_model.bananaThrow.velocity = velocity;
			_model.bananaThrow.bananaFlying = true;
			
			_bananas.bananaView.update();
		}
		
		public function spawnGorilla(id : int, position : Point) : void
		{
			// get gorilla by id
			var gorilla : Gorilla = _model.gorillas[id];
			
			// initialize gorilla
			gorilla.id = id;
			gorilla.bounds.x 	= position.x;
			gorilla.bounds.y 	= position.y - Gorilla.HEIGHT;
			gorilla.bounds.width = Gorilla.WIDTH;
			gorilla.bounds.height = Gorilla.HEIGHT;
			gorilla.lives = Constants.MAX_GORILLA_LIVES;
			
			// set data on view
			var view : GorillaView = _bananas.gorrilaViews[id];
			
			// the second gorilla is mirrored and is the to be positioned more "right"
			if (id == 1)
			{
				view.scaleX = -1;
			}
			
			view.data = gorilla;
			// add powerBar model also (the gorilla needs to know about the angle of the power bar)
			view.bananaThrowData = _model.bananaThrow;			
			
			view.update();
			_bananas.addGorilla( view );
		}
		
		public function spawnBuilding(id : int, bounds : Rectangle) : void
		{
			// get building by id
			var building : Building = _model.buildings[id];
			
			// initialize building
			building.bounds = bounds;
			
			// set data on view
			var view : BuildingView = _bananas.buildingViews[id];
			view.data = building;
			view.update();
			_bananas.addBuilding( view );			
		}
		
		public function spawnCloud(id : int, position : Point) : void
		{
			// get cloud by id
			var cloud : Cloud = _model.clouds[id];
			
			// initialize cloud
			cloud.position = position;
			
			// set data on view
			var view : CloudView = _bananas.cloudViews[id];
			view.data = cloud;
			view.update();
			_bananas.addCloud( view );
		}
		
		public function spawnExplosion(position : Point) : void
		{
			// create an explosion target
			var explosion : Explosion = new Explosion();
			explosion.position = position;
			_model.explosions.push( explosion );
			
			// get explosion view
			var view : ExplosionView = _bananas.getExplosion();
			view.data = explosion;
			view.update();
			_bananas.addExplosion( view );
		}
		
		
		private function removeBanana() : void
		{
			// banana stops flying
			_model.bananaThrow.bananaFlying = false;
			
			// remove banana from view
			_bananas.bananaVisible = false;
		}
		
		private function passNextPlayer() : void
		{
			// de activate old
			_model.gorillas[_model.currentPlayer].active = false;
			
			// update
			_model.currentPlayer = (_model.currentPlayer + 1) % 2; // 0 or 1
			_model.wind.force = (Math.random() * Constants.MAX_WIND_FORCE) - (Constants.MAX_WIND_FORCE / 2);
			
			// activate new gorilla
			_model.gorillas[_model.currentPlayer].active = true;
			
			// if the second gorilla is active and we have an ai controller
			if( _model.currentPlayer == 1 && _aiController != null )
			{
				// the ai shall play
				_aiController.playMove();
			}
		}
		
		protected function sound_gameOverHandler(event : Event) : void 
		{
			// show the game over screen
			this._bananas._gameOverScreen.model = _model;
			this._soundController.playSound(SoundController.GORILLA_WINS);
			this._bananas.showGameOverScreen();			
		}
		
		protected function touch_dragReleasedHandler(event : Event, position : Point) : void
		{
			if (!_model.bananaThrow.bananaFlying && _model.bananaThrow.startPoint != null )
			{
				trace("SPAWN A BANANA AT", position );
				// calculate the velocity (start point of drag and release point)
				// Wurzel aus ((x1 - x2)² + (y1 - y2)²)
				var velocity_x : Number = _model.bananaThrow.startPoint.x - position.x;
				var velocity_y : Number = _model.bananaThrow.startPoint.y - position.y;
				
				// apply max forces
				_model.bananaThrow.velocity.x = velocity_x > 0 ? Math.min( velocity_x, Constants.MAX_DRAG_FORCE_AXIS )
															   : Math.max( velocity_x, -Constants.MAX_DRAG_FORCE_AXIS );
				
				_model.bananaThrow.velocity.y = velocity_y > 0 ? Math.min( velocity_y, Constants.MAX_DRAG_FORCE_AXIS )
															   : Math.max( velocity_y, -Constants.MAX_DRAG_FORCE_AXIS );
				
				trace( _model.bananaThrow.aimingAngle, _model.bananaThrow.aimingForce, _model.bananaThrow.velocity );
								
				_model.powerBar.gorillaIsAiming = false; // not aiming any more
				
				// spawn the banana at the local gorilla spawn point -> caluldated to global coordinates
				this.spawnBanana( 
					_model.currentPlayer, 
					_bananas.gorrilaViews[_model.currentPlayer].localToGlobal( PowerBar.POWER_BAR_ORIGIN ), 
					_model.bananaThrow.velocity
				);
				
				// stop the current sound (so that throw starte & released do not overlap)
				_soundController.stopSound(SoundController.GORILLA_THROW_STARTED);
				
				// play the sound for throw released
				_soundController.playSound(SoundController.GORILLA_THROW_RELEASED);			
				// play the sound for a flying banana
				_soundController.playSound(SoundController.BANANA_FLYING);
				
				// draggedOnce is true again...
				_model.bananaThrow.inDragPhase = !_model.bananaThrow.inDragPhase; 
				
				_model.bananaThrow.startPoint = null;
			}
		}
		
		protected function touch_dragStartedHandler(event : Event, position : Point) : void
		{
			if (!_model.bananaThrow.bananaFlying)
			{
				trace("Drag started at ", position );	
				_model.bananaThrow.startPoint = position;
								
				// set initial values				
				_model.powerBar.owningGorillaPosition = _model.getActiveGorilla().bounds.topLeft;
				_model.bananaThrow.aimingAngle = 0;
				_model.bananaThrow.aimingForce = 0;
			}
		}

		protected function touch_draggedHandler(event : Event, position : Point) : void
		{
			if (!_model.bananaThrow.bananaFlying && _model.bananaThrow.startPoint != null)  // this is the logic for a human player
			{
				if (_model.currentPlayer == 1)
				{
					var i :int = 1;
				}
				// play throw started sound once
				if (!_model.bananaThrow.inDragPhase)
				{
					// now show the bar also
					_model.powerBar.gorillaIsAiming = true;
					_soundController.playSound(SoundController.GORILLA_THROW_STARTED);
					_model.bananaThrow.inDragPhase = !_model.bananaThrow.inDragPhase;
				}
				
				// calculate dragged delta
				var deltaX : Number = _model.bananaThrow.startPoint.x - position.x;
				var deltaY : Number = _model.bananaThrow.startPoint.y - position.y;
				
				// get applied forces
				var forceX : Number = Math.min( Math.abs( deltaX ), Constants.MAX_DRAG_FORCE_AXIS );
				var forceY : Number = Math.min( Math.abs( deltaY ), Constants.MAX_DRAG_FORCE_AXIS );
				
				// angular force - sqrt(x² + y²)
				var length : Number = Math.sqrt( (forceX * forceX) + (forceY * forceY) );
												
				// get current active gorilla
				_model.bananaThrow.aimingAngle = Math.atan2(deltaY, deltaX); 			// set angle in radians
				_model.bananaThrow.aimingForce = length / Constants.MAX_DRAG_FORCE; 	// force added 
				
				_model.powerBar.aimingAngle = _model.bananaThrow.aimingAngle;
				_model.powerBar.aimingForce = _model.bananaThrow.aimingForce;
				
				// modify the angle of the gorilla arm
				// draw arm, if player is inactive
				if (_model.getActiveGorilla().id == 0)
				{					
					_model.getActiveGorilla().armAngle = _model.powerBar.aimingAngle; // angle applies to rotation
					// step 2: add 180° to the powerBar angle
					_model.getActiveGorilla().armAngle += deg2rad(180);					
				} else {
					_model.getActiveGorilla().armAngle = (-1 * _model.powerBar.aimingAngle); // angle applies to rotation
				}				
					
				// step 3: convert the "power" of the bar into angle as well
				_model.getActiveGorilla().armAngle -= ( _model.powerBar.aimingForce * 2 );
			}
		}

		protected function touch_soundPressedHandler(event : Event) : void 
		{
			// mute / unmute the sound
			_model.bananaSound.playing = !_model.bananaSound.playing;
			
			// mute / unmute all sounds
			if (!_model.bananaSound.playing)
			{
				_soundController.muteSound();			
			} else {
				_soundController.unmuteSound();
			}
			
			// change the sound icon
			_bananas.soundView.switchSoundDisplay();
		}
		
		protected function collision_bananaOutOfWorld(event : Event) : void
		{
			// remove the banana
			removeBanana();
			
			// stop the banana sound
			_soundController.stopSound(SoundController.BANANA_FLYING);
			
			// pass to next player
			passNextPlayer();
		}
		
		protected function collision_bananaGorilla(event : Event, gorilla : Gorilla) : void
		{
			// remove the banana
			removeBanana();
			
			// stop the banana sound
			_soundController.stopSound(SoundController.BANANA_FLYING);
			
			//  remove live from gorilla
			gorilla.lives--;
			
			// TODO show effect
			
			// check if gorilla is dead
			if ( gorilla.lives == 0)
			{
				// set the game to inactive, so that no bananas can be thrown anymore
				_model.gameActive = false;
				
				// play the gorilla has lost sound
				// once the sound has finished, the game over screen can be displayed
				_soundController.playSound(SoundController.GORILLA_LOST);
			} 
			else
			{
				// gorilla got hit sound
				_soundController.playSound(SoundController.GORILLA_GOT_HIT);
				
				// pass to next player
				passNextPlayer();
			}
		}
		
		protected function collision_bananaBuilding(event : Event, data : Object) : void
		{
			// remove the banana
			removeBanana();
			
			// get building and point
			var building : Building 	= data.building;
			var collisionPoint : Point	= data.collisionPoint;
			
			// create explosision in "middle" of banana
			/*spawnExplosion( new Point(( _model.banana.bounds.right + _model.banana.bounds.left) / 2, 
									  ( _model.banana.bounds.top + _model.banana.bounds.top) / 2 ));*/
			spawnExplosion( collisionPoint );
			
			// stop flying sound
			_soundController.stopSound( SoundController.BANANA_FLYING);
			
			// play explosion
			_soundController.playSound( SoundController.EXPLOSION);
			
			// show effect at lower explosion radius border
			_bananas.playExplosionEffect( collisionPoint.x, collisionPoint.y );
			
			// pass to next player
			passNextPlayer();
		}
		
		protected function collision_cloudOutOfWorld(event : Event, cloud : Cloud) : void 
		{
			if (cloud.position.x > Constants.WORLD_BOUNDARY.width)
			{
				cloud.position.x = 0 - Cloud.FRONT_WIDTH;
			} else if (cloud.position.x < (0 - Cloud.FRONT_WIDTH)) {
				cloud.position.x = Constants.WORLD_BOUNDARY.width;
			}
		}
		protected function bananas_restartGameHandler(event : Event) : void 
		{
			_bananas.showStartScreen();
			_bananas.hideGameOverScreen();
		}
		
		protected function bananas_startGameHandler(event : Event, mode : String) : void
		{
			// hide the start screen
			_bananas.hideStartScreen();
			
			createGame(mode);
			
			if(mode == Constants.GAME_MODE_PVP)
			{
				if(_aiController!= null)
				{
					_aiController.removeEventListeners();
				}
				
				_aiController = null;
				
			}
			else if(mode == Constants.GAME_MODE_PVC)
			{
				if(_aiController!= null)
				{
					_aiController.removeEventListeners();
				}
				
				// create a new ai controller if not done yet
				_aiController = new AIController();
				_aiController.addEventListener( BananasEvent.DRAG_RELEASED, touch_dragReleasedHandler );
				_aiController.addEventListener( BananasEvent.DRAGGED, touch_draggedHandler);
//				_aiController.addEventListener( BananasEvent.DRAG_RELEASED, touch_dragReleasedHandler);
				_aiController.addEventListener( BananasEvent.DRAG_STARTED, touch_dragStartedHandler);
//				_aiController.addEventListener( BananasEvent.DRAGGED, touch_draggedHandler);
			}
			
			
			// make game active
			_model.gameActive = true;
		}
	}
}