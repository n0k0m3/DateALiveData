return {
    ["links"] = {
        ["13BEA192C2C94FB9B86E3E971D530CAD"] = {
            [1] = "4DB407406B2D4068A11EA2A11F6E31CB",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "C9EDCA1A0E974EA581E97282DB9C1653",
        },
        ["4DB407406B2D4068A11EA2A11F6E31CB"] = {
            [1] = "E6741488FF5F4DD394B95A2B368265BE",
        },
        ["C9EDCA1A0E974EA581E97282DB9C1653"] = {
            [1] = "6CD961E1E219493E86DE8709CA778D5A",
        },
        ["6CD961E1E219493E86DE8709CA778D5A"] = {
            [1] = "13BEA192C2C94FB9B86E3E971D530CAD",
        },
    },
    ["nodes"] = {
        ["13BEA192C2C94FB9B86E3E971D530CAD"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 528,
                ["x"] = 1284,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "13BEA192C2C94FB9B86E3E971D530CAD",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6CD961E1E219493E86DE8709CA778D5A"] = {
            ["Pos"] = {
                ["y"] = 729,
                ["x"] = 940,
            },
            ["Judge"] = 3,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "6CD961E1E219493E86DE8709CA778D5A",
            ["Value"] = 0,
            ["Key"] = "chuifeng",
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI\
",
            ["Pos"] = {
                ["y"] = 469,
                ["x"] = 410,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4110108",
            ["Name"] = "11号BOSS吹风怪",
            ["Static"] = true,
        },
        ["4DD64642EDF5473E96DF75E4F4AA0A2C"] = {
            ["Pos"] = {
                ["y"] = 332,
                ["x"] = 956,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4DD64642EDF5473E96DF75E4F4AA0A2C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4DB407406B2D4068A11EA2A11F6E31CB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 341,
                ["x"] = 1427,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4DB407406B2D4068A11EA2A11F6E31CB",
            ["ID"] = 345907,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C9EDCA1A0E974EA581E97282DB9C1653"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "C9EDCA1A0E974EA581E97282DB9C1653",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 561,
                ["x"] = 673,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["E6741488FF5F4DD394B95A2B368265BE"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "E6741488FF5F4DD394B95A2B368265BE",
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 699,
                ["x"] = 1562,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "stand",
            ["Type"] = 0,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}