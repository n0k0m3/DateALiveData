--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 助战小游戏界面
* 
]]

local AssistanceGameLayer = class("AssistanceGameLayer", BaseLayer)

function AssistanceGameLayer:ctor(  )
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.assistance.assistanceGameLayer")
end

function AssistanceGameLayer:initData(  )
    self.inviteGiftCfg = TabDataMgr:getData("InviteGift")
    self.assisGameDiscreteData = TabDataMgr:getData("DiscreteData" , 1100004).data
    self.roll_cost_data = self.assisGameDiscreteData.RewardPointConsume
    self.refresh_cost_data = self.assisGameDiscreteData.refreshPointConsume
    self.activityInfo = AssistanceDataMgr:getActivityStoreInfo()
       self.rankIconRes = {
            "ui/activity/assist/038.png",
            "ui/activity/assist/039.png",
            "ui/activity/assist/040.png",
        }

        self.isFirstEnter = true
end

function AssistanceGameLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.panel_black = TFDirector:getChildByPath(ui , "panel_black")
    
    self:initGameLayer(ui)
    self:initRankLayer(ui)

    AssistanceDataMgr:sendYouCiInfoReq()

end
--初始化游戏ui
function AssistanceGameLayer:initGameLayer( ui )
    local img_bg = TFDirector:getChildByPath(ui , "image_bg")
    local panel_top = TFDirector:getChildByPath(ui , "panel_top")
    self.Label_timing = TFDirector:getChildByPath(panel_top , "label_time")
    self.btn_refresh = TFDirector:getChildByPath(panel_top , "btn_shuaxin")
    self.label_refresh_cost = TFDirector:getChildByPath(panel_top , "label_num")
    self.img_refresh_cost_icon = TFDirector:getChildByPath(panel_top , "img_icon")

     self.btn_refresh:onClick(function ( ... )

        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_AssistanceGameScoreRefresh) then
            --刷新尤茨奖励按钮
            AssistanceDataMgr:sendRefreshAwardReq( )
        else
            local rstr = TextDataMgr:getText(112000130)
            local refresh_cost = {}
            for k ,v in pairs(self.refresh_cost_data) do
                table.insert(refresh_cost , {id =k , value = v})
            end
            local costCfg = GoodsDataMgr:getItemCfg(refresh_cost[1].id)
            local content = string.format(rstr, costCfg.icon , refresh_cost[1].value)
            Utils:openView(
                       "common.ReConfirmTipsView",
                       {
                             tittle = 112000165,
                             content = content,
                             reType = EC_OneLoginStatusType.ReConfirm_AssistanceGameScoreRefresh,
                             confirmCall = function()
                               --刷新尤茨奖励按钮
                                AssistanceDataMgr:sendRefreshAwardReq( )
                             end
                        }
                       )
        end
        
    end)


     local panel_left = TFDirector:getChildByPath(ui , "panel_left")
     --圈数
     self.label_quanshu = TFDirector:getChildByPath(panel_left , "label_num")
     self.img_tuzi = TFDirector:getChildByPath(panel_left , "panel_tuzi")
     self.img_tuzi.spine_tuzi = self.img_tuzi:getChildByName("spine_tuzi")
     self.img_tuzi.spine_tuzi:play("animation" , true)
     self.img_qipao = TFDirector:getChildByPath(self.img_tuzi , "img_qipao")
     self.img_qipao.label_text = TFDirector:getChildByPath(self.img_qipao , "label_qipao") 
     self.img_qipao.img_icon = TFDirector:getChildByPath(self.img_qipao , "img_icon")
     self.img_qipao:setVisible(false)


     --棋子底盘 29个
     self.img_qizi = {}

     for i=1,29 do
        self.img_qizi[i] = TFDirector:getChildByPath(panel_left , "img_qizi_"..i)
        self.img_qizi[i].icon = TFDirector:getChildByPath(self.img_qizi[i] , "img_icon")
        self.img_qizi[i].numLabel = TFDirector:getChildByPath(self.img_qizi[i] , "label_itemNum")
     end

     self.closeBtn = TFDirector:getChildByPath(img_bg , "btn_close")

     local panel_right = TFDirector:getChildByPath(ui , "panel_right")
     local panel_top = TFDirector:getChildByPath(panel_right , "panel_top")
     self.label_my_asisst_score = TFDirector:getChildByPath(panel_top , "label_num")
     self.img_my_asisst_icon = TFDirector:getChildByPath(panel_top , "img_icon")

     self.btn_yulan = TFDirector:getChildByPath(panel_right , "btn_yulan")
     self.btn_yulan:onClick(function( ... )
         -- 跳转兑换商店
         Utils:openView("assistance.AssistanceShopLayer")
     end)

     self.my_store_score = TFDirector:getChildByPath( self.btn_yulan , "label_num")
     local storeItemId = tonumber(self.activityInfo.extendData.showCurrency)
     self.my_store_score:setText(GoodsDataMgr:getItemCount(storeItemId))

     local my_store_score_icon = TFDirector:getChildByPath(self.btn_yulan , "img_icon")
     --local storeItemId = tonumber(self.activityInfo.extendData.showCurrency)
     my_store_score_icon:setTexture(GoodsDataMgr:getItemCfg(storeItemId).icon)
     my_store_score_icon:setScale(0.7)

     self.btn_reng = TFDirector:getChildByPath(panel_right , "btn_reng")
     self.btn_reng:onClick(function( ... )


        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_AssistanceGameUseScore) then
            --扔尤茨
            AssistanceDataMgr:sendStarYouCiGameReq()
        else
            local rstr = TextDataMgr:getText(112000129)
           local roll_cost = {}
            for k ,v in pairs(self.roll_cost_data) do
                table.insert(roll_cost , {id =k , value = v})
            end
            local costCfg = GoodsDataMgr:getItemCfg(roll_cost[1].id)
            local content = string.format(rstr, costCfg.icon , roll_cost[1].value)
            Utils:openView(
                       "common.ReConfirmTipsView",
                       {
                             tittle = 112000165,
                             content = content,
                             reType = EC_OneLoginStatusType.ReConfirm_AssistanceGameUseScore,
                             confirmCall = function()
                               --扔尤茨
                                AssistanceDataMgr:sendStarYouCiGameReq()
                             end
                        }
                       )
        end
        
         
     end)

     self.label_roll_cost_num = TFDirector:getChildByPath(self.btn_reng , "label_num")
     self.img_roll_cost_icon = TFDirector:getChildByPath(self.btn_reng, "img_icon")


    self.btn_rule = TFDirector:getChildByPath(panel_left , "btn_rule")
    self.btn_rule:onClick(function ( ... )
         print("打开规则界面")
         Utils:openView("assistance.AssistanceHelpLayer" , {uiName = "assistance.assistanceGameHelpLayer"})
    end)

    self.btn_history = TFDirector:getChildByPath(panel_left , "btn_history")
    self.btn_history:onClick(function ( ... )
         print("打开历史记录界面")
         local youciData = AssistanceDataMgr:getYouCiInfo() or {}
         Utils:openView("assistance.AssistanceGameHistoryView",{records = youciData.records})
    end)

    self.btn_help = TFDirector:getChildByPath(panel_left , "btn_help")
    self.btn_help:onClick(function ( ... )
         print("打开概率界面")
         Utils:openView("summon.SummonPreviewView", 9010 , 112000157)
    end)

    self.spine_jump_act = TFDirector:getChildByPath(img_bg , "spine_jump_act")
    self.spine_jump_act:setVisible(false)

    self.spine_show = TFDirector:getChildByPath(panel_right , "spine_show")
    self.Label_no_act = TFDirector:getChildByPath(panel_right , "Label_no_act")
    self.Label_no_act:setTextById(112000147)

    self.panel_touch = TFDirector:getChildByPath(ui , "panel_touch")
    self.panel_touch:setVisible(false)

    self.panel_jump_black = TFDirector:getChildByPath(img_bg , "panel_jump_black")
    self.panel_jump_black:setVisible(false)
