return {
    ["links"] = {
        ["E3D176A52BDD4A9B96D7169DF6B5B4FD"] = {
            [1] = "1F0C37E4D1884E2CA3E8D0DFD7205553",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "E3D176A52BDD4A9B96D7169DF6B5B4FD",
        },
    },
    ["nodes"] = {
        ["E3D176A52BDD4A9B96D7169DF6B5B4FD"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 978,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E3D176A52BDD4A9B96D7169DF6B5B4FD",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            ["Pos"] = {
                ["y"] = 312,
                ["x"] = 707,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "8565FCC068944377AD1FE7ED7AD14D97",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 264,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
            ["ID"] = "910122",
            ["Name"] = "社团f3_掉落BUFF怪物",
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
                ["y"] = 304,
                ["x"] = 481,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["1F0C37E4D1884E2CA3E8D0DFD7205553"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 1190,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "1F0C37E4D1884E2CA3E8D0DFD7205553",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}