return {
    ["links"] = {
        ["8E947BE3D1BA4AEB9CBDF9D5A1D2D502"] = {
            [1] = "EC1C524D9B0D43F6887848264FF10F9E",
            [2] = "CDF8F82B83AF4B29928C38B5FD397ABF",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "8E947BE3D1BA4AEB9CBDF9D5A1D2D502",
        },
    },
    ["nodes"] = {
        ["8E947BE3D1BA4AEB9CBDF9D5A1D2D502"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 1049,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "8E947BE3D1BA4AEB9CBDF9D5A1D2D502",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["EC1C524D9B0D43F6887848264FF10F9E"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 700,
            ["Weight"] = 10,
            ["NodeTag"] = "EC1C524D9B0D43F6887848264FF10F9E",
            ["RangeOrigin"] = {
                ["y"] = -3000,
                ["x"] = -3000,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 84,
                ["x"] = 1255,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 6000,
                ["width"] = 6000,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["CDF8F82B83AF4B29928C38B5FD397ABF"] = {
            ["Desc"] = "行为",
            ["Weight"] = 10,
            ["NodeTag"] = "CDF8F82B83AF4B29928C38B5FD397ABF",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 221,
                ["x"] = 1263,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
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
            ["ID"] = "910201",
            ["Name"] = "社团4到处跑的AI",
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
            ["Loop"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
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
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}