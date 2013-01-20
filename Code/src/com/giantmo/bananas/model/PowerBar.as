package com.giantmo.bananas.model 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class PowerBar 
	{
		/** The point on the gorilla where the banana would be thrown off. */
		public static const POWER_BAR_ORIGIN : Point = new Point(21, 20);
		
		// PROPERTIES
		public var gorillaIsAiming : Boolean;
		public var aimingAngle : Number;
		public var aimingForce : Number;
		
		public var owningGorillaPosition : Point;
		
		public function PowerBar() 
		{
			gorillaIsAiming = false;
			aimingAngle = 0;
			aimingForce = 0;
			
			owningGorillaPosition = new Point();
		}
		
	}

}