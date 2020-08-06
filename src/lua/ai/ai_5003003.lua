return {
    ["links"] = {
        ["DD59328E042F410FAA118BA3BF25A95D"] = {
            [1] = "A8372B3C7D3C43FFB89ED583574473BE",
        },
        ["A8372B3C7D3C43FFB89ED583574473BE"] = {
            [1] = "F8E8C20F6F3D467BB190BCB6CF0BA174",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "DD59328E042F410FAA118BA3BF25A95D",
        },
    },
    ["nodes"] = {
        ["DD59328E042F410FAA118BA3BF25A95D"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 600,
            ["NodeTag"] = "DD59328E042F410FAA118BA3BF25A95D",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 321,
                ["x"] = 446,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["A8372B3C7D3C43FFB89ED583574473BE"] = {
            ["Pos"] = {
                ["y"] = 328,
                ["x"] = 784,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "A8372B3C7D3C43FFB89ED583574473BE",
            ["Duration"] = 600,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F8E8C20F6F3D467BB190BCB6CF0BA174"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 315,
                ["x"] = 1097,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "F8E8C20F6F3D467BB190BCB6CF0BA174",
            ["ID"] = 2001010,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 319,
                ["x"] = 226,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "5003003",
            ["Name"] = "wave3",
            ["Static"] = true,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}