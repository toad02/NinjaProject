package  
{
	import flash.display.MovieClip;	
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.display.Stage;
	import core.*;
	import utils.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import core.Enemies.EnemyBase;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip 
	{		
		private static var BlockArray:Vector.<LevelBlock> = new Vector.<LevelBlock>(); // Array contendo os blocos do mapa
		private var timerUpdate:Timer; // Timer 
		private static var Player1:Player = new Player(); // Jogador
		private var FisicObjects:Array = new Array(); // Array onde serão armazenados todos os objetos que sofrerão alteração por física
		
		public static var GameSprite:Sprite = new Sprite(); // Sprite onde serão adicionados os objetos do jogo
		public var Distance:uint = 0;
		private var backGround:Background = new Background();
		private static var _efeitos:Efeitos = new Efeitos();
		
		private static var SprEvents:Sprite = new Sprite();
		private static var ClickBox:HitBox = new HitBox();
	
		public function Main() 
		{
			Config();
			GameStart();
			
			//addChild(new FPSCounter());
		}
		
		/*
		* Seta o necessário para que o jogo comece
		* @author Carvalho
		*/
		public function Config():void
		{
			this.addChild(backGround);
			this.addChild(GameSprite);
			this.addChild(SprEvents);
			
			GameSprite.addChild(Player1);
			Player1.x = Constantes.PLAYER_SCREEN_POSITION;
			Player1.y = Constantes.PLAYER_Y_POSITION;
			
			stage.frameRate = Constantes.FRAME_RATE;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
		}
		
		/*
		* Método chamado quando o jogo inicia
		* @author Carvalho
		*/
		private function GameStart():void
		{
			for (var i:uint = 0; i < 3; ++i)
			{
				AddLevelBlock();
			}
			
			timerUpdate = new Timer(1000/Constantes.UPDATE_RATE);
			timerUpdate.addEventListener(TimerEvent.TIMER, Update);
			timerUpdate.start();
		}
		
		/*
		* Adiciona um bloco de mapa
		* @author Carvalho
		*/
		private function AddLevelBlock():void
		{
			var ClassReference:Class = getDefinitionByName("LevelBlock" + RandomBlock) as Class;
			//var auxBlock:LevelBlock = new ClassReference();
			var auxBlock:LevelBlock = new LevelBlock1();
			var lastBlock:LevelBlock;
			
			if (BlockArray.length)
			{
				lastBlock = BlockArray[BlockArray.length-1];
				auxBlock.x = lastBlock.x + lastBlock.width;
			}
			else
			{
				auxBlock = new LevelBlockEmpty();
				auxBlock.x = 0;
			}
			
			auxBlock.y = 0;
			GameSprite.addChild(auxBlock);
			BlockArray.push(auxBlock);
		}
		
		/*
		* Retorna um bloco de mapa
		* @author Carvalho
		*/
		private static function get RandomBlock():uint
		{
			return ((Math.random() * Constantes.BLOCKS_NUMBER) + 1);
		}
		
		private function EnemiesLoop():void
		{
			var enemy:EnemyBase;
			
			for each (enemy in CurrentLevelBlock.Enemies)
			{
				// Testa colisão do jogador com os inimigos
				if (Player1.PlayerHitBox.hitTestObject(enemy.VHitBox))
				{
					enemy.Die();
					Effects.WeakImpact();
				}
				enemy.EnemyLoop();
			}
			
			for each (enemy in NextLevelBlock.Enemies)
			{
				enemy.EnemyLoop();
			}
		}
		
		private static function LoopCamera():void
		{
			if (Player1.y < Constantes.PLAYER_Y_POSITION)
			{
				GameSprite.y = (Constantes.PLAYER_Y_POSITION - Player1.y)/6;
			}
		}
		
		/*
		* Método que atualiza os cálculos do jogo
		* @author Carvalho
		*/
		private function Update(e:TimerEvent):void
		{
			// Loop do cenário
			backGround.BackgroundLoop();
			
			if (Player1.Alive)
			{
				// Loop de cada inimigo
				EnemiesLoop();
				
				// Loop da camera
				LoopCamera();
				
				//Loop dos efeitos
				Effects.LoopEfeitos();
				
				for each (var iterator:LevelBlock in BlockArray)
				{
					if (Player1.Dashing)
					{
						Distance += Constantes.DASH_SPEED/10;
						iterator.x -= Constantes.DASH_SPEED;
					}
					else
					{
						Distance += Constantes.LEVEL_SCROLL_SPEED/10;
						iterator.x -= Constantes.LEVEL_SCROLL_SPEED;
					}
				}
				
				// Remove o bloco se sair da tela
				if (BlockArray[0].x < ((BlockArray[0].width) * -1))
				{
					LevelBlockRemover();
				}
				
				Player1.PlayerLoop();
				txtDistance.text = "" + Distance;
			}
		}
		
		/*
		* Trata os eventos do teclado
		* @author Carvalho
		*/
		private function onKeyboardDown(e:KeyboardEvent):void
		{
			if ((e.keyCode == Keyboard.SPACE))
			{
				if ((!Player1.InAir) && (Player1.SoltouEspaco))
					Player1.Jump();
				else if ((!Player1.AlreadyDashed) && (Player1.SoltouEspaco))
					Player1.StartDash();
			}
		}
		
		private function MouseDownEvent(e:MouseEvent):void
		{
			if ((!Player1.InAir) && (Player1.SoltouEspaco))
					Player1.Jump();
			else if ((!Player1.AlreadyDashed) && (Player1.SoltouEspaco))
				Player1.StartDash();
		}
		
		private function MouseUpEvent(e:MouseEvent):void
		{
			Player1.EndJump();
		}
		
		private function onKeyboardUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				Player1.EndJump();
			}
		}
		
		
		/*
		* Remove os blocos que estão fora da tela e insere novos na direita
		* @author Carvalho
		*/
		private function LevelBlockRemover():void
		{			
			GameSprite.removeChild(BlockArray[0]);
			BlockArray.shift();
			AddLevelBlock();
		}
		
		public static function GameOver():void
		{
			GameSprite.removeChild(Player1);
		}
		
		public static function get ScreenWidth():Number
		{
			return 480;
		}
		
		public static function get ScreenHeight():Number
		{
			return 320;
		}
		
		public static function get CurrentLevelBlock():LevelBlock
		{
			return BlockArray[0];
		}
		
		public static function get NextLevelBlock():LevelBlock
		{
			return BlockArray[1];
		}
		
		public static function get Effects():Efeitos
		{
			return _efeitos;
		}
	}
	
}
