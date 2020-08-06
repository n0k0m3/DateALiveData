return {
    ["links"] = {
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "62E5807C789E4F1C858C433E6725520F",
        },
        ["DFA3DCE5932442C688BFF2D9A542EBD9"] = {
            [1] = "91DD393B8F4E4D66B8455BFC17289F60",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            [1] = "AE66E0144B014A04835D31857D7B2562",
        },
        ["6E23C5375BC64C0D8BA9438F159872AB"] = {
            [1] = "33EA1C672CC341F593B71F803D5FD3FC",
            [2] = "BE139382F7AB405EA9AC4A9CBC2FFE36",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "2B5A8D39E87742268F039B77963B6CD6",
        },
        ["AE66E0144B014A04835D31857D7B2562"] = {
            [1] = "6E23C5375BC64C0D8BA9438F159872AB",
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["2B5A8D39E87742268F039B77963B6CD6"] = {
            [1] = "E2B9076F5448423DAAB2952E3DF36AF1",
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            [1] = "DFA3DCE5932442C688BFF2D9A542EBD9",
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            [1] = "EA0D18F8EB58419DAB38337AA94567EA",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "13E7D11BAF354014A99EFB6CDCCC4908",
            [2] = "768D2CCA84884A06AF834B3299052885",
            [3] = "8E7A4B66B4A34757883A00276DCCF8C0",
            [4] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            [1] = "98CD06A449B146918EF02AA0CAE348F0",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["62E5807C789E4F1C858C433E6725520F"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
    },
    ["nodes"] = {
        ["AE66E0144B014A04835D31857D7B2562"] = {
            ["Pos"] = {
                ["y"] = 707,
                ["x"] = 655,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "AE66E0144B014A04835D31857D7B2562",
            ["RangeY"] = {
                [1] = 0,
                [2] = 100,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["DFA3DCE5932442C688BFF2D9A542EBD9"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 0,
            ["NodeTag"] = "DFA3DCE5932442C688BFF2D9A542EBD9",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -400,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 596,
                ["x"] = 1066,
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
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = 196,
                ["x"] = 644,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 185,
                ["x"] = 1187,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 303010,
            ["Type"] = 1,
            ["Static"] = false,
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
            ["Weight"] = 0,
            ["NodeTag"] = "62E5807C789E4F1C858C433E6725520F",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -200,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 138,
                ["x"] = 1065,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 400,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["91DD393B8F4E4D66B8455BFC17289F60"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 491,
                ["x"] = 1208,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "91DD393B8F4E4D66B8455BFC17289F60",
            ["ID"] = 303020,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 185,
                ["x"] = 903,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            ["Desc"] = "布雷\
",
            ["Duration"] = 10000,
            ["NodeTag"] = "13E7D11BAF354014A99EFB6CDCCC4908",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 733,
                ["x"] = 404,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["BE139382F7AB405EA9AC4A9CBC2FFE36"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 782,
                ["x"] = 1147,
            },
            ["Weight"] = 50,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "BE139382F7AB405EA9AC4A9CBC2FFE36",
            ["ID"] = 303031,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "冲锋技能\
",
            ["Duration"] = 7000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 553,
                ["x"] = 406,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["6E23C5375BC64C0D8BA9438F159872AB"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 735,
                ["x"] = 946,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "6E23C5375BC64C0D8BA9438F159872AB",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 538,
                ["x"] = 906,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E2B9076F5448423DAAB2952E3DF36AF1",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["33EA1C672CC341F593B71F803D5FD3FC"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 669,
                ["x"] = 1144,
            },
            ["Weight"] = 50,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "33EA1C672CC341F593B71F803D5FD3FC",
            ["ID"] = 303030,
            ["Type"] = 1,
            ["Static"] = false,
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
        ["2B5A8D39E87742268F039B77963B6CD6"] = {
            ["Pos"] = {
                ["y"] = 490,
                ["x"] = 637,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "2B5A8D39E87742268F039B77963B6CD6",
            ["Duration"] = 7000,
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
                ["y"] = 302,
                ["x"] = 187,
            },
            ["Category"] = 9,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "6040",
            ["Name"] = "万由里高阶近战",
            ["Static"] = true,
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
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}