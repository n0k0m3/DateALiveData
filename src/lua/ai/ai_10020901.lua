return {
    ["links"] = {
        ["356F26EF8C7F456B9092277CC6587676"] = {
            [1] = "5F616D06B6D44093B71809A38D4D1D92",
        },
        ["3E923AE5DCDF4795951487068FBAF870"] = {
            [1] = "356F26EF8C7F456B9092277CC6587676",
        },
        ["372A37C00DDD44A094342A500935CC50"] = {
            [1] = "97B0EC0FB9D842D6AC89671C9EC19559",
        },
        ["C8A25464590641138174C3866AEDC7F0"] = {
            [1] = "5000509DD367409C8E9A866CBDEBD2DD",
            [2] = "3E923AE5DCDF4795951487068FBAF870",
        },
        ["5000509DD367409C8E9A866CBDEBD2DD"] = {
            [1] = "372A37C00DDD44A094342A500935CC50",
        },
    },
    ["nodes"] = {
        ["356F26EF8C7F456B9092277CC6587676"] = {
            ["Pos"] = {
                ["y"] = 459,
                ["x"] = 768,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "356F26EF8C7F456B9092277CC6587676",
            ["Duration"] = 1200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3E923AE5DCDF4795951487068FBAF870"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1200,
            ["NodeTag"] = "3E923AE5DCDF4795951487068FBAF870",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 454,
                ["x"] = 469,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["372A37C00DDD44A094342A500935CC50"] = {
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 771,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "372A37C00DDD44A094342A500935CC50",
            ["Duration"] = 300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C8A25464590641138174C3866AEDC7F0"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 235,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "C8A25464590641138174C3866AEDC7F0",
            ["ID"] = "10020901",
            ["Name"] = "关卡2-9",
            ["Static"] = true,
        },
        ["5F616D06B6D44093B71809A38D4D1D92"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 459,
                ["x"] = 1093,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5F616D06B6D44093B71809A38D4D1D92",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["97B0EC0FB9D842D6AC89671C9EC19559"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 291,
                ["x"] = 1091,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "97B0EC0FB9D842D6AC89671C9EC19559",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5000509DD367409C8E9A866CBDEBD2DD"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 300,
            ["NodeTag"] = "5000509DD367409C8E9A866CBDEBD2DD",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 483,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "C8A25464590641138174C3866AEDC7F0",
}