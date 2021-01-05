package journal_fla
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   
   public dynamic class tutorialHolder_34 extends MovieClip
   {
       
      
      public var desc_txt:TextField;
      
      public var showTutorialPopups_mc:CheckBoxWlabel;
      
      public var title_txt:TextField;
      
      public var base:MovieClip;
      
      public function tutorialHolder_34()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function init() : *
      {
         this.showTutorialPopups_mc.init(this.onCheckBoxPressed);
      }
      
      public function onCheckBoxPressed() : *
      {
         ExternalInterface.call("tutPopups",this.showTutorialPopups_mc.isActive);
      }
      
      public function showSelected(param1:MovieClip) : *
      {
         if(param1 && param1.grpMc)
         {
            this.title_txt.htmlText = param1.titleStr.toUpperCase();
            this.desc_txt.htmlText = param1.descStr;
         }
      }
      
      function frame1() : *
      {
         this.base = parent as MovieClip;
         this.showTutorialPopups_mc.visible = false;
      }
   }
}
