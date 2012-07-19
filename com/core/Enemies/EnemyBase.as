package core.Enemies
{
	import flash.display.MovieClip;
	import utils.Constantes;
	import flash.display.Sprite;
	
	public class EnemyBase extends MovieClip
	{
		private var _animstate:String = "idle";
		private var _animstep:uint = 0;
		private var _alive:Boolean = true;
		
		private static var START_ACTION_DISTANCE:uint = 200;
		
		public function EnemyBase():void
		{
			cacheAsBitmap = true;
		}
		
		// Hitbox da vulnerabilidade do personagem
		public function get VHitBox():Sprite
		{
			return new MovieClip();
		}
		
		public function get Alive():Boolean
		{
			return _alive;
		}
		
		public function Die():void
		{
		}
		
		public function EnemyLoop():void
		{
		}
	}
}