return {
    ["links"] = {
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "6A8F38DAD60244E289AC2BAE98AD9F54",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "4804848BEDB645769A946956F518ACFE",
        },
        ["6A8F38DAD60244E289AC2BAE98AD9F54"] = {
            [1] = "62E5807C789E4F1C858C433E6725520F",
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            [1] = "EE9BBA98499344558DC43225C7903135",
        },
        ["EE9BBA98499344558DC43225C7903135"] = {
            [1] = "8CE7E4B7D4AC41FF98B145515D968649",
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
        ["EE9BBA98499344558DC43225C7903135"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 462,
                ["x"] = 920,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "EE9BBA98499344558DC43225C7903135",
            ["Type"] = 0,
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
        ["6A8F38DAD60244E289AC2BAE98AD9F54"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 170,
                ["x"] = 889,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "6A8F38DAD60244E289AC2BAE98AD9F54",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 181,
                ["x"] = 1219,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 309910,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "绣球\
",
            ["Duration"] = 7000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 466,
                ["x"] = 413,
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
        ["62E5807C789E4F1C858C433E6725520F"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 10,
            ["NodeTag"] = "62E5807C789E4F1C858C433E6725520F",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -150,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 158,
                ["x"] = 1083,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 300,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["8CE7E4B7D4AC41FF98B145515D968649"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 1106,
            },
            ["Weight"] = 10,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8CE7E4B7D4AC41FF98B145515D968649",
            ["ID"] = 309930,
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
                ["x"] = 214,
            },
            ["Category"] = 13,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "551",
            ["Name"] = "年兽-岁-绣球",
            ["Static"] = true,
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            ["Pos"] = {
                ["y"] = 476,
                ["x"] = 633,
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