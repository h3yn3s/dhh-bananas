package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Cloud;
	
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class CloudView extends Sprite
	{
		public var data : Cloud;
		
		private var _image : Image;
		
		public function CloudView() 
		{
			_image = new Image( Assets.cloud );
			_image.width = Cloud.WIDTH;
			_image.height = Cloud.HEIGHT;
			this.addChild( _image );
		}
		
		public function update() : void
		{
			// update size
			this.x = data.position.x;
			this.y = data.position.y;			
		}
	}

}