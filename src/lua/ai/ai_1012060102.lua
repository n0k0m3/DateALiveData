return {
    ["links"] = {
        ["B8E8E89AFBA04DA3BBD4CE08DD9FE257"] = {
            [1] = "A26D3F4752BC4A328F590C4DAFFD24E2",
        },
        ["94F3E4A3942D44929150BDBE8951EBDF"] = {
            [1] = "8D6DBE7CC4174BC39FDD387989598ACB",
        },
        ["8D6DBE7CC4174BC39FDD387989598ACB"] = {
            [1] = "B8E8E89AFBA04DA3BBD4CE08DD9FE257",
        },
    },
    ["nodes"] = {
        ["A26D3F4752BC4A328F590C4DAFFD24E2"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 1067,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "A26D3F4752BC4A328F590C4DAFFD24E2",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["94F3E4A3942D44929150BDBE8951EBDF"] = {
            ["Desc"] = "新的 wave2",
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 252,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "94F3E4A3942D44929150BDBE8951EBDF",
            ["ID"] = "1012060102",
            ["Name"] = "新的 wave2",
            ["Static"] = true,
        },
        ["B8E8E89AFBA04DA3BBD4CE08DD9FE257"] = {
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 770,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B8E8E89AFBA04DA3BBD4CE08DD9FE257",
            ["Duration"] = 200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8D6DBE7CC4174BC39FDD387989598ACB"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 200,
            ["NodeTag"] = "8D6DBE7CC4174BC39FDD387989598ACB",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 485,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "94F3E4A3942D44929150BDBE8951EBDF",
}