end

--初始化排行
function AssistanceGameLayer:initRankLayer( ui )
    self.isShowRank = true
    local panel_rank = TFDirector:getChildByPath(ui , "panel_rank")
    self.btn_rank = TFDirector:getChildByPath(panel_rank , "img_btn")
    self.rank_move_panel = TFDirector:getChildByPath(panel_rank , "panel_move")
    self.btn_rank:setTouchEnabled(true)
    self.btn_rank:onClick(function()
        self:runRankPanelAct(self.isShowRank)
    end)
    self.rank_move_panel:setPosition(ccp(-591 , 0))
    self:runRankPanelAct(false)

    local scroll_rank = TFDirector:getChildByPath(panel_rank, "scrollView")
    self.ListView_rank = UIListView:create(scroll_rank)

    local panel_pefab = TFDirector:getChildByPath(ui , "panel_pefab")
    self.Panel_rankItem = TFDirector:getChildByPath(panel_pefab , "panel_item")

    self.panel_myself_rank = TFDirector:getChildByPath(panel_rank , "panel_item")

    self.label_rank_des = TFDirector:getChildByPath(panel_rank , "label_des")
    self.label_rank_des:setTextById(112000156)

end
--
function AssistanceGameLayer:runRankPanelAct(isHide)
    if not isHide then
        --显示并发送排行信息请求
        AssistanceDataMgr:sendYouCiRankReq( )
        self.btn_rank:setTexture("ui/assistance/assisGame/1-1.png")
    else
        self.btn_rank:setTexture("ui/assistance/assisGame/1-2.png")
    end
    local movePos = ccp(0 , 0)
    if isHide then
        movePos = ccp(-591 , 0)
    else
        self.panel_black:setVisible(true)
    end
    local actList = {}
    table.insert(actList , CCMoveTo:create(0.2 ,movePos))
    table.insert(actList ,CCCallFunc:create(function ( ... )
        if isHide then
            self.panel_black:setVisible(false)
        end
    end))
    self.rank_move_panel:runAction(CCSequence:create(actList))
    self.isShowRank = not isHide
