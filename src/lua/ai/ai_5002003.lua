return {
    ["links"] = {
        ["CD5EE96FC76548F98AA5E93C6C046FC0"] = {
            [1] = "C419E1B3AD4E4082AB114C20D5A0483C",
        },
        ["C419E1B3AD4E4082AB114C20D5A0483C"] = {
            [1] = "22E5BC8E70E84394A7C732FE140A3F8D",
        },
        ["9B7E379CFCE64F59ADEC6F5B5DB8DA87"] = {
            [1] = "CD5EE96FC76548F98AA5E93C6C046FC0",
        },
    },
    ["nodes"] = {
        ["CD5EE96FC76548F98AA5E93C6C046FC0"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 800,
            ["NodeTag"] = "CD5EE96FC76548F98AA5E93C6C046FC0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 353,
                ["x"] = 489,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["22E5BC8E70E84394A7C732FE140A3F8D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 1092,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "22E5BC8E70E84394A7C732FE140A3F8D",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C419E1B3AD4E4082AB114C20D5A0483C"] = {
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 779,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C419E1B3AD4E4082AB114C20D5A0483C",
            ["Duration"] = 800,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9B7E379CFCE64F59ADEC6F5B5DB8DA87"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 235,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "9B7E379CFCE64F59ADEC6F5B5DB8DA87",
            ["ID"] = "5002003",
            ["Name"] = "wave3",
            ["Static"] = true,
        },
    },
    ["root"] = "9B7E379CFCE64F59ADEC6F5B5DB8DA87",
}