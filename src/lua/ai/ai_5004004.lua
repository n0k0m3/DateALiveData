return {
    ["links"] = {
        ["01816D874C414725A63AE4279862B184"] = {
            [1] = "5BBEDFC3CD7D4001A174CCE56B089674",
        },
        ["EB37F236DD414A33A451B3F7D90F850C"] = {
            [1] = "6B06683252304691BDD3E2AD35B80ABB",
        },
        ["5BBEDFC3CD7D4001A174CCE56B089674"] = {
            [1] = "EB37F236DD414A33A451B3F7D90F850C",
        },
    },
    ["nodes"] = {
        ["EB37F236DD414A33A451B3F7D90F850C"] = {
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 844,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EB37F236DD414A33A451B3F7D90F850C",
            ["Duration"] = 40,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["01816D874C414725A63AE4279862B184"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "01816D874C414725A63AE4279862B184",
            ["ID"] = "5004004",
            ["Name"] = "wave4",
            ["Static"] = true,
        },
        ["6B06683252304691BDD3E2AD35B80ABB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 279,
                ["x"] = 1174,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6B06683252304691BDD3E2AD35B80ABB",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5BBEDFC3CD7D4001A174CCE56B089674"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 40,
            ["NodeTag"] = "5BBEDFC3CD7D4001A174CCE56B089674",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 540,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "01816D874C414725A63AE4279862B184",
}