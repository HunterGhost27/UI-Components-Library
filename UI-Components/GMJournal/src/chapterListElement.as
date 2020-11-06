package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public dynamic class chapterListElement extends MovieClip
   {
       
      
      public var chapter_mc:MovieClip;
      
      public var editableElement_mc:MovieClip;
      
      public var onRemove:Function;
      
      public var heightOverride:Number;
      
      public var onSelect:Function;
      
      public var _id:Number;
      
      public var parentId:Number;
      
      public var paragraphs:Array;
      
      public var onDestroy:Function;
      
      public function chapterListElement()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function Init(param1:String, param2:Number) : *
      {
         this._id = param2;
         this.paragraphs = new Array();
         this.editableElement_mc.Init(this.chapter_mc,param1,523,27);
         this.editableElement_mc.onRemove = this.onChapterRemove;
         this.editableElement_mc.addEventListener("HeightChanged",this.onHeightChanged);
         this.editableElement_mc.id = param2;
         this.updateHeight();
      }
      
      public function onHeightChanged(param1:Event) : *
      {
         this.updateHeight();
         dispatchEvent(new Event("HeightChanged"));
      }
      
      public function updateHeight() : *
      {
         this.heightOverride = this.editableElement_mc.heightOverride;
      }
      
      public function setEditable(param1:Boolean) : *
      {
         this.editableElement_mc.setEditable(param1);
         if(param1)
         {
            addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
            removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         else
         {
            removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
            addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }
      
      public function selectThis() : *
      {
         if(this.onSelect != null)
         {
            this.onSelect(this);
         }
      }
      
      public function onMouseUp(param1:Event) : *
      {
         this.selectThis();
      }
      
      public function onChapterRemove() : *
      {
         if(this.onRemove != null)
         {
            this.onRemove(this.list_pos);
         }
         ExternalInterface.call("removeNode",this.id);
         if(this.onDestroy != null)
         {
            this.onDestroy(this);
         }
      }
      
      public function onFocusIn(param1:Event) : *
      {
         this.selectThis();
      }
      
      public function createParagraph(param1:Number, param2:int, param3:String, param4:Boolean) : MovieClip
      {
         var _loc5_:* = new paragraphListElement();
         _loc5_.Init(param3,param1);
         _loc5_.editableElement_mc.setShared(param4);
         _loc5_.parentId = this._id;
         if(this.paragraphs.length <= param2)
         {
            this.paragraphs[param2] = _loc5_;
         }
         else
         {
            this.paragraphs.splice(param2,0,_loc5_);
         }
         return _loc5_;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      function frame1() : *
      {
      }
   }
}
