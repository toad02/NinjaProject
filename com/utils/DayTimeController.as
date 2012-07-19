package utils {
	import flash.display.MovieClip;
	
	public class DayTimeController extends MovieClip
	{
		var fundo = new ChangeableBackground(100,100,0xffa500);
		
		public function DayTimeController() 
		{
			addChild(fundo);
			
			Night();
		}
		
		public function Tarde():void
		{
			fundo.Red = 255;
			fundo.Green = 215;
			fundo.Blue = 0;
		}
		
		public function Evening():void
		{
			fundo.Red = 250;
			fundo.Green = 128;
			fundo.Blue = 114;
		}
		
		public function Night():void
		{
			fundo.Red = 25;
			fundo.Green = 25;
			fundo.Blue = 114;
		}

	}
	
}
