package GMJournal_fla
{
   import LS_Classes.scrollList;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   
   public dynamic class content_7 extends MovieClip
   {
       
      
      public var addCategoryButton_mc:addCategoryButton;
      
      public var categoriesListHolder_mc:MovieClip;
      
      public var mouseHook_mc:MovieClip;
      
      public var categories:scrollList;
      
      public var _editControlsVisible:Boolean;
      
      public function content_7()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function Init() : *
      {
         var _loc1_:MovieClip = root as MovieClip;
         this.categories = new scrollList();
         this.categories.setTileableBG = "leftPageBG";
         this.categories.mouseWheelWhenOverEnabled = true;
         addChild(this.categories);
         this.categories.container_mc.x = 111;
         this.categories.container_mc.y = 165;
         this.categories.setFrame(525,720);
         this.categories.m_scrollbar_mc.x = 19;
         this.categories.m_scrollbar_mc.y = 177;
         this.categories.m_scrollbar_mc.setLength(683);
         this.categories.m_scrollbar_mc.m_hideWhenDisabled = false;
         this.categories.canPositionInvisibleElements = false;
         this.categories.elementSpacing = 3;
         this.addCategoryButton_mc.initialize(_loc1_.strings.addCategory,this.onAddCategory);
         this.addCategoryButton_mc.visible = this._editControlsVisible;
         this.addCategoryButton_mc.heightOverride = 27;
         this.categories.addElement(this.addCategoryButton_mc,false);
         this.categories.positionElements();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16711680);
         _loc2_.graphics.drawRect(0,0,620,700);
         _loc2_.graphics.endFill();
         _loc2_.width = 620;
         _loc2_.height = 700;
         this.mouseHook_mc.addChild(_loc2_);
         this.mouseHook_mc.alpha = 0;
      }
      
      public function setEditControlsVisible(param1:Boolean) : *
      {
         var _loc3_:MovieClip = null;
         this._editControlsVisible = param1;
         this.addCategoryButton_mc.visible = param1;
         var _loc2_:* = 0;
         while(_loc2_ < this.categories.length - 1)
         {
            _loc3_ = this.categories.getAt(_loc2_);
            if(_loc3_.setEditable != undefined)
            {
               _loc3_.setEditable(param1);
            }
            _loc2_++;
         }
         this.categories.positionElements();
      }
      
      public function onAddCategory() : *
      {
         ExternalInterface.call("addCategory");
      }
      
      public function createCategory(param1:Number, param2:int, param3:String, param4:Boolean) : MovieClip
      {
         var _loc5_:* = new categoryListElement();
         this.categories.addElementOnPosition(_loc5_,param2,false);
         _loc5_.Init(param1,param3);
         _loc5_.setEditable(this._editControlsVisible);
         _loc5_.addEventListener("HeightChanged",this.rebuildLayout);
         _loc5_.editableElement_mc.setShared(param4);
         return _loc5_;
      }
      
      public function rebuildLayout() : *
      {
         this.categories.positionElements();
      }
      
      function frame1() : *
      {
      }
   }
}
