return {
    ["links"] = {
        ["5E4BC7FB6E824CD8A4A650FB65AD0237"] = {
            [1] = "EFBCCBE0C79C41E3AC2F2F769A0ED8A7",
        },
        ["2A7369BF4AD244BCAB7B9D411C66511C"] = {
            [1] = "D71DEE67158D4554ACC48C22549365AF",
        },
        ["D71DEE67158D4554ACC48C22549365AF"] = {
            [1] = "5E4BC7FB6E824CD8A4A650FB65AD0237",
        },
    },
    ["nodes"] = {
        ["EFBCCBE0C79C41E3AC2F2F769A0ED8A7"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 1023,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "EFBCCBE0C79C41E3AC2F2F769A0ED8A7",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5E4BC7FB6E824CD8A4A650FB65AD0237"] = {
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 705,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5E4BC7FB6E824CD8A4A650FB65AD0237",
            ["Duration"] = 300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2A7369BF4AD244BCAB7B9D411C66511C"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "2A7369BF4AD244BCAB7B9D411C66511C",
            ["ID"] = "10020903",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["D71DEE67158D4554ACC48C22549365AF"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 300,
            ["NodeTag"] = "D71DEE67158D4554ACC48C22549365AF",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 287,
                ["x"] = 445,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "2A7369BF4AD244BCAB7B9D411C66511C",
}