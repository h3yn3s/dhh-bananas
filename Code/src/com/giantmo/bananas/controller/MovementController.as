package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Banana;
	import com.giantmo.bananas.model.BananaThrow;
	import com.giantmo.bananas.model.Cloud;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Wind;
	
	import starling.events.EventDispatcher;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author ...
	 */
	public class MovementController extends EventDispatcher
	{
		private var _banana : Banana;
		private var _clouds : Vector.<Cloud>;
		private var _wind : Wind;
		private var _bananaThrow : BananaThrow;
		
		public function MovementController(banana : Banana, clouds : Vector.<Cloud>, wind : Wind, bananaThrow : BananaThrow) 
		{
			_banana = banana;
			_clouds = clouds;
			_wind = wind;
			_bananaThrow = bananaThrow;
		}
		
		public function tick(timePassed : Number, bananaFlying : Boolean) : void
		{
			if (bananaFlying)
			{
				// change velocity based on "gravity"
				_bananaThrow.velocity.y += (Constants.GRAVITY * timePassed);
				_bananaThrow.velocity.x += (Constants.WIND_RESISTANCE * _wind.force)
				
				_banana.bounds.x += _bananaThrow.velocity.x * timePassed * Constants.BANANA_SPEED_MODIFIER;
				_banana.bounds.y += _bananaThrow.velocity.y * timePassed * Constants.BANANA_SPEED_MODIFIER;
				_banana.rotation += deg2rad(50 * timePassed);
			}
				
			// move the clouds
			for each (var cloud : Cloud in _clouds) 
			{
				cloud.position.x += _wind.force * timePassed;
			}
		}
	}

}