end

function AssistanceGameLayer:updateRankInfo( )
    self.rank_data = AssistanceDataMgr:getYouCiRankData().info or {}
    self.rank_data_myself = AssistanceDataMgr:getYouCiRankData().self or {}
    local items = self.ListView_rank:getItems()
    local gap = #self.rank_data - #items

    for i = 1, math.abs(gap) do
        if gap < 0 then
            self.ListView_rank:removeItem(1)
        else
            local Panel_rankItem = self.Panel_rankItem:clone()
            self.ListView_rank:pushBackCustomItem(Panel_rankItem)
        end
    end

    for i, v in ipairs(self.rank_data) do
        local Panel_rankItem = self.ListView_rank:getItem(i)
        self:updateRankItem(Panel_rankItem, v)
    end

    self:updateRankItem(self.panel_myself_rank , self.rank_data_myself)
end

--更新排行单条数据
function AssistanceGameLayer:updateRankItem(panel_item , data )
    local img_rank = TFDirector:getChildByPath(panel_item , "img_rank")  
    local label_rank = TFDirector:getChildByPath(panel_item , "label_rank")
    local Image_icon = TFDirector:getChildByPath(panel_item , "Image_icon")
    local Image_icon_cover_frame = TFDirector:getChildByPath(panel_item , "Image_icon_cover_frame")
    local label_lv = TFDirector:getChildByPath(panel_item , "label_lv")
    local label_name = TFDirector:getChildByPath(panel_item , "label_name")
    local label_num = TFDirector:getChildByPath(panel_item , "label_num")

    label_lv:setText("lv．"..data.lvl)
    label_name:setText(data.pName)
    label_num:setText(data.rounds)
    if data.rank <=3  and data.rank>=1 then
        img_rank:show()
        label_rank:hide()
        img_rank:setTexture(self.rankIconRes[data.rank])
    else
        img_rank:hide()
        label_rank:show()
        label_rank:setText(data.rank)
    end

    if data.rank == 0 then  --玩家自己未上榜
        img_rank:hide()
        label_rank:show()
        label_rank:setTextById(263009)
    end

    local icon = AvatarDataMgr:getAvatarIconPath(data.headId)
    Image_icon:setTexture(icon)
    Image_icon:onClick(function()
        MainPlayer:sendPlayerId(data.pid)
    end)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.frameId)
    Image_icon_cover_frame:setTexture(avatarFrameIcon)
