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
					
					// find the first collision of the movement line with the building
					var collisionPoints : Array = rayBoxIntersect( _banana.oldPosition, _banana.bounds.topLeft, _buildings[idx].bounds.topLeft, _buildings[idx].bounds.bottomRight );
					
					if(collisionPoints != null && collisionPoints.length > 0)
					{
						var collisionPoint : Point = collisionPoints[0];
						if(collisionPoint == null)
							collisionPoint = collisionPoints[1];
						
						// go through the explosions and check
						for (var idx2 : int = 0; idx2 < _explosions.length; idx2++)
						{
							var exp : Explosion = _explosions[idx2];
							
							// check if is in explosion radius
							if( intersectRectCircle( _banana.bounds, exp.position, Explosion.RADIUS ) )
							{
								_banana.wasInExplosion = true;
								isColliding = false;
								break;
							}
						}
						
						if(isColliding)
						{
							
							// gorilla has been hit -> dispatch event
							dispatchEventWith( 
								BananasEvent.BANANA_COLLISION_BUILDING, 
								false, {
									building : _buildings[idx], 
									collisionPoint : _banana.wasInExplosion ? new Point( _banana.bounds.x + _banana.bounds.width / 2, _banana.bounds.y + _banana.bounds.height / 2) : collisionPoint
								} 
							);
							
							return true;
						}
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
		
		public function rayBoxIntersect(r1:Point, r2:Point, box1:Point, box2:Point):Array {
			
			// lower values of bounding box
			var b1:Point = new Point();
			// higher values of bounding box
			var b2:Point = new Point();
			
			b1.x = Math.min(box1.x, box2.x);
			b1.y = Math.min(box1.y, box2.y);
			b2.x = Math.max(box1.x, box2.x);
			b2.y = Math.max(box1.y, box2.y);
			
			if (b2.x < Math.min(r1.x, r2.x) || b1.x > Math.max(r1.x, r2.x)) return null;
			if (b2.y < Math.min(r1.y, r2.y) || b1.y > Math.max(r1.y, r2.y)) return null;
			
			var arr:Array = [];
			var tnear:Number;	// near value on plane
			var tfar:Number;	// far value on plane
			
			tnear = Math.max((b1.x - r1.x) / (r2.x - r1.x), (b1.y - r1.y) / (r2.y - r1.y));
			tfar = Math.min((b2.x - r1.x) / (r2.x - r1.x), (b2.y - r1.y) / (r2.y - r1.y));
			if (tnear < tfar) {
				if (tnear >=0 && tnear <= 1) arr[0] = Point.interpolate(r2, r1, tnear);
				if (tfar >= 0 && tfar <= 1) arr[1] = Point.interpolate(r2, r1, tfar);
				return arr;
			}
			
			tnear = Math.min((b1.x - r1.x) / (r2.x - r1.x), (b1.y - r1.y) / (r2.y - r1.y));
			tfar = Math.max((b2.x - r1.x) / (r2.x - r1.x), (b2.y - r1.y) / (r2.y - r1.y));
			if (tnear > tfar) {
				if (tnear >=0 && tnear <= 1) arr[0] = Point.interpolate(r2, r1, tnear);
				if (tfar >= 0 && tfar <= 1) arr[1] = Point.interpolate(r2, r1, tfar);
				return arr;
			}
			
			tnear = Math.min((b2.x - r1.x) / (r2.x - r1.x), (b1.y - r1.y) / (r2.y - r1.y));
			tfar = Math.max((b1.x - r1.x) / (r2.x - r1.x), (b2.y - r1.y) / (r2.y - r1.y));
			if (tnear > tfar) {
				if (tnear >=0 && tnear <= 1) arr[0] = Point.interpolate(r2, r1, tnear);
				if (tfar >= 0 && tfar <= 1) arr[1] = Point.interpolate(r2, r1, tfar);
				return arr;
			}
			
			tnear = Math.max((b2.x - r1.x) / (r2.x - r1.x), (b1.y - r1.y) / (r2.y - r1.y));
			tfar = Math.min((b1.x - r1.x) / (r2.x - r1.x), (b2.y - r1.y) / (r2.y - r1.y));
			if (tnear < tfar) {
				if (tnear >=0 && tnear <= 1) arr[0] = Point.interpolate(r2, r1, tnear);
				if (tfar >= 0 && tfar <= 1) arr[1] = Point.interpolate(r2, r1, tfar);
				return arr;
			}
			
			return null;
		}
		
		public function clamp(value:Number, minimum:Number, maximum:Number):Number
		{
			if(minimum > maximum)
			{
				throw new ArgumentError("minimum should be smaller than maximum.");
			}
			return Math.min(maximum, Math.max(minimum, value));
		}
		
		public function intersectRectCircle(rectangle : Rectangle, circle : Point, radius : Number) : Boolean
		{
			var closestX : Number = clamp(circle.x, rectangle.left, rectangle.right);
			var closestY : Number = clamp(circle.y, rectangle.top, rectangle.bottom);
			
			// Calculate the distance between the circle's center and this closest point
			var distanceX : Number = circle.x - closestX;
			var distanceY : Number = circle.y - closestY;
			
			// If the distance is less than the circle's radius, an intersection occurs
			var distanceSquared : Number = (distanceX * distanceX) + (distanceY * distanceY);
			return distanceSquared < (radius * radius);
		}
	}
	
}