package com.giantmo.bananas.model 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class BananaThrow 
	{
		public var velocity : Point;
		public var startPoint : Point;
		public var releasePoint : Point;
		public var aimingAngle : Number;
		public var aimingForce : Number;
		public var inDragPhase : Boolean;
		public var bananaFlying : Boolean;
		
		public function BananaThrow() 
		{
			inDragPhase = false;
			bananaFlying = false;
			
			aimingAngle = 0;
			aimingForce = 0;
			
			velocity = new Point();
			startPoint = new Point();
			releasePoint = new Point();
		}
		
	}

}