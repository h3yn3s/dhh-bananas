package com.giantmo.bananas.view 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Banana;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author ...
	 */
	public class BananaView extends Sprite
	{
		public var data : Banana;
		
		private var mBorder : Sprite;
		
		private var _image : Image;
		
		public function BananaView() 
		{
			/*var bg : Quad = new Quad( Banana.WIDTH, Banana.HEIGHT, 0xF0AB00 );
			this.addChild( bg );*/
			
			mBorder = new Sprite();
			addChild(mBorder);
			
			for (var i:int=0; i<4; ++i)
				mBorder.addChild(new Quad(1.0, 1.0));
			
			updateBorder();
			
			_image = new Image( Assets.banana );
			_image.width = Banana.WIDTH;
			_image.height = Banana.HEIGHT;
			this.addChild( _image );
			
			this.pivotX = Banana.WIDTH  >> 1;
			this.pivotY = Banana.HEIGHT >> 1;
		}
		
		public function update() : void
		{
			// update size
			//_quad.width = data.bounds.width;
			//_quad.height = data.bounds.height;
			
			this.x = data.bounds.x + this.pivotX;
			this.y = data.bounds.y + this.pivotY;
			//this.rotation = data.rotation;
		}
		
		private function updateBorder():void
		{			
			var width:Number  = Banana.WIDTH;
			var height:Number = Banana.HEIGHT;
			
			var topLine:Quad    = mBorder.getChildAt(0) as Quad;
			var rightLine:Quad  = mBorder.getChildAt(1) as Quad;
			var bottomLine:Quad = mBorder.getChildAt(2) as Quad;
			var leftLine:Quad   = mBorder.getChildAt(3) as Quad;
			
			topLine.width    = width; topLine.height    = 1;
			bottomLine.width = width; bottomLine.height = 1;
			leftLine.width   = 1;     leftLine.height   = height;
			rightLine.width  = 1;     rightLine.height  = height;
			rightLine.x  = width  - 1;
			bottomLine.y = height - 1;
			topLine.color = rightLine.color = bottomLine.color = leftLine.color = 0x000000;
		}
	}

}