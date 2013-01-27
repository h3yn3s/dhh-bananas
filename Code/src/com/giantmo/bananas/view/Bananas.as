package com.giantmo.bananas.view 
{	
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Constants;
	import com.giantmo.bananas.util.ObjectPool;
	
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.textures.RenderTexture;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bananas extends Sprite 
	{
		public var bananaView 	  : BananaView;
		public var gorrilaViews   : Vector.<GorillaView>;
		public var buildingViews  : Vector.<BuildingView>;
		public var explosionViews : Vector.<ExplosionView>;
		public var cloudViews 	  : Vector.<CloudView>;
		public var powerBarView	  : PowerBarView;
		public var soundView	  : SoundView;
		public var _gameOverScreen : GameOverScreen;
		
		public var _cloudLayer 		: Sprite;
		public var _gorillaLayer 	: Sprite;
		public var _bananaLayer 	: Sprite;		
		public var _buildingLayer 			: Image;
		public var _buildingLayerTexture	: RenderTexture;
		public var _powerBarLayer 	: Sprite;
		public var _soundViewLayer : Sprite;
		
		private var _explosionPool : ObjectPool;
		
		private var _explosionEffect : ParticleSystem;
		
		private var _startScreen : StartScreen;
		
		
		public function Bananas() 
		{
			// set ambient sound for iOS silent switch issue
			var string : String = AudioPlaybackMode.AMBIENT;
			SoundMixer.audioPlaybackMode = string;
		}
		
		public function initialize() : void
		{
			// create clouds
			_cloudLayer = new Sprite();
			_cloudLayer.touchable = false;
			cloudViews = new <CloudView>[
				new CloudView(),
				new CloudView(),
				new CloudView(),
				new CloudView(),
				new CloudView()
			];
			
			// create banana
			_bananaLayer = new Sprite();
			_bananaLayer.touchable = false;
			bananaView = new BananaView();
			
			// create gorillas
			_gorillaLayer = new Sprite();
			gorrilaViews 	= new <GorillaView>[ 
				new GorillaView(), 
				new GorillaView() 
			];
			
			// create powerBar			
			_powerBarLayer = new Sprite();
			_powerBarLayer.touchable = false;
			
			powerBarView = new PowerBarView();
			//_powerBarLayer.addChild( powerBarView );
			
			
			// create buildings
			_buildingLayerTexture = new RenderTexture( Constants.WORLD_BOUNDARY.width, Constants.WORLD_BOUNDARY.height );
			_buildingLayer = new Image(_buildingLayerTexture);
			_buildingLayer.touchable = false;
			buildingViews 	= new <BuildingView>[ 
				new BuildingView(), 
				new BuildingView(),
				new BuildingView(),
				new BuildingView(),
				new BuildingView(),
				new BuildingView(),
				new BuildingView(),
				new BuildingView() 
			];
			
			// explosions
			explosionViews  = new Vector.<ExplosionView>();
			_explosionPool 	= new ObjectPool( 6, 12, function() : ExplosionView { return new ExplosionView() } );
			
			// explosion effect
			_explosionEffect = new PDParticleSystem( Assets.explosionEffectXML, Assets.explosionEffect );
			_explosionEffect.addEventListener( Event.COMPLETE, explosionEffect_completeHandler );
			
			// create start screen
			_startScreen = new StartScreen();
			
			// create gameOverScreen
			_gameOverScreen = new GameOverScreen();

			// sound view layer
			soundView = new SoundView();
			_soundViewLayer = new Sprite();
			_soundViewLayer.addChild(soundView);
			
			// add layers as children
			this.addChild( _cloudLayer );		// clouds
			this.addChild( _buildingLayer );	// buildings
			//this.addChild( _explosionLayer );	// explosions
			this.addChild( _gorillaLayer );		// gorillas
			this.addChild( _powerBarLayer );	// power bar
			this.addChild( _bananaLayer );		// banana
			this.addChild( _soundViewLayer );
		}
		
		public function clean() : void
		{
			//_buildingLayer.removeChildren();
			_buildingLayerTexture.clear();
			_gorillaLayer.removeChildren();
			_bananaLayer.removeChildren();
			this.hideGameOverScreen();
			//_explosionLayer.removeChildren();
			
			// reput all explosions into pool
			for each(var explosion : ExplosionView in explosionViews)
			{
				// put explosion back to pool
				if(!_explosionPool.put( explosion ))
				{
					// pool has been full, we can dispose the explosion
					explosion.dispose();
				}
			}
			
			explosionViews.length = 0;
		}
		
		public function addBuilding(building : BuildingView) : void
		{
			// draw onto texture
			_buildingLayerTexture.draw( building );
		}
		
		public function addPowerBar( powerBar : PowerBarView) : void
		{
			// draw onto the gorilla layer texture
			_powerBarLayer.addChild( powerBar );
		}
		
		public function addGorilla(gorilla : GorillaView) : void
		{
			_gorillaLayer.addChild( gorilla );
		}
		
		public function addCloud ( cloud : CloudView) : void 
		{
			_cloudLayer.addChild( cloud );
		}		
		
		public function set bananaVisible(value : Boolean) : void
		{
			if (value)
			{
				_bananaLayer.addChild( bananaView );
			}
			else 
			{
				_bananaLayer.removeChild( bananaView );
			}
		}
		
		public function addExplosion ( explosion : ExplosionView ) : void 
		{
			//_explosionLayer.addChild( explosion );
			explosionViews.push( explosion );
			
			_buildingLayerTexture.draw( explosion );
		}
		
		public function getExplosion() : ExplosionView
		{
			return _explosionPool.get() as ExplosionView;
		}
		
		/** Play the explosion effect at a certain position. */
		public function playExplosionEffect( x : Number, y : Number ) : void
		{
			_explosionEffect.emitterX = x;
			_explosionEffect.emitterY = y;
			this.addChild( _explosionEffect );
			
			Starling.juggler.add( _explosionEffect ); // we need to add it to juggler to be animated
			_explosionEffect.start( 0.3 ); // explode for 0.3 seconds
		}
		
		public function showStartScreen() : void
		{
			this.addChild( _startScreen );
		}
		
		public function hideStartScreen() : void
		{
			this.removeChild( _startScreen );
		}
		
		public function showGameOverScreen( ) : void
		{			
			_gameOverScreen.setWinner();
			this.addChild( _gameOverScreen );
		}
		
		public function hideGameOverScreen() : void
		{
			this.removeChild( _gameOverScreen );
		}
		
		private function explosionEffect_completeHandler(event : Event):void
		{
			// get particle system
			var particleSystem : ParticleSystem = event.target as ParticleSystem;
			
			// remove from juggler
			Starling.juggler.remove( particleSystem );
			
			// remove
			this.removeChild( particleSystem );
		}
	}

}