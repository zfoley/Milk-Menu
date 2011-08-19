package 
{
	import accordion.AccordionMenu;
	import accordion.ExpandableButton;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var menu:AccordionMenu = new AccordionMenu();
			menu.x = 15;
			menu.y = 15;
			addChild(menu);	
			//addChild(new ExpandableButton());	
			this.graphics.beginFill(0x676767);
			this.graphics.drawRect(0, 0, 330, 600);
		}
		
	}
	
}