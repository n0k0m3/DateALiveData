return {
    ["links"] = {
        ["936720C9922B49B9826EA40862653BCD"] = {
            [1] = "5E08CFE76CD14EC8BCCB9922BE66C1D3",
        },
        ["2F821D329FD6438683DD6AE4EDBB40EA"] = {
            [1] = "6026DE9C31D44B359C05C8EFBD38AC6E",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "90041C8CB6D04DECAFD24A75D1C3218C",
        },
        ["90041C8CB6D04DECAFD24A75D1C3218C"] = {
            [1] = "E3AE2A9A73354AA68131E38A9AE0E197",
        },
        ["E3AE2A9A73354AA68131E38A9AE0E197"] = {
            [1] = "2F821D329FD6438683DD6AE4EDBB40EA",
        },
        ["5E08CFE76CD14EC8BCCB9922BE66C1D3"] = {
            [1] = "11D5F2B3FA6F41598171FD7C58BEB8A0",
        },
        ["71201A5A3A094152999F1153F50CFB86"] = {
            [1] = "5E08CFE76CD14EC8BCCB9922BE66C1D3",
        },
        ["6026DE9C31D44B359C05C8EFBD38AC6E"] = {
            [1] = "944163AC834546FABFAC4185E0B35EBE",
        },
        ["4EC2AFE61979441DBD4050E842744560"] = {
            [1] = "936720C9922B49B9826EA40862653BCD",
            [2] = "71201A5A3A094152999F1153F50CFB86",
        },
    },
    ["nodes"] = {
        ["936720C9922B49B9826EA40862653BCD"] = {
            ["Pos"] = {
                ["y"] = 260,
                ["x"] = 935,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "936720C9922B49B9826EA40862653BCD",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2F821D329FD6438683DD6AE4EDBB40EA"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -8,
                ["x"] = 1216,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "2F821D329FD6438683DD6AE4EDBB40EA",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI\
",
            ["Pos"] = {
                ["y"] = 162,
                ["x"] = 368,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4120104",
            ["Name"] = "12号BOSS能量舱正常",
            ["Static"] = true,
        },
        ["944163AC834546FABFAC4185E0B35EBE"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -10,
                ["x"] = 1613,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "944163AC834546FABFAC4185E0B35EBE",
            ["Type"] = 0,
            ["IsCount"] = 2,
            ["Static"] = false,
        },
        ["90041C8CB6D04DECAFD24A75D1C3218C"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "90041C8CB6D04DECAFD24A75D1C3218C",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 50,
                ["x"] = 662,
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
        ["E3AE2A9A73354AA68131E38A9AE0E197"] = {
            ["Pos"] = {
                ["y"] = -5,
                ["x"] = 929,
            },
            ["Class"] = "ConditionSelfHPLessNode",
            ["NodeTag"] = "E3AE2A9A73354AA68131E38A9AE0E197",
            ["Percent"] = 1,
            ["Type"] = 4,
            ["Static"] = false,
        },
        ["5E08CFE76CD14EC8BCCB9922BE66C1D3"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 350,
                ["x"] = 1287,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "5E08CFE76CD14EC8BCCB9922BE66C1D3",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["11D5F2B3FA6F41598171FD7C58BEB8A0"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "11D5F2B3FA6F41598171FD7C58BEB8A0",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 347,
                ["x"] = 1541,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["71201A5A3A094152999F1153F50CFB86"] = {
            ["ModelIndex"] = 2,
            ["Pos"] = {
                ["y"] = 455,
                ["x"] = 915,
            },
            ["Class"] = "ConditionModelIndex",
            ["NodeTag"] = "71201A5A3A094152999F1153F50CFB86",
            ["Static"] = false,
        },
        ["6026DE9C31D44B359C05C8EFBD38AC6E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -11,
                ["x"] = 1420,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6026DE9C31D44B359C05C8EFBD38AC6E",
            ["ID"] = 347011,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4EC2AFE61979441DBD4050E842744560"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "4EC2AFE61979441DBD4050E842744560",
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 656,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}