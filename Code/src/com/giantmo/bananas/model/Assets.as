package com.giantmo.bananas.model 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author ...
	 */
	public class Assets 
	{
		private static var _textureBuffer   : Dictionary; 		// subtexture buffer
		private static var _textures : TextureAtlas;	// texture atlas
		private static var _soundBuffer   : Dictionary;
		
		public static var explosionEffectXML : XML;
		
		private static var _readyCallback : Function; // ready callback
		
		// TEXTURE ACCESS
		
		/** Get the gorilla arm texture. */
		public static function get gorillaArm() : Texture
		{
			return getTexture( "Gorilla_arm_ingame_small" ); 
		}
		
		/** Get the gorilla arm with banana texture. */
		public static function get gorillaArmBanana() : Texture
		{
			return getTexture( "Gorilla_arm_mit_banane_ingame_small" ); 
		}
		
		/** Get the gorilla texture. */
		public static function get gorilla() : Texture
		{
			return getTexture( "Gorilla_ingame_small" ); 
		}
		
		/** Get the power bar fill texture. */
		public static function get powerBarFill() : Texture
		{
			return getTexture( "powerbar_fill" ); 
		}
		
		/** Get the power bar border texture. */
		public static function get powerBarBorder() : Texture
		{
			return getTexture( "powerbar_border" ); 
		}
		
		/** Get the banana texture. */
		public static function get banana() : Texture
		{
			return getTexture( "banana" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud() : Texture
		{
			return getTexture( "cloud" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud1_front() : Texture
		{
			return getTexture( "cloud1_front" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud2_front() : Texture
		{
			return getTexture( "cloud2_front" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud3_front() : Texture
		{
			return getTexture( "cloud3_front" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud1_middle() : Texture
		{
			return getTexture( "cloud1_middle" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud2_middle() : Texture
		{
			return getTexture( "cloud2_middle" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud3_middle() : Texture
		{
			return getTexture( "cloud3_middle" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud1_back() : Texture
		{
			return getTexture( "cloud1_back" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud2_back() : Texture
		{
			return getTexture( "cloud2_back" ); 
		}
		
		/** Get the cloud texture. */
		public static function get cloud3_back() : Texture
		{
			return getTexture( "cloud3_back" ); 
		}
		
		/** Get the explosion erase texture. */
		public static function get explosion() : Texture
		{
			return getTexture( "explosion" ); 
		}
		
		/** Get the explosion effect texture. */
		public static function get explosionEffect() : Texture
		{
			return getTexture( "explosion_effect" ); 
		}
		
		/** Get the building texture. */
		public static function get building() : Texture
		{
			return getTexture( "building" ); 
		}
		
		/** Get the heart texture. */
		public static function get heart() : Texture
		{
			return getTexture( "heart" ); 
		}
		
		/** Get the screen overlay texture. */
		public static function get greyPixel() : Texture
		{
			return getTexture( "grey_pixel", new Rectangle(1,1,2,2) ); 
		}
		
		/** Player 1 wins texture */
		public static function get player1Wins() : Texture
		{
			return getTexture( "player_1_wins" );
		}
		
		/** Player 2 wins texture */
		public static function get player2Wins() : Texture
		{
			return getTexture( "player_2_wins" );
		}
		
		/** Computer wins texture */
		public static function get computerWins() : Texture
		{
			return getTexture( "computer_wins" );
		}
		
		/** PVP Button texture. */
		public static function get pvpButton() : Texture
		{
			return getTexture( "pvp_button" ); 
		}
		
		/** PVC Button texture. */
		public static function get pvcButton() : Texture
		{
			return getTexture( "pvc_button" ); 
		}
		
		/** Again? Button texture. */
		public static function get againButton() : Texture
		{
			return getTexture( "again_button" ); 
		}
		
		/** Sound On texture. */
		public static function get soundOn() : Texture
		{
			return getTexture( "sound_on" ); 
		}
		
		/** Sound Off texture. */
		public static function get soundOff() : Texture
		{
			return getTexture( "sound_off" ); 
		}
		
		/** Get a texture form the buffer or create it. */
		private static function getTexture(key : String, region : Rectangle = null) : Texture
		{
			if(_textureBuffer[key] == null)
			{
				if(region == null)
					_textureBuffer[key] = _textures.getTexture( key );
				else
					_textureBuffer[key] = Texture.fromTexture( _textures.getTexture( key ), region );
			}
			
			return _textureBuffer[key];
		}
		
		/** Get the theme sound */
		public static function get soundBananaTheme() : Sound
		{
			return getSound( "sound_bananas_theme" ); 
		}
		
		/** Get the banana flying sound */
		public static function get soundBananaFlying() : Sound
		{
			return getSound( "sound_banana_flying" ); 
		}
		
		/** Get the explosion sound */
		public static function get soundExplosion() : Sound
		{
			return getSound( "sound_explosion" ); 
		}
		
		/** Get the gorilla falling sound */
		public static function get soundGorillaFalling() : Sound
		{
			return getSound( "sound_gorilla_falling" ); 
		}
		
		/** Get the gorilla got hit sound */
		public static function get soundGorillaGotHit() : Sound
		{
			return getSound( "sound_gorilla_got_hit" ); 
		}
		
		/** Get the gorilla lost sound */
		public static function get soundGorillaLost() : Sound
		{
			return getSound( "sound_gorilla_lost" ); 
		}
		
		/** Get the gorilla throw released sound */
		public static function get soundGorillaThrowReleased() : Sound
		{
			return getSound( "sound_gorilla_throw_released" ); 
		}
		
		/** Get the gorilla throw started sound */
		public static function get soundGorillaThrowStarted() : Sound
		{
			return getSound( "sound_gorilla_throw_started" ); 
		}
		
		/** Get the gorilla wins sound */
		public static function get soundGorillaWins() : Sound
		{
			return getSound( "sound_gorilla_wins" ); 
		}
		
		/** Get a texture form the buffer or create it. */
		private static function getSound(key : String) : Sound
		{
			if( _soundBuffer[key] == null)
			{
				_soundBuffer[key] = LoaderMax.getContent( key );
			}
			
			return _soundBuffer[key];
		}
		
		// LOADING STUFF
		public static function loadAssets(readyCallback : Function) : void
		{
			// set ready callback
			_readyCallback = readyCallback;
			
			// create buffer
			_textureBuffer = new Dictionary();
			_soundBuffer = new Dictionary();
			
			// get the file directory
			var fileDir : String = File.applicationDirectory.url;			
			
			// create a loader max queue
			var loaderQueue : LoaderMax = new LoaderMax( {name:"assetsQueue", onProgress : loader_progressHandler, onComplete : loader_completeHandler, onError : loader_errorHandler});
			
			// load textures
			loaderQueue.append( new XMLLoader( fileDir + "assets/textures.xml", {name:"textures_xml"}) );
			loaderQueue.append( new ImageLoader( fileDir + "assets/textures.png", {name:"textures_png"}) );
			
			// load effects
			loaderQueue.append( new XMLLoader( fileDir + "assets/effects/explosion_effect.pex", {name:"explosion_effect"}) );
			
			// add MP3Loader & sounds
			// load this all into one mp3 file to make it a better performance...
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Banana_flying.mp3", { name:"sound_banana_flying", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Bananas_Theme.mp3", { name:"sound_bananas_theme", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Explosion.mp3", { name:"sound_explosion", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_falling.mp3", { name:"sound_gorilla_falling", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_got_hit.mp3", { name:"sound_gorilla_got_hit", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_lost.mp3", { name:"sound_gorilla_lost", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_throw_started.mp3", { name:"sound_gorilla_throw_started", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_throw_released.mp3", { name:"sound_gorilla_throw_released", autoPlay:false } ) );
			loaderQueue.append( new MP3Loader( fileDir + "assets/sounds/Gorilla_wins.mp3", { name:"sound_gorilla_wins", autoPlay:false } ) );
			
			// TODO add additional assets?
			
			// start loading
			loaderQueue.load();
		}
		
		private static function loader_progressHandler(event:LoaderEvent):void 
		{
			trace("loading progress: " + event.target.progress);
		}
		
		private static function loader_completeHandler(event:LoaderEvent):void 
		{			
			var texturesXML 	: XML 			= LoaderMax.getContent( "textures_xml" );
			var texturesBitmap	: BitmapData 	= ContentDisplay(LoaderMax.getContent( "textures_png" )).rawContent.bitmapData;
			
			explosionEffectXML = LoaderMax.getContent( "explosion_effect" );
			
			// create the texture atlas
			_textures = new TextureAtlas(
				Texture.fromBitmapData( texturesBitmap, false ),
				texturesXML
			);
			
			// for now, lets dispose the bitmap data
			texturesBitmap.dispose();
			
			// execute the ready callback
			if (_readyCallback != null)
			{
				_readyCallback();
			}
		}
		
		private static function loader_errorHandler(event:LoaderEvent):void 
		{
			trace("loading error occured with " + event.target + ": " + event.text);
		}
		
	}

}