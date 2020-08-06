return {
    ["links"] = {
        ["715C5B6790404CA284AFC9EB30A37368"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "715C5B6790404CA284AFC9EB30A37368",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
        },
    },
    ["nodes"] = {
        ["715C5B6790404CA284AFC9EB30A37368"] = {
            ["Pos"] = {
                ["y"] = 415,
                ["x"] = 682,
            },
            ["Class"] = "ConditionRangeHaveEnemyNode",
            ["NodeTag"] = "715C5B6790404CA284AFC9EB30A37368",
            ["RangeOrigin"] = {
                ["y"] = 0,
                ["x"] = 0,
            },
            ["RangeSize"] = {
                ["height"] = 20,
                ["width"] = 50,
            },
            ["Static"] = false,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "施放技能释放技能",
            ["Pos"] = {
                ["y"] = 417,
                ["x"] = 1035,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 200531,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            ["Desc"] = "--\
",
            ["Pos"] = {
                ["y"] = 425,
                ["x"] = 195,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
            ["ID"] = "10002",
            ["Name"] = "自爆地雷的AI",
            ["Static"] = true,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 402,
                ["x"] = 396,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 999,
            ["Priority"] = 10,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}