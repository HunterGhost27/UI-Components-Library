package
{
   import flash.display.MovieClip;
   
   public dynamic class handle2_id extends MovieClip
   {
       
      
      public function handle2_id()
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
