package core
{
	
	import flash.display.MovieClip;	
	import utils.Constantes;
	import core.Enemies.EnemyBase;
	import flash.display.Sprite;
	import utils.Utils;
	
	public class LevelBlock extends GameObject 
	{
		private var _fixedObjects:Vector.<LevelObject> = new Vector.<LevelObject>();
		private var _enemies:Vector.<EnemyBase> = new Vector.<EnemyBase>();
		
		public function LevelBlock() 
		{
			cacheAsBitmap = true;
			ExamineLevel();
		}
		
		/*
		* Atribui cada objeto do level à um array específico, onde será tratado
		* @author Carvalho
		*/
		private function ExamineLevel():void
		{
			for(var i:int=0; i < this.numChildren; i++) 
			{
				var mc:Sprite = getChildAt(i) as Sprite;
					
				// add floors and walls to fixedObjects
				if ((mc is Floor) || (mc is Box))
				{
					var levelObject:LevelObject = new LevelObject();
					levelObject.MC = mc;
					_fixedObjects.push(levelObject);
				}
				else if (mc is EnemyBase)
				{
					_enemies.push(mc);
				}
			}
		}
		
		public function get FixedObjects():Vector.<LevelObject>
		{
			return _fixedObjects;
		}
		
		public function get Enemies():Vector.<EnemyBase>
		{
			return _enemies;
		}
		
		public function get TileWidth():Number
		{
			return (this.width / Constantes.TILE);
		}
		
		public function get TileHeight():Number
		{
			return (this.height / Constantes.TILE);
		}
	}
	
}
