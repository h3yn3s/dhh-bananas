package com.giantmo.bananas.model 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Wind 
	{
		public var force : Number;
		public var justChanged : Boolean;
		public var oldForce : Number;
		
		public function Wind() 
		{
			force = 0;
			justChanged = false;
		}
		
	}

}