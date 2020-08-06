return {
    ["links"] = {
        ["247B759C4A734CFBBD087199A953DE8B"] = {
            [1] = "40A5AD011C18439E964A116A6C8B6DF4",
        },
        ["F1B41EDD80C04CE58242B591CDF72488"] = {
            [1] = "247B759C4A734CFBBD087199A953DE8B",
        },
        ["86217DE2E10C41D2A66E826C29E9C9F2"] = {
            [1] = "F1B41EDD80C04CE58242B591CDF72488",
        },
        ["F93638890A5946B5B0D57CFFD9AF473D"] = {
            [1] = "A5711A2673B14234AFDE0C9D0F338C5F",
        },
        ["340A56DEA6DF4846826193C83F9E0BA6"] = {
            [1] = "86217DE2E10C41D2A66E826C29E9C9F2",
            [2] = "E0D4E552678B4FE092552C6DAD263FA6",
        },
        ["A5711A2673B14234AFDE0C9D0F338C5F"] = {
            [1] = "6B5FD85C47644898A43E6FFB2F34D212",
        },
        ["E0D4E552678B4FE092552C6DAD263FA6"] = {
            [1] = "F93638890A5946B5B0D57CFFD9AF473D",
        },
    },
    ["nodes"] = {
        ["40A5AD011C18439E964A116A6C8B6DF4"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 482,
                ["x"] = 1108,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "40A5AD011C18439E964A116A6C8B6DF4",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["86217DE2E10C41D2A66E826C29E9C9F2"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "86217DE2E10C41D2A66E826C29E9C9F2",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 479,
                ["x"] = 383,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 5,
        },
        ["247B759C4A734CFBBD087199A953DE8B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 567,
                ["x"] = 897,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "247B759C4A734CFBBD087199A953DE8B",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["F1B41EDD80C04CE58242B591CDF72488"] = {
            ["Pos"] = {
                ["y"] = 497,
                ["x"] = 642,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F1B41EDD80C04CE58242B591CDF72488",
            ["Duration"] = 30000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6B5FD85C47644898A43E6FFB2F34D212"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 289,
                ["x"] = 1090,
            },
            ["Weight"] = 10,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6B5FD85C47644898A43E6FFB2F34D212",
            ["ID"] = 343222,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A5711A2673B14234AFDE0C9D0F338C5F"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 344,
                ["x"] = 893,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "A5711A2673B14234AFDE0C9D0F338C5F",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["F93638890A5946B5B0D57CFFD9AF473D"] = {
            ["Pos"] = {
                ["y"] = 334,
                ["x"] = 635,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F93638890A5946B5B0D57CFFD9AF473D",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["340A56DEA6DF4846826193C83F9E0BA6"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 345,
                ["x"] = 215,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "340A56DEA6DF4846826193C83F9E0BA6",
            ["ID"] = "40603",
            ["Name"] = "6号BOSS剑",
            ["Static"] = true,
        },
        ["E0D4E552678B4FE092552C6DAD263FA6"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "E0D4E552678B4FE092552C6DAD263FA6",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 309,
                ["x"] = 393,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
    },
    ["root"] = "340A56DEA6DF4846826193C83F9E0BA6",
}