package journal_fla
{
   import LS_Classes.horizontalList;
   import LS_Classes.listDisplay;
   import LS_Classes.scrollList;
   import LS_Classes.scrollListGrouped;
   import LS_Classes.textHelpers;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public dynamic class journalMC_1 extends MovieClip
   {
       
      
      public var bg_mc:MovieClip;
      
      public var close_mc:MovieClip;
      
      public var container_mc:empty;
      
      public var dialogLogContainer_mc:empty;
      
      public var infoContainer_mc:MovieClip;
      
      public var journalContainer_mc:empty;
      
      public var leftJournalBtn_mc:stateButton;
      
      public var mapName_txt:TextField;
      
      public var map_mc:MovieClip;
      
      public var onMapBtn_mc:button;
      
      public var paperTop_mc:MovieClip;
      
      public var postponeBtn_mc:button;
      
      public var rightJournalBtn_mc:stateButton;
      
      public var showPostponed_mc:CheckBoxWlabel;
      
      public var tabHolder_mc:empty;
      
      public var tutorialContainer_mc:MovieClip;
      
      public const cLineHeight:Number = 30;
      
      public const cSbOffset:Number = -5;
      
      public const cListTopSpacing:Number = 30;
      
      public const cScrollSpeed:Number = 60.0;
      
      public const cSbYOffset:Number = -4;
      
      public const cMaxLines:Number = 20;
      
      public const tutEntryDeselectColour:uint = 0;
      
      public const tutDeselectColour:uint = 7346462;
      
      public const tutSelectColour:uint = 23424;
      
      public var selectedCompID:Number;
      
      public var totalHeight:Number;
      
      public var maxWidth:Number;
      
      public var WidthSpacing:Number;
      
      public var HeightSpacing:Number;
      
      public var minWidth:Number;
      
      public var root_mc:MovieClip;
      
      public var scrollPlaneLWidth:Number;
      
      public var scrollPlaneRWidth:Number;
      
      public var scrollPlaneHeight:Number;
      
      public var openedQuest:MovieClip;
      
      public var openedDialog:MovieClip;
      
      public var questSelectedId:String;
      
      public var postponeBtnText:Array;
      
      public const RListHeightDisc:Number = 10;
      
      public const scrollbarSize:Number = 404;
      
      public const cqSbYOffset:Number = 160;
      
      public var activeList:scrollList;
      
      public var closedList:scrollList;
      
      public var journalList:scrollList;
      
      public const cInfoListY:Number = 40;
      
      public var infoList:scrollList;
      
      public var dialogList:scrollList;
      
      public var tutorialList:scrollListGrouped;
      
      public var tabList:horizontalList;
      
      public var currentList:listDisplay;
      
      public var tooltipBtn_array:Array;
      
      public var isAvatar:Boolean;
      
      public var lastDialog:MovieClip;
      
      public var dialogColours:Array;
      
      public function journalMC_1()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function onSelectTut(param1:Event) : *
      {
         this.tutorialContainer_mc.showSelected(this.tutorialList.getCurrentMovieClip());
      }
      
      public function setBtnTooltip(param1:Number, param2:String) : *
      {
         if(param1 >= 0 && param1 < this.tooltipBtn_array.length)
         {
            this.tooltipBtn_array[param1].tooltip = param2;
         }
      }
      
      public function nextEl() : *
      {
         this.journalList.next();
      }
      
      public function prevEl() : *
      {
         this.journalList.previous();
      }
      
      public function addTutorialEntry(param1:String, param2:Number, param3:String, param4:String) : *
      {
         var _loc6_:MovieClip = null;
         var _loc5_:MovieClip = this.tutorialList.getElementByString("gName",param1);
         if(_loc5_ == null)
         {
            _loc5_ = this.addTutorialCategory(this.tutorialList.length + 1,param1);
         }
         if(_loc5_ != null)
         {
            _loc6_ = this.addTutorialEntryINT(_loc5_.groupId,param2,param3,param4);
            if(this.tutorialList.length == 1 && _loc5_.list.length == 1)
            {
               _loc5_.setOpen(true);
               this.tutorialList.selectMC(_loc6_);
            }
         }
      }
      
      public function addTutorialCategory(param1:Number, param2:String) : MovieClip
      {
         var _loc3_:MovieClip = this.tutorialList.addGroup(param1,param2,false);
         if(_loc3_ != null)
         {
            _loc3_.init();
            _loc3_.title_txt.autoSize = TextFieldAutoSize.LEFT;
            _loc3_.heightOverride = this.tutorialList.m_myInterlinie;
            _loc3_.gName = param2;
            _loc3_.list.EL_SPACING = 0;
            _loc3_.list.TOP_SPACING = 0;
            _loc3_.list.m_customElementHeight = this.tutorialList.m_myInterlinie;
            _loc3_.entryHeight = this.tutorialList.m_myInterlinie;
            _loc3_.listOffset = this.cLineHeight;
            _loc3_.deselectColour = this.tutDeselectColour;
            _loc3_.selectColour = this.tutDeselectColour;
            _loc3_.setTextColor(this.tutDeselectColour);
            return _loc3_;
         }
         return null;
      }
      
      public function addTutorialEntryINT(param1:Number, param2:Number, param3:String, param4:String) : MovieClip
      {
         var _loc5_:MovieClip = this.getTutorialEntry(param1,param2);
         if(_loc5_ == null)
         {
            _loc5_ = new TutorialEntry();
            _loc5_.Init();
            _loc5_.title_txt.autoSize = TextFieldAutoSize.LEFT;
            _loc5_.id = param2;
            _loc5_.title_txt.htmlText = param3;
            _loc5_.titleStr = param3;
            _loc5_.descStr = param4;
            _loc5_.mainlist = this.tutorialList;
            _loc5_.deselectColour = this.tutEntryDeselectColour;
            _loc5_.selectColour = this.tutSelectColour;
            _loc5_.setTextColor(this.tutEntryDeselectColour);
            this.tutorialList.addGroupElement(param1,_loc5_,false);
         }
         return _loc5_;
      }
      
      public function getTutorialEntry(param1:Number, param2:Number) : MovieClip
      {
         var _loc3_:MovieClip = this.tutorialList.getElementByNumber("groupId",param1);
         if(_loc3_)
         {
            return _loc3_.list.getElementByNumber("id",param2);
         }
         return null;
      }
      
      public function tutorialUpdateDone() : *
      {
         this.tutorialList.positionElements();
      }
      
      public function clearTutorials() : *
      {
         this.tutorialList.clearElements();
      }
      
      public function addTab(param1:Number, param2:Number, param3:String, param4:Boolean) : *
      {
         var _loc5_:MovieClip = new tabBtn();
         if(_loc5_)
         {
            _loc5_.SND_Click = "UI_Gen_BigButton_Click";
            _loc5_.textInActiveAlpha = 1;
            _loc5_.m_AllowToggleActive = false;
            _loc5_.textActiveAlpha = 1;
            _loc5_.id = param1;
            _loc5_.funcId = param2;
            _loc5_.initialize(param3,this.selectClickedTab,_loc5_,param4);
            this.tabList.addElement(_loc5_);
            if(param4)
            {
               this.tabList.selectMC(_loc5_);
            }
         }
      }
      
      public function setTabEnabled(param1:Number, param2:Boolean) : *
      {
         var _loc3_:MovieClip = this.tabList.getElementByNumber("id",param1);
         if(_loc3_)
         {
            _loc3_.setEnabled(param2);
         }
      }
      
      public function selectTab(param1:uint) : *
      {
         var _loc2_:MovieClip = this.tabList.getElementByNumber("id",param1);
         this.selectClickedTab(_loc2_);
      }
      
      public function selectClickedTab(param1:MovieClip) : *
      {
         this.tabList.getCurrentMovieClip().setActive(false);
         this.tabList.selectMC(param1);
         param1.setActive(true);
         this.infoContainer_mc.visible = false;
         if(this.tabList.getCurrentMovieClip() != param1)
         {
            this.dialogLogContainer_mc.visible = false;
            this.infoList.clearElements();
            this.infoContainer_mc.title_mc.visible = false;
            this.openedDialog = null;
         }
         if(param1.funcId == 0)
         {
            this.infoContainer_mc.visible = true;
            this.journalContainer_mc.visible = true;
            this.journalList.mouseWheelWhenOverEnabled = true;
            this.currentList = this.journalList;
            this.leftJournalBtn_mc.visible = true;
            this.rightJournalBtn_mc.visible = true;
            this.paperTop_mc.visible = true;
            this.onMapBtn_mc.visible = this.postponeBtn_mc.visible = this.showPostponed_mc.visible = this.rightJournalBtn_mc.visible && !this.rightJournalBtn_mc.isActive;
            this.toggleQuest(this.openedQuest,true,false);
         }
         else
         {
            this.journalContainer_mc.visible = false;
            this.journalList.mouseWheelWhenOverEnabled = false;
            this.leftJournalBtn_mc.visible = false;
            this.rightJournalBtn_mc.visible = false;
            this.paperTop_mc.visible = false;
            this.onMapBtn_mc.visible = this.postponeBtn_mc.visible = this.showPostponed_mc.visible = false;
         }
         if(param1.funcId == 3)
         {
            this.bg_mc.gotoAndStop(2);
            this.mapName_txt.visible = true;
            this.map_mc.visible = true;
            this.map_mc.mouseWheelEnabled = true;
            this.currentList = null;
         }
         else
         {
            this.mapName_txt.visible = false;
            this.map_mc.visible = false;
            this.map_mc.mouseWheelEnabled = false;
         }
         if(param1.funcId == 4)
         {
            this.infoContainer_mc.visible = true;
            this.dialogLogContainer_mc.visible = true;
            this.dialogList.mouseWheelWhenOverEnabled = true;
            this.currentList = this.dialogList;
         }
         else
         {
            this.dialogLogContainer_mc.visible = false;
            this.dialogList.mouseWheelWhenOverEnabled = false;
         }
         if(param1.funcId == 7)
         {
            this.tutorialContainer_mc.visible = true;
            this.tutorialList.mouseWheelWhenOverEnabled = true;
            this.currentList = this.tutorialList;
         }
         else
         {
            this.tutorialContainer_mc.visible = false;
            this.tutorialList.mouseWheelWhenOverEnabled = false;
         }
         if(this.map_mc.visible)
         {
            this.bg_mc.gotoAndStop(3);
         }
         else if(param1.funcId == 0)
         {
            this.bg_mc.gotoAndStop(1);
            if(this.bg_mc.btnBG_mc)
            {
               this.bg_mc.btnBG_mc.visible = this.onMapBtn_mc.visible;
            }
         }
         else
         {
            this.bg_mc.gotoAndStop(2);
         }
         ExternalInterface.call("PlaySound","UI_Game_Journal_Click");
         ExternalInterface.call("selectClickedTab",param1.id);
      }
      
      public function toggleDialog(param1:MovieClip, param2:Boolean = true) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         if(param1)
         {
            if(this.openedDialog != param1 || param2)
            {
               this.infoList.clearElements();
               if(this.openedDialog != null)
               {
                  this.openedDialog.setTextColour(18034);
               }
               this.infoContainer_mc.title_mc.subTitle_txt.htmlText = "";
               _loc3_ = 0;
               while(_loc3_ < param1.infolist.length)
               {
                  this.infoList.addElement(param1.infolist.getAt(_loc3_),false);
                  _loc3_++;
               }
               _loc4_ = param1.title_mc.name_txt.htmlText;
               this.infoContainer_mc.title_mc.title_txt.htmlText = _loc4_.toUpperCase();
               this.infoContainer_mc.title_mc.title_txt.textColor = 6881285;
               param1.setTextColour(6881285);
               this.openedDialog = param1;
               this.infoContainer_mc.title_mc.visible = true;
               this.infoContainer_mc.title_mc.setDeco();
               this.infoList.positionElements();
               this.infoPageResetLayout();
            }
            else
            {
               this.openedDialog.setTextColour(18034);
               this.openedDialog = null;
               this.infoList.clearElements();
               this.infoContainer_mc.title_mc.visible = false;
            }
         }
      }
      
      public function infoPageResetLayout() : *
      {
         var _loc1_:int = 0;
         if(this.openedQuest && this.openedQuest.isMystery && !this.openedQuest.isCompleted)
         {
            _loc1_ = 20;
            this.infoList.setFrame(this.scrollPlaneRWidth,this.scrollPlaneHeight + this.RListHeightDisc - 10 - this.infoContainer_mc.title_mc.subTitle_txt.textHeight - _loc1_);
            this.infoList.y = this.cInfoListY + 14 + this.infoContainer_mc.title_mc.subTitle_txt.textHeight + _loc1_;
            this.infoList.m_scrollbar_mc.y = this.cqSbYOffset - 2 - this.infoContainer_mc.title_mc.subTitle_txt.textHeight - _loc1_;
            this.infoList.m_scrollbar_mc.setLength(this.scrollbarSize);
         }
         else
         {
            this.infoList.setFrame(this.scrollPlaneRWidth,this.scrollPlaneHeight + this.RListHeightDisc - 10);
            this.infoList.y = this.cInfoListY + 14;
            this.infoList.m_scrollbar_mc.y = this.cqSbYOffset - 2;
            this.infoList.m_scrollbar_mc.setLength(this.scrollbarSize);
         }
      }
      
      public function addDialog(param1:Number, param2:Number, param3:String, param4:String, param5:String) : *
      {
         var _loc6_:MovieClip = new DialogEntry();
         if(_loc6_)
         {
            _loc6_.title_mc.name_txt.autoSize = TextFieldAutoSize.LEFT;
            _loc6_.title_mc.level_txt.autoSize = TextFieldAutoSize.LEFT;
            _loc6_.title_mc.dateTime_txt.autoSize = TextFieldAutoSize.LEFT;
            _loc6_.id = param1;
            _loc6_.dateTime = param2;
            _loc6_.title_mc.name_txt.htmlText = param4;
            _loc6_.title_mc.level_txt.htmlText = param5;
            _loc6_.title_mc.dateTime_txt.htmlText = param3;
            _loc6_.infolist = new listDisplay();
            _loc6_.infolist.TOP_SPACING = this.cLineHeight;
            _loc6_.infolist.EL_SPACING = 0;
            this.dialogList.addElement(_loc6_,false);
            _loc6_.speakerArray = new Array();
            _loc6_.heightOverride = Math.round(_loc6_.height / this.cLineHeight) * this.cLineHeight;
            if(this.lastDialog == null || this.lastDialog && this.lastDialog.dateTime < _loc6_.dateTime)
            {
               this.lastDialog = _loc6_;
            }
         }
      }
      
      public function addDialogLine(param1:Number, param2:int, param3:String, param4:String) : *
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Number = NaN;
         var _loc5_:MovieClip = this.dialogList.getElementByNumber("id",param1);
         if(_loc5_)
         {
            _loc6_ = null;
            _loc7_ = _loc5_.infolist.length;
            if(_loc7_ > 0)
            {
               _loc6_ = _loc5_.infolist.getAt(_loc7_ - 1) as MovieClip;
               if(_loc6_ != null && (param3 != _loc6_._speaker || param3 == _loc6_._speaker && param2 != _loc6_.speakerType))
               {
                  _loc6_ = null;
               }
            }
            if(_loc6_ == null)
            {
               _loc6_ = new DialogLine();
               _loc6_.iline_txt.autoSize = _loc6_.line_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc6_.iline_txt.width = _loc6_.line_txt.width = this.scrollPlaneRWidth - 64;
               _loc6_._speaker = param3;
               _loc6_.speakerType = param2;
               _loc6_.textStr = "\t" + param3 + " - " + param4;
               _loc5_.infolist.addElement(_loc6_,false);
            }
            else
            {
               _loc6_.textStr = _loc6_.textStr + (" " + param4);
            }
            if(param2 == 4)
            {
               _loc6_.iline_txt.htmlText = "";
               textHelpers.setFormattedText(_loc6_.iline_txt,_loc6_.textStr);
               _loc6_.iline_txt.textColor = 0;
            }
            else
            {
               textHelpers.setFormattedText(_loc6_.line_txt,_loc6_.textStr);
               _loc6_.line_txt.textColor = this.getColourForSpeaker(param3,_loc5_.speakerArray);
            }
            _loc6_.heightOverride = Math.round(_loc6_.height / this.cLineHeight) * this.cLineHeight;
         }
      }
      
      public function findIdInArray(param1:String, param2:Array) : Number
      {
         var _loc3_:Number = -1;
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            if(param1 == param2[_loc4_])
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ == -1)
         {
            _loc3_ = param2.length;
            param2.push(param1);
         }
         return _loc3_;
      }
      
      public function getColourForSpeaker(param1:String, param2:Array) : uint
      {
         var _loc3_:Number = this.findIdInArray(param1,param2);
         _loc3_ = _loc3_ % this.dialogColours.length;
         return this.dialogColours[_loc3_];
      }
      
      public function dialogUpdateDone() : *
      {
         var _loc1_:MovieClip = null;
         if(this.dialogList.length > 0)
         {
            this.dialogList.positionElements();
            for each(_loc1_ in this.dialogList.content_array)
            {
               _loc1_.infolist.positionElements();
            }
            if(this.lastDialog)
            {
               this.toggleDialog(this.lastDialog,true);
            }
         }
      }
      
      public function clearDialogs() : *
      {
         this.lastDialog = null;
         this.dialogList.clearElements();
      }
      
      public function clearQuests() : *
      {
         var _loc3_:MovieClip = null;
         if(this.openedQuest)
         {
            this.openedQuest = null;
         }
         var _loc1_:MovieClip = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.journalList.length)
         {
            _loc3_ = this.journalList.getAt(_loc2_);
            if(_loc3_ && _loc3_.filterName != this.root_mc.secretsFilterName)
            {
               _loc3_.questList.clearElements();
            }
            else if(_loc3_ && _loc3_.filterName == this.root_mc.secretsFilterName)
            {
               _loc1_ = _loc3_;
            }
            _loc2_++;
         }
         this.journalList.clearElements();
         this.infoList.clearElements();
         this.infoContainer_mc.title_mc.visible = false;
         if(_loc1_ != null)
         {
            this.journalList.addElement(_loc1_);
         }
      }
      
      public function loadQuests(param1:Boolean = false) : *
      {
         if(this.leftJournalBtn_mc.isActive != param1)
         {
            this.leftJournalBtn_mc.setActive(param1);
            this.onMapBtn_mc.visible = this.postponeBtn_mc.visible = this.showPostponed_mc.visible = param1;
            if(this.bg_mc.btnBG_mc)
            {
               this.bg_mc.btnBG_mc.visible = this.onMapBtn_mc.visible;
            }
            this.rightJournalBtn_mc.setActive(!param1);
            this.infoList.clearElements();
            this.infoContainer_mc.title_mc.visible = false;
            this.swapList(param1);
         }
      }
      
      public function swapList(param1:Boolean) : *
      {
         if(this.journalList)
         {
            this.journalContainer_mc.removeChild(this.journalList);
         }
         this.journalList = !!param1?this.activeList:this.closedList;
         if(this.bg_mc.btnBG_mc)
         {
            this.bg_mc.btnBG_mc.visible = Boolean(this.journalList == this.activeList);
         }
         this.journalContainer_mc.addChild(this.journalList);
         this.toggleQuest(this.openedQuest);
         if(this.journalList == this.closedList)
         {
            this.checkForCompletedQuests();
         }
         this.journalList.positionElements();
         this.openedQuest = null;
         this.questUpdateDone();
      }
      
      public function checkForCompletedQuests() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:uint = 0;
         var _loc4_:* = undefined;
         var _loc1_:uint = 0;
         while(_loc1_ < this.activeList.length)
         {
            _loc2_ = this.activeList.getAt(_loc1_);
            if(_loc2_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.questList.length)
               {
                  _loc4_ = _loc2_.questList.getAt(_loc3_);
                  if(_loc4_ && _loc4_.isCompleted && _loc4_.isSeen)
                  {
                     this.setQuestComplete(_loc4_.questId);
                  }
                  _loc3_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function toggleQuest(param1:MovieClip, param2:Boolean = false, param3:Boolean = true) : *
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc8_:uint = 0;
         var _loc9_:MovieClip = null;
         this.infoList.clearElements();
         this.infoContainer_mc.title_mc.visible = false;
         if(param1)
         {
            _loc4_ = 23424;
            if(this.openedQuest != param1 || param2)
            {
               if(this.openedQuest != null)
               {
                  this.openedQuest.title_mc.img_mc.gotoAndStop(1);
                  this.openedQuest.title_mc.name_txt.textColor = 0;
                  this.openedQuest.flag_mc.gotoAndStop(1);
               }
               this.openedQuest = param1;
               this.infoContainer_mc.title_mc.visible = true;
               this.openedQuest.flag_mc.gotoAndStop(2);
               _loc5_ = param1.title_mc.name_txt.htmlText;
               this.infoContainer_mc.title_mc.title_txt.htmlText = _loc5_.toUpperCase();
               this.infoContainer_mc.title_mc.title_txt.textColor = 2555904;
               if(param1.isMystery && !param1.isCompleted)
               {
                  this.infoContainer_mc.title_mc.subTitle_txt.htmlText = param1.questionStr;
               }
               else
               {
                  this.infoContainer_mc.title_mc.subTitle_txt.htmlText = "";
               }
               if(param1.infolist.length > 0)
               {
                  _loc7_ = null;
                  _loc8_ = 0;
                  while(_loc8_ < param1.infolist.length)
                  {
                     _loc7_ = param1.infolist.getAt(_loc8_);
                     if(_loc7_)
                     {
                        _loc7_.isNew = _loc7_.isNew && !param1.isSeen;
                        this.infoList.addElement(_loc7_,false);
                        _loc7_.icon_mc.gotoAndStop(1);
                     }
                     _loc8_++;
                  }
                  _loc7_ = this.infoList.getFirstElement();
                  if(_loc7_)
                  {
                     _loc7_.icon_mc.gotoAndStop(2);
                  }
               }
               this.infoContainer_mc.title_mc.setDeco();
               param1.isSeen = true;
               param1.title_mc.img_mc.gotoAndStop(4);
               param1.title_mc.name_txt.textColor = _loc4_;
               this.infoList.positionElements();
               _loc6_ = "";
               _loc8_ = 0;
               while(_loc8_ < this.infoList.length)
               {
                  _loc9_ = this.infoList.getAt(_loc8_);
                  if(_loc9_)
                  {
                     if(_loc9_.objectiveID == _loc6_)
                     {
                        if(_loc6_ != "")
                        {
                           _loc9_.setObjectiveStr("",false);
                        }
                     }
                     else
                     {
                        _loc6_ = _loc9_.objectiveID;
                        _loc9_.setObjectiveStr(_loc9_.objectiveStr,false);
                     }
                  }
                  _loc8_++;
               }
               this.infoList.positionElements();
               this.infoPageResetLayout();
               if(param3 && this.journalList == this.activeList)
               {
                  ExternalInterface.call("questOpened",param1.questId);
                  this.questSelectedId = param1.questId;
               }
               param1.filterCategory.expand(true);
            }
            else
            {
               this.openedQuest = null;
               param1.title_mc.img_mc.gotoAndStop(1);
               param1.title_mc.name_txt.textColor = 0;
            }
            this.onMapBtn_mc.setEnabled(this.journalList == this.activeList && param1.flag_mc.visible && !param1.isPostponed);
            this.postponeBtn_mc.setEnabled(param1.canPostpone);
            this.postponeBtn_mc.setText(!!param1.isPostponed?this.postponeBtnText[0]:this.postponeBtnText[1]);
         }
         else
         {
            this.onMapBtn_mc.setEnabled(false);
            this.postponeBtn_mc.setEnabled(false);
            this.postponeBtn_mc.setText(this.postponeBtnText[0]);
         }
      }
      
      public function GetFilter(param1:String, param2:Boolean, param3:Boolean = true) : MovieClip
      {
         var _loc4_:scrollList = !!param2?this.closedList:this.activeList;
         var _loc5_:MovieClip = _loc4_.getElementByString("filterName",param1);
         if(!_loc5_ && param3)
         {
            _loc5_ = new questFilter();
            _loc5_.selectable = false;
            _loc5_.lineHeight = this.cLineHeight;
            _loc5_.init(param1,_loc4_);
            _loc5_.name = "q" + param1 + "_mc";
            _loc4_.addElement(_loc5_);
         }
         return _loc5_;
      }
      
      public function findQuest(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = this.findQuestInList(this.activeList,param1);
         if(!_loc2_)
         {
            _loc2_ = this.findQuestInList(this.closedList,param1);
         }
         return _loc2_;
      }
      
      public function findQuestInList(param1:scrollList, param2:String) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         for each(_loc3_ in param1.content_array)
         {
            _loc4_ = _loc3_.questList.getElementByString("questId",param2);
            if(_loc4_)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function OnMapQuest() : *
      {
         ExternalInterface.call("showQuestOnMap",this.getCurrentQuestMarkerId());
      }
      
      public function getCurrentQuestMarkerId() : String
      {
         var _loc1_:String = "";
         if(this.openedQuest)
         {
            _loc1_ = this.openedQuest.getCurrentMarker();
         }
         return _loc1_;
      }
      
      public function showPostponed() : *
      {
         ExternalInterface.call("showPostponed",this.showPostponed_mc.isActive);
      }
      
      public function addSubQuest(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Number, param8:int) : *
      {
         var _loc10_:MovieClip = null;
         var _loc11_:String = null;
         var _loc9_:MovieClip = this.findQuest(param1);
         if(_loc9_ && !_loc9_.isUpdated)
         {
            if(this.showPostponed_mc.isActive || !_loc9_.isPostponed)
            {
               _loc9_ = this.findQuestInList(this.closedList,param1);
            }
         }
         if(_loc9_)
         {
            _loc10_ = _loc9_.subQuests.getElementByString("questId",param2);
            if(!_loc10_)
            {
               _loc10_ = new QuestEntry();
               _loc10_.title_mc.name_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc11_ = param3.toUpperCase();
               _loc10_.base = this;
               _loc10_.entryHeight = this.cLineHeight;
               _loc10_.onInit();
               _loc10_.infolist.sortOn(["objectiveOrder","updateTime","id"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
               _loc10_.filterCategory = _loc9_.filterCategory;
               _loc10_.isQuest = true;
               _loc10_.questId = param2;
               _loc10_.updateTime = param7;
               _loc10_.priority = param8;
               _loc10_.qName = param3;
               _loc10_.title_mc.x = _loc10_.subQuestIcon_mc.x + _loc10_.subQuestIcon_mc.width + 3;
               _loc10_.title_mc.hl_mc.x = -_loc10_.title_mc.x;
               _loc10_.title_mc.name_txt.width = 330;
               _loc9_.subQuests.addElement(_loc10_,false);
            }
            _loc10_.title_mc.img_mc.gotoAndStop(!!param5?5:1);
            _loc10_.title_mc.name_txt.htmlText = param3;
            _loc10_.isPostponed = param6;
            _loc10_.alpha = !!param6?Number(0.5):Number(1);
            _loc10_.isUpdated = true;
            _loc10_.isCompleted = param4;
            if(param4)
            {
               _loc10_.title_mc.name_txt.htmlText = _loc10_.title_mc.name_txt.htmlText + (" (" + this.root_mc.questCompletedLabel + ")");
               _loc10_.refreshLocationIcon();
               _loc10_.title_mc.img_mc.gotoAndStop(1);
               _loc10_.title_mc.name_txt.textColor = 0;
            }
            if(param5)
            {
               _loc10_.startAnim();
            }
         }
      }
      
      public function addQuest(param1:String, param2:String, param3:String, param4:int, param5:String, param6:Boolean, param7:Boolean, param8:Boolean, param9:Number, param10:int, param11:Boolean) : *
      {
         var _loc13_:MovieClip = null;
         var _loc12_:MovieClip = this.GetFilter(param3,param6 && !param7);
         if(_loc12_)
         {
            _loc12_.priority = param4;
            _loc13_ = _loc12_.questList.getElementByString("questId",param1);
            if(_loc13_ == null)
            {
               _loc13_ = new QuestEntry();
               _loc13_.flag_mc.visible = false;
               _loc13_.filterCategory = _loc12_;
               _loc13_.logType = "quest";
               _loc13_.entryHeight = this.cLineHeight;
               _loc13_.onInit();
               _loc13_.infolist.sortOn(["objectiveOrder","updateTime","id"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
               _loc13_.questId = param1;
               _loc13_.name = param1 + "_mc";
               _loc13_.title_mc.name_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc13_.subQuestIcon_mc.visible = false;
               _loc13_.updateTime = 0;
               _loc13_.subQuests = new listDisplay();
               _loc13_.subQuests.EL_SPACING = 0;
               _loc13_.addChild(_loc13_.subQuests);
               _loc12_.questList.addElement(_loc13_,false);
            }
            if(param7)
            {
               _loc12_.expand(true);
            }
            _loc13_.priority = param10;
            _loc13_.canPostpone = param11 && !param6;
            _loc13_.isPostponed = !param6 && param8;
            _loc13_.isSeen = !param7;
            _loc13_.updateTime = param9;
            _loc13_.isUpdated = this.showPostponed_mc.isActive || !param8;
            _loc13_.isCompleted = param6;
            _loc13_.title_mc.hl_mc.visible = false;
            _loc13_.title_mc.img_mc.gotoAndStop(!!param7?5:1);
            _loc13_.title_mc.name_txt.htmlText = param5;
            if(param6)
            {
               _loc13_.title_mc.name_txt.htmlText = _loc13_.title_mc.name_txt.htmlText + (" (" + this.root_mc.questCompletedLabel + ")");
               _loc13_.title_mc.img_mc.gotoAndStop(1);
               _loc13_.title_mc.name_txt.textColor = 0;
            }
            _loc13_.subQuests.y = _loc13_.title_mc.y + _loc13_.title_mc.name_txt.y + _loc13_.title_mc.name_txt.textHeight - 2;
            _loc13_.qName = param5;
         }
      }
      
      public function addMystery(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String) : *
      {
         var _loc9_:MovieClip = null;
         var _loc8_:MovieClip = this.GetFilter(param2.toUpperCase(),param4 && !param5);
         if(_loc8_)
         {
            _loc8_.priority = int.MAX_VALUE;
            _loc9_ = _loc8_.questList.getElementByString("questId",param1);
            if(_loc9_ == null)
            {
               _loc9_ = new QuestEntry();
               _loc9_.filterCategory = _loc8_;
               _loc9_.logType = "quest";
               _loc9_.entryHeight = this.cLineHeight;
               _loc9_.isMystery = true;
               _loc9_.onInit();
               _loc9_.infolist.sortOn(["objectiveOrder","updateTime","id"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
               _loc9_.questId = param1;
               _loc9_.name = param1 + "_mc";
               _loc9_.title_mc.name_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc9_.subQuestIcon_mc.visible = false;
               _loc9_.updateTime = 0;
               _loc9_.flag_mc.visible = false;
               _loc8_.questList.addElement(_loc9_,false);
               if(param4)
               {
                  this.addQuestAction(true,"",param1,"",-1,"",0,param7,"",0,"");
               }
            }
            if(param5)
            {
               _loc8_.expand(true);
            }
            _loc9_.questionStr = param6;
            _loc9_.completeStr = param7;
            _loc9_.priority = 0;
            _loc9_.canPostpone = false;
            _loc9_.isPostponed = false;
            _loc9_.isSeen = !param5;
            _loc9_.updateTime = 0;
            _loc9_.isUpdated = true;
            _loc9_.isCompleted = param4;
            _loc9_.title_mc.hl_mc.visible = false;
            _loc9_.title_mc.img_mc.gotoAndStop(!!param5?5:1);
            _loc9_.title_mc.name_txt.htmlText = param3;
            if(param4)
            {
               _loc9_.title_mc.name_txt.htmlText = _loc9_.title_mc.name_txt.htmlText + (" (" + this.root_mc.questCompletedLabel + ")");
            }
            _loc9_.qName = param3;
         }
      }
      
      public function PostponeQuest() : *
      {
         ExternalInterface.call("postponeQuest",this.openedQuest.questId,this.openedQuest.isPostponed);
      }
      
      public function setQuestComplete(param1:String) : *
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc2_:MovieClip = this.findQuestInList(this.activeList,param1);
         if(_loc2_ != null && !_loc2_.finalUpdateSeen)
         {
            _loc2_.finalUpdateSeen = true;
            _loc3_ = this.GetFilter(_loc2_.filterCategory.filterName,false);
            if(_loc3_)
            {
               _loc3_.questList.removeElement(_loc2_.list_pos,true);
               _loc3_.calculateHeight();
               _loc3_.visible = _loc3_.questList.length > 0;
               _loc3_ = this.GetFilter(_loc2_.filterCategory.filterName,true);
               _loc4_ = _loc3_.questList.getElementByString("questId",_loc2_.questId);
               if(!_loc4_)
               {
                  if(_loc2_.isMystery)
                  {
                     this.addQuestAction(true,"",_loc2_.questId,"",-1,"",0,_loc2_.completeStr,"",0,"");
                  }
                  _loc2_.flag_mc.visible = false;
                  _loc2_.isCompleted = true;
                  _loc3_.questList.addElement(_loc2_,true);
                  _loc3_.calculateHeight();
                  _loc2_.filterCategory = _loc3_;
                  this.journalList.positionElements();
               }
            }
         }
      }
      
      public function addQuestAction(param1:Boolean, param2:String, param3:String, param4:String, param5:int, param6:String, param7:Number, param8:String, param9:String, param10:Number = 0, param11:String = "") : *
      {
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         if(param2 == "")
         {
            _loc12_ = this.findQuest(param3);
         }
         else
         {
            _loc13_ = this.findQuest(param2);
            if(_loc13_)
            {
               _loc12_ = _loc13_.subQuests.getElementByString("questId",param3);
            }
         }
         if(_loc12_)
         {
            this.int_addQuestAction(param1,param2,_loc12_,param4,param5,param6,param7,param8,param9,param10,param11);
         }
      }
      
      public function int_addQuestAction(param1:Boolean, param2:String, param3:MovieClip, param4:String, param5:int, param6:String, param7:Number, param8:String, param9:String, param10:Number = 0, param11:String = "") : *
      {
         var _loc12_:MovieClip = null;
         if(param3 != null)
         {
            _loc12_ = param3.infolist.getElementByNumber("id",param7);
            if(_loc12_ == null)
            {
               _loc12_ = new QuestAction();
               _loc12_.mysteryIcon_mc.visible = param1;
               _loc12_.id = param7;
               _loc12_.dateNr = param10;
               _loc12_.name_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc12_.objective_txt.autoSize = TextFieldAutoSize.LEFT;
               _loc12_.icon_mc.gotoAndStop(1);
               param3.infolist.addElement(_loc12_,false);
               _loc12_.markerID = param11;
               _loc12_.cLineHeight = this.cLineHeight;
               if(param11 == "")
               {
                  _loc12_.markerList = new Array();
               }
               else
               {
                  _loc12_.markerList = param11.split(";");
               }
            }
            _loc12_.text = param8;
            if(param5 == -1)
            {
               param5 = int.MAX_VALUE;
            }
            _loc12_.objectiveOrder = param5;
            _loc12_.objectiveID = param4;
            _loc12_.setObjectiveStr(param6);
            _loc12_.name_txt.htmlText = param8;
            if(param10 > param3.updateTime)
            {
               param3.updateTime = param10;
            }
         }
      }
      
      public function fixOffset(param1:Number, param2:Number) : Number
      {
         return Math.ceil(param1 / param2) * param2;
      }
      
      public function strReplace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public function questAddingDone() : *
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.journalList.content_array)
         {
            if(_loc1_)
            {
               _loc1_.questList.cleanUpElements();
            }
         }
         this.journalList.positionElements();
      }
      
      public function questUpdateDone() : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         this.journalContainer_mc.visible = true;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this.journalList.content_array)
         {
            if(_loc2_)
            {
               for each(_loc3_ in _loc2_.questList.content_array)
               {
                  if(_loc3_)
                  {
                     _loc3_.visible = this.showPostponed_mc.isActive || !_loc3_.isPostponed;
                     if(_loc3_.visible)
                     {
                        if(!_loc1_ && _loc3_.subQuests && _loc3_.subQuests.length > 0)
                        {
                           _loc4_ = _loc3_.subQuests.getElementByString("questId",this.questSelectedId);
                           if(_loc4_)
                           {
                              if(this.openedQuest == null)
                              {
                                 this.openedQuest = _loc4_;
                              }
                              _loc1_ = true;
                           }
                        }
                        if(!_loc1_ && this.questSelectedId == _loc3_.questId)
                        {
                           if(this.openedQuest == null)
                           {
                              this.openedQuest = _loc3_;
                           }
                           _loc1_ = true;
                        }
                     }
                     if(!_loc3_.isMystery)
                     {
                        if(_loc3_.subQuests && _loc3_.subQuests.length > 0)
                        {
                           for each(_loc5_ in _loc3_.subQuests.content_array)
                           {
                              _loc5_.infolist.positionElements();
                              if(!_loc5_.isMystery)
                              {
                                 _loc5_.refreshLocationIcon();
                              }
                           }
                        }
                     }
                     _loc3_.infolist.positionElements();
                     if(!_loc3_.isMystery)
                     {
                        _loc3_.refreshLocationIcon();
                     }
                  }
               }
               _loc2_.questList.positionElements();
               _loc2_.visible = _loc2_.questList.visibleLength > 0;
               _loc2_.calculateHeight();
            }
         }
         this.journalList.positionElements();
         if(!_loc1_)
         {
            _loc6_ = this.journalList.getFirstVisible();
            if(_loc6_)
            {
               this.openedQuest = _loc6_.questList.getFirstElement();
            }
         }
         if(this.openedQuest)
         {
            this.toggleQuest(this.openedQuest,true,!_loc1_);
         }
         else
         {
            this.infoList.clearElements();
            this.infoContainer_mc.title_mc.visible = false;
         }
      }
      
      public function getFirstJournalEntry(param1:Boolean) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc4_:uint = 0;
         var _loc5_:* = undefined;
         var _loc2_:uint = 0;
         while(_loc2_ < this.journalList.length)
         {
            _loc3_ = this.journalList.getAt(_loc2_);
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.questList.length)
               {
                  _loc5_ = _loc3_.questList.getAt(_loc4_);
                  if(_loc5_)
                  {
                     if(_loc5_.isPostponed == param1)
                     {
                        return _loc5_;
                     }
                  }
                  _loc4_++;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setPersonalTrait(param1:Number, param2:String, param3:String, param4:Number) : *
      {
      }
      
      public function clearPersonalTraits() : *
      {
      }
      
      public function moveCursor(param1:Boolean) : *
      {
         if(this.currentList)
         {
            if(this.currentList == this.journalList)
            {
               return;
            }
            if(param1)
            {
               this.currentList.previous();
            }
            else
            {
               this.currentList.next();
            }
            this.setListLoopable(false);
         }
      }
      
      public function setListLoopable(param1:Boolean) : *
      {
         if(this.currentList)
         {
            this.currentList.m_cyclic = param1;
         }
      }
      
      public function setCursorPositionMC(param1:MovieClip) : *
      {
         if(this.currentList)
         {
            if(param1)
            {
               this.currentList.selectMC(param1);
            }
            else
            {
               this.currentList.clearSelection();
            }
         }
      }
      
      public function executeSelected() : *
      {
         var _loc1_:MovieClip = null;
         if(this.currentList)
         {
            _loc1_ = this.currentList.getCurrentMovieClip();
            if(_loc1_ && _loc1_.onUp)
            {
               _loc1_.onUp(null);
            }
         }
      }
      
      public function removeChildrenOf(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         if(param1.numChildren != 0)
         {
            _loc2_ = param1.numChildren;
            while(_loc2_ > 0)
            {
               _loc2_--;
               param1.removeChildAt(_loc2_);
            }
         }
      }
      
      public function addIggyIcon(param1:MovieClip, param2:String) : *
      {
         var _loc3_:MovieClip = null;
         if(param2 != param1.texture)
         {
            this.removeChildrenOf(param1);
            _loc3_ = new IggyIcon();
            _loc3_.name = "iggy_" + param2;
            param1.texture = param2;
            param1.addChild(_loc3_);
         }
      }
      
      public function resizeToContent() : *
      {
         this.journalList.m_scrollbar_mc.scrollToFit();
      }
      
      function frame1() : *
      {
         this.selectedCompID = 0;
         this.totalHeight = 0;
         this.maxWidth = 0;
         this.WidthSpacing = 80;
         this.HeightSpacing = 10;
         this.minWidth = 400;
         this.root_mc = root as MovieClip;
         this.scrollPlaneLWidth = 400;
         this.scrollPlaneRWidth = 760;
         this.scrollPlaneHeight = 724;
         this.openedDialog = null;
         this.activeList = new scrollList("down2_id","up2_id","handle2_id","scrollBg2_id");
         this.activeList.setFrame(this.scrollPlaneLWidth,this.scrollPlaneHeight);
         this.activeList.containerBG_mc.x = 20;
         this.activeList.y = 35;
         this.activeList.x = 0;
         this.activeList.EL_SPACING = this.cLineHeight;
         this.activeList.m_allowKeepIntoView = false;
         this.activeList.m_scrollbar_mc.m_hideWhenDisabled = true;
         this.activeList.SB_SPACING = -(this.scrollPlaneLWidth + 49);
         this.activeList.m_scrollbar_mc.y = this.cqSbYOffset;
         this.activeList.m_scrollbar_mc.m_SCROLLSPEED = this.cLineHeight;
         this.activeList.m_scrollbar_mc.setLength(this.scrollbarSize);
         this.activeList.m_scrollbar_mc.ScaleBG = true;
         this.activeList.sortOn(["priority","updateTime","filterName"],[Array.NUMERIC,Array.NUMERIC,Array.CASEINSENSITIVE]);
         this.activeList.m_cyclic = true;
         this.closedList = new scrollList("down2_id","up2_id","handle2_id","scrollBg2_id");
         this.closedList.setFrame(this.scrollPlaneLWidth,this.scrollPlaneHeight);
         this.closedList.containerBG_mc.x = 20;
         this.closedList.y = 35;
         this.closedList.x = 0;
         this.closedList.EL_SPACING = this.cLineHeight;
         this.closedList.m_allowKeepIntoView = false;
         this.closedList.m_scrollbar_mc.m_hideWhenDisabled = true;
         this.closedList.SB_SPACING = -(this.scrollPlaneLWidth + 49);
         this.closedList.m_scrollbar_mc.y = this.cqSbYOffset;
         this.closedList.m_scrollbar_mc.m_SCROLLSPEED = this.cLineHeight;
         this.closedList.m_scrollbar_mc.setLength(this.scrollbarSize);
         this.closedList.m_scrollbar_mc.ScaleBG = true;
         this.closedList.sortOn(["priority","updateTime","filterName"],[Array.NUMERIC,Array.NUMERIC,Array.CASEINSENSITIVE]);
         this.closedList.m_cyclic = true;
         this.journalList = this.activeList;
         this.journalContainer_mc.addChild(this.journalList);
         this.activeList.addEventListener(MouseEvent.ROLL_OVER,function():*
         {
            activeList.mouseWheelEnabled = true;
         });
         this.activeList.addEventListener(MouseEvent.ROLL_OUT,function():*
         {
            activeList.mouseWheelEnabled = false;
         });
         this.closedList.addEventListener(MouseEvent.ROLL_OVER,function():*
         {
            closedList.mouseWheelEnabled = true;
         });
         this.closedList.addEventListener(MouseEvent.ROLL_OUT,function():*
         {
            closedList.mouseWheelEnabled = false;
         });
         this.infoList = new scrollList("down2_id","up2_id","handle2_id","scrollBg2_id");
         this.infoList.EL_SPACING = this.cLineHeight;
         this.infoList.TOP_SPACING = this.cLineHeight;
         this.infoList.setFrame(this.scrollPlaneRWidth,this.scrollPlaneHeight + this.RListHeightDisc - 10);
         this.infoContainer_mc.addChild(this.infoList);
         this.infoList.y = this.cInfoListY + 14;
         this.infoList.x = 54;
         this.infoList.m_allowKeepIntoView = false;
         this.infoList.mouseWheelWhenOverEnabled = true;
         this.infoList.m_scrollbar_mc.m_hideWhenDisabled = true;
         this.infoList.SB_SPACING = this.scrollPlaneRWidth - 800;
         this.infoList.m_scrollbar_mc.y = this.cqSbYOffset - 2;
         this.infoList.m_scrollbar_mc.m_SCROLLSPEED = this.cLineHeight;
         this.infoList.m_scrollbar_mc.setLength(this.scrollbarSize);
         this.infoList.m_scrollbar_mc.ScaleBG = true;
         this.infoList.m_cyclic = true;
         this.dialogList = new scrollList("down2_id","up2_id","handle2_id","scrollBg2_id");
         this.dialogList.EL_SPACING = 0;
         this.dialogList.TOP_SPACING = 0;
         this.dialogList.setFrame(this.scrollPlaneLWidth,this.scrollPlaneHeight + this.RListHeightDisc);
         this.dialogList.sortOn(["dateTime","id"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         this.dialogLogContainer_mc.addChild(this.dialogList);
         this.dialogLogContainer_mc.visible = false;
         this.dialogList.y = 49;
         this.dialogList.x = 30;
         this.dialogList.m_scrollbar_mc.m_hideWhenDisabled = true;
         this.dialogList.SB_SPACING = -(this.scrollPlaneLWidth + 40);
         this.dialogList.m_scrollbar_mc.y = this.cqSbYOffset - 2;
         this.dialogList.m_scrollbar_mc.m_SCROLLSPEED = this.cLineHeight;
         this.dialogList.m_scrollbar_mc.setLength(this.scrollbarSize);
         this.dialogList.m_scrollbar_mc.ScaleBG = true;
         this.dialogList.m_cyclic = true;
         this.tutorialList = new scrollListGrouped("down2_id","up2_id","handle2_id","scrollBg2_id");
         this.tutorialList.EL_SPACING = 0;
         this.tutorialList.setGroupMC("TutCategory");
         this.tutorialList.TOP_SPACING = this.cListTopSpacing;
         this.tutorialList.setFrame(this.scrollPlaneLWidth,this.scrollPlaneHeight);
         this.tutorialContainer_mc.addChild(this.tutorialList);
         this.tutorialList.m_myInterlinie = this.cLineHeight;
         this.tutorialList.m_allowAutoScroll = true;
         this.tutorialList.groupedScroll = false;
         this.tutorialList.x = 0;
         this.tutorialList.y = 72;
         this.tutorialList.m_scrollbar_mc.m_hideWhenDisabled = true;
         this.tutorialList.SB_SPACING = -(this.scrollPlaneLWidth + 9);
         this.tutorialList.m_scrollbar_mc.y = this.cqSbYOffset + 25;
         this.tutorialList.m_scrollbar_mc.m_SCROLLSPEED = this.cLineHeight;
         this.tutorialList.m_scrollbar_mc.setLength(this.scrollbarSize);
         this.tutorialList.m_scrollbar_mc.ScaleBG = true;
         this.tutorialList.m_cyclic = true;
         this.showPostponed_mc.interactiveTextOnClick = false;
         this.tutorialList.addEventListener(Event.CHANGE,this.onSelectTut);
         this.mapName_txt.visible = false;
         this.map_mc.visible = false;
         this.tabList = new horizontalList();
         this.tabList.EL_SPACING = 60;
         this.tabList.m_forceDepthReorder = true;
         this.tabHolder_mc.addChild(this.tabList);
         this.currentList = this.journalList;
         this.tooltipBtn_array = new Array(this.map_mc.zoomInBtn,this.map_mc.zoomOutBtn);
         this.bg_mc.mouseEnabled = false;
         this.bg_mc.mouseChildren = false;
         this.isAvatar = false;
         this.lastDialog = null;
         this.dialogColours = new Array(0,6881285,17257,1529887);
      }
   }
}
