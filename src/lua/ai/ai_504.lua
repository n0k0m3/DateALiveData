return {
    ["links"] = {
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "6611E7C857EF485692398A6391E5C8AF",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "4804848BEDB645769A946956F518ACFE",
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            [1] = "A4C97AC731964C168E72464D62143BB0",
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["A4C97AC731964C168E72464D62143BB0"] = {
            [1] = "9990603EE13B48BE9E038C6A8FD152FD",
        },
        ["6611E7C857EF485692398A6391E5C8AF"] = {
            [1] = "62E5807C789E4F1C858C433E6725520F",
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            [1] = "EA0D18F8EB58419DAB38337AA94567EA",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            [1] = "98CD06A449B146918EF02AA0CAE348F0",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "768D2CCA84884A06AF834B3299052885",
            [2] = "8E7A4B66B4A34757883A00276DCCF8C0",
            [3] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
        },
        ["62E5807C789E4F1C858C433E6725520F"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
    },
    ["nodes"] = {
        ["9990603EE13B48BE9E038C6A8FD152FD"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 459,
                ["x"] = 1120,
            },
            ["Weight"] = 10,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9990603EE13B48BE9E038C6A8FD152FD",
            ["ID"] = 309720,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = 195,
                ["x"] = 640,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["62E5807C789E4F1C858C433E6725520F"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 150,
            ["Weight"] = 10,
            ["NodeTag"] = "62E5807C789E4F1C858C433E6725520F",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -400,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 180,
                ["x"] = 1081,
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
        ["6611E7C857EF485692398A6391E5C8AF"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 180,
                ["x"] = 892,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "6611E7C857EF485692398A6391E5C8AF",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "攻击圈\
",
            ["Duration"] = 7000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 465,
                ["x"] = 404,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["98CD06A449B146918EF02AA0CAE348F0"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "98CD06A449B146918EF02AA0CAE348F0",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 312,
                ["x"] = 1078,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            ["Pos"] = {
                ["y"] = 321,
                ["x"] = 638,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EA0D18F8EB58419DAB38337AA94567EA",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A4C97AC731964C168E72464D62143BB0"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 930,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "A4C97AC731964C168E72464D62143BB0",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 183,
                ["x"] = 1260,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 309710,
            ["Type"] = 1,
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
                ["y"] = 298,
                ["x"] = 414,
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
            ["Desc"] = "普攻",
            ["Duration"] = 1500,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 192,
                ["x"] = 414,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 200,
                [2] = 200,
            },
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 310,
                ["x"] = 909,
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
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 13,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "504",
            ["Name"] = "美术",
            ["Static"] = true,
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            ["Pos"] = {
                ["y"] = 469,
                ["x"] = 635,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4804848BEDB645769A946956F518ACFE",
            ["Duration"] = 7000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}