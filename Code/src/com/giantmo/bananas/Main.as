package com.giantmo.bananas
{
	import com.giantmo.bananas.controller.GameController;
	import com.giantmo.bananas.model.Assets;
	import com.giantmo.bananas.model.Model;
	import com.giantmo.bananas.view.Bananas;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author G.Giant & h.ebbmo
	 */
	[SWF(frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var _bananas : Bananas;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// add added to stage handler
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, main_addedToStageHandler);
		}
		
		private function deactivate(e:flash.events.Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		
		protected function main_addedToStageHandler(event : flash.events.Event) : void
		{
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, main_addedToStageHandler);
			
			// create Starling (Bananas) instance
			var _starling : Starling = new Starling( Bananas, stage, new Rectangle(0, 0, 960, 640) );
			_starling.addEventListener( starling.events.Event.ROOT_CREATED, starling_rootCreatedHandler );
			
			// add stage resize handler
			stage.addEventListener( flash.events.Event.RESIZE, stage_resizeHandler );
		}
		
		protected function starling_rootCreatedHandler(event : starling.events.Event) : void
		{
			// show stats
			Starling.current.showStats = true;
			
			Assets.loadAssets( assets_readyHandler );
		}
		
		protected function assets_readyHandler() : void
		{
			var _model : Model = new Model();
			
			// get bananas
			_bananas = Starling.current.root as Bananas;
			_bananas.initialize();
			
			new GameController ( _model, _bananas );
			
			// starling render loop
			Starling.current.start();
		}
		
		protected function stage_resizeHandler(event : flash.events.Event):void
		{			
			// the flash stage has been resized -> update and center the view port of starling
			if(Starling.current)
			{
				Starling.current.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);	
			}
		}
	}
	
}