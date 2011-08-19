package accordion
{
	import com.greensock.easing.Back;
	import com.greensock.TweenMax;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class ExpandableButton extends Sprite
	{
		private static const CLOSED_HEIGHT:Number = 64;
		private static const OPEN_HEIGHT:Number = 260;
		private var _height:Number;
		private static var buttonWords:Array = new Array('CREAM', 'BUTTER', 'MILK', 'CHEESE', 'ICE CREAM', 'YOGURT', 'BUTTERMILK', 'SOUR CREAM', 'BEEF');
		
		ButtonFont
		
		/**
		 * The Y velocity;
		 */
		public var vy:Number = 0;
		private var bg:Sprite;
		
		public function ExpandableButton()
		{
			buttonMode = true;
			mouseChildren = false;
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			this.filters = [new GlowFilter(0x000000, 1, 8, 4, 1, 3, true),new DropShadowFilter(4, 45, 0x000000, 0.75, 8, 8, 1, 3)];			
			_height = CLOSED_HEIGHT;
			
			bg = new Sprite();
			bg.graphics.beginFill(0xFFCC00);
			bg.graphics.drawRect(0, 0, 300, CLOSED_HEIGHT);

			// The font is embedded in the Font.swc in the /lib folder.
			var tf:TextFormat = new TextFormat("HelveticaNeueLT Std Blk", 40);
			var txt:TextField = new TextField();
			txt.textColor = 0xFFFFFF;
			txt.embedFonts = true;
			txt.setTextFormat(tf);
			txt.defaultTextFormat = tf;
			// A bit of fancy stuff to grab a random word from a list of dairly products. 
			// But lets be real, who would want a random menu, right? 
			// So you could just pass through the button lable through the constructor and use that. 
			txt.text = buttonWords.splice(Math.floor(Math.random() * buttonWords.length), 1);			
			txt.width = 300;
			txt.autoSize = TextFieldAutoSize.CENTER
			txt.y = CLOSED_HEIGHT / 2 - txt.height / 2;
			
			txt.filters = [new DropShadowFilter(4, 45, 0x000000, 1, 8, 8, 1, 3)];//[new GlowFilter(0x000000,1,8,8,1,3,false,false)];
			
			addChild(bg);
			addChild(txt);						
		}
		
		private function onRollOut(e:MouseEvent):void
		{			
			_height = CLOSED_HEIGHT;
			TweenMax.to(bg, 0.5, {removeTint:true, height: CLOSED_HEIGHT, ease:Back.easeOut});
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			_height = OPEN_HEIGHT;
			TweenMax.to(bg, 0.5, {tint:0xFFDD66, height: OPEN_HEIGHT, ease:Back.easeOut});
		}
		
		public function getHeight():Number
		{
			/*
			 * I use a fake height in this spot so that the menu anticiaptes where the button will expand to.
			 * But there's no reason you couldn't use the real 'height' either. It will just behave a little different
			 * You might like it that way.
			*/ 
			return _height;
			//return this.height;
		}	
	}

}