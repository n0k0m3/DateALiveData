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
*  ºÃÓÑÖúÁ¦
* 
]]

local AssistanceStatusLayer = class("AssistanceStatusLayer", BaseLayer)

function AssistanceStatusLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceStatusLayer")
end

function AssistanceStatusLayer:initData( data )
    self.friendInfo = data.friendInfo

    self.taskItemList1 = {}
    self.taskItemList2 = {}
    self.taskItemList3 = {}
end

function AssistanceStatusLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.uiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui")
    self.closeBtn = TFDirector:getChildByPath(self.uiPanel, "btn_close")

    self.playerPanel = TFDirector:getChildByPath(self.uiPanel, "panel_player")

    self.taskPanel1 = TFDirector:getChildByPath(self.uiPanel, "panel_task_1")
    
    local taskScrollView2 = TFDirector:getChildByPath(self.uiPanel, "scrollView_task_2")
    self.taskUIListView2 = UIListView:create(taskScrollView2)

    local taskScrollView3 = TFDirector:getChildByPath(self.uiPanel, "scrollView_task_3")
    self.taskUIListView3 = UIListView:create(taskScrollView3)

    self.itemModelPanel = TFDirector:getChildByPath(ui, "panel_item"):hide()

    self:updateUI()
end

function AssistanceStatusLayer:onShow( )
    self.super.onShow(self)
end

function AssistanceStatusLayer:updateUI( )
    self:updatePlayerPanel()
    self:updateTask1()
    self:updateTask2()
    self:updateTask3()
end

function AssistanceStatusLayer:registerEvents( )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_RESRECEIVEFRIENDHELPTASK, handler(self.onResReceiveFriendHelpTask, self))
    EventMgr:addEventListener(self, EV_RESREFRESHFRIENDHELPTASK, handler(self.onResRefreshFriendHelpTask, self))

    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)
end

function AssistanceStatusLayer:removeEvents( )
    self.super.removeEvents(self)
end

function AssistanceStatusLayer:updatePlayerPanel( )
    local playerIconBgImg = TFDirector:getChildByPath(self.playerPanel, "img_player_icon_bg")
    
    local iconImg = TFDirector:getChildByPath(self.playerPanel, "img_icon")
    iconImg:onClick(function(sender)
        MainPlayer:sendPlayerId(self.friendInfo.playerId)
    end)
    local portraitCid = self.friendInfo.portraitCid
    if portraitCid > 0 then
        local icon = AvatarDataMgr:getAvatarIconPath(portraitCid)
        iconImg:setTexture(icon)
    end 

    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(self.friendInfo .portraitFrameCid)
    local coverFrameImg = TFDirector:getChildByPath(self.playerPanel, "img_icon_cover_frame")
    coverFrameImg:setTexture(avatarFrameIcon)

    local headFrameEffect = coverFrameImg:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        coverFrameImg:addChild(headFrameEffect, 1)
    end

    local qualityImg = TFDirector:getChildByPath(self.playerPanel, "img_quality")
    qualityImg:hide()

    local nameLabel = TFDirector:getChildByPath(self.playerPanel, "label_name")
    nameLabel:setText(self.friendInfo .playerName)

    local lvLabel = TFDirector:getChildByPath(self.playerPanel, "label_lv")
    lvLabel:setText(self.friendInfo.level)

    local scoreLabel = TFDirector:getChildByPath(self.playerPanel, "label_score")
    scoreLabel:setText(AssistanceDataMgr:getFriendScore(self.friendInfo.playerId) .."/" ..AssistanceDataMgr:getFriendMaxScore())
end

function AssistanceStatusLayer:updateTask1( )
    local item = TFDirector:getChildByPath(self.taskPanel1, "item_2")
    table.insert(self.taskItemList1, item)
    local taskList = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_1)
    self:updateTaskItem(item, taskList[1], false)
end

