package hotBar_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class skillSlotNumbers_30 extends MovieClip
   {
       
      
      public var key10_mc:TextField;
      
      public var key11_mc:TextField;
      
      public var key12_mc:TextField;
      
      public var key1_mc:TextField;
      
      public var key2_mc:TextField;
      
      public var key3_mc:TextField;
      
      public var key4_mc:TextField;
      
      public var key5_mc:TextField;
      
      public var key6_mc:TextField;
      
      public var key7_mc:TextField;
      
      public var key8_mc:TextField;
      
      public var key9_mc:TextField;
      
      public var textArray:Array;
      
      public function skillSlotNumbers_30()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function setText(param1:Number, param2:String) : *
      {
         this.textArray[param1].text = param2;
      }
      
      function frame1() : *
      {
         this.textArray = new Array(this.key1_mc,this.key2_mc,this.key3_mc,this.key4_mc,this.key5_mc,this.key6_mc,this.key7_mc,this.key8_mc,this.key9_mc,this.key10_mc,this.key11_mc,this.key12_mc);
      }
   }
}