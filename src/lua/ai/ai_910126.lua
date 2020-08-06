return {
    ["links"] = {
        ["AA4D1B51635B493D8483C39BA6581827"] = {
            [1] = "6DB5468447794E20ADEF2B818279541D",
        },
        ["C1B164F74E354A56BD5353D709E6F90D"] = {
            [1] = "AA4D1B51635B493D8483C39BA6581827",
        },
        ["6DB5468447794E20ADEF2B818279541D"] = {
            [1] = "6F26E821DCF343AC9F16D974A740952B",
        },
        ["2B656919F6F2404EB78199B1B4BC7082"] = {
            [1] = "C1B164F74E354A56BD5353D709E6F90D",
        },
    },
    ["nodes"] = {
        ["AA4D1B51635B493D8483C39BA6581827"] = {
            ["Pos"] = {
                ["y"] = 309,
                ["x"] = 648,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "AA4D1B51635B493D8483C39BA6581827",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6DB5468447794E20ADEF2B818279541D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 889,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "6DB5468447794E20ADEF2B818279541D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C1B164F74E354A56BD5353D709E6F90D"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3000,
            ["NodeTag"] = "C1B164F74E354A56BD5353D709E6F90D",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 424,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["6F26E821DCF343AC9F16D974A740952B"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 1070,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6F26E821DCF343AC9F16D974A740952B",
            ["ID"] = 600161,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2B656919F6F2404EB78199B1B4BC7082"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "2B656919F6F2404EB78199B1B4BC7082",
            ["ID"] = "910126",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
    },
    ["root"] = "2B656919F6F2404EB78199B1B4BC7082",
}