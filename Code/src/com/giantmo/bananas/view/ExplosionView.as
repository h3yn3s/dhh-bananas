package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Explosion;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author ...
	 */
	public class ExplosionView extends Sprite
	{
		public var data : Explosion;
		
		private var _image : Image;
		
		public function ExplosionView() 
		{
			_image = new Image( Assets.explosion );
			_image.width  = Explosion.RADIUS * 2;
			_image.height = Explosion.RADIUS * 2;
			this.addChild( _image );
			
			this.blendMode = BlendMode.ERASE;
		}
		
		public function update() : void
		{
			// update size
			this.x = data.position.x - Explosion.RADIUS;
			this.y = data.position.y - Explosion.RADIUS;			
		}
		
		override public function dispose():void
		{
			data = null;
			
			super.dispose();
		}
	}

}