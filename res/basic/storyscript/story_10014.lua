
-----------------------------------例子
return {
            
           { 
                ["class"] = "EvtSequence",
                ["enbaleSkip"] = false,
                ["Evts"] = {


                        --并行事件
                        
                        {   ["class"] = "EvtSpaw",
                            ["Evts"] = {

                                --剧情开启前AI，操作的控制
                                -- { ["class"] = "Evt",["evtType"] = "monsterAIEvt",["val"] = false, },  --暂停AI
                                { ["class"] = "Evt",["evtType"] = "playerCtrlEvt",["isEnable"] = false,}, --玩家无法操作
                                { ["class"] = "Evt",["evtType"] = "ctrlEvt",["list"] = {{
                                    ["group"] = 3 ,     --控件分类1:血条,2：键盘,3全部ui
                                    ["val"] = false,    --显示或隐藏
                                },} },
                            },
                        },
                        -- --上下屏幕遮罩
                        --         { ["class"] = "Evt",["evtType"] = "curtainEvt",["val"] = true, },     --开启黑幕
                        -- --展示对话
                        --         { ["class"] = "Evt",["evtType"] = "playStoryEvt",["groupID"] = 1001,["skipBtn"] = true,   },
                        -- --关闭上下遮罩
                        --         { ["class"] = "Evt",["evtType"] = "curtainEvt",["val"] = false, },     --开启黑幕

                        -- { --镜头移动事件
                        --     ["class"] = "Evt",
                        --     ["evtType"] = "cameraMoveEvt",
                        --     ["finalPos"] = {["x"] = 639,["y"] = 42}, --终点
                        --     ["duration"] = 1000,--时长(ms)
                        -- },

                        -- { --镜头移动事件
                        --     ["class"] = "Evt",
                        --     ["evtType"] = "cameraMoveEvt",
                        --     ["finalPos"] = {["x"] = 639,["y"] = 1000}, --终点
                        --     ["duration"] = 1000,--时长(ms)
                        -- },

                        -- { --镜头移动事件
                        --     ["class"] = "Evt",
                        --     ["evtType"] = "cameraMoveEvt",
                        --     ["finalPos"] = {["x"] = 639,["y"] = 2500}, --终点
                        --     ["duration"] = 1000,--时长(ms)
                        -- },

                        -- { --镜头移动事件
                        --     ["class"] = "Evt",
                        --     ["evtType"] = "cameraMoveEvt",
                        --     ["finalPos"] = {["x"] = 639,["y"] = 5000}, --终点
                        --     ["duration"] = 1000,--时长(ms)
                        -- },

                -- {    ["class"] = "EvtSpaw",
                --     ["Evts"] = {

                        { --镜头移动事件
                                ["class"] = "Evt",
                                ["evtType"] = "cameraMoveEvt",
                                ["finalPos"] = {["x"] = 660,["y"] = 3500,["z"] = 553}, --终点
                                ["duration"] = 3000,--时长(ms)
                                ["zoomDuration"] = 3000,--变焦过程用时
                                ["holdDuration"] = 1000,--停留时间
                                ["recoverTime"] = 1000, --恢复默认焦距过程时间
                            },   

                        --     { --镜头倍率调节事件
                        --         ["class"] = "Evt",
                        --         ["evtType"] = "cameraFocusEvt",
                        --         ["scale"] = 1.2,
                        --         ["zoomDuration"] = 4000,--变焦过程用时
                        --         ["holdDuration"] = 1000,--停留时间
                        --         ["recoverTime"] = 2000, --恢复默认焦距过程时间
                        --     },
                        --                         },
                        -- },



                        --并行事件 还原控制
                        
                        {    ["class"] = "EvtSpaw",
                            ["Evts"] = {
                                --剧情开启前AI，操作的控制
                                -- { ["class"] = "Evt",["evtType"] = "monsterAIEvt",["val"] = true, },  --暂停AI
                                { ["class"] = "Evt",["evtType"] = "playerCtrlEvt",["isEnable"] = true,}, --玩家无法操作
                                { ["class"] = "Evt",["evtType"] = "ctrlEvt",["list"] = {{
                                    ["group"] = 3 ,     --控件分类1:血条,2：键盘,3全部ui
                                    ["val"] = true,    --显示或隐藏
                                },} },
                                   {["class"] = "Evt",["evtType"] = "cameraFollowEvt",  
                                    ["tarID"] = -1, },                               
                            },
                        },


            }
        }
            
}

--                {
 --                   ["class"] = "EvtSpaw",
 --                   ["Evts"] = {},
  --              },