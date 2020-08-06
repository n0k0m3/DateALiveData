return {
    ["links"] = {
        ["0807C490B4B4498AAA8E6DBB27652E63"] = {
            [1] = "15FA86C11CDC4ACAB5A20E27F6660FE4",
        },
        ["3576FDE6CA3C40069DBFA4B25F25A570"] = {
            [1] = "0807C490B4B4498AAA8E6DBB27652E63",
        },
        ["15FA86C11CDC4ACAB5A20E27F6660FE4"] = {
            [1] = "F78F801092774AF993CC450345B5C64F",
        },
    },
    ["nodes"] = {
        ["3576FDE6CA3C40069DBFA4B25F25A570"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "3576FDE6CA3C40069DBFA4B25F25A570",
            ["ID"] = "5003002",
            ["Name"] = "wave2",
            ["Static"] = true,
        },
        ["0807C490B4B4498AAA8E6DBB27652E63"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 100,
            ["NodeTag"] = "0807C490B4B4498AAA8E6DBB27652E63",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 295,
                ["x"] = 538,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["F78F801092774AF993CC450345B5C64F"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 295,
                ["x"] = 1173,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "F78F801092774AF993CC450345B5C64F",
            ["ID"] = 2001009,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["15FA86C11CDC4ACAB5A20E27F6660FE4"] = {
            ["Pos"] = {
                ["y"] = 309,
                ["x"] = 863,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "15FA86C11CDC4ACAB5A20E27F6660FE4",
            ["Duration"] = 100,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "3576FDE6CA3C40069DBFA4B25F25A570",
}