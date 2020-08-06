return {
    ["links"] = {
        ["13BEA192C2C94FB9B86E3E971D530CAD"] = {
            [1] = "F2E95DC55096418C9FE8EAD4428CFA48",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "C9EDCA1A0E974EA581E97282DB9C1653",
        },
        ["F2E95DC55096418C9FE8EAD4428CFA48"] = {
            [1] = "4DB407406B2D4068A11EA2A11F6E31CB",
        },
        ["C9EDCA1A0E974EA581E97282DB9C1653"] = {
            [1] = "D1BBB2B1C18E4F67BB05A5D9BC013F54",
        },
        ["D1BBB2B1C18E4F67BB05A5D9BC013F54"] = {
            [1] = "13BEA192C2C94FB9B86E3E971D530CAD",
        },
    },
    ["nodes"] = {
        ["13BEA192C2C94FB9B86E3E971D530CAD"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 510,
                ["x"] = 1316,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "13BEA192C2C94FB9B86E3E971D530CAD",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["D1BBB2B1C18E4F67BB05A5D9BC013F54"] = {
            ["Pos"] = {
                ["y"] = 686,
                ["x"] = 968,
            },
            ["Judge"] = 3,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "D1BBB2B1C18E4F67BB05A5D9BC013F54",
            ["Value"] = 0,
            ["Key"] = "chuifeng",
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI\
",
            ["Pos"] = {
                ["y"] = 405,
                ["x"] = 417,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4110109",
            ["Name"] = "11号BOSS电网怪",
            ["Static"] = true,
        },
        ["F2E95DC55096418C9FE8EAD4428CFA48"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 684,
                ["x"] = 1439,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "F2E95DC55096418C9FE8EAD4428CFA48",
            ["DelayTime"] = 5000,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4DB407406B2D4068A11EA2A11F6E31CB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 517,
                ["x"] = 1604,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4DB407406B2D4068A11EA2A11F6E31CB",
            ["ID"] = 345906,
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
        ["63DF5E9E55BD40A4A3A28CC888E4CF08"] = {
            ["Pos"] = {
                ["y"] = 542,
                ["x"] = 970,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "63DF5E9E55BD40A4A3A28CC888E4CF08",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}