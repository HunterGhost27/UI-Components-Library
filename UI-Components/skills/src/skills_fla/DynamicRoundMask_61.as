package skills_fla
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public dynamic class DynamicRoundMask_61 extends MovieClip
   {
       
      
      public function DynamicRoundMask_61()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function drawWedge(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 1, param7:* = 1, param8:* = 0.5) : *
      {
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         if(!this.init)
         {
            this.m_CX = param1;
            this.m_CY = param2;
            this.m_R = param3;
            this.m_BA = param4;
            this.m_EA = param5;
            this.m_A = param6;
            this.needsRefresh = true;
            return;
         }
         var _loc9_:Number = Math.PI / 180;
         var _loc10_:Number = -1;
         var _loc11_:Number = -1;
         if(param4 == _loc10_ && param5 == _loc11_)
         {
            return;
         }
         _loc10_ = param4;
         _loc11_ = param5;
         if(param5 < param4)
         {
            param5 = param5 + 360;
         }
         var _loc12_:Number = Math.ceil((param5 - param4) / 45);
         if(_loc12_ == 0)
         {
            return;
         }
         var _loc13_:Sprite = this.getChildByName("myPie") as Sprite;
         if(_loc13_ != null)
         {
            this.removeChild(_loc13_);
         }
         var _loc14_:Sprite = new Sprite();
         _loc14_.name = "myPie";
         _loc14_.graphics.lineStyle(param8,0,param7);
         _loc14_.graphics.beginFill(16777215,param6);
         var _loc15_:int = 0;
         var _loc16_:Number = (param5 - param4) / _loc12_ * _loc9_;
         var _loc17_:Number = param3 / Math.cos(_loc16_ / 2);
         var _loc18_:Number = param4 * _loc9_;
         var _loc19_:Number = _loc18_ - _loc16_ / 2;
         _loc14_.graphics.moveTo(param1,param2);
         _loc14_.graphics.lineTo(param1 + param3 * Math.cos(_loc18_),param2 + param3 * Math.sin(_loc18_));
         _loc15_ = 0;
         while(_loc15_ < _loc12_)
         {
            _loc18_ = _loc18_ + _loc16_;
            _loc19_ = _loc19_ + _loc16_;
            _loc20_ = param3 * Math.cos(_loc18_);
            _loc21_ = param3 * Math.sin(_loc18_);
            _loc14_.graphics.lineTo(param1 + _loc20_,param2 + _loc21_);
            _loc15_++;
         }
         _loc14_.graphics.lineTo(param1,param2);
         _loc14_.graphics.endFill();
         this.addChild(_loc14_);
      }
      
      public function deleteWedge() : *
      {
         var _loc1_:Sprite = this.getChildByName("myPie") as Sprite;
         if(_loc1_ != null)
         {
            this.removeChild(_loc1_);
         }
      }
      
      public function initDraw() : *
      {
         this.init = true;
         if(this.needsRefresh)
         {
            this.drawWedge(this.m_CX,this.m_CY,this.m_R,this.m_BA,this.m_EA,this.m_A);
         }
      }
      
      function frame1() : *
      {
         this.initDraw();
      }
   }
}
