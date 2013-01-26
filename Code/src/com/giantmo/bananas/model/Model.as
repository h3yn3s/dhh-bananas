package com.giantmo.bananas.model 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Model 
	{
		public var banana 		: Banana;
		public var gorillas 	: Vector.<Gorilla>;
		public var buildings 	: Vector.<Building>;
		public var clouds 		: Vector.<Cloud>;
		public var explosions	: Vector.<Explosion>;
		public var bananaThrow	: BananaThrow;
		public var powerBar		: PowerBar;
		
		public var wind : Wind;
		
		public var currentPlayer : int; // ID of the current player
				
		public var gameActive : Boolean;
		public var mode : String;
		
		public function Model() 
		{
			// 1 banana
			banana 		= new Banana();
			
			// 2 gorillas
			gorillas 	= new <Gorilla>[ 
				new Gorilla(), 
				new Gorilla() 
			];
			
			// 8 buildings
			buildings 	= new <Building>[ 
				new Building(),
				new Building(),
				new Building(),
				new Building(),
				new Building(),
				new Building(),
				new Building(),
				new Building()
			];
			
			// 5 Clouds
			clouds 		= new <Cloud>[
				new Cloud(),
				new Cloud(),
				new Cloud(),
				new Cloud(),
				new Cloud(),
			];
			
			wind = new Wind();
			
			// explosions
			explosions = new Vector.<Explosion>();
			
			// bananaThrow
			bananaThrow = new BananaThrow();
			
			// powerBar
			powerBar = new PowerBar();
		}
		
		public function getActiveGorilla() : Gorilla
		{
			return gorillas[currentPlayer];
		}
	}
}