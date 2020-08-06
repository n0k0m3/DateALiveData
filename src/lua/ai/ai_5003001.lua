return {
    ["links"] = {
        ["9AD1AB96247F46D38132DA0694FA78C1"] = {
            [1] = "C491470DA9A4421F9044D94ED9B8F003",
            [2] = "FC64A279A93C43B3B6F7CB1CCFD90A55",
        },
        ["FC64A279A93C43B3B6F7CB1CCFD90A55"] = {
            [1] = "1A296AD485BC4CB6882B4C1766F13649",
        },
        ["325DE855D7314F928C802EB6B3E502B5"] = {
            [1] = "1A5B30C3FE5E429A818895F357128259",
        },
        ["C491470DA9A4421F9044D94ED9B8F003"] = {
            [1] = "325DE855D7314F928C802EB6B3E502B5",
        },
        ["1A296AD485BC4CB6882B4C1766F13649"] = {
            [1] = "BACDA2AD86E8430F9ACFD60EC3E8B99C",
        },
    },
    ["nodes"] = {
        ["9AD1AB96247F46D38132DA0694FA78C1"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "9AD1AB96247F46D38132DA0694FA78C1",
            ["ID"] = "5003001",
            ["Name"] = "日常飞行-3",
            ["Static"] = true,
        },
        ["BACDA2AD86E8430F9ACFD60EC3E8B99C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 472,
                ["x"] = 1150,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "BACDA2AD86E8430F9ACFD60EC3E8B99C",
            ["ID"] = 2001009,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1A5B30C3FE5E429A818895F357128259"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 294,
                ["x"] = 1146,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1A5B30C3FE5E429A818895F357128259",
            ["ID"] = 2001009,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["FC64A279A93C43B3B6F7CB1CCFD90A55"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2400,
            ["NodeTag"] = "FC64A279A93C43B3B6F7CB1CCFD90A55",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 467,
                ["x"] = 488,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["325DE855D7314F928C802EB6B3E502B5"] = {
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 803,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "325DE855D7314F928C802EB6B3E502B5",
            ["Duration"] = 600,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C491470DA9A4421F9044D94ED9B8F003"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 600,
            ["NodeTag"] = "C491470DA9A4421F9044D94ED9B8F003",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 299,
                ["x"] = 485,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["1A296AD485BC4CB6882B4C1766F13649"] = {
            ["Pos"] = {
                ["y"] = 484,
                ["x"] = 822,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "1A296AD485BC4CB6882B4C1766F13649",
            ["Duration"] = 2400,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "9AD1AB96247F46D38132DA0694FA78C1",
}