return {
    ["links"] = {
        ["FF81BCEC6F29436D9858EF0E473708A2"] = {
            [1] = "0A7880BBBE7B419A9EBBDB77002E9908",
        },
        ["A40B05F472734B47AEB95A39BB65D00F"] = {
            [1] = "B96DB1C7F2694488A348E0DB2CEB4D97",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["B96DB1C7F2694488A348E0DB2CEB4D97"] = {
            [1] = "FF81BCEC6F29436D9858EF0E473708A2",
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["62E5807C789E4F1C858C433E6725520F"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            [1] = "E2B9076F5448423DAAB2952E3DF36AF1",
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "62E5807C789E4F1C858C433E6725520F",
        },
        ["3070CA45A2964BD3BE08CC41A6E535F7"] = {
            [1] = "B11377258E3746489D67A2E22B3C45FD",
        },
        ["0A7880BBBE7B419A9EBBDB77002E9908"] = {
            [1] = "EA7BCC5988844E8799DD73EA90602EA9",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "4804848BEDB645769A946956F518ACFE",
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            [1] = "B4EE3137C6694033A4247717B8DA8793",
        },
        ["B4EE3137C6694033A4247717B8DA8793"] = {
            [1] = "91DD393B8F4E4D66B8455BFC17289F60",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            [1] = "EA0D18F8EB58419DAB38337AA94567EA",
        },
        ["B11377258E3746489D67A2E22B3C45FD"] = {
            [1] = "853ADF916A3D49B0AA264529E5D743F0",
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            [1] = "98CD06A449B146918EF02AA0CAE348F0",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "3070CA45A2964BD3BE08CC41A6E535F7",
            [2] = "A40B05F472734B47AEB95A39BB65D00F",
        },
        ["853ADF916A3D49B0AA264529E5D743F0"] = {
            [1] = "57F04B6D193141B19EAAB28CF32B9AA5",
        },
    },
    ["nodes"] = {
        ["FF81BCEC6F29436D9858EF0E473708A2"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 405,
                ["x"] = 897,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "FF81BCEC6F29436D9858EF0E473708A2",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["A40B05F472734B47AEB95A39BB65D00F"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "A40B05F472734B47AEB95A39BB65D00F",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 413,
                ["x"] = 393,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = -37,
                ["x"] = 687,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 7000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["B96DB1C7F2694488A348E0DB2CEB4D97"] = {
            ["Pos"] = {
                ["y"] = 412,
                ["x"] = 636,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B96DB1C7F2694488A348E0DB2CEB4D97",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -102,
                ["x"] = 1225,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 309210,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            ["Pos"] = {
                ["y"] = 15,
                ["x"] = 708,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EA0D18F8EB58419DAB38337AA94567EA",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["62E5807C789E4F1C858C433E6725520F"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 0,
            ["NodeTag"] = "62E5807C789E4F1C858C433E6725520F",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -160,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = -80,
                ["x"] = 1100,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 320,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["91DD393B8F4E4D66B8455BFC17289F60"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -305,
                ["x"] = 1261,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "91DD393B8F4E4D66B8455BFC17289F60",
            ["ID"] = 309220,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            ["Pos"] = {
                ["y"] = -124,
                ["x"] = 632,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4804848BEDB645769A946956F518ACFE",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["57F04B6D193141B19EAAB28CF32B9AA5"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 236,
                ["x"] = 1083,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "57F04B6D193141B19EAAB28CF32B9AA5",
            ["ID"] = 310370,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -13,
                ["x"] = 908,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["3070CA45A2964BD3BE08CC41A6E535F7"] = {
            ["Desc"] = "释放雪球特效\
\
",
            ["Duration"] = 0,
            ["NodeTag"] = "3070CA45A2964BD3BE08CC41A6E535F7",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 234,
                ["x"] = 379,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EA7BCC5988844E8799DD73EA90602EA9"] = {
            ["Desc"] = "移动到指定位置",
            ["Weight"] = 0,
            ["NodeTag"] = "EA7BCC5988844E8799DD73EA90602EA9",
            ["MoveSpeedScale"] = 100,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 401,
                ["x"] = 1260,
            },
            ["Class"] = "MoveToBevNode",
            ["MoveSite"] = 225,
            ["MovePos"] = {
                ["y"] = 246,
                ["x"] = 11000,
            },
            ["Type"] = 7,
            ["MovePosWay"] = 1,
        },
        ["0A7880BBBE7B419A9EBBDB77002E9908"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 399,
                ["x"] = 1063,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "0A7880BBBE7B419A9EBBDB77002E9908",
            ["DelayTime"] = 2000,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "投掷",
            ["Duration"] = 5000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -88,
                ["x"] = 407,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["853ADF916A3D49B0AA264529E5D743F0"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 235,
                ["x"] = 886,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "853ADF916A3D49B0AA264529E5D743F0",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -149,
                ["x"] = 923,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E2B9076F5448423DAAB2952E3DF36AF1",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 0,
            ["NodeTag"] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 44,
                ["x"] = 468,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "吹风\
",
            ["Duration"] = 7000,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -11,
                ["x"] = 451,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 2000,
                [2] = 2000,
            },
        },
        ["98CD06A449B146918EF02AA0CAE348F0"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "98CD06A449B146918EF02AA0CAE348F0",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 55,
                ["x"] = 1124,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["B11377258E3746489D67A2E22B3C45FD"] = {
            ["Pos"] = {
                ["y"] = 244,
                ["x"] = 639,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B11377258E3746489D67A2E22B3C45FD",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 37,
                ["x"] = 933,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "711396D9C1B34958870908CA364A2153",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 341,
                ["x"] = 250,
            },
            ["Category"] = 11,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "911302",
            ["Name"] = "滚动的雪球",
            ["Static"] = true,
        },
        ["B4EE3137C6694033A4247717B8DA8793"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 0,
            ["NodeTag"] = "B4EE3137C6694033A4247717B8DA8793",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -400,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = -275,
                ["x"] = 1126,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 800,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}