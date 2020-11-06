package GMJournal_fla
{
   import LS_Classes.textHelpers;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var caption_mc:TextField;
      
      public var closeButton_mc:closeButton;
      
      public var content_mc:MovieClip;
      
      public var paragraphs_mc:MovieClip;
      
      public var shareWithParty_mc:CheckBoxWlabel;
      
      public var toggleEditButton_mc:toggleEditButton;
      
      public var layout:String;
      
      public var isDragging:Boolean;
      
      public const CONTEXT_MENU_EVENT:String = "IE ContextMenu";
      
      public var events:Array;
      
      public var contextTarget:Number;
      
      public var strings:Object;
      
      public var editable:Boolean;
      
      public var entries:Array;
      
      public var EGMJournalNodeType:Object;
      
      public var entriesMap:Object;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function _mouse_press_hack_(param1:MouseEvent) : void
      {
      }
      
      public function onClose() : *
      {
         ExternalInterface.call("PlaySound","UI_Game_Journal_Close");
         ExternalInterface.call("closeUI");
      }
      
      public function onToggleEdit() : *
      {
         this.editable = !this.editable;
         if(!this.editable)
         {
            stage.focus = null;
         }
         this.content_mc.setEditControlsVisible(this.editable);
         this.paragraphs_mc.setEditable(this.editable);
      }
      
      public function HideSharedThings() : *
      {
         this.shareWithParty_mc.visible = false;
      }
      
      public function onEventInit() : *
      {
         ExternalInterface.call("registerAnchorId","gmjournal");
         ExternalInterface.call("setPosition","center","screen","center");
         this.HideSharedThings();
         this.caption_mc.text = textHelpers.toUpperCase(this.strings.caption);
         this.toggleEditButton_mc.initialize(textHelpers.toUpperCase(this.strings.editButtonCaption),this.onToggleEdit);
         this.closeButton_mc.init(this.onClose);
         this.content_mc.Init();
         this.paragraphs_mc.Init();
         this.shareWithParty_mc.init(this.onShareWithParty);
      }
      
      public function updateEntries() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = undefined;
         var _loc1_:int = 0;
         while(_loc1_ < this.entries.length)
         {
            _loc2_ = this.entries[_loc1_++];
            _loc3_ = this.entries[_loc1_++];
            _loc4_ = this.entries[_loc1_++];
            _loc5_ = this.entries[_loc1_++];
            _loc6_ = this.entries[_loc1_++];
            _loc7_ = this.entries[_loc1_++];
            _loc8_ = this.entriesMap[_loc4_];
            switch(_loc2_)
            {
               case this.EGMJournalNodeType.EGMJournalNodeType_Unassigned:
               case this.EGMJournalNodeType.EGMJournalNodeType_Journal:
               default:
                  continue;
               case this.EGMJournalNodeType.EGMJournalNodeType_Category:
                  if(_loc8_ == null)
                  {
                     this.createCategory(_loc4_,_loc3_,_loc6_,_loc7_);
                  }
                  else
                  {
                     this.updateCategory(_loc8_,_loc3_,_loc6_,_loc7_);
                  }
                  continue;
               case this.EGMJournalNodeType.EGMJournalNodeType_Chapter:
                  if(_loc8_ == null)
                  {
                     this.createChapter(_loc4_,_loc5_,_loc3_,_loc6_,_loc7_);
                  }
                  else
                  {
                     this.updateChapter(_loc8_,_loc5_,_loc3_,_loc6_,_loc7_);
                  }
                  continue;
               case this.EGMJournalNodeType.EGMJournalNodeType_Paragraph:
                  if(_loc8_ == null)
                  {
                     this.createParagraph(_loc4_,_loc5_,_loc3_,_loc6_,_loc7_);
                  }
                  else
                  {
                     this.updateParagraph(_loc8_,_loc5_,_loc3_,_loc6_,_loc7_);
                  }
                  continue;
            }
         }
         this.content_mc.rebuildLayout();
         this.entries = new Array();
      }
      
      public function createCategory(param1:Number, param2:int, param3:String, param4:Boolean) : MovieClip
      {
         var _loc5_:* = this.content_mc.createCategory(param1,param2,param3,param4);
         _loc5_.editableElement_mc.ownerScrollList = this.content_mc.categories;
         this.entriesMap[param1] = _loc5_;
         _loc5_.onDestroy = this.onCategoryDestroy;
         return _loc5_;
      }
      
      public function updateCategory(param1:MovieClip, param2:int, param3:String, param4:Boolean) : *
      {
         if(param1.list_pos != param2)
         {
            this.content_mc.categories.addElementOnPos(param1,param2,false);
            this.content_mc.rebuildLayout();
         }
         param1.editableElement_mc.updateText(param3);
         param1.editableElement_mc.setShared(param4);
      }
      
      public function createChapter(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : MovieClip
      {
         var _loc6_:MovieClip = this.entriesMap[param2] as MovieClip;
         if(_loc6_ == null)
         {
            _loc6_ = this.createCategory(param2,this.content_mc.categories.length,"",false);
         }
         var _loc7_:MovieClip = _loc6_.createChapter(param1,param3,param4,param5);
         _loc6_.editableElement_mc.ownerScrollList = this.content_mc.categories;
         _loc7_.onSelect = this.onChapterSelect;
         this.entriesMap[param1] = _loc7_;
         _loc7_.onDestroy = this.onChapterDestroy;
         return _loc7_;
      }
      
      public function updateChapter(param1:MovieClip, param2:Number, param3:int, param4:String, param5:Boolean) : *
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         if(param1.parentId != param2)
         {
            _loc6_ = this.entriesMap[param1.parentId];
            if(_loc6_ != null)
            {
               _loc6_.removeChapter(param1);
            }
            _loc7_ = this.entriesMap[param2];
            if(_loc7_ != null)
            {
               _loc7_.addChapter(param1,param3);
            }
         }
         else if(param3 != param1.list_pos)
         {
            _loc8_ = this.entriesMap[param2];
            if(_loc8_ != null)
            {
               _loc8_.addChapter(param1,param3);
            }
         }
         param1.editableElement_mc.updateText(param4);
         param1.editableElement_mc.setShared(param5);
      }
      
      public function createParagraph(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : *
      {
         var _loc6_:MovieClip = this.entriesMap[param2] as MovieClip;
         if(_loc6_ == null)
         {
            _loc6_ = this.createChapter(param2,-1,0,"",false);
         }
         var _loc7_:* = _loc6_.createParagraph(param1,param3,param4,param5);
         _loc7_.editableElement_mc.ownerScrollList = this.paragraphs_mc._paragraphsList;
         this.entriesMap[param1] = _loc7_;
         if(_loc6_ == this.paragraphs_mc._currentChapter)
         {
            this.paragraphs_mc.addParagraph(_loc7_,param3);
         }
         _loc7_.onDestroy = this.onParagraphDestroy;
      }
      
      public function updateParagraph(param1:MovieClip, param2:Number, param3:int, param4:String, param5:Boolean) : *
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         if(param1.parentId != param2)
         {
            _loc6_ = this.entriesMap[param1.parentId];
            if(_loc6_ != null)
            {
               _loc6_.removeParagraph(param1);
               if(_loc6_ == this.paragraphs_mc._currentChapter)
               {
                  this.paragraphs_mc.removeParagraph(param1);
               }
            }
            _loc7_ = this.entriesMap[param2];
            if(_loc7_ != null)
            {
               _loc7_.addParagraph(param1,param3);
               if(_loc7_ == this.paragraphs_mc._currentChapter)
               {
                  this.paragraphs_mc.addParagraph(param1,param3);
               }
            }
         }
         else if(param3 != param1.list_pos)
         {
            _loc8_ = this.entriesMap[param2];
            if(_loc8_ != null)
            {
               _loc8_.addParagraph(param1,param3);
               if(_loc8_ == this.paragraphs_mc._currentChapter)
               {
                  this.paragraphs_mc.addParagraph(param1,param3);
               }
            }
         }
         param1.editableElement_mc.updateText(param4);
         param1.editableElement_mc.setShared(param5);
      }
      
      public function removeEntry(param1:Number) : *
      {
      }
      
      public function onChapterSelect(param1:MovieClip) : *
      {
         this.paragraphs_mc.selectChapter(param1);
      }
      
      public function onCategoryDestroy(param1:MovieClip) : *
      {
         this.entriesMap[param1.id] = undefined;
         var _loc2_:int = 0;
         while(_loc2_ < param1._chapters.content_array.length - 1)
         {
            this.onChapterDestroy(param1._chapters.getAt(_loc2_));
            _loc2_++;
         }
      }
      
      public function onChapterDestroy(param1:MovieClip) : *
      {
         this.entriesMap[param1.id] = undefined;
         var _loc2_:int = param1.paragraphs.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.onParagraphDestroy(param1.paragraphs[_loc3_]);
            _loc3_++;
         }
         if(this.paragraphs_mc._currentChapter == param1)
         {
            this.paragraphs_mc.selectChapter(null);
         }
      }
      
      public function onParagraphDestroy(param1:MovieClip) : *
      {
         this.entriesMap[param1.id] = undefined;
      }
      
      public function onShareWithParty() : *
      {
         ExternalInterface.call("updateShared",4294967295);
      }
      
      public function onEventUp(param1:Number, param2:Number) : *
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         switch(this.events[param1])
         {
            case this.CONTEXT_MENU_EVENT:
               if(this.editable)
               {
                  _loc3_ = stage.getObjectsUnderPoint(new Point(stage.mouseX,stage.mouseY)).reverse();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc5_ = _loc3_[_loc4_];
                     if(_loc5_ && _loc5_.hasEventListener && _loc5_.hasEventListener(this.CONTEXT_MENU_EVENT))
                     {
                        if(_loc5_ is TextField)
                        {
                           this.contextTarget = textHelpers.getSelectionLengthOfText(_loc5_ as TextField,_loc5_.mouseX,_loc5_.mouseY);
                        }
                        _loc5_.dispatchEvent(new Event(this.CONTEXT_MENU_EVENT));
                        return true;
                     }
                     _loc4_++;
                  }
                  return true;
               }
               break;
            default:
               if(this.editable)
               {
                  _loc3_ = stage.getObjectsUnderPoint(new Point(stage.mouseX,stage.mouseY)).reverse();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc5_ = _loc3_[_loc4_];
                     if(_loc5_ && _loc5_.hasEventListener && _loc5_.hasEventListener(this.CONTEXT_MENU_EVENT))
                     {
                        if(_loc5_ is TextField)
                        {
                           this.contextTarget = textHelpers.getSelectionLengthOfText(_loc5_ as TextField,_loc5_.mouseX,_loc5_.mouseY);
                        }
                        _loc5_.dispatchEvent(new Event(this.CONTEXT_MENU_EVENT));
                        return true;
                     }
                     _loc4_++;
                  }
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function onEventDown(param1:Number, param2:Number) : *
      {
         var _loc3_:TextField = null;
         switch(this.events[param1])
         {
            case "IE UICopy":
               if(stage.focus && stage.focus is TextField)
               {
                  _loc3_ = stage.focus as TextField;
                  ExternalInterface.call("copy",Math.abs(_loc3_.selectionEndIndex - _loc3_.selectionBeginIndex));
               }
               return true;
            case "IE UICut":
               if(stage.focus && stage.focus is TextField)
               {
                  _loc3_ = stage.focus as TextField;
                  ExternalInterface.call("cut",Math.abs(_loc3_.selectionEndIndex - _loc3_.selectionBeginIndex));
               }
               return true;
            case "IE UIPaste":
               if(stage.focus && stage.focus is TextField)
               {
                  _loc3_ = stage.focus as TextField;
                  if(_loc3_.selectable)
                  {
                     ExternalInterface.call("paste");
                  }
               }
               return true;
            case "IE UICancel":
               this.onClose();
               return true;
            default:
               return false;
         }
      }
      
      function frame1() : *
      {
         addEventListener(MouseEvent.MOUSE_DOWN,this._mouse_press_hack_);
         this.layout = "fixed";
         this.isDragging = false;
         this.events = new Array("IE UICopy","IE UICut","IE UIPaste",this.CONTEXT_MENU_EVENT,"IE UICancel");
         this.strings = {
            "caption":"",
            "editButtonCaption":"",
            "addChapter":"",
            "addCategory":"",
            "addParagraph":"",
            "shareWithParty":""
         };
         this.editable = false;
         this.entries = new Array();
         this.EGMJournalNodeType = {
            "EGMJournalNodeType_Unassigned":0,
            "EGMJournalNodeType_Category":1,
            "EGMJournalNodeType_Chapter":2,
            "EGMJournalNodeType_Paragraph":3,
            "EGMJournalNodeType_Journal":4
         };
         this.entriesMap = new Object();
      }
   }
}
