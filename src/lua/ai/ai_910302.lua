return {
    ["links"] = {
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            [1] = "ED0879D1FDF747649A4D955BE628E45A",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "230B4B24561D4D87B66ED31837B369EF",
        },
    },
    ["nodes"] = {
        ["ED0879D1FDF747649A4D955BE628E45A"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 1289,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "ED0879D1FDF747649A4D955BE628E45A",
            ["ID"] = 600110,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            ["Pos"] = {
                ["y"] = 311,
                ["x"] = 790,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "8565FCC068944377AD1FE7ED7AD14D97",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 1047,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "230B4B24561D4D87B66ED31837B369EF",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 320,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
            ["ID"] = "910302",
            ["Name"] = "社团火焰",
            ["Static"] = true,
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "B4045A8FF0724111A27EE1480AC39F72",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 556,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}