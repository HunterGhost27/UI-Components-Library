package
{
   import flash.display.MovieClip;
   
   public dynamic class down2_id extends MovieClip
   {
       
      
      public var disabled_mc:empty;
      
      public function down2_id()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
   }
}
