return {
    ["links"] = {
        ["3BCBC59AE9C44418914BE60524BBA260"] = {
            [1] = "1F0DE82972D6431888CFAC2518ACF048",
        },
        ["BC207E080E6943D6B3448ED432363D7C"] = {
            [1] = "3BCBC59AE9C44418914BE60524BBA260",
        },
        ["CA0B2F8897DD44AF994650BD83881E3F"] = {
            [1] = "BC207E080E6943D6B3448ED432363D7C",
        },
    },
    ["nodes"] = {
        ["3BCBC59AE9C44418914BE60524BBA260"] = {
            ["Pos"] = {
                ["y"] = 320,
                ["x"] = 779,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "3BCBC59AE9C44418914BE60524BBA260",
            ["Duration"] = 1800,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BC207E080E6943D6B3448ED432363D7C"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1800,
            ["NodeTag"] = "BC207E080E6943D6B3448ED432363D7C",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 309,
                ["x"] = 519,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["CA0B2F8897DD44AF994650BD83881E3F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "CA0B2F8897DD44AF994650BD83881E3F",
            ["ID"] = "1012060008",
            ["Name"] = "wave7-2",
            ["Static"] = true,
        },
        ["1F0DE82972D6431888CFAC2518ACF048"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 313,
                ["x"] = 1153,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1F0DE82972D6431888CFAC2518ACF048",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "CA0B2F8897DD44AF994650BD83881E3F",
}