package com.giantmo.bananas.controller 
{
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Model;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundController extends EventDispatcher
	{	
		public static const BANANA_THEME : String = new String ( "bananaTheme" );
		public static const BANANA_FLYING : String = new String ( "bananaFlying" );
		public static const EXPLOSION : String = new String ( "explosion" );
		public static const GORILLA_FALLING : String = new String ( "gorillaFalling" );
		public static const GORILLA_GOT_HIT : String = new String ( "gorillaGotHit" );
		public static const GORILLA_LOST : String = new String ( "gorillaLost" );
		public static const GORILLA_WINS : String = new String ( "gorillaWins" );
		public static const GORILLA_THROW_STARTED : String = new String ( "gorillaThrowStarted" );
		public static const GORILLA_THROW_RELEASED : String = new String ( "gorillaThrowReleased" );
		
		private var _soundChannel : SoundChannel;
		private var _soundTransform : SoundTransform;
		private var _model : Model;
		
		// gorilla wins sound duration
		private var _loseDuration : Number;
		private var _losePlaying : Boolean;
				
		public function SoundController( model : Model) 
		{
			_soundChannel = new SoundChannel();
			_soundTransform = new SoundTransform();
			_losePlaying = false;
			_loseDuration = 0;
			_model = model;
		}
		
		public function tick(timePassed : Number ) : void 
		{
			// if someone won the game, the winning theme plays
			if (_losePlaying) {				
				_loseDuration += timePassed;
				// if the winning theme is over, dispatch this event!
				if (_loseDuration > (Assets.soundGorillaWins.length / 1000)) {					
					// now reset the variables for the next game
					_losePlaying = false;
					_loseDuration = 0;
					this.dispatchEventWith(BananasEvent.GAME_OVER);					
				}
			}
		}	
		
		public function playSound ( key : String ) : void 
		{
			if ( _model.bananaSound.playing )
			{
				switch (key) 
				{
					case BANANA_THEME: 
						_soundChannel = Assets.soundBananaTheme.play();										
						break;
					case BANANA_FLYING: 
						_soundChannel = Assets.soundBananaFlying.play();
						break;
					case EXPLOSION: 
						_soundChannel = Assets.soundExplosion.play();
						break;
					case GORILLA_FALLING: 
						_soundChannel = Assets.soundGorillaFalling.play();
						break;
					case GORILLA_GOT_HIT: 
						_soundChannel = Assets.soundGorillaGotHit.play();
						break;
					case GORILLA_LOST: 
						_soundChannel = Assets.soundGorillaLost.play();
						_losePlaying = true;
						break;
					case GORILLA_WINS: 
						_soundChannel = Assets.soundGorillaWins.play();
						break;
					case GORILLA_THROW_RELEASED: 
						_soundChannel = Assets.soundGorillaThrowReleased.play();
						break;
					case GORILLA_THROW_STARTED: 
						_soundChannel = Assets.soundGorillaThrowStarted.play();
						break;
					
					default:
				}
			}
		}
			
		public function muteSound () : void 
		{
			_soundTransform.volume = 0;
			this._soundChannel.soundTransform = _soundTransform;			
			
		}
		
		public function unmuteSound () : void 
		{
			_soundTransform.volume = 1;
			this._soundChannel.soundTransform = _soundTransform;			
		}
		
		public function stopSound ( key : String ) : void 
		{
			_soundChannel.stop();
/*			switch (key) 
			{
				case BANANA_THEME: 
					Assets.soundBananaTheme.close();
					break;
				case BANANA_FLYING: 
					_soundChannel = Assets.soundBananaFlying.close();
					break;
				case EXPLOSION: 
					Assets.soundExplosion.close();
					break;
				case GORILLA_FALLING: 
					Assets.soundGorillaFalling.close();
					break;
				case GORILLA_GOT_HIT: 
					Assets.soundGorillaGotHit.close();
					break;
				case GORILLA_LOST: 
					Assets.soundGorillaLost.close();
					break;
				case GORILLA_WINS: 
					Assets.soundGorillaWins.close();
					break;
				case GORILLA_THROWING: 
					Assets.soundGorillaThrowing.close();
					break;
				
				default:
			}*/
		}
		
		
	}

}
