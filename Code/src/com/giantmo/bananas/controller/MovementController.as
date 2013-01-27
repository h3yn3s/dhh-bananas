package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Banana;
	import com.giantmo.bananas.model.BananaThrow;
	import com.giantmo.bananas.model.Cloud;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Gorilla;
	import com.giantmo.bananas.model.Wind;
	import starling.utils.rad2deg;
	
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
		private var _gorillas : Vector.<Gorilla>;
		
		public function MovementController(banana : Banana, clouds : Vector.<Cloud>, wind : Wind, bananaThrow : BananaThrow, gorilla : Vector.<Gorilla> ) 
		{
			_banana = banana;
			_clouds = clouds;
			_wind = wind;
			_bananaThrow = bananaThrow;
			_gorillas = gorilla;
		}
		
		public function tick(timePassed : Number) : void
		{
			if (_bananaThrow.bananaFlying)
			{
				// change velocity based on "gravity"
				_bananaThrow.velocity.y += (Constants.GRAVITY * timePassed);
				_bananaThrow.velocity.x += (Constants.WIND_RESISTANCE * _wind.force)
				
				_banana.oldPosition.x = _banana.bounds.x;
				_banana.oldPosition.y = _banana.bounds.y;
				
				_banana.bounds.x += _bananaThrow.velocity.x * timePassed * Constants.BANANA_SPEED_MODIFIER;
				_banana.bounds.y += _bananaThrow.velocity.y * timePassed * Constants.BANANA_SPEED_MODIFIER;
				if (_banana.owner == Constants.PLAYER_1)
				{
					_banana.rotation += deg2rad(500 * timePassed);
				} else {
					_banana.rotation += deg2rad(-500 * timePassed);
				}
			}
				
			// move the clouds
			for each (var cloud : Cloud in _clouds) 
			{
				cloud.position.x += _wind.force * timePassed;
			}
			
			// move the arm of the gorilla back in position			
			for (var idx : int = 0; idx < _gorillas.length; idx++)
			{
				if (_gorillas[idx].active) 
				{
					if (!_bananaThrow.inDragPhase && _bananaThrow.bananaFlying)
					{	
						if (Math.abs(rad2deg(_gorillas[idx].armAngle) % 360) > 10) 
						{
							_gorillas[idx].armAngle += deg2rad(Constants.GORILLA_ARM_REPOSITION_SPEED * timePassed);
						} else {
							_gorillas[idx].armAngle = 0;
						}
					}
				} else {					
					if (Math.abs(rad2deg(_gorillas[idx].armAngle) % 360) > 10) 
					{
						_gorillas[idx].armAngle += deg2rad(Constants.GORILLA_ARM_REPOSITION_SPEED * timePassed);						
					} else {
						_gorillas[idx].armAngle = 0;
					}
				}
			}
		}
	}
}