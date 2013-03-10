﻿package com 
{
	/**
	 * ...
	 * @author Armen Abrahamyan | http://www.abrahamyan.com
	 */
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	public class TileBg extends Sprite
	{
		private var _bgWidth:Number;
		private var _bgHeight:Number;
		public var _bitmapdata:BitmapData;
		public function TileBg() 
		{
			
		}
		
		public function setBitmap(pBitmapData:BitmapData, pWidth:Number=0, pHeight:Number=0):void
		{
			_bitmapdata = pBitmapData;
			with (graphics)
			{
				clear();
				beginBitmapFill(_bitmapdata);
				moveTo(0, 0);
				lineTo(pWidth, 0);
				lineTo(pWidth, pHeight);
				lineTo(0, pHeight);
				lineTo(0, 0);
				endFill();
			}
		
		}
		public function loadBitmap(pUrl:String,pWidth:Number=0, pHeight:Number=0):void
		{
			_bgWidth = pWidth;
			_bgHeight = pHeight;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBitmapLoaded, false, 0, true);
			loader.load(new URLRequest(pUrl));
			
		}
		public function setSize(pWidth:Number,pHeight:Number):void
		{
			setBitmap(_bitmapdata, pWidth, pHeight);
		}
		public function clear():void
		{
			graphics.clear();
		}
		private function onBitmapLoaded(e:Event):void
		{
			setBitmap(BitmapData(e.target.content.bitmapData), _bgWidth, _bgHeight);
		}
	}
	
}