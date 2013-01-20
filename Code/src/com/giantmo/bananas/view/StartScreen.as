package com.giantmo.bananas.view
{
	import com.giantmo.bananas.controller.BananasEvent;
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Constants;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * TODO Add ASdoc
	 */
	public class StartScreen extends Sprite
	{
		// ======================================
		// =====	CONSTANTS				=====
		// ======================================
		
		// ======================================
		// =====	PROPERTIES				=====
		// ======================================
		private var _background : Image;
		
		private var _pvpButton  : Button;
		private var _pvcButton  : Button;
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function StartScreen()
		{
			super();
			
			_background = new Image( Assets.greyPixel );
			_background.width  = Constants.WORLD_BOUNDARY.width;
			_background.height = Constants.WORLD_BOUNDARY.height;
			this.addChild( _background );
			
			_pvpButton = new Button( Assets.pvpButton );
			_pvpButton.useHandCursor = true;
			_pvpButton.x = (Constants.WORLD_BOUNDARY.width / 2) - 430 - 20;
			_pvpButton.y = (Constants.WORLD_BOUNDARY.height - 430) / 2;
			this.addChild( _pvpButton );
			
			_pvcButton = new Button( Assets.pvcButton );
			_pvcButton.useHandCursor = true;
			_pvcButton.x = (Constants.WORLD_BOUNDARY.width / 2) + 20;
			_pvcButton.y = (Constants.WORLD_BOUNDARY.height - 430) / 2;
			this.addChild( _pvcButton );
			
			_pvpButton.addEventListener( Event.TRIGGERED, pvpButton_triggeredHandler );
			_pvcButton.addEventListener( Event.TRIGGERED, pvcButton_triggeredHandler );
		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	PROTECTED FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	PRIVATE FUNCTIONS		=====
		// ======================================
		
		// ======================================
		// =====	EVENT HANDLERS			=====
		// ======================================
		protected function pvpButton_triggeredHandler(event : Event) : void
		{
			this.dispatchEventWith( BananasEvent.START_GAME_SELECTED, true, Constants.GAME_MODE_PVP );
		}
		
		protected function pvcButton_triggeredHandler(event : Event) : void
		{
			this.dispatchEventWith( BananasEvent.START_GAME_SELECTED, true, Constants.GAME_MODE_PVC );
		}
	}
}