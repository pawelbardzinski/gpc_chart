package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SlicedCircle extends Sprite
	{
		private var timer:Timer;
		private var slices:int;
		private var radius:int;
		private var sliceColor:uint;
		
		public function SlicedCircle(slices:int = 96, radius:int = 24, sliceColor:uint=0x666666)
		{
			super();
			this.slices = slices;
			this.radius = radius;
			this.sliceColor = sliceColor;
			draw();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer = new Timer(65);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer = null;
		}
		private function onTimer(event:TimerEvent):void 
		{
			rotation = (rotation + (360 / slices)) % 360;
		}
		private function draw():void
		{
			var i:int = slices;
			var degrees:int = 360 / slices;
			while (i--)
			{
				var slice:Shape = getSlice();
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = Math.sin(radianAngle) * radius;
				slice.y = Math.cos(radianAngle) * radius;
				addChild(slice);
			}
		}
		private function getSlice():Shape
		{
			var slice:Shape = new Shape();
			slice.graphics.beginFill(sliceColor);
			slice.graphics.drawRoundRect(-1, 0, 2, radius, 2*radius, 2*radius);
			slice.graphics.endFill();
			return slice;
		}
	}
}