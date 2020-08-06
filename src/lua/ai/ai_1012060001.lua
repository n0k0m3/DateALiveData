return {
    ["links"] = {
        ["4F4FFC8E6B4D40F4A33155DD1B9DD1F6"] = {
            [1] = "8F6273BC9F2348F9A1EC92B04CDF6FE6",
        },
        ["139B767FCE5B40D8B5531FC5A277E6B5"] = {
            [1] = "4F4FFC8E6B4D40F4A33155DD1B9DD1F6",
            [2] = "2BD01AE532CE435D8279BC0A46EB95CF",
        },
        ["4BF4083EE7574B77A37305AB95E0295E"] = {
            [1] = "BC4050E6CA984BD1AFA2A0B442378EEA",
        },
        ["8F6273BC9F2348F9A1EC92B04CDF6FE6"] = {
            [1] = "10FDE3C1B6EC4AE8870F51ED7EADE338",
        },
        ["2BD01AE532CE435D8279BC0A46EB95CF"] = {
            [1] = "4BF4083EE7574B77A37305AB95E0295E",
        },
    },
    ["nodes"] = {
        ["4F4FFC8E6B4D40F4A33155DD1B9DD1F6"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 470,
            ["NodeTag"] = "4F4FFC8E6B4D40F4A33155DD1B9DD1F6",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 346,
                ["x"] = 420,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["139B767FCE5B40D8B5531FC5A277E6B5"] = {
            ["Desc"] = "1-6飞行关卡的第1波怪物",
            ["Pos"] = {
                ["y"] = 345,
                ["x"] = 179,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "139B767FCE5B40D8B5531FC5A277E6B5",
            ["ID"] = "1012060001",
            ["Name"] = "wave1",
            ["Static"] = true,
        },
        ["4BF4083EE7574B77A37305AB95E0295E"] = {
            ["Pos"] = {
                ["y"] = 522,
                ["x"] = 711,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4BF4083EE7574B77A37305AB95E0295E",
            ["Duration"] = 2900,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2BD01AE532CE435D8279BC0A46EB95CF"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2900,
            ["NodeTag"] = "2BD01AE532CE435D8279BC0A46EB95CF",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 525,
                ["x"] = 423,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["BC4050E6CA984BD1AFA2A0B442378EEA"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 514,
                ["x"] = 1018,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "BC4050E6CA984BD1AFA2A0B442378EEA",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8F6273BC9F2348F9A1EC92B04CDF6FE6"] = {
            ["Pos"] = {
                ["y"] = 352,
                ["x"] = 697,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "8F6273BC9F2348F9A1EC92B04CDF6FE6",
            ["Duration"] = 470,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["10FDE3C1B6EC4AE8870F51ED7EADE338"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 344,
                ["x"] = 1015,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "10FDE3C1B6EC4AE8870F51ED7EADE338",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "139B767FCE5B40D8B5531FC5A277E6B5",
}