package partyInventory_fla
{
   import LS_Classes.LSPanelHelpers;
   import LS_Classes.horizontalList;
   import LS_Classes.inventoryClass;
   import LS_Classes.larTween;
   import LS_Classes.listDisplay;
   import LS_Classes.scrollList;
   import LS_Classes.textEffect;
   import LS_Classes.textHelpers;
   import fl.motion.easing.Sine;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getDefinitionByName;
   
   public dynamic class partyInventory_1 extends MovieClip
   {
       
      
      public var allBtn_mc:AllBtn;
      
      public var autosortBtn_mc:sortBtn;
      
      public var bgFrame_mc:MovieClip;
      
      public var close_mc:m_CloseButton;
      
      public var dragHit_mc:MovieClip;
      
      public var faderBot:MovieClip;
      
      public var faderTop:MovieClip;
      
      public var hitArea_mc:MovieClip;
      
      public var keyHintsHolder_mc:empty;
      
      public var listHolder_mc:empty;
      
      public var minimise_mc:MinimiseButton;
      
      public var sortByBg_mc:MovieClip;
      
      public var sortByBtn_mc:sortBtn;
      
      public var sortBy_mc:MovieClip;
      
      public var tabs_mc:empty;
      
      public var title_txt:TextField;
      
      public var totalGold_mc:MovieClip;
      
      public var view_mc:MovieClip;
      
      public const cSize:uint = 50;
      
      public const invColW:uint = 11;
      
      public const cSpacing:uint = 8;
      
      public const bgDiscrap:Number = -3;
      
      public const portraitH:uint = 100;
      
      public const portraitW:uint = 80;
      
      public var selectedCharHandle:Number;
      
      public var overContainer:Boolean;
      
      public var usePartyView:Boolean;
      
      public var list:scrollList;
      
      public const invW:uint = 650;
      
      public const invH:uint = 827;
      
      public const invMinH:uint = 349;
      
      public var minimised:Boolean;
      
      public var tabList:horizontalList;
      
      public var keyHintsList:listDisplay;
      
      public function partyInventory_1()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function justEatClick(param1:MouseEvent) : *
      {
      }
      
      public function getTab(param1:Number) : MovieClip
      {
         return this.tabList.getElementByNumber("id",param1);
      }
      
      public function selectTab(param1:Number, param2:Boolean = false, param3:Boolean = false) : *
      {
         var _loc5_:uint = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:uint = 0;
         var _loc4_:String = "UI_Game_Inventory_Click";
         if(param1 != -1)
         {
            this.clearSlots();
            _loc5_ = 0;
            if(param1 == 0)
            {
               _loc5_ = 0;
               while(_loc5_ < this.tabList.length)
               {
                  this.tabList.getAt(_loc5_).selectElement();
                  _loc5_++;
               }
               if(param2)
               {
                  ExternalInterface.call("PlaySound",_loc4_);
               }
            }
            else
            {
               _loc6_ = this.getTab(param1);
               if(_loc6_)
               {
                  if(param3)
                  {
                     _loc7_ = 0;
                     while(_loc7_ < this.tabList.length)
                     {
                        _loc8_ = this.tabList.getAt(_loc7_);
                        if(_loc8_)
                        {
                           if(_loc8_.id != param1)
                           {
                              _loc8_.deselectElement();
                           }
                           else
                           {
                              _loc8_.selectElement();
                           }
                        }
                        _loc7_++;
                     }
                     if(param2)
                     {
                        ExternalInterface.call("PlaySound",_loc4_);
                     }
                  }
                  else if(!_loc6_.isSelected())
                  {
                     _loc6_.selectElement();
                     if(param2)
                     {
                        ExternalInterface.call("PlaySound",_loc4_);
                     }
                  }
                  else
                  {
                     _loc9_ = 0;
                     while(_loc9_ < this.tabList.length)
                     {
                        if(this.tabList.getAt(_loc9_).id != param1 && this.tabList.getAt(_loc9_).isSelected())
                        {
                           _loc6_.deselectElement();
                           if(param2)
                           {
                              ExternalInterface.call("PlaySound",_loc4_);
                           }
                           break;
                        }
                        _loc9_++;
                     }
                  }
               }
            }
         }
      }
      
      public function onBGOut(param1:MouseEvent) : *
      {
      }
      
      public function closeUIBtn() : *
      {
         var _loc1_:MovieClip = root as MovieClip;
         if(_loc1_.isDragging)
         {
            ExternalInterface.call("cancelDragging");
         }
         else
         {
            ExternalInterface.call("closeCharacterUIs");
         }
      }
      
      public function onContextMenuInputUp() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.list.length)
         {
            if(this.list.getAt(_loc1_).inv.onContextMenuInputUp())
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function init() : *
      {
         var _loc4_:MovieClip = null;
         this.tabList = new horizontalList();
         this.tabList.EL_SPACING = 0;
         this.tabs_mc.addChild(this.tabList);
         var _loc1_:uint = 7;
         var _loc2_:Class = getDefinitionByName("InvTabIcon") as Class;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = new Tab();
            _loc4_.select_mc.visible = false;
            _loc4_.id = -1;
            _loc4_.disabled_mc.visible = false;
            _loc4_.iconMC = new _loc2_();
            _loc4_.icon_mc.alpha = 0;
            _loc4_.icon_mc.addChild(_loc4_.iconMC);
            this.tabList.addElement(_loc4_);
            _loc3_++;
         }
         this.title_txt.mouseEnabled = false;
         this.close_mc.init(this.closeUIBtn);
         this.close_mc.SND_Click = "UI_Game_Inventory_Close";
         this.minimise_mc.init(this.minimiseUIBtn);
         this.faderTop.mouseEnabled = this.faderBot.mouseEnabled = false;
         this.list = new scrollList();
         this.list.dragAutoScroll = true;
         this.list.EL_SPACING = 0;
         this.list.scrollbarSpacing = 1;
         this.list.mouseWheelWhenOverEnabled = true;
         this.list.setFrame(this.invW,this.invH);
         this.listHolder_mc.addChild(this.list);
         this.list.sortOn(["order"],[Array.NUMERIC]);
         this.view_mc.pressedFunc = this.pressedView;
         this.sortBy_mc.init();
         this.sortByBg_mc.visible = false;
         this.allBtn_mc.init(this.selectAllPressed);
         this.allBtn_mc.onOverFunc = this.allBtnOver;
         this.allBtn_mc.onOutFunc = this.allBtnOut;
         this.title_txt.filters = this.autosortBtn_mc.text_txt.filters = this.sortByBtn_mc.text_txt.filters = this.title_txt.filters = textEffect.createStrokeFilter(0,1.4,1,1.8,3);
         this.totalGold_mc.value_txt.autoSize = TextFieldAutoSize.LEFT;
         this.totalGold_mc.label_txt.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public function allBtnOver() : *
      {
         this.allBtn_mc.text_txt.textColor = 16777215;
      }
      
      public function allBtnOut() : *
      {
         this.allBtn_mc.text_txt.textColor = 11900037;
      }
      
      public function selectAllPressed() : *
      {
         this.selectTab(0);
      }
      
      public function minimiseUIBtn() : *
      {
         this.setMinimised(!this.minimised);
      }
      
      public function setMinimised(param1:Boolean) : *
      {
         var _loc2_:Number = NaN;
         if(this.minimised != param1)
         {
            _loc2_ = 594;
            this.bgFrame_mc.gotoAndStop(!!param1?2:1);
            this.list.setFrame(this.invW,!!param1?Number(this.invMinH):Number(this.invH));
            this.minimised = param1;
            ExternalInterface.call("setMcSize",682,!!param1?_loc2_:1152);
            this.list.m_scrollbar_mc.scrollbarVisible();
            this.hitArea_mc.height = !!param1?Number(_loc2_ - 50):Number(1152);
            this.sortByBg_mc.height = !!param1?Number(350):Number(827);
            this.sortBy_mc.y = !!param1?Number(0):Number(100);
         }
      }
      
      public function modifyTextFieldToFit(param1:TextField, param2:String) : *
      {
         if(param1.textWidth > param1.width)
         {
            param1.htmlText = param2;
            textHelpers.smallCaps(param1,2,true);
         }
      }
      
      public function setSortBtnTexts(param1:String, param2:String) : *
      {
         this.autosortBtn_mc.initialize(param1.toUpperCase(),this.autosortPressed);
         this.autosortBtn_mc.m_AllowToggleActive = false;
         this.sortByBtn_mc.initialize(param2.toUpperCase(),this.sortByPressed);
         this.sortByBtn_mc.m_AllowToggleActive = true;
         this.modifyTextFieldToFit(this.autosortBtn_mc.text_txt,param1);
         this.modifyTextFieldToFit(this.sortByBtn_mc.text_txt,param2);
      }
      
      public function autosortPressed() : *
      {
         ExternalInterface.call("autosort");
      }
      
      public function sortByPressed() : *
      {
         this.setSortPanelVisible(!this.sortBy_mc.visible);
      }
      
      public function setSortPanelVisible(param1:Boolean, param2:Boolean = true) : *
      {
         this.sortBy_mc.visible = param1;
         this.sortByBg_mc.visible = param1;
         if(!param1)
         {
            if(param2)
            {
               this.sortBy_mc.resetOptions();
            }
            this.sortByBtn_mc.setActive(false);
         }
      }
      
      public function pressedView(param1:Boolean) : *
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.usePartyView = param1;
         ExternalInterface.call("showParty",!!param1?1:0);
         if(this.usePartyView)
         {
            _loc2_ = 0;
            while(_loc2_ < this.list.length)
            {
               _loc3_ = this.list.getAt(_loc2_);
               if(_loc3_)
               {
                  _loc3_.visible = true;
               }
               _loc2_++;
            }
            this.list.positionElements();
         }
         else
         {
            this.showSingleInventory();
         }
      }
      
      public function showSingleInventory() : *
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.list.length)
         {
            _loc2_ = this.list.getAt(_loc1_);
            if(_loc2_)
            {
               if(_loc2_.id == this.selectedCharHandle)
               {
                  _loc2_.visible = true;
                  _loc2_.setOpenState(true);
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
            _loc1_++;
         }
         this.list.positionElements();
      }
      
      public function getNextTab() : MovieClip
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.tabList.length)
         {
            if(this.tabList.getAt(_loc1_).id == -1)
            {
               return this.tabList.getAt(_loc1_);
            }
            _loc1_++;
         }
         return null;
      }
      
      public function addTab(param1:Number, param2:Number, param3:String) : *
      {
         var _loc4_:MovieClip = this.getNextTab();
         if(_loc4_)
         {
            _loc4_.tooltip = param3;
            _loc4_.id = param1;
            if(_loc4_.imgID != param2)
            {
               _loc4_.iconMC.gotoAndStop(param2);
               _loc4_.tw = new larTween(_loc4_.icon_mc,"alpha",Sine.easeOut,0,1,0.15);
            }
            _loc4_.imgID = param2;
         }
      }
      
      public function onCellCreate(param1:MovieClip) : *
      {
         if(param1)
         {
            param1.base = root as MovieClip;
         }
      }
      
      public function addInventory(param1:Number, param2:String, param3:Boolean, param4:Boolean, param5:Number, param6:Number) : *
      {
         var _loc8_:Number = NaN;
         var _loc7_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc7_ == null)
         {
            _loc8_ = 94;
            _loc7_ = new playerInventory();
            _loc7_.frame_mc.gotoAndStop(this.list.length % 4 + 1);
            this.list.addElement(_loc7_,false);
            _loc7_.id = param1;
            _loc7_.inv = new inventoryClass(param1,"Cell",this.invColW,1,this.cSize,this.cSize,this.cSpacing,this.onCellCreate);
            _loc7_.inv.m_Base = root as MovieClip;
            _loc7_.drop_mc.visible = false;
            _loc7_.inv.gridRefresh = true;
            _loc7_.selected = false;
            _loc7_.invOpen = true;
            _loc7_.init();
            _loc7_.icon = new iggyIcon();
            _loc7_.list = this.list;
            _loc7_.inv.y = 56;
            _loc7_.inv.x = 12;
            _loc7_.inv.addEventListener("GridChanged",this.gridChangeCallback);
            _loc7_.icon.scrollRect = new Rectangle(0,10,_loc8_,45);
            _loc7_.iconHolder_mc.addChild(_loc7_.icon);
            _loc7_.addChild(_loc7_.inv);
            _loc7_.weight_txt.mouseEnabled = false;
            _loc7_.gold_txt.mouseEnabled = false;
            _loc7_.icon.scrollRect = new Rectangle(0,10,_loc8_,45);
            _loc7_.iconHolder_mc.addChild(_loc7_.icon);
            _loc7_.inv.bgDiscrap = -3;
            _loc7_.updateBG();
         }
         if(_loc7_)
         {
            if(this.selectedCharHandle == param1)
            {
               _loc7_.setSelected(true);
               _loc7_.visible = true;
            }
            else
            {
               _loc7_.setSelected(false);
               _loc7_.visible = this.usePartyView;
            }
            _loc7_.ownedByUI = param3;
            _loc7_.lockBtn_mc.setActive(param4);
            _loc7_.f_updated = true;
            _loc7_.order = param6;
            _loc7_.name_txt.htmlText = param2;
            ExternalInterface.call("rowsChanged",_loc7_.inv.id,_loc7_.inv.row);
         }
      }
      
      public function cleanupList() : *
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.list.length)
         {
            _loc2_ = this.list.getAt(_loc1_);
            if(_loc2_)
            {
               if(_loc2_.f_updated)
               {
                  _loc2_.f_updated = false;
                  _loc1_++;
               }
               else
               {
                  this.list.removeElement(_loc1_,false);
               }
            }
         }
         if(this.list.length > 0)
         {
            this.list.positionElements();
         }
         this.view_mc.setDisabled(Boolean(this.list.length <= 1));
         this.totalGold_mc.visible = Boolean(this.list.length > 1);
      }
      
      public function setCharacterGoldWeight(param1:Number, param2:String, param3:String) : *
      {
         var _loc4_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc4_)
         {
            _loc4_.goldStr = param2;
            _loc4_.gold_txt.htmlText = param2;
            _loc4_.weight_txt.htmlText = param3;
         }
         this.updateTotalGold();
      }
      
      public function updateTotalGold() : *
      {
         var _loc1_:Number = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.list.length)
         {
            _loc1_ = _loc1_ + Number(this.list.content_array[_loc2_].goldStr);
            _loc2_++;
         }
         this.totalGold_mc.value_txt.htmlText = "" + _loc1_;
      }
      
      public function gridChangeCallback(param1:Event) : *
      {
         var _loc3_:MovieClip = null;
         var _loc2_:inventoryClass = param1.currentTarget as inventoryClass;
         if(_loc2_)
         {
            _loc3_ = this.list.getElementByNumber("id",_loc2_.id);
            if(_loc3_)
            {
               _loc3_.updateBG();
            }
            ExternalInterface.call("rowsChanged",_loc2_.id,_loc2_.row);
         }
      }
      
      public function removeInventory(param1:Number) : *
      {
         var _loc2_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc2_)
         {
            this.list.removeElementByListId(_loc2_.list_id);
         }
      }
      
      public function setMultiplayerMode(param1:Boolean) : *
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this.list.content_array)
         {
            _loc2_.setLockButtonVisible(_loc2_.ownedByUI && param1);
         }
      }
      
      public function setActionsDisabled(param1:Number, param2:Boolean) : *
      {
         var _loc4_:Number = NaN;
         var _loc3_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc3_)
         {
            _loc4_ = !!param2?Number(0.6):Number(1);
            _loc3_.inv.alpha = _loc4_;
            _loc3_.frame_mc.alpha = _loc4_;
            _loc3_.bagIcon_mc.gotoAndStop(!!param2?2:1);
            _loc3_.inv.disableActions = param2;
            _loc3_.updateTextColours();
         }
      }
      
      public function addItem(param1:Number, param2:uint, param3:Number, param4:Number, param5:Boolean) : *
      {
         var _loc7_:* = undefined;
         var _loc6_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc6_)
         {
            _loc7_ = _loc6_.inv.addItem(param2,param3,param4);
            _loc7_.setIsNewItem(param5);
         }
      }
      
      public function setSelectedCharacter(param1:Number) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         if(this.selectedCharHandle != param1)
         {
            _loc2_ = this.list.getElementByNumber("id",this.selectedCharHandle);
            if(_loc2_)
            {
               _loc2_.setSelected(false);
            }
            _loc3_ = this.list.getElementByNumber("id",param1);
            if(_loc3_)
            {
               _loc3_.setSelected(true);
            }
            this.selectedCharHandle = param1;
            if(!this.usePartyView)
            {
               this.showSingleInventory();
            }
         }
      }
      
      public function removeItem(param1:Number, param2:uint) : *
      {
         var _loc3_:MovieClip = this.list.getElementByNumber("id",param1);
         if(_loc3_)
         {
            _loc3_.inv.removeItem(param2) as Cell;
         }
      }
      
      public function clearSlots() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.list.length)
         {
            this.list.content_array[_loc1_].inv.clearSlots();
            _loc1_++;
         }
         this.list.resetScroll();
      }
      
      public function addKeyHint(param1:String, param2:String) : *
      {
         var _loc3_:MovieClip = new keyBtnHint();
         if(_loc3_)
         {
            _loc3_.setupBtn(param1,param2);
            this.keyHintsList.addElement(_loc3_);
         }
      }
      
      public function clearKeyHints() : *
      {
         this.keyHintsList.clearElements();
      }
      
      public function clearList() : *
      {
         this.list.clearElements();
         this.updateTotalGold();
      }
      
      function frame1() : *
      {
         LSPanelHelpers.makeDraggable(this.dragHit_mc);
         this.selectedCharHandle = 0;
         this.overContainer = false;
         this.usePartyView = true;
         this.minimised = false;
         this.hitArea_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.justEatClick);
         this.hitArea_mc.addEventListener(MouseEvent.MOUSE_UP,this.justEatClick);
         this.dragHit_mc.addEventListener(MouseEvent.ROLL_OUT,this.onBGOut);
         this.keyHintsList = new listDisplay();
         this.keyHintsHolder_mc.addChild(this.keyHintsList);
      }
   }
}