end

function AssistanceGameLayer:onShow( )
    self.super.onShow(self)
end

--更新尤茨面板
function AssistanceGameLayer:updateGameUI( )
    local youciData = AssistanceDataMgr:getYouCiInfo() or {}
    self.label_quanshu:setText(youciData.rounds)

    local rewardId = youciData.rewardId

    for k ,v in pairs(self.img_qizi) do
        local youciCfg = self.inviteGiftCfg[k]
         v.icon:setScale(1)
         v.numLabel:hide()
        if youciCfg.type == 1 then  --道具奖励
            local itemCfg = GoodsDataMgr:getItemCfg(youciCfg["items"..rewardId][1][1])
            v.icon:setTexture(itemCfg.icon)
            v.icon:setScale(0.5)
            v.numLabel:setText("x" ..youciCfg["items"..rewardId][1][2])
            v.numLabel:show()
        elseif youciCfg.type == 2 then  --次数奖励  

        elseif youciCfg.type == 3 then  --步数奖励
            v.icon:setTexture("ui/assistance/assisGame/add_"..youciCfg.parameter ..".png")
        elseif youciCfg.type == 4 then  --步数惩罚
            v.icon:setTexture("ui/assistance/assisGame/decrese_"..youciCfg.parameter ..".png")
        end
        
        if (youciData.curPos == 0 and k == 1) or k == youciData.curPos then
            v.icon:hide()  --设置兔子位置           
            self.img_tuzi:setPosition(v:getPosition() + ccp(0 , 20))
        else
            v.icon:show()           
        end
        if self:isGetPosAward(k) then
             v.icon:hide()
             v.numLabel:hide()
        end
    end

    self:updateRankInfo()
    self:refreshCostUI()
end

function AssistanceGameLayer:isGetPosAward(pos)
    local youciData = AssistanceDataMgr:getYouCiInfo() or {}
    for k , v in pairs(youciData.posRewarded) do
            if pos == v then  --如果已经领取
               return true
            end
    end
    return false
end

function AssistanceGameLayer:updateCountDonw()
    local youciData = AssistanceDataMgr:getYouCiInfo() or {}
    --local isEnd = ActivityDataMgr2:isEnd(self.activityInfo.id)
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, youciData.nextRefreshTime/1000 - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    self.Label_timing:setTextById(800044, day, hour, min)


    -- if isEnd then
    --     local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
    --     local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    --     if day == "00" then
    --         self.Label_timing:setTextById("r41004", hour, min)
    --     else
    --         self.Label_timing:setTextById("r41003", day, hour)
    --     end
    -- else
    --     local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
    --     local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    --     if day == "00" then
    --         self.Label_timing:setTextById("r41002", hour, min)
    --     else
    --         self.Label_timing:setTextById("r41001", day, hour)
    --     end
    -- end
       
end

