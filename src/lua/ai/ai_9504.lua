return {
    ["links"] = {
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            [1] = "48659897274D4A6B9611C41C86074A76",
        },
        ["48659897274D4A6B9611C41C86074A76"] = {
            [1] = "2B74484E4E984999B081C8CEE945B94B",
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            [1] = "2D2DE306659945C38744538E401E2A43",
        },
        ["2B74484E4E984999B081C8CEE945B94B"] = {
            [1] = "8A50D5DC423445079FC0DFB9DBF864F9",
        },
        ["2D2DE306659945C38744538E401E2A43"] = {
            [1] = "8ECA0CCCFC074426929DE1048442CAF3",
        },
    },
    ["nodes"] = {
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6E7A693C05A646FAB593AF25DBAF7047",
            ["ID"] = "9504",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["48659897274D4A6B9611C41C86074A76"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "48659897274D4A6B9611C41C86074A76",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 350,
                ["x"] = 449,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["8ECA0CCCFC074426929DE1048442CAF3"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 327,
                ["x"] = 1373,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "8ECA0CCCFC074426929DE1048442CAF3",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 328,
                ["x"] = 1013,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "8A50D5DC423445079FC0DFB9DBF864F9",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2B74484E4E984999B081C8CEE945B94B"] = {
            ["Pos"] = {
                ["y"] = 356,
                ["x"] = 677,
            },
            ["Class"] = "ConditionRangeHaveEnemyNode",
            ["NodeTag"] = "2B74484E4E984999B081C8CEE945B94B",
            ["RangeOrigin"] = {
                ["y"] = -20,
                ["x"] = -20,
            },
            ["RangeSize"] = {
                ["height"] = 40,
                ["width"] = 40,
            },
            ["Static"] = false,
        },
        ["2D2DE306659945C38744538E401E2A43"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 326,
                ["x"] = 1196,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2D2DE306659945C38744538E401E2A43",
            ["ID"] = 311110,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "6E7A693C05A646FAB593AF25DBAF7047",
}