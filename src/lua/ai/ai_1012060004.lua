return {
    ["links"] = {
        ["6941CC632E064D1299BC2E0FAD7E18F4"] = {
            [1] = "71164BBBDD1547A69314ADCE92230781",
        },
        ["71164BBBDD1547A69314ADCE92230781"] = {
            [1] = "CD71382DACFB45A8826848B69FB7487D",
        },
        ["5698DABE3EA74406800613E17607A011"] = {
            [1] = "BEB3A44A5E6247468234AB9329C3EF02",
        },
        ["BEB3A44A5E6247468234AB9329C3EF02"] = {
            [1] = "9F261E796B834CFBBCCF336A4482D0C5",
        },
        ["6B587F0E61C24A9F9E0E88A3AF13D8F6"] = {
            [1] = "5698DABE3EA74406800613E17607A011",
            [2] = "6941CC632E064D1299BC2E0FAD7E18F4",
        },
    },
    ["nodes"] = {
        ["6941CC632E064D1299BC2E0FAD7E18F4"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 4200,
            ["NodeTag"] = "6941CC632E064D1299BC2E0FAD7E18F4",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 519,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["CD71382DACFB45A8826848B69FB7487D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 465,
                ["x"] = 1162,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "CD71382DACFB45A8826848B69FB7487D",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BEB3A44A5E6247468234AB9329C3EF02"] = {
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 796,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BEB3A44A5E6247468234AB9329C3EF02",
            ["Duration"] = 2000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["71164BBBDD1547A69314ADCE92230781"] = {
            ["Pos"] = {
                ["y"] = 478,
                ["x"] = 809,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "71164BBBDD1547A69314ADCE92230781",
            ["Duration"] = 4200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5698DABE3EA74406800613E17607A011"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2000,
            ["NodeTag"] = "5698DABE3EA74406800613E17607A011",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 299,
                ["x"] = 513,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["6B587F0E61C24A9F9E0E88A3AF13D8F6"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6B587F0E61C24A9F9E0E88A3AF13D8F6",
            ["ID"] = "1012060004",
            ["Name"] = "wave3-2",
            ["Static"] = true,
        },
        ["9F261E796B834CFBBCCF336A4482D0C5"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 315,
                ["x"] = 1156,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9F261E796B834CFBBCCF336A4482D0C5",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "6B587F0E61C24A9F9E0E88A3AF13D8F6",
}