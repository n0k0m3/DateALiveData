return {
    ["links"] = {
        ["3357BF9AC0B5488BA6B110044176AFFC"] = {
            [1] = "F59D45B99EBC49248C032785A1B642E2",
        },
        ["F59D45B99EBC49248C032785A1B642E2"] = {
            [1] = "B0330DF3AD644C0F94F57E6D23C7CA2D",
        },
        ["B0330DF3AD644C0F94F57E6D23C7CA2D"] = {
            [1] = "16FDBB0C6E2645D9BD654EE7D6D768B4",
        },
    },
    ["nodes"] = {
        ["16FDBB0C6E2645D9BD654EE7D6D768B4"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 1125,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "16FDBB0C6E2645D9BD654EE7D6D768B4",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3357BF9AC0B5488BA6B110044176AFFC"] = {
            ["Desc"] = "新的 wave12",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "3357BF9AC0B5488BA6B110044176AFFC",
            ["ID"] = "1012060112",
            ["Name"] = "新的 wave12",
            ["Static"] = true,
        },
        ["F59D45B99EBC49248C032785A1B642E2"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 200,
            ["NodeTag"] = "F59D45B99EBC49248C032785A1B642E2",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 315,
                ["x"] = 511,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["B0330DF3AD644C0F94F57E6D23C7CA2D"] = {
            ["Pos"] = {
                ["y"] = 322,
                ["x"] = 814,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B0330DF3AD644C0F94F57E6D23C7CA2D",
            ["Duration"] = 200,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "3357BF9AC0B5488BA6B110044176AFFC",
}