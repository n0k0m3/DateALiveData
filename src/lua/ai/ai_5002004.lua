return {
    ["links"] = {
        ["789A9265362049488B86D286BC3463A1"] = {
            [1] = "51088BBE9CE64527807C8FFF1D6AF7AF",
        },
        ["D091604392E343C0B6F3CF31F838DC85"] = {
            [1] = "9589B630991E4B95A7BEC7DB54845925",
        },
        ["51088BBE9CE64527807C8FFF1D6AF7AF"] = {
            [1] = "D091604392E343C0B6F3CF31F838DC85",
        },
    },
    ["nodes"] = {
        ["789A9265362049488B86D286BC3463A1"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 293,
                ["x"] = 244,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "789A9265362049488B86D286BC3463A1",
            ["ID"] = "5002004",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["51088BBE9CE64527807C8FFF1D6AF7AF"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 200,
            ["NodeTag"] = "51088BBE9CE64527807C8FFF1D6AF7AF",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 482,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["D091604392E343C0B6F3CF31F838DC85"] = {
            ["Pos"] = {
                ["y"] = 320,
                ["x"] = 783,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "D091604392E343C0B6F3CF31F838DC85",
            ["Duration"] = 200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9589B630991E4B95A7BEC7DB54845925"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 312,
                ["x"] = 1064,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9589B630991E4B95A7BEC7DB54845925",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "789A9265362049488B86D286BC3463A1",
}