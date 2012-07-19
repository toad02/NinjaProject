package core.Enemies 
{
	import flash.display.Sprite;
	import utils.Efeitos;
	
	public class Grappler extends EnemyBase
	{
		private var _falling:Boolean = false;
		private var _alive:Boolean = true;
		private var _fallSpeed:Number = 4;
		private var _jumpForce:Number = 0;
		private static var START_ACTION_DISTANCE:uint = 120;
		private var Colided:Boolean = false;
		
		public function Grappler() 
		{
		}
		
		public override function get VHitBox():Sprite
		{
			return EnemyHitBox;
		}
		
		public override function EnemyLoop():void
		{
			if (Alive)
			{
				if (EnemyHitBox.y + EnemyHitBox.height < floorHitBox.y)
				{
					if (this.parent.x + this.x <= START_ACTION_DISTANCE)
					{
						_jumpForce += 3;
						EnemyHitBox.y += _jumpForce;
					}
				}
				else if (!Colided)
				{
					Colided = true;
					Main.Effects.StrongImpact();
				}
			}
		}

	}
	
}
