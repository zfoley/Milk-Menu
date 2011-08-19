package accordion 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class AccordionMenu extends Sprite 
	{
		private var buttons:Vector.<ExpandableButton>;
		private var updateTimer:Timer;
		static public const NUMBER_OF_ITEMS:uint = 5;
		// CHANGE THE CONSTANTS TO GET A DIFFERENT FEEL TO THE MENU ANIMATION.
		/**
		 * Factor that determines how hast the spring motion will attenuate.
		 * Must be >0 and < 1;
		 */
		static private const ELASTIC_DAMPING:Number = 0.79;
		/**
		 * Factor that detrmines how hard the spring pulls, based on distance. Must be <1 and  >0;
		 */
		static private const SPRING_STRENGTH:Number = 0.25;
		/**
		 * A drag factor that slows the overall motion of the menu. Like viscosity.
		 * Lower is slower. 
		 * Must be >0  and < 1;
		 */
		static private const EASING:Number = 0.30;
		
		public function AccordionMenu() 
		{
			updateTimer = new Timer(30);
			updateTimer.addEventListener(TimerEvent.TIMER, update);
			makeMenu();
			enableMenu();
		}
		/**
		 * This gets the timer running. You could use Enter_Frame if you wanted instead.
		 */		
		private function enableMenu():void 
		{
			updateTimer.start();
		}
		
		/**
		 * Creates the buttons and stores a reference of each button in a vector called 'buttons'.
		 */
		private function makeMenu():void 
		{
			buttons = new Vector.<ExpandableButton>;
			for (var i:int = 0; i < NUMBER_OF_ITEMS; i++) 
			{
				var b:ExpandableButton = new ExpandableButton();
				b.y = this.height;
				b.vy = 0;
				buttons.push(b);				
				addChild(b);
			}
		}
		
		/**
		 * Applies the spring equation to each button, easing it into its place.
		 * This is called by the updateTimer.
		 * @param	e a Timer Event. 
		 */
		private function update(e:TimerEvent):void 
		{
			// targetY is the position the button is easing towards.
			var targetY:Number = 0;
			for (var i:int = 0; i < buttons.length; i++) 
			{				
				// Get a reference to a button.
				var b:ExpandableButton = buttons[i]; 
				// Change the velocity of the button.
				b.vy += (targetY - b.y) * SPRING_STRENGTH;
				// Make lose a little velocity each time so that the button eventually comes to rest
				b.vy *= ELASTIC_DAMPING;
				// Apply some easing to the velocity. Makes everything move like its in syrup.
				b.y += b.vy * EASING;
				// Set the targetY for the next Button.
				targetY += b.getHeight();
			}
		}
		
		
	}

}