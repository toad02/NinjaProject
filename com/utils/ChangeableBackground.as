package utils {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	public class ChangeableBackground extends MovieClip 
	{
		private var square:Shape = new Shape();
		private var myColor:ColorTransform;
		
		//Cores alvo
		private var _redToBe:Number;
		private var _greenToBe:Number;
		private var _blueToBe:Number;
		
		public static var CHANGE_SPEED:uint = 99;
		
		public function ChangeableBackground(xSize:uint,ySize:uint, startingColor = 0xFFFFFF,alph:Number = 1) {
			square.graphics.beginFill(startingColor);
			square.graphics.drawRect(0, 0, xSize, ySize);
			
			myColor = square.transform.colorTransform;
			myColor.color = startingColor;
			myColor.alphaMultiplier = alph;
			square.transform.colorTransform = myColor;
			
			Red = myColor.redOffset;
			Green = myColor.greenOffset;
			Blue = myColor.blueOffset;
			
			addChild(square);
			
			addEventListener(Event.ENTER_FRAME, enterframe);
		}
		
		public function get Blue():Number
		{
			return _blueToBe;
		}
		
		public function set Blue(i:Number):void
		{
			if (i >= 0 && i < 256)
				_blueToBe = i;
		}
		
		public function get Red():Number
		{
			return _redToBe;
		}
		
		public function set Red(i:Number):void
		{
			if (i >= 0 && i < 256)
				_redToBe = i;
		}
		
		public function get Green():Number
		{
			return _greenToBe;
		}
		
		public function set Green(i:Number):void
		{
			if (i >= 0 && i < 256)
				_greenToBe = i;
		}
		
		// Muda a cor instantaneamente
		public function ChangeToColor(red:uint, green:uint, blue:uint):void
		{
			myColor.redOffset = red;
			myColor.greenOffset = green;
			myColor.blueOffset = blue;
		}
		
		
		function enterframe(e:Event):void
		{
			var aux:Number;
			
			if (myColor.redOffset != Red)
			{
				aux = (Red - myColor.redOffset)/(999/CHANGE_SPEED);
				
				if (myColor.redOffset + aux > 0 && myColor.redOffset + aux < 255)
					myColor.redOffset += aux;
				else
					myColor.redOffset = Red;
					
				trace("Red " + Red + "myColor.redOffset " + myColor.redOffset);
			}
			
			if (myColor.greenOffset != Green)
			{
				aux = (Green - myColor.greenOffset)/(999/CHANGE_SPEED);
				
				if (myColor.greenOffset + aux > 0 && myColor.greenOffset + aux < 255)
					myColor.greenOffset += aux;
				else
					myColor.greenOffset = Green;
			}
			
			if (myColor.blueOffset != Blue)
			{
				aux = (Blue - myColor.blueOffset)/(999/CHANGE_SPEED);
				
				if (myColor.blueOffset + aux > 0 && myColor.blueOffset + aux < 255)
					myColor.blueOffset += aux;
				else
					myColor.blueOffset = Blue;
			}
				
			square.transform.colorTransform = myColor;
		}
	}
	
}
