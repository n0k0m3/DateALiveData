return {
    ["links"] = {
        ["93D18127B7B44CFD9CAA8922E98C2AE8"] = {
            [1] = "3296E46145E948A9BF4DB4A676D40488",
        },
        ["3296E46145E948A9BF4DB4A676D40488"] = {
            [1] = "A30D69AE673D402DBF39A4D855781CDC",
        },
        ["65870C9D9B4D49A7B446EC5093F0EB70"] = {
            [1] = "93D18127B7B44CFD9CAA8922E98C2AE8",
        },
    },
    ["nodes"] = {
        ["93D18127B7B44CFD9CAA8922E98C2AE8"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 50,
            ["NodeTag"] = "93D18127B7B44CFD9CAA8922E98C2AE8",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 419,
                ["x"] = 506,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["A30D69AE673D402DBF39A4D855781CDC"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 416,
                ["x"] = 1130,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "A30D69AE673D402DBF39A4D855781CDC",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3296E46145E948A9BF4DB4A676D40488"] = {
            ["Pos"] = {
                ["y"] = 422,
                ["x"] = 782,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "3296E46145E948A9BF4DB4A676D40488",
            ["Duration"] = 50,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["65870C9D9B4D49A7B446EC5093F0EB70"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 422,
                ["x"] = 252,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "65870C9D9B4D49A7B446EC5093F0EB70",
            ["ID"] = "1012060002",
            ["Name"] = "wave2",
            ["Static"] = true,
        },
    },
    ["root"] = "65870C9D9B4D49A7B446EC5093F0EB70",
}