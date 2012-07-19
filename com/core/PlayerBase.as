package core
{
	import flash.display.MovieClip;
	import utils.Constantes;
	import utils.Efeitos;
	
	public class PlayerBase extends MovieClip 
	{
		private var _jumping:Boolean = false;
		private var ActualJumpSpeed:Number = 0;
		private var JumpStart:Number = 0;
		private var colidedObject:LevelObject;
		private var _dashing:Boolean;
		private var ActualDashFrame:uint = 0;
		private var ActualPostDashTime:uint = 0;
		private var _alreadyDashed:Boolean = false;
		public var SoltouEspaco:Boolean = true;
		private var _alive:Boolean = true;
		private var _animstate:String = "running";
		private var _walkAnimation:Array = new Array(1,2); //Frames da animação de corrida
		private var _dashAnimation:Array = new Array(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19); //Frames da animação de dash
		private var _jumpAnimation:Array = new Array(20,21,22); //Frames da animação de pulo
		private var animstep:uint = 0; // frame atual da animação ativa
		
		public function PlayerBase()
		{
			cacheAsBitmap = true;
		}
		
		public function set Animstate(s:String):void
		{
			if (s != Animstate)
			{
				_animstate = s;
				animstep = 0;
			}
		}
		
		public function get Animstate():String
		{
			return _animstate;
		}
		
		private function get Jumping():Boolean
		{
			return _jumping;
		}
		
		public function get Alive():Boolean
		{
			return _alive;
		}
		
		public function get AlreadyDashed():Boolean
		{
			return _alreadyDashed;
		}
		
		public function get Dashing():Boolean
		{
			return _dashing;
		}
		
		public function get Top():Number
		{
			return this.y + PlayerHitBox.Top;
		}
		
		public function get Bottom():Number
		{
			return this.y + PlayerHitBox.Bottom;
		}
		
		public function get Left():Number
		{
			return this.x + PlayerHitBox.Left;
		}
		
		public function get Right():Number
		{
			return this.x + PlayerHitBox.Right;
		}
		
		public function Jump():void
		{
			SoltouEspaco = false;
			Jumping = true;
		}
		
		public function EndJump():void
		{
			SoltouEspaco = true;
			Jumping = false;
		}
		
		private function set Jumping(b:Boolean):void
		{
			// Se o jogador comecou a pular agora, guarda a altura em que ele estava quando o pulo comecou
			// e impede que ele pule mais do que a altura maxima
			if ((!InAir) && (!_jumping))
			{
				JumpStart = this.y;
				Animstate = "jumping";
				this.y -= Constantes.PLAYER_MIN_JUMP;
			}
			
			_jumping = b;
		}
		
		/*
		* Loop principal do personagem
		* @author Carvalho
		*/
		public function PlayerLoop():void
		{
			if (this.y > 1000 || this.x < 0)
			{
				Die();
			}
				
				
			PlayerFisics();
			Animation();
			DashLoop();
		}
		
		private function TopColision(object:*):void
		{
			// Checa colisão de baixo para cima
			if ((Top - ActualJumpSpeed < object.BottomSide) && (Top > object.TopSide) &&
				(Right > object.LeftSide) && (Left < object.RightSide))
			{
				trace("TopColision -> " + Top + " B:" + object.BottomSide + " T:" + object.TopSide + " L:" + object.LeftSide + " R:" + object.RightSide);
				this.y = object.BottomSide + this.height;
			}
		}
		
		/*
		* Checa a colisão vertical do personagem com os objetos da fase
		* @author Carvalho
		*/
		private function VerticalColision(levBlock:LevelBlock):Boolean
		{
			var colided:Boolean = false;
			
			for each (var iterator:* in levBlock.FixedObjects)
			{			
				//TopColision(iterator);
			
				if ( 
					((Right > (iterator.LeftSide + levBlock.x)) && (Right < (iterator.RightSide + levBlock.x))) || 
					((Left > (iterator.LeftSide + levBlock.x)) && (Left < (iterator.RightSide + levBlock.x)))
					) 
				{
					// Checa colisão de cima para baixo
					if ((Bottom <= iterator.TopSide) && (Bottom + Constantes.GRAVITY > iterator.TopSide)) 
					{
						this.y = iterator.TopSide;
						colidedObject = iterator;
						_alreadyDashed = false;
						Animstate = "running";
						return true;
					}
				}
			}
			
			return colided;
		}
		
		
		public function Animation():void
		{
			// move along walk cycle
			if (Animstate == "running") 
			{				
				if (animstep >= _walkAnimation.length) 
				{
					animstep = 0;
				}
				this.gotoAndStop(_walkAnimation[animstep]);
				animstep += 1;
			}
			else if (Animstate == "dashing")
			{
				if (animstep >= _dashAnimation.length) 
				{
					animstep = _dashAnimation.length-1;
				}
				this.gotoAndStop(_dashAnimation[animstep]);
				animstep += 1;
			}
			else if (Animstate == "jumping")
			{
				if (animstep >= _jumpAnimation.length) 
				{
					animstep = 0;
				}
				this.gotoAndStop(_jumpAnimation[animstep]);
				animstep += 1;
			}
		}
		
		/*
		* Checa a colisão horizontal do personagem com os objetos da fase
		* @author Carvalho
		*/
		private function HorizontalColision(levBlock:LevelBlock):Boolean
		{
			var colided:Boolean = false;
			
			for each (var iterator:* in levBlock.FixedObjects)
			{			
				//var posy:Number = this.y - this.height/2;
			
				// Checa colisão com a direita de um objeto
				if (((Bottom > iterator.TopSide) && (Bottom <= iterator.BottomSide)) ||
					((Top > iterator.TopSide) && (Top < iterator.BottomSide)) )
				{
					if (((Left >= iterator.LeftSide + levBlock.x) && (Left <= iterator.RightSide + levBlock.x)) ||
						((Right >= iterator.LeftSide + levBlock.x) && (Right <= iterator.RightSide + levBlock.x))) 
					{
						if (this.x - Constantes.DASH_SPEED < iterator.LeftSide + levBlock.x)
						{
							this.x = iterator.LeftSide + levBlock.x - Constantes.PLAYER_WIDTH;
							EndDash();
							return true;
						}
					}
				}
			}
			
			return colided;
		}
		
		private function Die():void
		{
			_alive = false;
			Main.GameOver();
		}
		
		/*
		* Retorna se o personagem está no ar ou não
		* @author Carvalho
		*/
		public function get InAir():Boolean
		{
			// Checa se o personagem colidiu com algum objeto
			if (VerticalColision(Main.CurrentLevelBlock))
			{
				// Se colidiu, o personagem não está no ar
				return false;
			}
			
			if (VerticalColision(Main.NextLevelBlock))
			{	
				return false;
			}
			
			// Se o próximo LevelBlock está próximo, também calculamos a colisão com seus objetos
			/*else if (Main.CurrentLevelBlock.x + Main.CurrentLevelBlock.width <= Constantes.PLAYER_SCREEN_POSITION + 100)
			{
				if (VerticalColision(Main.NextLevelBlock))
				{	
					return false;
				}
			}*/
			
			return true;
		}
		
		/*
		* Calcula a física do personagem
		* @author Carvalho
		*/
		private function PlayerFisics():void
		{
			if (Jumping)
			{
				ActualJumpSpeed = Constantes.JUMP_SPEED;
			}
			
			if (!Dashing)
			{
				if (InAir || Jumping)
				{
					if (this.y <= (JumpStart - Constantes.MAX_JUMP_HEIGHT))
						Jumping = false;
					this.y -= ActualJumpSpeed;
				}
				
				if (InAir)
				{
					if (ActualJumpSpeed > 0 && (!Jumping))
						ActualJumpSpeed -= Constantes.JUMP_DELAY;
	
					this.y += Constantes.GRAVITY;				
				}
			}
			
			// Calcula colisão com objetos do LevelBlock
			HorizontalColision(Main.CurrentLevelBlock);
			
			// Se o próximo LevelBlock está próximo, também calculamos a colisão com seus objetos
			if (Main.CurrentLevelBlock.x + Main.CurrentLevelBlock.width <= Constantes.PLAYER_SCREEN_POSITION + 100)
				HorizontalColision(Main.NextLevelBlock);
		}
		
		/*
		* Inicia o Dash do personagem
		* @author Carvalho
		*/
		public function StartDash():void
		{
			if ((this.x + 100) < Constantes.PLAYER_MAX_DASH_DISTANCE)
				this.x += 100;
			else
				this.x += (Constantes.PLAYER_MAX_DASH_DISTANCE - this.x);
			_dashing = true;
			_alreadyDashed = true;
			ActualJumpSpeed = 0;
			Animstate = "dashing";
			
			// Aplica efeito de blur nos LevelBlocks que estão na tela
			Main.CurrentLevelBlock.filters = [Efeitos.HorizontalBlur];
			Main.NextLevelBlock.filters = [Efeitos.HorizontalBlur];
		}
		
		/*
		* Finaliza o Dash do personagem
		* @author Carvalho
		*/
		private function EndDash():void
		{
			_dashing = false;
			ActualDashFrame = 0;
			ActualPostDashTime = 0;
			
			//Remove efeito de blur
			Main.CurrentLevelBlock.filters = [];
			Main.NextLevelBlock.filters = [];
		}
		
		private function DashLoop():void
		{
			//trace("Main.GameSprite.x " + Main.GameSprite.x);
			if (Dashing)
			{
				if (ActualDashFrame == Constantes.DASH_FRAMES)
				{
					if (ActualPostDashTime == Constantes.POST_DASH_STOP_TIME)
					{
						EndDash();
					}
					else
					{
						if (this.x < Constantes.PLAYER_MAX_DASH_DISTANCE)
							this.x += Constantes.POST_DASH_SPEED;
						//Main.GameSprite.x -= 2;
						ActualPostDashTime++;
					}
					
				}
				else
				{
					if (this.x > Constantes.PLAYER_SCREEN_POSITION)
					{
						this.x -= Constantes.PLAYER_DASH_RECOVER_SPEED;
					}
					ActualDashFrame++;
					//Main.GameSprite.x += 2;
				}
			}
			else if (this.x > Constantes.PLAYER_SCREEN_POSITION)
			{
				this.x -= Constantes.PLAYER_DASH_RECOVER_SPEED;
			}
			/*else if (Main.GameSprite.x < 0)
			{
				Main.GameSprite.x += 0.3;
			}*/
		}
	}
	
}
