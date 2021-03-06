﻿package GMJournal_fla
{
   import LS_Classes.scrollList;
   import LS_Classes.textHelpers;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   
   public dynamic class editableElement_22 extends MovieClip
   {
       
      
      public var border_mc:MovieClip;
      public var eye_mc:eye;
      public var highlight_mc:MovieClip;
      public var remove_mc:removeButton;
      public var _content:MovieClip;
      public var _w:Number;
      public var _linesCount:int;
      public var _text:TextField;
      public var _shared;
      public var heightOverride:Number;
      public var onRemove:Function;
      public var _dirty:Boolean;
      public var id:Number;
      public var _textY:Number;
      public var ownerScrollList:scrollList;
      public var ident:String;
      
      public function editableElement_22()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function Init(elementMC:MovieClip, strContent:String, width:Number, height:Number) : *
      { 
         //ExternalInterface.call("S7_DebugHook", "editableElement", "Initializing new Editable Element", "String Content", strContent)
         this.ident = "";
         this._w = width;
         width = width;
         this.heightOverride = height;
         this.border_mc.Init(width, height);
         
         this._content = elementMC;
         this._text = this._content.text_txt;
         this._textY = this._text.y;
         textHelpers.makeInputFieldModal(this._text);
         
         addChild(elementMC);
         this._text.autoSize = TextFieldAutoSize.LEFT;
         this._text.addEventListener(Event.CHANGE,this.onTextChanged);
         this._text.htmlText = strContent;
         this._text.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         this._text.addEventListener("IE ContextMenu",this.onContext);
         this._linesCount = this._text.numLines;
         this.updateHeight(this._linesCount);
         this.eye_mc.init(this.onEyePressed);
         this.remove_mc.init(this.onRemovePressed);
         this.highlight_mc.alpha = 0;
         this._dirty = false;
         this.eye_mc.visible = false;
         this.DisplayChildren(this);
      }
      
      public function DisplayChildren(param1:DisplayObject) : *
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         this.ident = this.ident + "-";
         var _loc2_:* = param1 as MovieClip;
         if(_loc2_)
         {
            _loc3_ = _loc2_.numChildren - 1;
            while(_loc3_ >= 0)
            {
               _loc4_ = _loc2_.getChildAt(_loc3_);
               _loc5_ = _loc4_ is TextField?" [!!!] ":"";
               this.DisplayChildren(_loc4_);
               _loc3_--;
            }
         }
         this.ident = this.ident.substring(0,this.ident.length - 1);
      }
      
      public function setEditable(editable:Boolean) : *
      {
         this.border_mc.visible = editable;
         this.remove_mc.visible = editable;
         this._text.type = !!editable?TextFieldType.INPUT:TextFieldType.DYNAMIC;
         if(editable)
         {
            this._content.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
            removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
            this.highlight_mc.alpha = 0;
         }
         else
         {
            this._content.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
            if(this._dirty)
            {
               this.flush();
            }
         }
      }
      
      public function setShared(param1:Boolean) : *
      {
         this._shared = param1;
         this.eye_mc.setActive(!param1);
      }
      
      public function onEyePressed() : *
      {
         this._shared = this.eye_mc.isActive;
      }
      
      public function onRemovePressed() : *
      {
         this._content.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         this._text.removeEventListener(Event.CHANGE,this.onTextChanged);
         this._text.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         this._text.removeEventListener("IE ContextMenu",this.onContext);
         if(this.onRemove != null)
         {
            this.onRemove(this);
         }
      }
      
      public function onMouseOver() : *
      {
         this.highlight_mc.alpha = 0.3;
      }
      
      public function onMouseOut() : *
      {
         this.highlight_mc.alpha = 0;
      }
      
      public function mouseUp() : *
      {
         if(this._content.mouseUp)
         {
            this._content.mouseUp();
         }
      }
      
      public function updateText(param1:String) : *
      {
         if(param1 == this._text.htmlText)
         {
            return;
         }
         this._text.htmlText = param1;
         this.onTextChanged(null);
      }
      
      public function onTextChanged(param1:Event) : *
      {
         this._dirty = true;
         var _loc2_:Number = this._text.numLines;
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         if(this._text.htmlText.charAt(this._text.length - 1) == "\n")
         {
            _loc2_++;
         }
         if(_loc2_ != this._linesCount)
         {
            this.updateHeight(_loc2_);
            this._linesCount = _loc2_;
         }
      }
      
      public function updateHeight(param1:int) : *
      {
         this.heightOverride = param1 * 30 - 3;
         this.border_mc.setFrame(this._w - 2,this.heightOverride - 2);
         this.highlight_mc.height = this.heightOverride;
         dispatchEvent(new Event("HeightChanged"));
      }
      
      public function onFocusOut(param1:Event) : *
      {
         if(this._dirty)
         {
            this.flush();
         }
      }
      
      public function flush() : *
      {
         ExternalInterface.call("textUpdate",this.id,this._text.htmlText);
         this._dirty = false;
      }
      
      public function onMouseOverText(param1:MouseEvent) : void
      {
      }
      
      public function onMouseOutText(param1:MouseEvent) : void
      {
      }
      
      public function fixScrollRect(param1:Event) : void
      {
      }
      
      public function onContext(param1:Event) : *
      {
         (root as MovieClip).contextTarget = textHelpers.getSelectionLengthOfText(this._text,this._text.mouseX,this._text.mouseY);
         ExternalInterface.call("showContextMenu",0,stage.mouseX,stage.mouseY);
      }
      
      function frame1() : *
      {
         this._shared = Boolean;
      }
   }
}
