return {
    ["links"] = {
        ["1A68719179614D639D6B772D2099FA78"] = {
            [1] = "66756AE550AA45519A15D5A9E178DAD5",
        },
        ["DD54AD29410B468DA811FBBFB70B1F55"] = {
            [1] = "BC7D0F4AD81A40AFB02EABC3C5E24919",
        },
        ["BC7D0F4AD81A40AFB02EABC3C5E24919"] = {
            [1] = "1A68719179614D639D6B772D2099FA78",
        },
    },
    ["nodes"] = {
        ["66756AE550AA45519A15D5A9E178DAD5"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 289,
                ["x"] = 1115,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "66756AE550AA45519A15D5A9E178DAD5",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1A68719179614D639D6B772D2099FA78"] = {
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 797,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "1A68719179614D639D6B772D2099FA78",
            ["Duration"] = 700,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["DD54AD29410B468DA811FBBFB70B1F55"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "DD54AD29410B468DA811FBBFB70B1F55",
            ["ID"] = "5002001",
            ["Name"] = "日常飞行-2",
            ["Static"] = true,
        },
        ["BC7D0F4AD81A40AFB02EABC3C5E24919"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 600,
            ["NodeTag"] = "BC7D0F4AD81A40AFB02EABC3C5E24919",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 309,
                ["x"] = 489,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "DD54AD29410B468DA811FBBFB70B1F55",
}