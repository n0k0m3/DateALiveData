return {
    ["links"] = {
        ["2B3C9B886F2C4105A89C9210833E7C20"] = {
            [1] = "DCC3A77931DC451DA3A37E08EF35A62E",
        },
        ["34295B136F8E40A182E83D9FB5F7259E"] = {
            [1] = "D154CF02C42B4A51B469CD56BA984D6C",
        },
        ["56AE7045F6784AFC9C6A979F0534BD0C"] = {
            [1] = "34295B136F8E40A182E83D9FB5F7259E",
        },
        ["9BCA1470E2A34A5B95C3FE2DF002E614"] = {
            [1] = "56AE7045F6784AFC9C6A979F0534BD0C",
            [2] = "5ED2BBE7B4C8437D90EEEAB582C5BB1F",
        },
        ["5ED2BBE7B4C8437D90EEEAB582C5BB1F"] = {
            [1] = "2B3C9B886F2C4105A89C9210833E7C20",
        },
    },
    ["nodes"] = {
        ["DCC3A77931DC451DA3A37E08EF35A62E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 526,
                ["x"] = 1074,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "DCC3A77931DC451DA3A37E08EF35A62E",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9BCA1470E2A34A5B95C3FE2DF002E614"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 336,
                ["x"] = 141,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "9BCA1470E2A34A5B95C3FE2DF002E614",
            ["ID"] = "5001001",
            ["Name"] = "日常飞行-Level1",
            ["Static"] = true,
        },
        ["34295B136F8E40A182E83D9FB5F7259E"] = {
            ["Pos"] = {
                ["y"] = 340,
                ["x"] = 724,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "34295B136F8E40A182E83D9FB5F7259E",
            ["Duration"] = 1850,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["56AE7045F6784AFC9C6A979F0534BD0C"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1850,
            ["NodeTag"] = "56AE7045F6784AFC9C6A979F0534BD0C",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 338,
                ["x"] = 404,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["D154CF02C42B4A51B469CD56BA984D6C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 324,
                ["x"] = 1074,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "D154CF02C42B4A51B469CD56BA984D6C",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2B3C9B886F2C4105A89C9210833E7C20"] = {
            ["Pos"] = {
                ["y"] = 524,
                ["x"] = 724,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "2B3C9B886F2C4105A89C9210833E7C20",
            ["Duration"] = 3300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5ED2BBE7B4C8437D90EEEAB582C5BB1F"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3300,
            ["NodeTag"] = "5ED2BBE7B4C8437D90EEEAB582C5BB1F",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 517,
                ["x"] = 403,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "9BCA1470E2A34A5B95C3FE2DF002E614",
}