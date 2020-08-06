return {
    ["links"] = {
        ["2189AA30A15B47C2A5F6C5745A8CFEE7"] = {
            [1] = "DB9A11ED405E4C588A9D84CE37ABE743",
        },
        ["6FCC20C22F254934B2DB9121C319FFCD"] = {
            [1] = "03F39413E0614EAD86E70FC4951FA346",
        },
        ["DB9A11ED405E4C588A9D84CE37ABE743"] = {
            [1] = "6FCC20C22F254934B2DB9121C319FFCD",
        },
    },
    ["nodes"] = {
        ["2189AA30A15B47C2A5F6C5745A8CFEE7"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 292,
                ["x"] = 251,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "2189AA30A15B47C2A5F6C5745A8CFEE7",
            ["ID"] = "5004008",
            ["Name"] = "wave8",
            ["Static"] = true,
        },
        ["6FCC20C22F254934B2DB9121C319FFCD"] = {
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 756,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "6FCC20C22F254934B2DB9121C319FFCD",
            ["Duration"] = 300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["03F39413E0614EAD86E70FC4951FA346"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 288,
                ["x"] = 1055,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "03F39413E0614EAD86E70FC4951FA346",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["DB9A11ED405E4C588A9D84CE37ABE743"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 300,
            ["NodeTag"] = "DB9A11ED405E4C588A9D84CE37ABE743",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 486,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "2189AA30A15B47C2A5F6C5745A8CFEE7",
}