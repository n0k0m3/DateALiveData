return {
    ["links"] = {
        ["D0233C31361B4C1FB1CB60A158877F68"] = {
            [1] = "58F94BFCEC7E4ECFAD04EF47A75DCAC1",
        },
        ["58F94BFCEC7E4ECFAD04EF47A75DCAC1"] = {
            [1] = "0413533D33304DD681E7E3B36D8CE7D3",
        },
        ["0413533D33304DD681E7E3B36D8CE7D3"] = {
            [1] = "8CBCDCA20CE64B9C832EFC840D06CF24",
        },
    },
    ["nodes"] = {
        ["D0233C31361B4C1FB1CB60A158877F68"] = {
            ["Desc"] = "新的 wave6",
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 240,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "D0233C31361B4C1FB1CB60A158877F68",
            ["ID"] = "1012060106",
            ["Name"] = "新的 wave6",
            ["Static"] = true,
        },
        ["8CBCDCA20CE64B9C832EFC840D06CF24"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 1068,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8CBCDCA20CE64B9C832EFC840D06CF24",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["58F94BFCEC7E4ECFAD04EF47A75DCAC1"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1300,
            ["NodeTag"] = "58F94BFCEC7E4ECFAD04EF47A75DCAC1",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 484,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["0413533D33304DD681E7E3B36D8CE7D3"] = {
            ["Pos"] = {
                ["y"] = 321,
                ["x"] = 761,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "0413533D33304DD681E7E3B36D8CE7D3",
            ["Duration"] = 1300,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "D0233C31361B4C1FB1CB60A158877F68",
}