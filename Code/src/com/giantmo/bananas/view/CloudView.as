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
			
			_image = new Image( Assets.cloud1_front );
			_image.width = Cloud.FRONT_WIDTH;
			_image.height = Cloud.FRONT_HEIGHT;
			this.addChild( _image );
		}
		
		public function update() : void
		{
			// update size
			this.x = data.position.x;
			this.y = data.position.y;	
			
			// update the type & layer of the cloud
			switch(data.cloudLayer)
			{
				case Cloud.FRONT_CLOUD:
					_image.width = Cloud.FRONT_WIDTH;
					_image.height = Cloud.FRONT_HEIGHT;
					switch (data.cloudType)
					{
						case Cloud.CLOUD_TYPE_1:
							_image.texture = Assets.cloud1_front;
							break;
						case Cloud.CLOUD_TYPE_2:
							_image.texture = Assets.cloud2_front;
							break;
						case Cloud.CLOUD_TYPE_3:
							_image.texture = Assets.cloud3_front;
							break;
					}
				break;
				case Cloud.MIDDLE_CLOUD:
					_image.width = Cloud.MIDDLE_WIDTH;
					_image.height = Cloud.MIDDLE_HEIGHT;
					switch (data.cloudType)
					{
						case Cloud.CLOUD_TYPE_1:
							_image.texture = Assets.cloud1_middle;
							break;
						case Cloud.CLOUD_TYPE_2:
							_image.texture = Assets.cloud2_middle;
							break;
						case Cloud.CLOUD_TYPE_3:
							_image.texture = Assets.cloud3_middle;
							break;
					}
				break;
				case Cloud.BACK_CLOUD:
					_image.width = Cloud.BACK_WIDTH;
					_image.height = Cloud.BACK_HEIGHT;
					switch (data.cloudType)
					{
						case Cloud.CLOUD_TYPE_1:
							_image.texture = Assets.cloud1_back;
							break;
						case Cloud.CLOUD_TYPE_2:
							_image.texture = Assets.cloud2_back;
							break;
						case Cloud.CLOUD_TYPE_3:
							_image.texture = Assets.cloud3_back;
							break;
					}
				break;
			}
		}
	}

}