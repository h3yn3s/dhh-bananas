package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Gorilla;
	import com.giantmo.bananas.model.PowerBar;
	import starling.utils.deg2rad;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author ...
	 */
	public class GorillaView extends Sprite
	{
		// Gorilla data object
		public var data : Gorilla;
		
		// PowerBar data object
		public var powerBarData : PowerBar;
		
		// display object
		// private var _quad : Quad;
		private var _gorilla : Image;
		
		// lives display
		private var _livesDisplays : Vector.<Image>;
		
		// arm without banana
		private var _gorillaArm : Image;
		
		// arm with banana
		private var _gorillaArmBanana : Image;
		
		public function GorillaView() 
		{
			// create gorilla
			_gorilla = new Image( Assets.gorilla );			
			_gorilla.height = Gorilla.HEIGHT;
			_gorilla.width = Gorilla.WIDTH;			
			this.addChild( _gorilla );
			
			// create arms (with & without banana)
			_gorillaArm = new Image( Assets.gorillaArm);
			_gorillaArm.x = Gorilla.ARM_X + (_gorillaArm.width / 2);;			
			_gorillaArm.y = Gorilla.ARM_Y;
			_gorillaArm.visible = false;
			_gorillaArm.pivotX = Gorilla.ARM_X + (_gorillaArm.width / 2);
			this.addChild( _gorillaArm );
			
			_gorillaArmBanana = new Image (Assets.gorillaArmBanana);
			_gorillaArmBanana.x = Gorilla.ARM_X + (_gorillaArmBanana.width / 2);
			_gorillaArmBanana.y = Gorilla.ARM_Y;
			_gorillaArmBanana.visible = false;
			_gorillaArmBanana.pivotX = Gorilla.ARM_X + (_gorillaArmBanana.width / 2);
			
			this.addChild( _gorillaArmBanana );			
			
			// create lives displays
			_livesDisplays = new Vector.<Image>(3);
			var xPos : Array = [0, (Gorilla.WIDTH - 12) / 2, Gorilla.WIDTH - 12];
			for (var idx:int = 0; idx < _livesDisplays.length; idx++) 
			{
				var life : Image = new Image( Assets.heart );
				life.x = xPos[idx]; 
				life.y = -16;
				_livesDisplays[idx] = life; 
				
				this.addChild(life);
			}
			
			// set the pivot to the middle
			this.pivotX = this.width / 2;
		}
		
		public function update() : void
		{
			// set visibility of lives
			for (var idx:int = 0; idx < _livesDisplays.length; idx++) 
			{
				_livesDisplays[idx].visible = idx + 1 <= data.lives; 
			}
			
			// draw arm, if player is inactive
			if (data.active) 
			{
				// switch display of arms
				_gorillaArmBanana.visible = true;
				_gorillaArm.visible = false;
				
				// change arm with banana angle based on powerBar
				// step 1: apply the angle of the powerBar
				if ( powerBarData.gorillaIsAiming) {
					if ( data.id == 0 ) {					
						_gorillaArmBanana.rotation = powerBarData.aimingAngle; // angle applies to rotation
						// step 2: add 180° to the powerBar angle
						_gorillaArmBanana.rotation += deg2rad(180);					
					} else {
						_gorillaArmBanana.rotation = (-1 * powerBarData.aimingAngle); // angle applies to rotation
					}				
					
					// step 3: convert the "power" of the bar into angle as well
					_gorillaArmBanana.rotation -= ( powerBarData.aimingForce * 2 );
				}				
				
			} else {
				// switch display of arms
				_gorillaArm.visible = true;
				_gorillaArmBanana.visible = false;
				_gorillaArmBanana.rotation = 0;
			}
						
			this.x = data.bounds.x;
			this.y = data.bounds.y;
		}
	}

}