package com.giantmo.bananas.view
{
	import com.giantmo.bananas.controller.BananasEvent;
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.model.Model;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * The Game Over Screen after one of the players has "lost" the game...
	 */
	public class GameOverScreen extends Sprite
	{
		// ======================================
		// =====	CONSTANTS				=====
		// ======================================
		
		// ======================================
		// =====	PROPERTIES				=====
		// ======================================
		public var model : Model;
		
		private var _background : Image;
		private var _player1Wins : Image;
		private var _player2Wins : Image;
		private var _computerWins : Image;
		
		private var _againButton  : Button;		
		
		// ======================================
		// =====	CONSTRUCTOR				=====
		// ======================================
		public function GameOverScreen()
		{
			super();
			
			// background
			_background = new Image( Assets.greyPixel );
			_background.width  = Constants.WORLD_BOUNDARY.width;
			_background.height = Constants.WORLD_BOUNDARY.height;
			this.addChild( _background );
			
			// winner display images
			_player1Wins = new Image( Assets.player1Wins );
			_player1Wins.x = (Constants.WORLD_BOUNDARY.width / 2) - (_player1Wins.width / 2);
			_player1Wins.y = 30;
			_player1Wins.visible = false;
			this.addChild( _player1Wins );
			
			_player2Wins = new Image( Assets.player2Wins );
			_player2Wins.x = (Constants.WORLD_BOUNDARY.width / 2) - (_player2Wins.width / 2);
			_player2Wins.y = 30;
			_player2Wins.visible = false;
			this.addChild( _player2Wins );
			
			_computerWins = new Image( Assets.computerWins );
			_computerWins.x = (Constants.WORLD_BOUNDARY.width / 2) - (_computerWins.width / 2);
			_computerWins.y = 30;
			_computerWins.visible = false;
			this.addChild( _computerWins );
			
			// again Button for game restart
			_againButton = new Button( Assets.againButton );
			_againButton.useHandCursor = true;
			_againButton.x = (Constants.WORLD_BOUNDARY.width / 2) - (_againButton.width / 2);
			_againButton.y = (Constants.WORLD_BOUNDARY.height - 180);
			this.addChild( _againButton );
			
			_againButton.addEventListener( Event.TRIGGERED, againButton_triggeredHandler );			
		}
		
		// ======================================
		// =====	GETTER / SETTER			=====
		// ======================================
		
		// ======================================
		// =====	PUBLIC FUNCTIONS		=====
		// ======================================
		public function setWinner( ) : void
		{
			_player1Wins.visible = false;
			_player2Wins.visible = false; 
			_computerWins.visible = false;
			trace("current Player:", this.model.currentPlayer);
			
			switch (this.model.currentPlayer) 
			{
				case Constants.PLAYER_1:
					_player1Wins.visible = true;
				break;
				case Constants.PLAYER_2:
					if (this.model.mode == Constants.GAME_MODE_PVP) 
					{
						_player2Wins.visible = true;
					} else {
						_computerWins.visible = true;
					}
				break;				
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
		protected function againButton_triggeredHandler(event : Event) : void
		{
			this.dispatchEventWith( BananasEvent.RESTART_GAME, true );
		}
		
	}
}