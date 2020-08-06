return {
    ["links"] = {
        ["9D2EBB5A44B2403BBA6870D2D9472B80"] = {
            [1] = "822B3007A04B454EA01602D0D473F8A3",
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "B5921E0350014C9BB923A9472675E947",
        },
        ["FE33AF551AF445229A2538BA8351D501"] = {
            [1] = "8D44FDA902544C64ABB43B487E847BB9",
            [2] = "9D2EBB5A44B2403BBA6870D2D9472B80",
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            [1] = "91DD393B8F4E4D66B8455BFC17289F60",
        },
        ["B5921E0350014C9BB923A9472675E947"] = {
            [1] = "E2B9076F5448423DAAB2952E3DF36AF1",
        },
        ["822B3007A04B454EA01602D0D473F8A3"] = {
            [1] = "3A163EE2D84C4C9EA7C327988E1944BB",
        },
        ["8D44FDA902544C64ABB43B487E847BB9"] = {
            [1] = "822B3007A04B454EA01602D0D473F8A3",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "FE33AF551AF445229A2538BA8351D501",
            [2] = "768D2CCA84884A06AF834B3299052885",
            [3] = "8E7A4B66B4A34757883A00276DCCF8C0",
        },
    },
    ["nodes"] = {
        ["9D2EBB5A44B2403BBA6870D2D9472B80"] = {
            ["Pos"] = {
                ["y"] = 698,
                ["x"] = 657,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "9D2EBB5A44B2403BBA6870D2D9472B80",
            ["Duration"] = 12000,
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
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "弹开\
",
            ["Duration"] = 7000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 503,
                ["x"] = 415,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 6,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 182,
                ["x"] = 1136,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 305010,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["FE33AF551AF445229A2538BA8351D501"] = {
            ["Desc"] = "召唤\
",
            ["Duration"] = 0,
            ["NodeTag"] = "FE33AF551AF445229A2538BA8351D501",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 729,
                ["x"] = 413,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 9,
            ["DurationInterval"] = {
                [1] = 200,
                [2] = 200,
            },
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 545,
                ["x"] = 1066,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E2B9076F5448423DAAB2952E3DF36AF1",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["822B3007A04B454EA01602D0D473F8A3"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 746,
                ["x"] = 991,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "822B3007A04B454EA01602D0D473F8A3",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["B5921E0350014C9BB923A9472675E947"] = {
            ["Pos"] = {
                ["y"] = 528,
                ["x"] = 751,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "B5921E0350014C9BB923A9472675E947",
            ["RangeY"] = {
                [1] = 0,
                [2] = 40,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 150,
            },
            ["Static"] = false,
        },
        ["8D44FDA902544C64ABB43B487E847BB9"] = {
            ["Pos"] = {
                ["y"] = 857,
                ["x"] = 676,
            },
            ["Class"] = "ConditionSelfHPLessNode",
            ["NodeTag"] = "8D44FDA902544C64ABB43B487E847BB9",
            ["Percent"] = 80,
            ["Type"] = 4,
            ["Static"] = false,
        },
        ["91DD393B8F4E4D66B8455BFC17289F60"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 552,
                ["x"] = 1278,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "91DD393B8F4E4D66B8455BFC17289F60",
            ["ID"] = 305020,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3A163EE2D84C4C9EA7C327988E1944BB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 772,
                ["x"] = 1184,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3A163EE2D84C4C9EA7C327988E1944BB",
            ["ID"] = 305030,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 217,
            },
            ["Category"] = 9,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "6060",
            ["Name"] = "万由里高阶综合",
            ["Static"] = true,
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "普攻",
            ["Duration"] = 3000,
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
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}