package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Gorilla;
	
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
			_gorillaArm.x = Gorilla.ARM_X;
			_gorillaArm.y = Gorilla.ARM_Y;
			_gorillaArm.visible = false;
			this.addChild( _gorillaArm );
			
			_gorillaArmBanana = new Image (Assets.gorillaArmBanana);
			_gorillaArmBanana.x = Gorilla.ARM_X;
			_gorillaArmBanana.y = Gorilla.ARM_Y;
			_gorillaArmBanana.visible = false;
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
		}
		
		public function update() : void
		{
			// set visibility of lives
			for (var idx:int = 0; idx < _livesDisplays.length; idx++) 
			{
				_livesDisplays[idx].visible = idx + 1 <= data.lives; 
			}
			
			// draw arm, if player is inactive
			if (!data.active) 
			{
				_gorillaArm.visible = true;
				_gorillaArmBanana.visible = false;
			} else {
				_gorillaArmBanana.visible = true;
				_gorillaArm.visible = false;
			}
						
			this.x = data.bounds.x;
			this.y = data.bounds.y;
		}
	}

}