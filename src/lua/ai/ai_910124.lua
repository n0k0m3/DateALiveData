return {
    ["links"] = {
        ["E3D176A52BDD4A9B96D7169DF6B5B4FD"] = {
            [1] = "F7730506A3C44641B93AABEC5563E749",
        },
        ["F7730506A3C44641B93AABEC5563E749"] = {
            [1] = "DDCE05F7674B404EA75369C0C2581C75",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "E3D176A52BDD4A9B96D7169DF6B5B4FD",
        },
        ["DDCE05F7674B404EA75369C0C2581C75"] = {
            [1] = "F7730506A3C44641B93AABEC5563E749",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
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
        ["F7730506A3C44641B93AABEC5563E749"] = {
            ["Desc"] = "移动到指定位置",
            ["Weight"] = 0,
            ["NodeTag"] = "F7730506A3C44641B93AABEC5563E749",
            ["MoveSpeedScale"] = 150,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 138,
                ["x"] = 1368,
            },
            ["Class"] = "MoveToBevNode",
            ["MoveSite"] = 7,
            ["MovePos"] = {
                ["y"] = 0,
                ["x"] = 0,
            },
            ["Type"] = 7,
            ["MovePosWay"] = 1,
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
        ["DDCE05F7674B404EA75369C0C2581C75"] = {
            ["Desc"] = "移动到指定位置",
            ["Weight"] = 0,
            ["NodeTag"] = "DDCE05F7674B404EA75369C0C2581C75",
            ["MoveSpeedScale"] = 150,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 318,
                ["x"] = 1358,
            },
            ["Class"] = "MoveToBevNode",
            ["MoveSite"] = 8,
            ["MovePos"] = {
                ["y"] = 0,
                ["x"] = 0,
            },
            ["Type"] = 7,
            ["MovePosWay"] = 1,
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 320,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
            ["ID"] = "910124",
            ["Name"] = "社团f3快速",
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
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}