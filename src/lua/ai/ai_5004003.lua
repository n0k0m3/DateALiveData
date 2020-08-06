return {
    ["links"] = {
        ["1F67056776B44F1599C45FA31B28147E"] = {
            [1] = "A5BD19935F0947B5A6477E832D265BA5",
        },
        ["A5BD19935F0947B5A6477E832D265BA5"] = {
            [1] = "D9AE29E44A3A4DCAA73382830C9F23DC",
        },
        ["BCDDA14DCD8F4FC387BB70172146F716"] = {
            [1] = "1F67056776B44F1599C45FA31B28147E",
        },
    },
    ["nodes"] = {
        ["1F67056776B44F1599C45FA31B28147E"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 100,
            ["NodeTag"] = "1F67056776B44F1599C45FA31B28147E",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 508,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["A5BD19935F0947B5A6477E832D265BA5"] = {
            ["Pos"] = {
                ["y"] = 310,
                ["x"] = 788,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "A5BD19935F0947B5A6477E832D265BA5",
            ["Duration"] = 100,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BCDDA14DCD8F4FC387BB70172146F716"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BCDDA14DCD8F4FC387BB70172146F716",
            ["ID"] = "5004003",
            ["Name"] = "wave3",
            ["Static"] = true,
        },
        ["D9AE29E44A3A4DCAA73382830C9F23DC"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 1095,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "D9AE29E44A3A4DCAA73382830C9F23DC",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BCDDA14DCD8F4FC387BB70172146F716",
}