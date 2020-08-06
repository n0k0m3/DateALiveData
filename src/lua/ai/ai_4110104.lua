return {
    ["links"] = {
        ["3530398D13AD46728BE36A4DDD6F2940"] = {
            [1] = "3FC8120261D04B1B9C12F1D9658E5A09",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "05961F8AB4FC4634B60F637805B8B38F",
            [2] = "A92F80CBFFA44F46BB3F3055E79B6E33",
        },
        ["1AF483BFB30B4833A419095439544B69"] = {
            [1] = "64F610FD3A9F446B869755A0B4E679FF",
        },
        ["3FC8120261D04B1B9C12F1D9658E5A09"] = {
            [1] = "3E75834AC5D747D983F15580A6BB0533",
        },
        ["A92F80CBFFA44F46BB3F3055E79B6E33"] = {
            [1] = "AFF122DBA5CC4EB98433DC8D7D7A7B97",
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            [1] = "C0492BF7103F4D7CB948C51D9661FD52",
        },
        ["AFF122DBA5CC4EB98433DC8D7D7A7B97"] = {
            [1] = "3530398D13AD46728BE36A4DDD6F2940",
        },
        ["64F610FD3A9F446B869755A0B4E679FF"] = {
            [1] = "1FDB454C8EDB461F91A32A5971A28707",
        },
        ["C0492BF7103F4D7CB948C51D9661FD52"] = {
            [1] = "1AF483BFB30B4833A419095439544B69",
        },
    },
    ["nodes"] = {
        ["1FDB454C8EDB461F91A32A5971A28707"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -476,
                ["x"] = 1460,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1FDB454C8EDB461F91A32A5971A28707",
            ["ID"] = 346001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3530398D13AD46728BE36A4DDD6F2940"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -45,
                ["x"] = 1062,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "3530398D13AD46728BE36A4DDD6F2940",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI\
",
            ["Pos"] = {
                ["y"] = -198,
                ["x"] = 248,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4110104",
            ["Name"] = "11号熊",
            ["Static"] = true,
        },
        ["1AF483BFB30B4833A419095439544B69"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -465,
                ["x"] = 1017,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1AF483BFB30B4833A419095439544B69",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C0492BF7103F4D7CB948C51D9661FD52"] = {
            ["Pos"] = {
                ["y"] = -456,
                ["x"] = 772,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C0492BF7103F4D7CB948C51D9661FD52",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A92F80CBFFA44F46BB3F3055E79B6E33"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "A92F80CBFFA44F46BB3F3055E79B6E33",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -9,
                ["x"] = 429,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "05961F8AB4FC4634B60F637805B8B38F",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -421,
                ["x"] = 496,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3E75834AC5D747D983F15580A6BB0533"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -25,
                ["x"] = 1449,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3E75834AC5D747D983F15580A6BB0533",
            ["ID"] = 346002,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3FC8120261D04B1B9C12F1D9658E5A09"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 0,
            ["NodeTag"] = "3FC8120261D04B1B9C12F1D9658E5A09",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -200,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = -124,
                ["x"] = 1268,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 400,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["64F610FD3A9F446B869755A0B4E679FF"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 0,
            ["NodeTag"] = "64F610FD3A9F446B869755A0B4E679FF",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -200,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = -344,
                ["x"] = 1252,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 400,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["AFF122DBA5CC4EB98433DC8D7D7A7B97"] = {
            ["Pos"] = {
                ["y"] = 5,
                ["x"] = 704,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "AFF122DBA5CC4EB98433DC8D7D7A7B97",
            ["Duration"] = 3000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}