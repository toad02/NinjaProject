package core.Enemies {
	
	public class JumperTeam 
	{
		private var _jumping:Boolean = false;
		private var _alive:Boolean = true;
		private var _jumpForce:int;
		private static var START_ACTION_DISTANCE:uint = 200;
		
		
		
		public override function get VHitBox():Sprite
		{
			return EnemyHitBox;
		}

	}
	
}
