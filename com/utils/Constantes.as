package utils
{
	import flash.display.Stage;
	
	public class Constantes
	{
		private static var _tile:Number = Main.ScreenWidth/100; // Tamanho
		private static var _updateRate:uint = 30; // Numero de vezes que o jogo é calculado por segundo
		private static var _frameRate:uint = 30; // Numero de vezes que o jogo é re-desenhado por segundo
		private static var _blocksNumber:uint = 5;
		private static var _gravity:Number = 14;
		private static var _levelScrollSpeed = 15; // Velocidade em que o jogo se movimenta - DEF 10
		
		//Variáveis de controle do jogador
		private static var _jumpSpeed:Number = 27; // Força com que o personagem pula
		private static var _maxJumpHeight:Number = 110; // Altura maxima do pulo
		private static var _playerMinJump:uint = 30; // Altura mínima do pulo
		private static var _jumpDelay:Number = 2; // Suavidade do pulo. Controla um limite acima do pulo maximo
		private static var _dashFrames:Number = 4;
		private static var _playerScreenPosition:uint = 50;
		private static var _playerYposition:uint = 300;
		private static var _dashSpeed:Number = 20;
		private static var _postDashSpeed:uint = 2;
		private static var _postDashStopTime:uint = 6;
		private static var _playerDashDistance:uint = 60;
		private static var _playerDashRecoverSpeed:uint = 3;
		private static var _playerMaxDashDistance:uint = 180;
		private static var _playerWidth:uint = 48;
		
		public static function get PLAYER_Y_POSITION():uint
		{
			return _playerYposition;
		}

		public static function get PLAYER_WIDTH():uint
		{
			return _playerWidth;
		}

		public static function get PLAYER_MAX_DASH_DISTANCE():uint
		{
			return _playerMaxDashDistance;
		}
		
		public static function get PLAYER_DASH_RECOVER_SPEED():uint
		{
			return _playerDashRecoverSpeed;
		}
		
		public static function get PLAYER_DASH_DISTANCE():uint
		{
			return _playerDashDistance;
		}
		
		public static function get PLAYER_MIN_JUMP():uint
		{
			return _playerMinJump;
		}
		
		public static function get LEVEL_SCROLL_SPEED():Number
		{
			return _levelScrollSpeed;
		}
		
		public static function get POST_DASH_SPEED():Number
		{
			return _postDashSpeed;
		}
		
		public static function get POST_DASH_STOP_TIME():Number
		{
			return _postDashStopTime;
		}
		
		public static function get PLAYER_SCREEN_POSITION():uint
		{
			return _playerScreenPosition;
		}
		
		public static function get DASH_SPEED():Number
		{
			return _dashSpeed;
		}
		
		public static function get DASH_FRAMES():Number
		{
			return _dashFrames;
		}
		
		public static function get MAX_JUMP_HEIGHT():Number
		{
			return _maxJumpHeight;
		}
		
		public static function get JUMP_DELAY():Number
		{
			return _jumpDelay;
		}
		
		public static function get GRAVITY():Number
		{
			return _gravity;
		}
		
		public static function get JUMP_SPEED():Number
		{
			return _jumpSpeed;
		}
		
		public static function get BLOCKS_NUMBER():uint
		{
			return _blocksNumber;
		}
		
		public static function get UPDATE_RATE():uint
		{
			return _updateRate;
		}
		
		public static function get FRAME_RATE():uint
		{
			return _frameRate;
		}
		
		public static function get TILE():Number
		{
			return _tile;
		}
		
		/*public static function set Tile(t:Number):void
		{
			_tile = t;
		}*/
	}
}