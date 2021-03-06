﻿package msgbox_fla
{
   import LS_Classes.listDisplay;
   import LS_Classes.textEffect;
   import LS_Classes.textHelpers;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.text.TextField;

   public dynamic class popup_mc_1 extends MovieClip
   {
      public var bg_mc:MovieClip;
      
      public var cButtons_mc:MovieClip;
      
      public var input_mc:MovieClip;
      
      public var text_mc:MovieClip;
      
      public var title_txt:TextField;
      
      public var btnList:listDisplay;

      public var factor:Number;
      
      public var posDis:Number;
      
      public const textOffset:Number = 105;
      
      public var iconId:Number;
      
      public var shownIcon:int;

      public var popupType:Number;
      
      public function popup_mc_1()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function init() : *
      {
         this.visible = false;
         this.input_mc.paste_mc.visible = false;
         this.input_mc.copy_mc.visible = false;
         this.input_mc.visible = false;
         this.text_mc.filters = textEffect.createStrokeFilter(0,1.2,0.75,1,3);
      }
      
      public function setPopupType(param1:Number) : *
      {
         this.iconId = param1;
         this.bg_mc.gotoAndStop(param1);
         popupType = param1
         this.INT_SetTextPosition();
      }
      
      public function setInputEnabled(visibleBool:Boolean, minChar:Number, maxChar:Number) : *
      {
         this.input_mc.input_txt.maxChars = maxChar;
         this.input_mc.visible = visibleBool;

         // Commenting out the separate layouts. Positioning Handled through Lua.
         // if(param1)
         // {
         //    this.posDis = 30;
         //    this.setPopupType(3);
         // }
         // else
         // {
         //    this.posDis = 70;
         //    this.setPopupType(1);
         // }

         // Commenting out restrictions to text.

         // if(param2 == 0)
         // {
         //    this.input_mc.input_txt.restrict = "^<>\\\\/`´\',.:;|$€%#£+&*?\"";
         // }
         // else
         // {
         //    this.input_mc.input_txt.restrict = "^<>";
         // }
         
         this.INT_SetTextPosition();
      }
      
      public function showPopUp(titleText:String, text:String) : *
      {
         this.title_txt.htmlText = titleText;
         textHelpers.smallCaps(this.title_txt,7,true);
         this.setText(text);
         this.INT_SetTextPosition();
      }
      
      public function setText(text:String) : *
      {
         this.text_mc.text_txt.htmlText = text;
         if(this.text_mc.sb)
         {
            this.text_mc.sb.scrollbarVisible();
            this.text_mc.sb.resetHandle();
         }
         this.INT_SetTextPosition();
      }
      
      // Created setTitleText
	  public function setTitleText(titleText:String) : * {
		  this.title_txt.htmlText = titleText;
		  textHelpers.smallCaps(this.title_txt,7,true);
        this.INT_SetTextPosition();
	  }
	  
      public function INT_SetTextPosition() : *
      {
         // Commenting out positional layouts. Will figure this out later.

         // var _loc3_:Number = NaN;
         // var _loc4_:Number = NaN;
         // var _loc1_:Number = this.posDis;
         // if(this.title_txt.text == "")
         // {
         //    _loc1_ = _loc1_ + 30;
         // }
         // var _loc2_:Number = this.text_mc.text_txt.textHeight;
         // if(_loc2_ > this.text_mc.text_txt.height)
         // {
         //    _loc2_ = this.text_mc.text_txt.height;
         // }
         // this.text_mc.y = this.cButtons_mc.y - _loc1_ - Math.round(_loc2_ * 0.5);
         // if(this.title_txt.text != "")
         // {
         //    if(this.iconId == 3)
         //    {
         //       this.title_txt.y = this.input_mc.y - this.title_txt.textHeight - 8;
         //    }
         //    else
         //    {
         //       _loc3_ = 102;
         //       _loc4_ = 50;
         //       if(this.text_mc.y < _loc3_ + this.title_txt.textHeight)
         //       {
         //          this.title_txt.y = Math.round(this.text_mc.y - this.title_txt.textHeight);
         //          if(this.title_txt.y < _loc4_)
         //          {
         //             this.title_txt.y = _loc4_;
         //          }
         //       }
         //    }
         // }

         // MANUALLY POSITIONING ELEMENTS -- Redone in LUA.

      }
      
      public function onEF(param1:Event) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.onEF);
      }
      
      public function showMsgbox() : *
      {
         var _loc1_:Boolean = true;
         if(this.visible && this.shownIcon != this.iconId)
         {
            if(this.shownIcon == this.iconId)
            {
               _loc1_ = false;
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.onEF);
            }
         }
         if(_loc1_)
         {
            ExternalInterface.call("PlaySound","UI_Generic_Back");
            addEventListener(Event.ENTER_FRAME,this.onEF);
         }
         this.shownIcon = this.iconId;
         this.visible = true;
         this.INT_SetTextPosition();
      }

      public function addButton(movieClipID:Number, labelStr:String, soundOnOver:String, soundOnUp:String) : *
      {
         var buttonMC:MovieClip = null;
         if(this.btnList.length > 0)
         {
            buttonMC = new btnB_id();  // Create Normal Button
         }
         else
         {
            buttonMC = new btnA_id();  // Create Blue Button
         }
         buttonMC.label_mc.filters = textEffect.createStrokeFilter(0,1.2,0.75,1,3);
         buttonMC.label_mc.label_txt.htmlText = labelStr.toUpperCase();
         this.INTaddButton(buttonMC,movieClipID);
         if(soundOnOver != "")
         {
            buttonMC.snd_OnOver = soundOnOver;
         }
         if(soundOnUp != "")
         {
            buttonMC.snd_OnUp = soundOnUp;
         }
         else
         {
            buttonMC.snd_OnUp = "UI_Gen_BigButton_Click";
         }
      }
      
      public function addBlueButton(movieClipID:Number, labelStr:String) : *
      {
         var blueButtonMC:MovieClip = new btnB_id();
         blueButtonMC.label_mc.filters = textEffect.createStrokeFilter(0,1.2,0.75,1,3);
         blueButtonMC.label_mc.label_txt.htmlText = labelStr.toUpperCase();
         this.INTaddButton(blueButtonMC,movieClipID);
      }
      
      public function addYesButton(movieClipID:Number) : *
      {
         var yesButtonMC:MovieClip = new btnYes_id();
         this.INTaddButton(yesButtonMC,movieClipID);
      }
      
      public function addNoButton(movieClipID:Number) : *
      {
         var noButtonMC:MovieClip = new btnNo_id();
         this.INTaddButton(noButtonMC,movieClipID);
      }
      
      public function INTaddButton(ButtonMC:MovieClip, movieClipID:Number) : *
      {
         ButtonMC.id = movieClipID;
         ButtonMC.bg_mc.gotoAndStop(1);
         ButtonMC.x = -ButtonMC.width * 0.5;
         this.btnList.addElement(ButtonMC);

         // this.cButtons_mc.y = 347 - this.btnList.height; // <-- This little line of code cause me so much headache !!!

         // There is functionally no difference between 1 and 2 as far as I can tell.
         // if(!this.input_mc.visible)
         // {
         //    if(this.btnList.length > 1)
         //    {
         //       this.setPopupType(2);
         //    }
         //    else
         //    {
         //       this.setPopupType(1);
         //    }
         // }
         this.INT_SetTextPosition();
      }
      
      public function removeButtons() : *
      {
         this.btnList.clearElements();
         this.INT_SetTextPosition();
      }
      
      public function setBtnPos(param1:Number):void
      {
         this.cButtons_mc.y = param1;
      }

      function frame1() : *
      {
         this.btnList = new listDisplay();
         this.cButtons_mc.addChild(this.btnList);
         this.factor = 0.1;
         this.posDis = 70;
         this.iconId = 0;
         this.shownIcon = -1;
      }
   }
}
