package core.Enemies
{
	import flash.display.MovieClip;
	import utils.Constantes;
	import flash.display.Sprite;
	
	public class Jumper extends EnemyBase
	{
		private var _jumping:Boolean = false;
		private var _animstate:String = "idle";
		private var _walkAnimation:Array = new Array(1,2);
		private var _animstep:uint = 0;
		private var _alive:Boolean = true;
		private var _jumpForce:int;
		private static var START_ACTION_DISTANCE:uint = 145;
		
		
		public function get Jumping():Boolean
		{
			return _jumping;
		}
		
		public override function get VHitBox():Sprite
		{
			return EnemyHitBox;
		}
		
		public override function Die():void
		{
			if (Alive)
			{
				gotoAndStop(2);
			}
		}
		
		public override function EnemyLoop():void
		{
			if (Alive)
			{				
				if (Jumping)
				{
					this.y += _jumpForce;
					_jumpForce += 1;
				}
				else if (this.parent.x + this.x <= START_ACTION_DISTANCE)
				{
					StartJump();
				}
			}
		}
		
		private function StartJump():void
		{
			_jumping = true;
			
			_jumpForce = -16;
			this.y += _jumpForce;
		}
	}
}