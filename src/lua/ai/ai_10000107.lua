return {
    ["links"] = {
        ["8F0B2CBB0BB14D42A63393725CECF064"] = {
            [1] = "457F07EA9C3C4F4CB3E6DC590F0D5F41",
        },
        ["B0DA76BBC96649A3A35813ABDDB9C7DE"] = {
            [1] = "8F0B2CBB0BB14D42A63393725CECF064",
        },
        ["457F07EA9C3C4F4CB3E6DC590F0D5F41"] = {
            [1] = "09AF6AF719F6416586EF24DB85B7F51C",
        },
    },
    ["nodes"] = {
        ["09AF6AF719F6416586EF24DB85B7F51C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 1177,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "09AF6AF719F6416586EF24DB85B7F51C",
            ["ID"] = 2001022,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8F0B2CBB0BB14D42A63393725CECF064"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1400,
            ["NodeTag"] = "8F0B2CBB0BB14D42A63393725CECF064",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 523,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["B0DA76BBC96649A3A35813ABDDB9C7DE"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 8,
            ["Class"] = "RootNode",
            ["NodeTag"] = "B0DA76BBC96649A3A35813ABDDB9C7DE",
            ["ID"] = "10000107",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["457F07EA9C3C4F4CB3E6DC590F0D5F41"] = {
            ["Pos"] = {
                ["y"] = 318,
                ["x"] = 842,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "457F07EA9C3C4F4CB3E6DC590F0D5F41",
            ["Duration"] = 1400,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "B0DA76BBC96649A3A35813ABDDB9C7DE",
}