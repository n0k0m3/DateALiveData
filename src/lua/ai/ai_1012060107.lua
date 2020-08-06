return {
    ["links"] = {
        ["8AFD277231DA4439945E96BEB1FA0278"] = {
            [1] = "B938E5421BFA45CA84214BCEC998DA65",
        },
        ["9DC08A46FE3144CC9076660182158C12"] = {
            [1] = "45413DF484CF44EEA1986CE03FD02E16",
            [2] = "8AFD277231DA4439945E96BEB1FA0278",
        },
        ["45413DF484CF44EEA1986CE03FD02E16"] = {
            [1] = "1A4D60B2E94141E5B4F07B2174F79BBD",
        },
        ["B938E5421BFA45CA84214BCEC998DA65"] = {
            [1] = "418160549CC6460CAAB7A4996C096FC9",
        },
        ["1A4D60B2E94141E5B4F07B2174F79BBD"] = {
            [1] = "0E74DE5BBB374BB2B41D63334B857A7F",
        },
    },
    ["nodes"] = {
        ["0E74DE5BBB374BB2B41D63334B857A7F"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 1120,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "0E74DE5BBB374BB2B41D63334B857A7F",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["418160549CC6460CAAB7A4996C096FC9"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 512,
                ["x"] = 1116,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "418160549CC6460CAAB7A4996C096FC9",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["45413DF484CF44EEA1986CE03FD02E16"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "45413DF484CF44EEA1986CE03FD02E16",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 298,
                ["x"] = 511,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["9DC08A46FE3144CC9076660182158C12"] = {
            ["Desc"] = "新的 wave7",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "9DC08A46FE3144CC9076660182158C12",
            ["ID"] = "1012060107",
            ["Name"] = "新的 wave7",
            ["Static"] = true,
        },
        ["8AFD277231DA4439945E96BEB1FA0278"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2500,
            ["NodeTag"] = "8AFD277231DA4439945E96BEB1FA0278",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 489,
                ["x"] = 501,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["B938E5421BFA45CA84214BCEC998DA65"] = {
            ["Pos"] = {
                ["y"] = 521,
                ["x"] = 810,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B938E5421BFA45CA84214BCEC998DA65",
            ["Duration"] = 2500,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1A4D60B2E94141E5B4F07B2174F79BBD"] = {
            ["Pos"] = {
                ["y"] = 312,
                ["x"] = 809,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "1A4D60B2E94141E5B4F07B2174F79BBD",
            ["Duration"] = 1000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "9DC08A46FE3144CC9076660182158C12",
}