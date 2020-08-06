return {
    ["links"] = {
        ["0FBD3843E00043638D59A99973DF81EE"] = {
            [1] = "F374112D7DB34DB9BA4D8259C3749E65",
        },
        ["F374112D7DB34DB9BA4D8259C3749E65"] = {
            [1] = "F5DBC8915B1F4E0EBD43CF29472FEC09",
        },
        ["C5C07D7DC2AD4FB3836A8040815CF55E"] = {
            [1] = "3AC413011C5B481AA183D4673B40D268",
        },
        ["39EF0C9B00B441FEB1154C4FB3C93EFA"] = {
            [1] = "C5C07D7DC2AD4FB3836A8040815CF55E",
        },
        ["B2401C456C714C87803A92B8F96B80B6"] = {
            [1] = "0FBD3843E00043638D59A99973DF81EE",
            [2] = "39EF0C9B00B441FEB1154C4FB3C93EFA",
        },
    },
    ["nodes"] = {
        ["F5DBC8915B1F4E0EBD43CF29472FEC09"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 333,
                ["x"] = 1191,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "F5DBC8915B1F4E0EBD43CF29472FEC09",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3AC413011C5B481AA183D4673B40D268"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 487,
                ["x"] = 1186,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3AC413011C5B481AA183D4673B40D268",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0FBD3843E00043638D59A99973DF81EE"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 800,
            ["NodeTag"] = "0FBD3843E00043638D59A99973DF81EE",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 543,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["F374112D7DB34DB9BA4D8259C3749E65"] = {
            ["Pos"] = {
                ["y"] = 335,
                ["x"] = 828,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F374112D7DB34DB9BA4D8259C3749E65",
            ["Duration"] = 800,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C5C07D7DC2AD4FB3836A8040815CF55E"] = {
            ["Pos"] = {
                ["y"] = 492,
                ["x"] = 822,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C5C07D7DC2AD4FB3836A8040815CF55E",
            ["Duration"] = 3000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["39EF0C9B00B441FEB1154C4FB3C93EFA"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3000,
            ["NodeTag"] = "39EF0C9B00B441FEB1154C4FB3C93EFA",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 472,
                ["x"] = 541,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["B2401C456C714C87803A92B8F96B80B6"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 253,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "B2401C456C714C87803A92B8F96B80B6",
            ["ID"] = "1012060006",
            ["Name"] = "wave6",
            ["Static"] = true,
        },
    },
    ["root"] = "B2401C456C714C87803A92B8F96B80B6",
}