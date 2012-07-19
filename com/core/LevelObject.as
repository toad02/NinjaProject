package core
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class LevelObject extends Sprite
	{
		private var mc:Sprite;
		private var leftSide:Number;
		private var topSide:Number;
		private var bottomSide:Number;
		private var rightSide:Number;
		
		public function LevelObject()
		{
			cacheAsBitmap = true;
		}
		
		/*
		* Atribui as dimensões e posição do objeto
		* @author Carvalho
		*/
		private function ScanObject():void
		{
			leftSide = mc.x;
			rightSide = mc.x + mc.width;
			topSide = mc.y;
			bottomSide = mc.y + mc.height;
		}
		
		public function get TopSide():Number
		{
			return topSide;
		}
		
		public function set MC(moviec:Sprite):void
		{
			mc = moviec;
			ScanObject();
		}
		
		public function get MC():Sprite
		{
			return mc;
		}
		
		public function get BottomSide():Number
		{
			return bottomSide;
		}
		
		public function get LeftSide():Number
		{
			return leftSide;
		}
		
		public function get RightSide():Number
		{
			return rightSide;
		}
	}
}