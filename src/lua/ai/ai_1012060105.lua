return {
    ["links"] = {
        ["35EB7DBB886845F6AD82BDB41E30B250"] = {
            [1] = "2BA9CEABD72745B690C48DA9AA1A1386",
        },
        ["8D068FF2F8364EAF9E605BC5F9573895"] = {
            [1] = "3D57751A95A641388AFE155E5E82357C",
        },
        ["3D57751A95A641388AFE155E5E82357C"] = {
            [1] = "35EB7DBB886845F6AD82BDB41E30B250",
        },
    },
    ["nodes"] = {
        ["2BA9CEABD72745B690C48DA9AA1A1386"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 311,
                ["x"] = 1116,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2BA9CEABD72745B690C48DA9AA1A1386",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["35EB7DBB886845F6AD82BDB41E30B250"] = {
            ["Pos"] = {
                ["y"] = 315,
                ["x"] = 816,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "35EB7DBB886845F6AD82BDB41E30B250",
            ["Duration"] = 400,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8D068FF2F8364EAF9E605BC5F9573895"] = {
            ["Desc"] = "新的 wave5",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "8D068FF2F8364EAF9E605BC5F9573895",
            ["ID"] = "1012060105",
            ["Name"] = "新的 wave5",
            ["Static"] = true,
        },
        ["3D57751A95A641388AFE155E5E82357C"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 400,
            ["NodeTag"] = "3D57751A95A641388AFE155E5E82357C",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 515,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "8D068FF2F8364EAF9E605BC5F9573895",
}