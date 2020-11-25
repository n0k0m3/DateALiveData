
-----------------------------------例子
return {
            
           { 
                ["class"] = "EvtSequence",
                ["enbaleSkip"] = false,
                ["Evts"] = {

    

                 {
                        ["class"] = "EvtSpaw",
                        ["Evts"] = {       

                                               --幕布开关
                                                { ["class"] = "Evt",["evtType"] = "curtainEvt",["val"] = true, },   
                                                { ["class"] = "Evt",["evtType"] = "monsterAIEvt",["val"] = false, },  --暂停AI
                                                { ["class"] = "Evt",["evtType"] = "playerCtrlEvt",["isEnable"] = false,}, --玩家无法操作
                                                { ["class"] = "Evt",["evtType"] = "ctrlEvt",["list"] = {{
                                                    ["group"] = 3 ,      --控件分类1:血条,2：键盘,3全部ui
                                                    ["val"] = false,    --显示或隐藏
                                                },} },    

                },},

   
                          { ["class"] = "Evt",["evtType"] = "playStoryEvt",["groupID"] = 9363,["skipBtn"] = true,   },


                 {
                        ["class"] = "EvtSpaw",
                        ["Evts"] = {       
                                                { ["class"] = "Evt",["evtType"] = "monsterAIEvt",["val"] = true, },  --暂停AI
                                                { ["class"] = "Evt",["evtType"] = "playerCtrlEvt",["isEnable"] = true,}, --玩家无法操作
                                                { ["class"] = "Evt",["evtType"] = "ctrlEvt",["list"] = {{
                                                    ["group"] = 3 ,      --控件分类1:血条,2：键盘,3全部ui
                                                    ["val"] = true,    --显示或隐藏
                                                },} },    

                                                    --幕布开关
                                                { ["class"] = "Evt",["evtType"] = "curtainEvt",["val"] = false, },   

                },},

            }
        }
            
}

--                {
 --                   ["class"] = "EvtSpaw",
 --                   ["Evts"] = {},
  --              },