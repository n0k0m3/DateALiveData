return {
    ["links"] = {
        ["F5C2B3BDE0DE41258520927339291DFB"] = {
            [1] = "8F531E6468A446F0945D07166873195A",
        },
        ["64F01CE72C9940B3923C6C1FED62F8E6"] = {
            [1] = "8C1BCD1D0D03425F94BFE1CC86930162",
        },
        ["8C1BCD1D0D03425F94BFE1CC86930162"] = {
            [1] = "F5C2B3BDE0DE41258520927339291DFB",
        },
    },
    ["nodes"] = {
        ["8F531E6468A446F0945D07166873195A"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 292,
                ["x"] = 996,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8F531E6468A446F0945D07166873195A",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F5C2B3BDE0DE41258520927339291DFB"] = {
            ["Pos"] = {
                ["y"] = 298,
                ["x"] = 718,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F5C2B3BDE0DE41258520927339291DFB",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["64F01CE72C9940B3923C6C1FED62F8E6"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 293,
                ["x"] = 247,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "64F01CE72C9940B3923C6C1FED62F8E6",
            ["ID"] = "800001",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["8C1BCD1D0D03425F94BFE1CC86930162"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "8C1BCD1D0D03425F94BFE1CC86930162",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 294,
                ["x"] = 426,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
        },
    },
    ["root"] = "64F01CE72C9940B3923C6C1FED62F8E6",
}