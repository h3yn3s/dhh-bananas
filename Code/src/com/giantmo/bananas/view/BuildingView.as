package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Building;
	
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author ...
	 */
	public class BuildingView extends Sprite
	{
		// Building data object
		public var data : Building;
		
		// display object
		private var _image : Image;
		
		public function BuildingView() 
		{
			_image = new Image( Assets.building );
			this.addChild( _image );
		}
		
		public function update() : void
		{
			// update size
			//_image.width = data.bounds.width;
			//_image.height = data.bounds.height;
			
			this.x = data.bounds.x;
			this.y = data.bounds.y;
			//this.rotation = data.rotation;
		}
	}

}