return {
    ["links"] = {
        ["5EA605DB905247269165F6D3605E1BD4"] = {
            [1] = "18B3518185994E13A60F348C4D480D37",
        },
        ["6655F2EE25EA445784D4AB4C0D309B68"] = {
            [1] = "BE4E7B7F2AD140348E58A9B0B5629881",
        },
        ["BE4E7B7F2AD140348E58A9B0B5629881"] = {
            [1] = "30790421248C4D0EA5D37A547FB6E5C3",
            [2] = "56221ECA5EE441668881906DA99F769E",
        },
        ["18B3518185994E13A60F348C4D480D37"] = {
            [1] = "6655F2EE25EA445784D4AB4C0D309B68",
        },
    },
    ["nodes"] = {
        ["5EA605DB905247269165F6D3605E1BD4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5EA605DB905247269165F6D3605E1BD4",
            ["ID"] = "40602",
            ["Name"] = "6号BOSS技能白球与黑球",
            ["Static"] = true,
        },
        ["30790421248C4D0EA5D37A547FB6E5C3"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 176,
                ["x"] = 1158,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "30790421248C4D0EA5D37A547FB6E5C3",
            ["ID"] = 343241,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BE4E7B7F2AD140348E58A9B0B5629881"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 252,
                ["x"] = 980,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "BE4E7B7F2AD140348E58A9B0B5629881",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6655F2EE25EA445784D4AB4C0D309B68"] = {
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 738,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "6655F2EE25EA445784D4AB4C0D309B68",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["56221ECA5EE441668881906DA99F769E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 316,
                ["x"] = 1157,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "56221ECA5EE441668881906DA99F769E",
            ["ID"] = 343251,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["18B3518185994E13A60F348C4D480D37"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "18B3518185994E13A60F348C4D480D37",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 393,
                ["x"] = 494,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
        },
    },
    ["root"] = "5EA605DB905247269165F6D3605E1BD4",
}