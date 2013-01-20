package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.PowerBar;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author ...
	 */
	public class PowerBarView extends Sprite
	{
		// Gorilla data object
		public var data : PowerBar;		
		
		// power bar border
		private var _powerBarBorder : Image;
		
		// power bar fill
		private var _powerBarFill : Image;
		private var _fillTexturePointA : Point;
		private var _fillTexturePointB : Point;
		
		public function PowerBarView() 
		{
			this.visible 	= false;
			this.touchable  = false;
			this.pivotX 	= 3;	// pivot point of power bar at cone tip
			this.pivotY 	= 22; 	// pivot point of power bar at cone tip
			
			// create power bar
			_powerBarFill = new Image( Assets.powerBarFill );
			this.addChild( _powerBarFill );
			
			_powerBarBorder = new Image( Assets.powerBarBorder );
			this.addChild( _powerBarBorder );
			
			_fillTexturePointA = new Point(1.0, 0.0);
			_fillTexturePointB = new Point(1.0, 1.0);
		}
		
		public function update() : void
		{
			// update power bar if gorilla is aiming
			if(data.gorillaIsAiming)
			{
				// only add if not added yet
				this.visible = true;
				
				this.x = data.owningGorillaPosition.x + PowerBar.POWER_BAR_ORIGIN.x;
				this.y = data.owningGorillaPosition.y + PowerBar.POWER_BAR_ORIGIN.y;
				
				// update power bar rotation and force
				this.rotation 	= data.aimingAngle; // angle applies to rotation
				
				// set fill scale and texture
				_fillTexturePointA.x = data.aimingForce;
				_fillTexturePointB.x = data.aimingForce;
				
				_powerBarFill.scaleX = data.aimingForce;
				_powerBarFill.setTexCoords(1, _fillTexturePointA);
				_powerBarFill.setTexCoords(3, _fillTexturePointB);
			}
			else
			{
				// remove power bar if still there
				this.visible = false;
			}
		}
	}

}