function AssistanceGameLayer:refreshCostUI()
    local youciData = AssistanceDataMgr:getYouCiInfo() or {}
    local refresh_cost = {}
    for k ,v in pairs(self.refresh_cost_data) do
        table.insert(refresh_cost , {id =k , value = v})
    end
    local costCfg = GoodsDataMgr:getItemCfg(refresh_cost[1].id)
    self.img_refresh_cost_icon:setTexture(costCfg.icon)
  
    self.label_refresh_cost:setText(refresh_cost[1].value)
    self.label_quanshu:setText(youciData.rounds)
    self.label_my_asisst_score:setText("X "..GoodsDataMgr:getItemCount(refresh_cost[1].id))
    self.img_my_asisst_icon:setTexture(costCfg.icon)
    self.img_my_asisst_icon:onClick(function()        
        Utils:showInfo(refresh_cost[1].id)
    end)

    local myAssitScore = GoodsDataMgr:getItemCount(refresh_cost[1].id)
    if myAssitScore >= refresh_cost[1].value then  --刷新奖励是否不足
        self.label_refresh_cost:setColor(ccc3(255 , 255 , 255))
    else  
        self.label_refresh_cost:setColor(ccc3(255 , 0 , 0))
    end


    local roll_cost = {}
    for k ,v in pairs(self.roll_cost_data) do
        table.insert(roll_cost , {id =k , value = v})
    end
     self.label_roll_cost_num:setText(roll_cost[1].value)
     self.img_roll_cost_icon:setTexture(costCfg.icon)

    if myAssitScore >= roll_cost[1].value then  --扔尤茨消耗是否不足
        self.label_roll_cost_num:setColor(ccc3(255 , 255 , 255))
    else  
        self.label_roll_cost_num:setColor(ccc3(255 , 0 , 0))
    end

    local storeItemId = tonumber(self.activityInfo.extendData.showCurrency)
    self.my_store_score:setText(GoodsDataMgr:getItemCount(storeItemId))

    if next(youciData.records)   then
        if  self.isFirstEnter then
            self.Label_no_act:setVisible(false)
            self.spine_show:setVisible(true)
            local jump_act_name = {"zhu" , "gou" , "yang" , "niu" , "ma"}
            self.spine_show:play(jump_act_name[youciData.records[1].result])
             self.isFirstEnter = false
        end
    else
        self.isFirstRoll = true
        self.Label_no_act:setVisible(true)
        self.spine_show:setVisible(false)
    end
end
function AssistanceGameLayer:playTalkAni(textId , parameter, callbackFunc )  --尤茨兔子对话弹窗
    self.img_qipao:setVisible(true)
    self.img_qipao:setScale(0.1)
    self.img_qipao.label_text:show()
    self.img_qipao.label_text:setTextById(textId , parameter)
    local actList = {}
    table.insert(actList , CCScaleTo:create(0.2 ,1))
    table.insert(actList , DelayTime:create(2))
    table.insert(actList , CCScaleTo:create(0.2 ,0.1))
    table.insert(actList ,CCCallFunc:create(function ( ... ) 
        self.img_qipao:setVisible(false)
        if callbackFunc then
            callbackFunc()
        end
    end))
    self.img_qipao:runAction(CCSequence:create(actList))
