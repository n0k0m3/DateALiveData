return {
    ["links"] = {
        ["4430EF603B594082884727EA2162C692"] = {
            [1] = "731A8E7C74754D719C3D5FE99385B878",
        },
        ["CD71F246D8DD4BB7B42A30BA9A730689"] = {
            [1] = "A2CFAD4DE8A74314BAA0FC666CD73E74",
        },
        ["A2CFAD4DE8A74314BAA0FC666CD73E74"] = {
            [1] = "4430EF603B594082884727EA2162C692",
        },
    },
    ["nodes"] = {
        ["731A8E7C74754D719C3D5FE99385B878"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 1044,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "731A8E7C74754D719C3D5FE99385B878",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4430EF603B594082884727EA2162C692"] = {
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 741,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4430EF603B594082884727EA2162C692",
            ["Duration"] = 100,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["CD71F246D8DD4BB7B42A30BA9A730689"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "CD71F246D8DD4BB7B42A30BA9A730689",
            ["ID"] = "5004006",
            ["Name"] = "wave6",
            ["Static"] = true,
        },
        ["A2CFAD4DE8A74314BAA0FC666CD73E74"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 100,
            ["NodeTag"] = "A2CFAD4DE8A74314BAA0FC666CD73E74",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 456,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "CD71F246D8DD4BB7B42A30BA9A730689",
}