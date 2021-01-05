package hotBar_fla
{
   import LS_Classes.textEffect;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public dynamic class SlotCooldown_49 extends MovieClip
   {
       
      
      public var cd_txt:TextField;
      
      public var mask_mc:MovieClip;
      
      public var lineOpacity:Number;
      
      public var rot:Number;
      
      public var cellSize:Number;
      
      public function SlotCooldown_49()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function setCoolDown(param1:Number) : *
      {
         this.cd_txt.filters = textEffect.createStrokeFilter(16777215,1.2,0.8,1,3);
         this.cd_txt.text = int(Math.ceil(param1)).toString();
         this.cd_txt.background = false;
         this.cd_txt.border = false;
         var _loc2_:Boolean = (root as MovieClip).isInCombat;
         if(_loc2_)
         {
            this.lineOpacity = 0;
         }
         else
         {
            this.lineOpacity = 1;
         }
         this.mask_mc.drawWedge(this.cellSize * 0.5,this.cellSize * 0.5,this.cellSize,(1 - param1) * 360 - 90,270,0.6,this.lineOpacity,2);
      }
      
      public function onDraw(param1:Event) : *
      {
         this.mask_mc.drawWedge(this.cellSize * 0.5,this.cellSize * 0.5,this.cellSize,this.rot,270);
      }
      
      public function drawDone() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.onDraw);
         if(this.rot == 270)
         {
            this.mask_mc.deleteWedge();
         }
         (parent as MovieClip).isEnabled = true;
      }
      
      function frame1() : *
      {
         this.lineOpacity = 1;
         this.rot = -90;
         this.cellSize = 50;
         scrollRect = new Rectangle(0,0,this.cellSize,this.cellSize);
      }
   }
}