end
--执行尤茨动画
function AssistanceGameLayer:runYouciGame(data)
    self.img_tuzi.spine_tuzi:play("animation2" , false)
    local youciData = AssistanceDataMgr:getYouCiInfo()

    local curPos = youciData.curPos
    local lastCurPos = nil
    local rollNums = data.rollNum
    local movePos = data.movePos
    local runCount = 1
    local addOrDecrease = 0
    local isStart = true

    if curPos == 0 then
        curPos = 1
    end

    print("第一轮尤茨投掷"..rollNums[1])

    --步数递归执行动画
    function moveTuZi( step , isReturn )
        step = step -1
        local nextPos = nil
        if isReturn then  --如果是回退
             nextPos = self.inviteGiftCfg[curPos].before
        else
            if isStart then
                nextPos = self.inviteGiftCfg[curPos].nextStep 
                isStart = false
            else
                nextPos = self.inviteGiftCfg[curPos].next 
            end
        end
        
        if nextPos == 0 then   --有特殊转角23号位置下一步需要特殊判断
            if lastCurPos == 27 then
                nextPos = 28
            elseif lastCurPos == 22 then
                nextPos = 24
            end
        end
        local actList = {}
        table.insert(actList , CCMoveTo:create(0.5 ,self.img_qizi[nextPos]:getPosition() + ccp(0 , 20)))
        table.insert(actList ,CCCallFunc:create(function ( ... )
            self.img_qizi[nextPos].icon:hide() 
                          
            lastCurPos = curPos
            curPos = nextPos
            if step > 0 then
                moveTuZi(step,isReturn)
            else
                if curPos == movePos[runCount] then
                    runCount = runCount + 1
                    if movePos[runCount] then  --播放下面的尤茨动画执行动画 --新的尤茨开始
                        isStart = true
                        local nextStep = 0
                        local isBackStep = false
                        local isGetAward = false
                        local isNewRoll = false
                        if self.inviteGiftCfg[curPos].type == 2 then  --次数奖励
                            nextStep = rollNums[runCount - addOrDecrease]
                        elseif self.inviteGiftCfg[curPos].type == 3 then  --步数奖励
                            nextStep = self.inviteGiftCfg[curPos].parameter
                            addOrDecrease = addOrDecrease + 1
                        elseif self.inviteGiftCfg[curPos].type == 4 then  --惩罚步数
                            isBackStep = true
                            nextStep = self.inviteGiftCfg[curPos].parameter
                            addOrDecrease = addOrDecrease + 1
                        else  --道具奖励
                            --新一轮尤茨投掷
                            isNewRoll = true
                            nextStep = rollNums[runCount - addOrDecrease]
                            print("第"..runCount - addOrDecrease.."轮"..nextStep)
                            if self.inviteGiftCfg[curPos].type == 1 and not self:isGetPosAward(curPos) then  --获取奖励
                                print("获取奖励 pos = "..curPos)
                                isGetAward = true
                                table.insert(youciData.posRewarded , curPos)
                            end
                        end
                        if isGetAward then
                            local rewardList = {}
                            for k ,v in pairs(self.inviteGiftCfg[curPos]["items"..youciData.rewardId]) do
                                table.insert(rewardList , {id = v[1], num = v[2]})
                            end
                            Utils:showReward(rewardList , nil  , function ( ... )  --领取奖励后播放下一轮动作
                                self:playTalkAni(112000163 , nil , function( ... )  ---兔子说再扔一次
                                    self:playJumpAction(nextStep , function( ... )
                                        --播放特效然后执行尤茨动画
                                        moveTuZi(nextStep,isBackStep)
                                    end)
                                end)  
                            end)
                            self.img_qizi[curPos].numLabel:hide() 
                        else
                            if isNewRoll then  --如果是有奖励的新一轮
                                self:playTalkAni(112000163 , nil , function( ... )  ---兔子说再扔一次
                                    self:playJumpAction(nextStep , function( ... )
                                        --播放特效然后执行尤茨动画
                                        moveTuZi(nextStep,isBackStep)
                                    end)
                                end)  
                            else
                                local label_talk_textId = 0
                                local parameter = nil
                                local inviteCfg = self.inviteGiftCfg[curPos]
                                if inviteCfg.type == 3 then
                                     parameter = inviteCfg.parameter
                                     label_talk_textId = 112000161
                                elseif inviteCfg.type == 4 then
                                    parameter = inviteCfg.parameter
                                    label_talk_textId = 112000159
                                else
                                    label_talk_textId = 112000163
                                end
                                self:playTalkAni(label_talk_textId , parameter, function( ... )  ---兔子说再扔一次
                                     moveTuZi(nextStep,isBackStep)
                                end)
                            end
                        end
                    else   --尤茨完成
                        youciData.curPos = curPos
                        if self.inviteGiftCfg[curPos].type == 1 and not self:isGetPosAward(curPos) then  --获取奖励
                            print("获取奖励 pos = "..curPos)
                            table.insert(youciData.posRewarded , curPos)
                            local rewardList = {}
                            for k ,v in pairs(self.inviteGiftCfg[curPos]["items"..youciData.rewardId]) do
                                table.insert(rewardList , {id = v[1], num = v[2]})
                            end
                            Utils:showReward(rewardList)
                            self.img_qizi[curPos].numLabel:hide()   
                        end
                        self:removeLockLayer()
                        self.panel_touch:setVisible(false)
                        self.img_tuzi.spine_tuzi:play("animation" , true)
                    end
                else
                    Box("尤茨第"..runCount.."步数与服务器不一致!".."curPos"..curPos)
                end
                
            end
        end))
        local seq = CCSequence:create(actList)
        
        if curPos == 1 and not self.isFirstRoll then
            self.img_tuzi.seq = seq
            self.img_tuzi.seq:retain()
            self:playTalkAni(112000164 , nil ,function( ... )
                self.img_tuzi:runAction(self.img_tuzi.seq)
                self.img_tuzi.seq:release()
            end)
        else
            self.isFirstRoll = false
             self.img_tuzi:runAction(seq)
        end
        if self:isGetPosAward(curPos) then
            self.img_qizi[curPos].icon:hide()
            self.img_qizi[curPos].numLabel:hide()
        else
            self.img_qizi[curPos].icon:show()
            --self.img_qizi[curPos].numLabel:show()
        end
       
        
    end
    moveTuZi(rollNums[runCount] , false)
