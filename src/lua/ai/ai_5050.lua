return {
    ["links"] = {
        ["680E6DC8257E473DB90EA0307304DA80"] = {
            [1] = "CBFF0844ABCA4F0DAC39D960ED0D2DC9",
        },
        ["15AA0B0D620E48C4AA6EB28686B7653C"] = {
            [1] = "680E6DC8257E473DB90EA0307304DA80",
        },
        ["CBFF0844ABCA4F0DAC39D960ED0D2DC9"] = {
            [1] = "2B4B13088B3443DEA05AD9108E8B7D97",
        },
        ["2B4B13088B3443DEA05AD9108E8B7D97"] = {
            [1] = "175BABF476954364914533BBBDA52CCD",
        },
    },
    ["nodes"] = {
        ["CBFF0844ABCA4F0DAC39D960ED0D2DC9"] = {
            ["Pos"] = {
                ["y"] = 339,
                ["x"] = 596,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "CBFF0844ABCA4F0DAC39D960ED0D2DC9",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["680E6DC8257E473DB90EA0307304DA80"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "680E6DC8257E473DB90EA0307304DA80",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 299,
                ["x"] = 377,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
        },
        ["15AA0B0D620E48C4AA6EB28686B7653C"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 8,
            ["Class"] = "RootNode",
            ["NodeTag"] = "15AA0B0D620E48C4AA6EB28686B7653C",
            ["ID"] = "5050",
            ["Name"] = "糖果AI",
            ["Static"] = true,
        },
        ["175BABF476954364914533BBBDA52CCD"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 333,
                ["x"] = 1026,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "175BABF476954364914533BBBDA52CCD",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2B4B13088B3443DEA05AD9108E8B7D97"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 337,
                ["x"] = 847,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "2B4B13088B3443DEA05AD9108E8B7D97",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "15AA0B0D620E48C4AA6EB28686B7653C",
}