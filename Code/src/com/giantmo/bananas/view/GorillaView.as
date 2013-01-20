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
		private var _quad : Quad;
		
		// lives display
		private var _livesDisplays : Vector.<Image>;
		
		// power bar
		private var _powerBar : Image;
		
		public function GorillaView() 
		{
			// create gorilla
			_quad = new Quad(Gorilla.WIDTH, Gorilla.HEIGHT, 0x00ff00);
			this.addChild( _quad );
			
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
			
			// set active color
			_quad.color = data.active ? 0x00ff00 : 0x004400;
			
			this.x = data.bounds.x;
			this.y = data.bounds.y;
		}
	}

}