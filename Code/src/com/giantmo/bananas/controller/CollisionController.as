package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Banana;
	import com.giantmo.bananas.model.Building;
	import com.giantmo.bananas.model.Cloud;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Explosion;
	import com.giantmo.bananas.model.Gorilla;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.events.EventDispatcher;

	/**
	 * ...
	 * @author ...
	 */
	public class CollisionController extends EventDispatcher
	{
		private var _banana 	: Banana;
		private var _gorillas 	: Vector.<Gorilla>;
		private var _buildings 	: Vector.<Building>;
		private var _clouds		: Vector.<Cloud>;
		private var _explosions	: Vector.<Explosion>;
		
		private var _boundary 	: Rectangle;
		
		
		public function CollisionController( banana : Banana, 
											 gorillas : Vector.<Gorilla>, 
											 buildings : Vector.<Building>, 
											 clouds : Vector.<Cloud>, 
											 explosions	: Vector.<Explosion>,
											 boundary : Rectangle ) 
		{
			// map game objects
			_banana = banana;
			_gorillas = gorillas;
			_buildings = buildings;
			_clouds = clouds;
			_explosions = explosions;
			
			// map boundary
			_boundary = boundary;
		}
		
		public function tick(bananaFlying : Boolean):void 
		{
			if (bananaFlying) 
			{
				var collisionDetected : Boolean = false;
				
				// check banana vs world
				collisionDetected = checkBananaOutOfBounds();
				
				// no collision detected -> check banana vs gorillas
				if(!collisionDetected)
					checkBananaAndGorillas();
				
				// no collision detected -> check banana vs buildings
				if(!collisionDetected)
					checkBananaAndBuildings();
			}
			checkCloudsOutOfBounds();			
		}
		
		protected function checkBananaOutOfBounds() : Boolean
		{
			if (!_banana.bounds.intersects(_boundary)) 
			{
				if ((_banana.bounds.y > (_boundary.y + _boundary.height)) || // bottom hit?
					(_banana.bounds.x < _boundary.x) || // left side hit?
					(_banana.bounds.x > (_boundary.x + _boundary.width))) // right side hit?
				// dispatch the event that the banana has left...
				this.dispatchEventWith(BananasEvent.BANANA_COLLISION_OUT_OF_WORLD);
				
				return true;
					
			}
			
			return false;
		}
		
		protected function checkBananaAndGorillas() : Boolean
		{
			// check intersection of each gorilla with the banana
			for (var idx : int = 0; idx < _gorillas.length; idx++)
			{
				// can't shoot yourself...				
				if ( _banana.owner != _gorillas[idx].id && _banana.bounds.intersects(_gorillas[idx].bounds)) 
				{
					// gorilla has been hit -> dispatch event
					dispatchEventWith( BananasEvent.BANANA_COLLISION_GORILLA, false, _gorillas[idx] );
					
					return true;
				}
			}
			
			return false;
		}
		
		protected function checkBananaAndBuildings() : Boolean
		{
			// check intersection of each building with the banana
			for (var idx : int = 0; idx < _buildings.length; idx++)
			{
				if (_banana.bounds.intersects(_buildings[idx].bounds)) 
				{
					var isColliding : Boolean = true;
					
					var intersection : Rectangle = _banana.bounds.intersection(_buildings[idx].bounds);
					trace("INTERSECTION", intersection);
					
					// go through the explosions and check
					/*for (var idx2 : int = 0; idx2 < _explosions.length; idx2++)
					{
						var exp : Explosion = _explosions[idx2];
						
						//trace("DISTANCE", _banana.bounds.topLeft, exp.position, );
												
						if( _banana.bounds.topLeft.subtract( exp.position ).length <= Explosion.RADIUS
							|| _banana.bounds.bottomRight.subtract( exp.position ).length <= Explosion.RADIUS) // if the banana is in an exploded area
						{
							isColliding = false;
							break;
						}
					}*/
					
					if(isColliding)
					{
						// calculate collision center
						var collisionPoint : Point = new Point( intersection.x + intersection.width / 2, intersection.y + intersection.height / 2 ); 
						trace("COLLISION POINT", collisionPoint);
						
						// gorilla has been hit -> dispatch event
						dispatchEventWith( BananasEvent.BANANA_COLLISION_BUILDING, false, {building : _buildings[idx], collisionPoint : collisionPoint} );
						
						return true;
					}
				}
			}
			
			return false;
		}
		
		protected function checkCloudsOutOfBounds() : void 
		{
			for each (var cloud : Cloud in _clouds ) 
			{
				if (((cloud.position.x + Cloud.WIDTH) < -5) ||
					(cloud.position.x > (Constants.WORLD_BOUNDARY.width + 5)))
				{
					dispatchEventWith( BananasEvent.CLOUD_LEFT_THE_WORLD, false, cloud);
				}
				
			}
		}
	}

}