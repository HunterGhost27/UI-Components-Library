package GMJournal_fla
{
   import LS_Classes.scrollList;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   
   public dynamic class Paragraphs_12 extends MovieClip
   {
   
      
      public var addParagraphButton_mc:addParagraphButton;
      public var caption_txt:TextField;
      public var listHolder_mc:MovieClip;
      public var mouseHook_mc:MovieClip;
      public const addParagraphTopMargin:Number = 30;
      public const paragraphListScrollbarOffset:Number = -50;
      public var _paragraphsList:scrollList;
      public var _editable:Boolean;
      public var _currentChapter:MovieClip;
      public const defaultListHeight:Number = 660;
      public const defaultListWidth:Number = 660;
      
      public function Paragraphs_12()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function Init() : *
      {
         //ExternalInterface.call("S7_DebugHook", "Root:paragraphs_mc:Init()", "Initializing paragraphs_mc")
         this._paragraphsList = new scrollList();
         this._paragraphsList.mouseWheelWhenOverEnabled = true;
         this._paragraphsList.setTileableBG = "rightPageBG";
         this.listHolder_mc.addChild(this._paragraphsList);
         this._paragraphsList.elementSpacing = 3;
         this._paragraphsList.setFrame(this.defaultListWidth,this.defaultListHeight);
         this._paragraphsList.m_scrollbar_mc.x = 575;
         this._paragraphsList.m_scrollbar_mc.y = this.paragraphListScrollbarOffset;
         this._paragraphsList.m_scrollbar_mc.setLength(683);
         this._paragraphsList.m_scrollbar_mc.m_hideWhenDisabled = false;
         this._paragraphsList.canPositionInvisibleElements = false;
         this._paragraphsList.m_scrollbar_mc.visible = true;
         
         this.addParagraphButton_mc.initialize((root as MovieClip).strings.addParagraph,this.onAddParagraph);
         this.addParagraphButton_mc.visible = this._editable;
         this.addParagraphButton_mc.heightOverride = 27;
         
         this._paragraphsList.addElement(this.addParagraphButton_mc,false);
         this._paragraphsList.positionElements();
         this._paragraphsList.mouseWheelEnabled = true;
         this.caption_txt.text = "";
         
         var spriteGr:Sprite = new Sprite();
         spriteGr.graphics.beginFill(16711680);
         spriteGr.graphics.drawRect(0,0,620,700);
         spriteGr.graphics.endFill();
         spriteGr.width = 620;
         spriteGr.height = 700;
         spriteGr.alpha = 0;
         this.mouseHook_mc.addChild(spriteGr);
         this.mouseHook_mc.alpha = 0;
      }
      
      public function selectChapter(param1:MovieClip) : *
      {
         if(this._currentChapter != null)
         {
            this._currentChapter.chapter_mc.text_txt.removeEventListener(Event.CHANGE,this.onCaptionChanged);
         }
         this._paragraphsList.clearElements();
         this._currentChapter = param1;
         if(param1 == null)
         {
            this.caption_txt.text = "";
            this.addParagraphButton_mc.visible = false;
            this.adjustListPosition();
            return;
         }
         this._currentChapter.chapter_mc.text_txt.addEventListener(Event.CHANGE,this.onCaptionChanged);
         this._paragraphsList.addElement(this.addParagraphButton_mc,false);
         this.addParagraphButton_mc.visible = this._editable;
         this.caption_txt.text = this._currentChapter.chapter_mc.text_txt.text;
         this.adjustListPosition();
         var _loc2_:* = 0;
         while(_loc2_ < this._currentChapter.paragraphs.length)
         {
            this.createParagraph(this._currentChapter.paragraphs[_loc2_],_loc2_);
            _loc2_++;
         }
         this.rebuildLayout();
      }
      
      public function onAddParagraph() : *
      {
         ExternalInterface.call("addParagraph",this._currentChapter.id);
      }
      
      public function createParagraph(param1:MovieClip, param2:int) : *
      {
         this._paragraphsList.addElementOnPosition(param1,param2,false);
         this.initParagraph(param1);
      }
      
      public function addParagraph(param1:MovieClip, param2:int) : *
      {
         this.createParagraph(param1,param2);
         this.rebuildLayout();
      }
      
      public function initParagraph(param1:MovieClip) : *
      {
         param1.setEditable(this._editable);
         param1.addEventListener("HeightChanged",this.onHeightChanged);
         param1.onRemove = this.onParagraphRemove;
      }
      
      public function onHeightChanged(param1:Event) : *
      {
         this._paragraphsList.positionElements();
      }
      
      public function adjustListPosition() : *
      {
         this._paragraphsList.m_topSpacing = this.caption_txt.height - this.addParagraphTopMargin;
      }
      
      public function setEditable(editable:Boolean) : *
      {
         //ExternalInterface.call("S7_DebugHook", "Root:paragraphs_mc:setEditable()", editable)
         
         var paragraphElement:* = undefined;
         this._editable = editable;
         
         var i:* = 0;
         while(i < this._paragraphsList.length - 1)
         {
            paragraphElement = this._paragraphsList.getAt(i);
            if(paragraphElement.setEditable != undefined)
            {
               paragraphElement.setEditable(editable);
            }
            i++;
         }
         if(this._currentChapter != null)
         {
            this.addParagraphButton_mc.visible = editable;
         }
         this._paragraphsList.positionElements();
      }
      
      public function onParagraphRemove(param1:int) : *
      {
         var _loc2_:MovieClip = this._currentChapter.paragraphs[param1] as MovieClip;
         var _loc3_:* = _loc2_._id;
         this._currentChapter.paragraphs.splice(param1,1);
         this._paragraphsList.removeElement(param1);
         ExternalInterface.call("removeNode",_loc3_);
      }
      
      public function rebuildLayout() : *
      {
         var _loc1_:DisplayObjectContainer = this.addParagraphButton_mc.parent;
         _loc1_.setChildIndex(this.addParagraphButton_mc,_loc1_.numChildren - 1);
         this._paragraphsList.positionElements();
      }
      
      public function onCaptionChanged(param1:Event) : *
      {
         this.caption_txt.text = this._currentChapter.chapter_mc.text_txt.text;
         this.adjustListPosition();
      }
      
      function frame1() : *
      {
      }
   }
}
