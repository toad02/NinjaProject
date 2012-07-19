package utils
{
	import flash.filters.BlurFilter;
	
	public class Efeitos
	{
		private static var _weakImpactTime:uint;
		private static var _weakImpactStrenght:int;
		private static var _strongImpactTime:uint;
		private static var _strongImpactStrenght:int;
		private static var BooWeakImpact:Boolean = false;
		private static var BooStrongImpact:Boolean = false;
		private static var _horizontalBlur:BlurFilter = new BlurFilter(5,0,5);
		
		public static function get HorizontalBlur():BlurFilter
		{
			return _horizontalBlur;
		}
		
		public function WeakImpact():void
		{
			Main.GameSprite.x = 0;
			BooWeakImpact = true;
			_weakImpactTime = 5;
			_weakImpactStrenght = 10;
		}
		
		public function StrongImpact():void
		{
			Main.GameSprite.y = 0;
			BooStrongImpact = true;
			_strongImpactTime = 10;
			_strongImpactStrenght = 12;
		}
		
		private function WeakImpactLoop():void
		{
			if (_weakImpactTime) 
			{
				Main.GameSprite.x += _weakImpactStrenght;
				_weakImpactStrenght *= -1;
				_weakImpactTime--;
			}
			else
			{
				BooWeakImpact = false;
				Main.GameSprite.x = 0;
			}
		}
		
		private function StrongImpactLoop():void
		{
			if (_strongImpactTime) 
			{
				Main.GameSprite.y += _strongImpactStrenght;
				_strongImpactStrenght *= -1;
				_strongImpactTime--;
			}
			else
			{
				BooStrongImpact = false;
				Main.GameSprite.y = 0;
			}
		}
		
		public function LoopEfeitos():void
		{
			if (BooWeakImpact)
				WeakImpactLoop();
			if (BooStrongImpact)
				StrongImpactLoop();
		}
	}
}