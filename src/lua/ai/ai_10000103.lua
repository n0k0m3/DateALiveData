return {
    ["links"] = {
        ["5DFA2C1D0D144C8A9B6AA2F564651DAB"] = {
            [1] = "518AFC9F11C94B208445FB39A63D3E30",
        },
        ["65FE02096BA142AF9BFDEBD5EB6A2D2A"] = {
            [1] = "1D561DBF719042C9B7818A15120FC6AB",
        },
        ["1D561DBF719042C9B7818A15120FC6AB"] = {
            [1] = "5DFA2C1D0D144C8A9B6AA2F564651DAB",
        },
    },
    ["nodes"] = {
        ["5DFA2C1D0D144C8A9B6AA2F564651DAB"] = {
            ["Pos"] = {
                ["y"] = 317,
                ["x"] = 809,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5DFA2C1D0D144C8A9B6AA2F564651DAB",
            ["Duration"] = 1000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["518AFC9F11C94B208445FB39A63D3E30"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 318,
                ["x"] = 1132,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "518AFC9F11C94B208445FB39A63D3E30",
            ["ID"] = 2001018,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["65FE02096BA142AF9BFDEBD5EB6A2D2A"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 8,
            ["Class"] = "RootNode",
            ["NodeTag"] = "65FE02096BA142AF9BFDEBD5EB6A2D2A",
            ["ID"] = "10000103",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["1D561DBF719042C9B7818A15120FC6AB"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "1D561DBF719042C9B7818A15120FC6AB",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 498,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "65FE02096BA142AF9BFDEBD5EB6A2D2A",
}