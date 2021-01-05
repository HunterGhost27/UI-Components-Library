package hotBar_fla
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var actionSkillHolder_mc:MovieClip;
      
      public var endPiece_mc:endFill;
      
      public var hotbar_mc:MovieClip;
      
      public var showLog_mc:MovieClip;
      
      public const firstSlotX:Number = 339;
      
      public const apX:Number = 493;
      
      public const apY:Number = 637;
      
      public const hotBarX:Number = 468;
      
      public const hotBarY:Number = 943;
      
      public const endTurnX:Number = 938;
      
      public const endTurnY:Number = 771;
      
      public const charactersheetTutorialPosX:uint = 118;
      
      public const journalTutorialPosX:uint = 239;
      
      public const mapTutorialPosX:uint = 209;
      
      public const lockTutorialPosX:uint = 306;
      
      public const switchDeckPosX:uint = 329;
      
      public const skillTutorialPosX:uint = 148;
      
      public const tutorialPosY:uint = 930;
      
      public const iconSize:uint = 50;
      
      public const iconSpacing:uint = 6;
      
      public var numberOfActions:uint;
      
      public const maxSlots = 29;
      
      public const designResolution:Point = new Point(1920,1080);
      
      public const actionsPos:uint = 272;
      
      public var numberOfButtons:Number;
      
      public var numberOfShortKeys:Number;
      
      public var uiScaling:Number;
      
      public var isResizing:Boolean;
      
      public var isInCombat:Boolean;
      
      public var inSkillPane:Boolean;
      
      public const baseExpBarWidth:uint = 263;
      
      public const baseBarWidth:uint = 317;
      
      public const visualSlotWidth:uint = 55;
      
      public const barStopWidth:uint = 17;
      
      public var cellWidth:Number;
      
      public var cellHeight:Number;
      
      public var charIconSize:Number;
      
      public var cellSpacing:Number;
      
      public var currentBar:Number;
      
      public var slotUpdateList:Array;
      
      public var slotUpdateDataList:Array;
      
      public var isDragging:Boolean;
      
      public var actionsDefaultVisibility:Boolean;
      
      public var layout:String;
      
      public var events:Array;
      
      public const actionButtonPos:uint = 259;
      
      public var cachedSlots:uint;
      
      public const expLengthOffsetPercentage:Number = 0.007;
      
      public var actionSkillArray:Array;
      
      public var fixedBtnTooltips:Array;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function onEventInit() : *
      {
         this.actionSkillHolder_mc.visible = false;
         this.hotbar_mc.onInit();
      }
      
      public function onEventResolution(param1:Number, param2:Number) : *
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         param1 = param1 / this.uiScaling;
         param2 = param2 / this.uiScaling;
         var _loc3_:uint = Math.floor(param1 / param2 * (this.designResolution.y / this.uiScaling));
         if(_loc3_ < this.designResolution.x)
         {
            _loc4_ = 0;
            if(_loc3_ > this.baseBarWidth)
            {
               _loc4_ = Math.floor((_loc3_ - this.baseBarWidth) / this.visualSlotWidth);
            }
            _loc5_ = this.barStopWidth + this.baseBarWidth + _loc4_ * this.visualSlotWidth + 5;
            this.hotbar_mc.scrollRect = new Rectangle(0,0,_loc5_,this.hotbar_mc.height);
            _loc6_ = 12;
            if(_loc4_ < this.maxSlots)
            {
               if(this.hotbar_mc.isSkillBarShown)
               {
                  this.endPiece_mc.visible = true;
               }
            }
            this.hotbar_mc.x = (_loc6_ + this.designResolution.x - _loc5_) * 0.5;
            this.showLog_mc.x = this.hotbar_mc.x + _loc5_ - this.showLog_mc.width + _loc6_;
            this.endPiece_mc.x = this.hotbar_mc.x + _loc5_;
            this.actionSkillHolder_mc.x = this.hotbar_mc.x + this.actionsPos;
            ExternalInterface.call("updateSlots",_loc4_);
         }
         else
         {
            this.hotbar_mc.x = 0;
            this.hotbar_mc.scrollRect = null;
            this.showLog_mc.x = this.hotbar_mc.logBtnPosX;
            this.endPiece_mc.visible = false;
            this.actionSkillHolder_mc.x = this.hotbar_mc.x + this.actionsPos;
            ExternalInterface.call("updateSlots",this.maxSlots);
         }
         this.resizeExpBar();
      }
      
      public function resizeExpBar() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         if(this.hotbar_mc.expBar_mc != null)
         {
            _loc1_ = this.hotbar_mc.scrollRect != null?uint(this.hotbar_mc.scrollRect.width - this.hotbar_mc.expBar_mc.x):uint(0);
            _loc2_ = _loc1_ != 0?Number(_loc1_ / this.designResolution.x + this.expLengthOffsetPercentage):Number(0.977);
            this.hotbar_mc.expBar_mc.scaleX = _loc2_;
         }
      }
      
      public function startsWith(param1:String, param2:String) : Boolean
      {
         param1 = param1.toLowerCase();
         param2 = param2.toLowerCase();
         return param2 == param1.substr(0,param2.length);
      }
      
      public function onEventDown(param1:Number) : *
      {
         var _loc4_:MovieClip = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = "";
         if(this.hotbar_mc.isSkillBarShown)
         {
            if(this.startsWith(this.events[param1],"IE UISelectSlot") && !this.isDragging)
            {
               _loc3_ = this.events[param1].substr(15,this.events[param1].length - 15);
               if(_loc3_ != "" && _loc3_ != null)
               {
                  param1 = Number(_loc3_) - 1;
                  if(param1 == -1)
                  {
                     param1 = 9;
                  }
                  _loc4_ = this.hotbar_mc.slotholder_mc.getSlot(param1);
                  if(_loc4_)
                  {
                     _loc4_.onClick(null);
                     _loc2_ = true;
                  }
               }
            }
            else if(this.events[param1] == "IE UIHotBarPrev" && !this.isDragging)
            {
               this.hotbar_mc.cycleHotBar_mc.cycleHotBar([true]);
               _loc2_ = true;
            }
            else if(this.events[param1] == "IE UIHotBarNext" && !this.isDragging)
            {
               this.hotbar_mc.cycleHotBar_mc.cycleHotBar([false]);
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function onEventUp(param1:Number) : *
      {
         return false;
      }
      
      public function setExp(param1:Number, param2:Boolean = false) : *
      {
         this.hotbar_mc.setExp(param1,param2);
      }
      
      public function setPlayerHandle(param1:Number) : *
      {
         this.hotbar_mc.characterHandle = param1;
      }
      
      public function updateSlots() : *
      {
         this.hotbar_mc.slotholder_mc.updateSlots();
      }
      
      public function setAllSlotsEnabled(param1:Boolean) : *
      {
         this.hotbar_mc.setAllSlotsEnabled(param1);
      }
      
      public function showActiveSkill(param1:Number) : *
      {
         this.hotbar_mc.slotholder_mc.showActiveSkill(param1);
      }
      
      public function clearAll() : *
      {
         this.hotbar_mc.slotholder_mc.clearAll();
      }
      
      public function updateSlotData() : *
      {
         this.hotbar_mc.slotholder_mc.updateSlotData();
      }
      
      public function allowActionsButton(param1:Boolean) : *
      {
         this.hotbar_mc.actionsButton_mc.setEnabled(param1);
         if(!param1)
         {
            this.hotbar_mc.actionsButton_mc.setActive(false);
         }
      }
      
      public function setText(param1:Number, param2:String) : *
      {
         this.hotbar_mc.hotkeys_mc.setText(param1,param2);
      }
      
      public function setAllText(param1:Array) : *
      {
         this.hotbar_mc.setAllText(param1);
      }
      
      public function setButtonActive(param1:Number, param2:Boolean) : *
      {
         this.hotbar_mc.setButtonActive(param1,param2);
      }
      
      public function showSkillBar(param1:Boolean) : *
      {
         this.hotbar_mc.showSkillBar(param1);
         this.endPiece_mc.visible = param1;
         this.showLog_mc.visible = param1;
      }
      
      public function setLockBtnTooltips(param1:String = "", param2:String = "") : *
      {
         this.hotbar_mc.lockButton_mc.tooltipA = param1;
         this.hotbar_mc.lockButton_mc.tooltipB = param2;
      }
      
      public function setButtonDisabled(param1:Number, param2:Boolean) : *
      {
         this.hotbar_mc.hotbarButtons.getAt(param1).setBtnDisabled(param2);
      }
      
      public function setLockButtonEnabled(param1:Boolean) : *
      {
         this.hotbar_mc.lockButton_mc.setEnabled(param1);
      }
      
      public function setButton(param1:Number, param2:String, param3:String) : *
      {
         this.hotbar_mc.setButton(param1,param2,param3);
      }
      
      public function setCurrentHotbar(param1:uint) : *
      {
         this.hotbar_mc.cycleHotBar_mc.setCurrentBar(param1);
      }
      
      public function updateActionSkills() : *
      {
         this.actionSkillHolder_mc.update(this.actionSkillArray);
      }
      
      public function setActionSkillHolderVisible(param1:Boolean) : *
      {
         this.actionSkillHolder_mc.visible = param1;
         this.hotbar_mc.actionsButton_mc.setActive(param1);
      }
      
      public function toggleActionSkillHolder() : *
      {
         this.actionSkillHolder_mc.visible = !this.actionSkillHolder_mc.visible;
      }
      
      public function setActionPreview(param1:String, param2:Boolean) : *
      {
         this.actionSkillHolder_mc.setActionPreview(param1,param2);
      }
      
      public function setHotbarLocked(param1:Boolean) : *
      {
         this.hotbar_mc.lockButton_mc.setLocked(param1);
      }
      
      public function setFixedBtnTooltips(param1:Number, param2:String) : *
      {
         if(param1 >= 0 && param1 < this.fixedBtnTooltips.length)
         {
            this.fixedBtnTooltips[param1].tooltip = param2;
         }
      }
      
      function frame1() : *
      {
         this.numberOfActions = 3;
         this.numberOfButtons = 6;
         this.numberOfShortKeys = 12;
         this.uiScaling = 1;
         this.isResizing = false;
         this.isInCombat = false;
         this.inSkillPane = false;
         this.cellWidth = 50;
         this.cellHeight = 50;
         this.charIconSize = 45;
         this.cellSpacing = 8;
         this.currentBar = 1;
         this.slotUpdateList = new Array();
         this.slotUpdateDataList = new Array();
         this.isDragging = false;
         this.actionsDefaultVisibility = false;
         this.layout = "fixed";
         this.events = new Array("IE UISelectSlot1","IE UISelectSlot2","IE UISelectSlot3","IE UISelectSlot4","IE UISelectSlot5","IE UISelectSlot6","IE UISelectSlot7","IE UISelectSlot8","IE UISelectSlot9","IE UISelectSlot0","IE UISelectSlot11","IE UISelectSlot12","IE UIHotBarPrev","IE UIHotBarNext","IE UIToggleActions");
         this.cachedSlots = 0;
         this.actionSkillArray = new Array();
         this.fixedBtnTooltips = new Array(this.hotbar_mc.chatBtn_mc.bg_mc,this.showLog_mc.bg_mc,this.hotbar_mc.cycleHotBar_mc.upBtn_mc,this.hotbar_mc.cycleHotBar_mc.downBtn_mc);
      }
   }
}