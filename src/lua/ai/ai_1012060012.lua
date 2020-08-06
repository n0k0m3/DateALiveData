return {
    ["links"] = {
        ["7C4BD22934AF4C748962375764961C9A"] = {
            [1] = "199F92DEDAAC4141AF579320A05ECEF6",
        },
        ["199F92DEDAAC4141AF579320A05ECEF6"] = {
            [1] = "58677AA687934EB589EBE119683F2A32",
        },
        ["343C93D6656D4C44A3ABB591809766D1"] = {
            [1] = "7C4BD22934AF4C748962375764961C9A",
        },
    },
    ["nodes"] = {
        ["58677AA687934EB589EBE119683F2A32"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 1151,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "58677AA687934EB589EBE119683F2A32",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["7C4BD22934AF4C748962375764961C9A"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 200,
            ["NodeTag"] = "7C4BD22934AF4C748962375764961C9A",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 292,
                ["x"] = 515,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["199F92DEDAAC4141AF579320A05ECEF6"] = {
            ["Pos"] = {
                ["y"] = 310,
                ["x"] = 796,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "199F92DEDAAC4141AF579320A05ECEF6",
            ["Duration"] = 200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["343C93D6656D4C44A3ABB591809766D1"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "343C93D6656D4C44A3ABB591809766D1",
            ["ID"] = "1012060012",
            ["Name"] = "wave9",
            ["Static"] = true,
        },
    },
    ["root"] = "343C93D6656D4C44A3ABB591809766D1",
}