function AssistanceStatusLayer:updateTask2( )
    self.taskUIListView2:removeAllItems()

    local taskList = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_2)
    for _idx,_task in ipairs(taskList) do
        local item = self.itemModelPanel:clone()
        self:updateTaskItem(item, _task, _idx == #taskList)
        item:show()
        self.taskUIListView2:pushBackCustomItem(item)
        table.insert(self.taskItemList2, item)
    end

    self:jumpToNewPosByType(EC_INVITE_TASK.TASK_2)
end

function AssistanceStatusLayer:updateTask3( )
    self.taskUIListView3:removeAllItems()

    local taskList = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_3)
    for _idx,_task in ipairs(taskList) do
        local item = self.itemModelPanel:clone()
        self:updateTaskItem(item, _task, _idx == #taskList)
        item:show()
        self.taskUIListView3:pushBackCustomItem(item)
        table.insert(self.taskItemList3, item)
    end

    self:jumpToNewPosByType(EC_INVITE_TASK.TASK_3)
end

function AssistanceStatusLayer:updateTaskItem( item, task, isEnd )
    local numLabel1 = TFDirector:getChildByPath(item, "label_num_1"):hide()
    numLabel1:setText(task.reward[1][2])
    local numLabel2 = TFDirector:getChildByPath(item, "label_num_2"):hide()
    numLabel2:setText(task.reward[1][2])
    local numLabel3 = TFDirector:getChildByPath(item, "label_num_3"):hide()
    numLabel3:setText(task.reward[1][2])

    local img1 = TFDirector:getChildByPath(item, "img_1"):hide()
    local img2 = TFDirector:getChildByPath(item, "img_2"):hide()
    local img3 = TFDirector:getChildByPath(item, "img_3"):hide()

    local redTipImg = TFDirector:getChildByPath(item, "img_redTips")
    redTipImg:hide()
    if AssistanceDataMgr:checkTaskRedPoint(self.friendInfo.playerId, task.id) then
        redTipImg:show()      
    end

    local taskStatus = AssistanceDataMgr:getTaskStatus(self.friendInfo.playerId, task.id)
    if taskStatus == EC_FRIENDHELPTASKSTATUS.UNFINISHED then
        numLabel1:show()
        img1:show()
    elseif taskStatus == EC_FRIENDHELPTASKSTATUS.RECEIVED then
        numLabel3:show()
        img3:show()
    elseif taskStatus == EC_FRIENDHELPTASKSTATUS.FINISHED then
        numLabel2:show()
        img2:show()
    end

    local desLabel = TFDirector:getChildByPath(item, "label_des")
    desLabel:setTextById(task.name)

    local clickBtn = TFDirector:getChildByPath(item, "btn_click")
    clickBtn:onClick(function(sender)
        if taskStatus == EC_FRIENDHELPTASKSTATUS.UNFINISHED then
            local showReward = {}
            for _, _reward in ipairs(task.reward) do
                table.insert(showReward, {id = _reward[1], num = _reward[2]})
            end
            Utils:previewReward(nil, showReward)
            return
        end   
        
        if taskStatus == EC_FRIENDHELPTASKSTATUS.FINISHED then
            AssistanceDataMgr:sendReqReceiveFriendHelpTask(self.friendInfo.playerId, task.id)
        end
    end)

    local lineImg = TFDirector:getChildByPath(item, "img_line")
    if isEnd then
        lineImg:hide()
        local size = lineImg:getContentSize()
        item:setContentSize(CCSize(item:getContentSize().width - size.width, item:getContentSize().height))
    end
end

function AssistanceStatusLayer:onResReceiveFriendHelpTask( data )
    self:updatePlayerPanel()
    self:udpateFriendHelpTask(data.friendHelpInfo.taskInfos)
end

function AssistanceStatusLayer:onResRefreshFriendHelpTask( data )
    self:udpateFriendHelpTask(data.friendHelpInfo.taskInfos)
end

function AssistanceStatusLayer:udpateFriendHelpTask( taskInfos )
    local taskList1 = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_1)
    local taskList2 = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_2)
    local taskList3 = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_3)

    for _,_taskInfo in ipairs(taskInfos) do   
        if taskList1[1].id == _taskInfo.taskId then
            self:updateTaskItem(self.taskItemList1[1], taskList1[1])
        end

        for _idx,_task in ipairs(taskList2) do
            if _task.id == _taskInfo.taskId then
                self:updateTaskItem(self.taskItemList2[_idx], _task)
                break
            end
        end

        for _idx,_task in ipairs(taskList3) do
            if _task.id == _taskInfo.taskId then
                self:updateTaskItem(self.taskItemList3[_idx], _task)
                break
            end
        end
    end    

    self:jumpToNewPosByType(EC_INVITE_TASK.TASK_2)
    self:jumpToNewPosByType(EC_INVITE_TASK.TASK_3)
end

function AssistanceStatusLayer:getJumIndexByType( taskType )
    local taskList = {}
    if taskType == EC_INVITE_TASK.TASK_2 then
        taskList = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_2)
    end
    if taskType == EC_INVITE_TASK.TASK_3 then
        taskList = AssistanceDataMgr:getInviteOpenTasksByType(EC_INVITE_TASK.TASK_3)
    end
    local jumpIndex = 1
    for _idx,_task in ipairs(taskList) do
        local status = AssistanceDataMgr:getTaskStatus(self.friendInfo.playerId, _task.id)
        if status == EC_FRIENDHELPTASKSTATUS.UNFINISHED or status == EC_FRIENDHELPTASKSTATUS.FINISHED then
            jumpIndex = _idx
            break
        end
    end
    return jumpIndex
end

function AssistanceStatusLayer:jumpToNewPosByType( taskType )
    local jumpIndex = self:getJumIndexByType(taskType)
    if taskType == EC_INVITE_TASK.TASK_2 then
        self.taskUIListView2:jumpToItem(jumpIndex)
    end
    if taskType == EC_INVITE_TASK.TASK_3 then
        self.taskUIListView3:jumpToItem(jumpIndex)
    end
end

return AssistanceStatusLayer
