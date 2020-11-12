return {
    ["links"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            [1] = "3D68E89C2D2F47649E81F6A034540927",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "102207E20A0E489490C0C511B9A0AC0C",
        },
        ["102207E20A0E489490C0C511B9A0AC0C"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["87A80F21AB044E178650F0BFA869B994"] = {
            [1] = "585517229D9344808AC42B1C400677C0",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [2] = "87A80F21AB044E178650F0BFA869B994",
        },
    },
    ["nodes"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            ["Pos"] = {
                ["y"] = 685,
                ["x"] = 583,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "585517229D9344808AC42B1C400677C0",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "普攻\
",
            ["Duration"] = 1000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = 291,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["102207E20A0E489490C0C511B9A0AC0C"] = {
            ["Pos"] = {
                ["y"] = 399,
                ["x"] = 541,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "102207E20A0E489490C0C511B9A0AC0C",
            ["RangeY"] = {
                [1] = 0,
                [2] = 50,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["87A80F21AB044E178650F0BFA869B994"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 1000,
            ["NodeTag"] = "87A80F21AB044E178650F0BFA869B994",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 668,
                ["x"] = 257,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3D68E89C2D2F47649E81F6A034540927"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 100,
            ["Weight"] = 0,
            ["NodeTag"] = "3D68E89C2D2F47649E81F6A034540927",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -250,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 677,
                ["x"] = 903,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 500,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 388,
                ["x"] = 824,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            ["Desc"] = "--\
",
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = -54,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
            ["ID"] = "624117",
            ["Name"] = "或守鞠奈复制人AI",
            ["Static"] = true,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "替身消失\
",
            ["Pos"] = {
                ["y"] = 392,
                ["x"] = 1109,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 700300,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}