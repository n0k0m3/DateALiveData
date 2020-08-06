return {
    ["links"] = {
        ["E5DD0CF0CF884A12AE46E85E0C22AAFA"] = {
            [1] = "002EEF5AF159477CB0B2870177CE4770",
        },
        ["66B0C19E3348464597E5F3A159DFAABD"] = {
            [1] = "7AA2861535354A52805151B166DE7F6A",
        },
        ["7AA2861535354A52805151B166DE7F6A"] = {
            [1] = "E5DD0CF0CF884A12AE46E85E0C22AAFA",
        },
    },
    ["nodes"] = {
        ["E5DD0CF0CF884A12AE46E85E0C22AAFA"] = {
            ["Pos"] = {
                ["y"] = 316,
                ["x"] = 749,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "E5DD0CF0CF884A12AE46E85E0C22AAFA",
            ["Duration"] = 2000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["66B0C19E3348464597E5F3A159DFAABD"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 237,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "66B0C19E3348464597E5F3A159DFAABD",
            ["ID"] = "5004005",
            ["Name"] = "wave5",
            ["Static"] = true,
        },
        ["002EEF5AF159477CB0B2870177CE4770"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 294,
                ["x"] = 1092,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "002EEF5AF159477CB0B2870177CE4770",
            ["ID"] = 2001013,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["7AA2861535354A52805151B166DE7F6A"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2000,
            ["NodeTag"] = "7AA2861535354A52805151B166DE7F6A",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 474,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "66B0C19E3348464597E5F3A159DFAABD",
}