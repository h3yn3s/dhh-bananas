package com.giantmo.bananas.view
{
	import com.giantmo.bananas.controller.BananasEvent;
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.BananaSound;
	import com.giantmo.bananas.model.Constants;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * TODO Add ASdoc
	 */
	public class SoundView extends Sprite
	{
		// ======================================
		// =====	CONSTANTS				=====
		// ======================================
		public const SOUND_MIDDLE_X : int = (Constants.WORLD_BOUNDARY.width - 60);
		public const SOUND_MIDDLE_Y : int = (Constants.WORLD_BOUNDARY.height - 60);		
		
		// ======================================
		// =====	PROPERTIES				=====
		// ======================================
		public var data : BananaSound;
		
		private var _soundOn : Image;
		private var _soundOff : Image;
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function SoundView()
		{
			super();
			
			_soundOn= new Image( Assets.soundOn );			
			_soundOn.x = Constants.WORLD_BOUNDARY.width - _soundOn.width;
			_soundOn.y = Constants.WORLD_BOUNDARY.height - _soundOn.height;
			this.addChild( _soundOn );
			
			_soundOff = new Image( Assets.soundOff );
			_soundOff.x = Constants.WORLD_BOUNDARY.width - _soundOff.width;
			_soundOff.y = Constants.WORLD_BOUNDARY.height - _soundOff.height;
			this.addChild( _soundOff );

		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		public function switchSoundDisplay() : void
		{
			if (data.playing)
			{
				this._soundOff.visible = false;
				this._soundOn.visible = true;
			} else {
				this._soundOff.visible = true;
				this._soundOn.visible = false;
			}
		}
		
		// ======================================
		// =====	PROTECTED FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	PRIVATE FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	EVENT HANDLERS			=====
		// ======================================
	}
}