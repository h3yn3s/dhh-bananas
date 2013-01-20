package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.BananaThrow;
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
				
		// BananaThrow data object
		public var bananaThrowData : BananaThrow;
		
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
			
			if (data.active) 
			{				
				if (bananaThrowData.inDragPhase)
				{
					_gorillaArm.visible = false;
					_gorillaArmBanana.visible = true;
					_gorillaArmBanana.rotation = data.armAngle;
				} else if (bananaThrowData.bananaFlying) {
					_gorillaArm.visible = true;
					_gorillaArmBanana.visible = false;
					_gorillaArm.rotation = data.armAngle;
				} else { // banana "hanging"
					_gorillaArm.visible = false;
					_gorillaArmBanana.visible = true;
					_gorillaArmBanana.rotation = data.armAngle;
				}
			} else {
				_gorillaArm.visible = true;
				_gorillaArmBanana.visible = false;
				_gorillaArmBanana.rotation = 0;
				_gorillaArm.rotation = data.armAngle;
			}		
						
			this.x = data.bounds.x;
			this.y = data.bounds.y;
		}
	}

}