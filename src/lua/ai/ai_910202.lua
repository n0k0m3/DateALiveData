return {
    ["links"] = {
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "230B4B24561D4D87B66ED31837B369EF",
        },
        ["20FC0AC2F87D4FE79DB6C99B1B464136"] = {
            [1] = "B491D1F35CFA4304866F17A38F7DE71B",
        },
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            [1] = "20FC0AC2F87D4FE79DB6C99B1B464136",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["B491D1F35CFA4304866F17A38F7DE71B"] = {
            [1] = "9F185C4160584FE4AF6DC3EC46D7847B",
        },
    },
    ["nodes"] = {
        ["9F185C4160584FE4AF6DC3EC46D7847B"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 297,
                ["x"] = 1655,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "9F185C4160584FE4AF6DC3EC46D7847B",
            ["Type"] = 0,
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
        ["20FC0AC2F87D4FE79DB6C99B1B464136"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 1232,
            },
            ["Weight"] = 0,
            ["Class"] = "SwitchModelBevNode",
            ["NodeTag"] = "20FC0AC2F87D4FE79DB6C99B1B464136",
            ["ModelIndex"] = 5,
            ["Type"] = 0,
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
            ["ID"] = "910202",
            ["Name"] = "社团f26s",
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
        ["B491D1F35CFA4304866F17A38F7DE71B"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 1448,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "B491D1F35CFA4304866F17A38F7DE71B",
            ["DelayTime"] = 6000,
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}