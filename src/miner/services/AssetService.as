package miner.services 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import miner.models.ConfigModel;
	import miner.utils.GemGameEvent;
	import miner.utils.Tracer;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class AssetService extends Actor implements IAssetService 
	{
		[Inject]
		public var configModel:ConfigModel;
		
		private var assetLoader:Loader;
		private var assetPath:URLRequest = new URLRequest("assets/assets.swf");
		public function AssetService() 
		{
			
		}
		public function loadAssets():void {
			Tracer.log("loadAssets");
			
			assetLoader = new Loader();
			assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleted);
			assetLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			assetLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			var timer:Timer = new Timer(10, 1);
			timer.addEventListener(TimerEvent.TIMER, onTimer,false,0,true);
			timer.start();
			
			}
			
			private function onTimer(e:TimerEvent):void 
			{
				(e.target as Timer).removeEventListener(TimerEvent.TIMER,onTimer);
				assetLoader.load(assetPath);
			}
			
			private function onIOError(e:IOErrorEvent):void 
			{
				trace(e);
			}
			
			private function onHTTPStatus(e:HTTPStatusEvent):void 
			{
				Tracer.log(e.status.toString());
			}
			
			private function onProgress(e:ProgressEvent):void 
			{
				
			}
			
			private function onCompleted(e:Event):void 
			{
				Tracer.log("assetsLoaded");
				configModel.background = (assetLoader.content as MovieClip).cucc;
				dispatch(new GemGameEvent(GemGameEvent.ASSETS_LOADED));
			}
	}

}