end

function AssistanceGameLayer:playJumpAction( rollNum , callbackFunc )
    Utils:playSound(8001)  ---播放尤茨动画音效
    local jump_act_name = {"zhu" , "gou" , "yang" , "niu" , "ma"}
    self.spine_jump_act:setVisible(true)
    self.panel_jump_black:setVisible(true)
    self.spine_jump_act:play("animation")
    self.spine_jump_act.actId = 1
    self.spine_jump_act:addMEListener(TFARMATURE_COMPLETE , function( ... )
        if self.spine_jump_act.actId == 1 then
            self.spine_jump_act.actId = self.spine_jump_act.actId  + 1
            self.spine_jump_act:play(jump_act_name[rollNum])
            self.spine_show:play(jump_act_name[rollNum])
        else
            self.spine_jump_act:setVisible(false)
            self.panel_jump_black:setVisible(false)
            self.spine_jump_act:removeMEListener(TFARMATURE_COMPLETE)
                if rollNum == 5 then   --如果得到马先说话
                    self:playTalkAni("r1001004" , nil , function ( ... )
                        if callbackFunc then
                             callbackFunc()
                          end
                    end , true)
                else
                    if callbackFunc then
                     callbackFunc()
                  end
                end
        end
    end)
end

function AssistanceGameLayer:registerEvents( )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_YOUCI_RSP_YOUCI, handler(self.onRecvYouciGameInfo, self))
    EventMgr:addEventListener(self, EV_YOUCI_RSP_ROLL_YOUCI, handler(self.onRecvRollYouCi, self))

     EventMgr:addEventListener(self, EV_YOUCI_RSP_MAN_REFRESH_YOUCI, handler(self.onRevRefreshYouCiAward, self))
    EventMgr:addEventListener(self, EV_YOUCI_RSP_YOUCI_RANK, handler(self.onRevYouCiRankInfo, self))

     EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.refreshCostUI, self))

    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)

    self.panel_black:onClick(function(sender)
        self:runRankPanelAct(self.isShowRank)        
    end)
end

function AssistanceGameLayer:onRecvYouciGameInfo( ... )
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.updateCountDonw, self))
    end
    self:updateGameUI()
end

--响应尤茨投掷
function AssistanceGameLayer:onRecvRollYouCi( data )
    self:addLockLayer()
    self.panel_touch:setVisible(true)
    self:refreshCostUI() --刷新材料消耗
    self:playJumpAction(data.rollNum[1] , function( ... )
        --播放特效然后执行尤茨动画
        self:runYouciGame(data)
    end)
end

function AssistanceGameLayer:removeEvents( )
    self.super.removeEvents(self)
     if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end


--刷新奖池奖励响应
function AssistanceGameLayer:onRevRefreshYouCiAward(data )
    AssistanceDataMgr:getYouCiInfo().posRewarded = {}
    self:updateGameUI()
end

--排行榜数据响应
function AssistanceGameLayer:onRevYouCiRankInfo( data )
   
    self:updateRankInfo()
end



return AssistanceGameLayer
