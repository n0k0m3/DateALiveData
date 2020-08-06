local DatingConfig = {}

DatingConfig.live2dConfig = {
    MOTION_GROUP_IDLE_SEND          ="id_send", -- 默认送礼待机
    MOTION_GROUP_IDLE_SEND_FOOD     ="id_send_food", -- 赠送食物待机（拖出食物）
    MOTION_GROUP_IDLE_SEND_GIFT     ="id_send_gift", -- 赠送礼物待机（拖出礼物）
    MOTION_GROUP_IDLE_SEND_FOOD_1   ="id_send_food_1", -- 收到喜爱食物
    MOTION_GROUP_IDLE_SEND_FOOD_2   ="id_send_food_2", -- 收到一般食物
    MOTION_GROUP_IDLE_SEND_GIFT_1   ="id_send_gift_1", -- 收到喜爱礼物
    MOTION_GROUP_IDLE_SEND_GIFT_2   ="id_send_gift_2", -- 收到一般礼物

    MOTION_GROUP_IDLE_SEND_TIME          = 5, -- 默认送礼待机
    MOTION_GROUP_IDLE_SEND_FOOD_TIME     = 3, -- 赠送食物待机（拖出食物）
    MOTION_GROUP_IDLE_SEND_GIFT_TIME     = 3, -- 赠送礼物待机（拖出礼物）
    MOTION_GROUP_IDLE_SEND_FOOD_1_TIME   = 5, -- 收到喜爱食物
    MOTION_GROUP_IDLE_SEND_FOOD_2_TIME   = 5, -- 收到一般食物
    MOTION_GROUP_IDLE_SEND_GIFT_1_TIME   = 5, -- 收到喜爱礼物
    MOTION_GROUP_IDLE_SEND_GIFT_2_TIME   = 5, -- 收到一般礼物
}

DatingConfig.centerPos = ccp(me.Director:getWinSize().width/2,me.Director:getWinSize().height/2)

DatingConfig.DatingLayerType = {
    infoType = "infoLayer",
    giveGiftType = "giveGiftLayer",
    changeDressType = "changeDressLayer",
    garnishType = "garnishLayer",
    yuehuiType = "yuehuiLayer",
    jobType = "jobType"
}

DatingConfig.UserDefaultKey = {
    SCORE_KEY = "score",
    ROLEID_KEY = "roleId"
}

DatingConfig.GameMode = {
    YUEHUI_MODE = "yueHui_mode",
    FUBEN_MODE = "fuBen_mode"
}

DatingConfig.ReviewKey = {
    YUEHUI_KEY = "yueHui_key",
    FUBEN_KEY = "fuBen_key"
}

--CG区域选项标记组合
DatingConfig.SignCombination = {
    ["cg1"] = {
        {priority = 1, signs = {1,3}, isOver = true, jumpId = 1101101},
        {priority = 2, signs = {3}, isOver = true, jumpId = 1101102},
        {priority = 3, signs = {2,4}, isOver = false, jumpId = 1101103},
        {priority = 4, signs = {}, isOver = false, jumpId = 1101104},
    },
    ["cg2"] = {
    }
}

--CG区域选择标记触发的事件
DatingConfig.SignTouchEvent = {
    ["cg1"] = {
        [1] = {changeImage = {uiName = "Image_1",textruePath = "icon/item/gift/530142.png"},textIds = {12002,12003}},
        [2] = {changeImage = {uiName = "Image_2",textruePath = "icon/item/gift/530143.png"},textIds = {12004,12005}},
        [3] = {changeImage = {uiName = "Image_3",textruePath = "icon/item/gift/530144.png"},textIds = {12006}},
        [4] = {changeImage = {uiName = "Image_4",textruePath = "icon/item/gift/530145.png"},textIds = {12007,12008}},
    },
    ["cg2"] = {
    }
}

return DatingConfig