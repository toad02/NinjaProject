package core
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;

	public class HitBoxBase extends Sprite
	{
		public var Top:Number;
		public var Bottom:Number;
		public var Left:Number;
		public var Right:Number;
		
		public function HitBoxBase()
		{
			addEventListener(Event.ADDED,AddedListener);
		}
		
		private function AddedListener(e:Event):void
		{
			Top = this.y;
			Bottom = this.y + this.height;
			Left = this.x;
			Right = this.x + this.width;
		}
	}
}