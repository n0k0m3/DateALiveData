return {
    ["links"] = {
        ["957C54F966BC4B70B165DC744CFBDF2A"] = {
            [1] = "9476480134DF40DB8867E96447A77D5A",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "AC8700FE36B44E25A7789973C3A9E3E9",
        },
        ["AC8700FE36B44E25A7789973C3A9E3E9"] = {
            [1] = "957C54F966BC4B70B165DC744CFBDF2A",
        },
    },
    ["nodes"] = {
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 292,
                ["x"] = 269,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "5004001",
            ["Name"] = "日常飞行-4",
            ["Static"] = true,
        },
        ["957C54F966BC4B70B165DC744CFBDF2A"] = {
            ["Pos"] = {
                ["y"] = 295,
                ["x"] = 788,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "957C54F966BC4B70B165DC744CFBDF2A",
            ["Duration"] = 1500,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9476480134DF40DB8867E96447A77D5A"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 279,
                ["x"] = 1125,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9476480134DF40DB8867E96447A77D5A",
            ["ID"] = 2001008,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["AC8700FE36B44E25A7789973C3A9E3E9"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1500,
            ["NodeTag"] = "AC8700FE36B44E25A7789973C3A9E3E9",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 292,
                ["x"] = 502,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}