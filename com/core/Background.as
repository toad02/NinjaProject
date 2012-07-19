package core 
{	
	import flash.display.MovieClip;

	public class Background extends MovieClip
	{
		private var montanha:MountainBG = new MountainBG();
		
		public function Background() 
		{
			cacheAsBitmap = true;
			addChild(new MoonBG());
			addChild(montanha);
		}
		
		public function BackgroundLoop():void
		{
			montanha.x -= 0.09;
		}

	}
	
}
