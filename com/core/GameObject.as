package core
{
	import flash.display.MovieClip;
	import utils.Constantes;
	
	public class GameObject extends MovieClip 
	{
		public function get TileX():Number
		{
			return (Constantes.TILE / this.x);
		}
		
		public function get TileY():Number
		{
			return (Constantes.TILE / this.y);
		}
		
		public function set TileX(n:Number):void
		{
			this.x = n/Constantes.TILE;
		}
		
		public function set TileY(n:Number):void
		{
			this.y = n/Constantes.TILE;
		}
	}
}