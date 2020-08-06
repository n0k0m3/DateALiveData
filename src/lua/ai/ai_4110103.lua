return {
    ["links"] = {
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "1921519CC4D24B659484D94C53989989",
            [2] = "05961F8AB4FC4634B60F637805B8B38F",
        },
        ["776E112CFC4B4C718832100332515749"] = {
            [1] = "44A6F5E824934C9FA8066184235B024B",
        },
        ["9714ABE6543D47CE8835BB3F303E2B34"] = {
            [1] = "070DFECD0A07416D8FDE10E29D2DD6A4",
            [2] = "5177B25E827942D08BE6E65C4BAEBA0E",
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            [1] = "BBB24DCBF0424F7C9A647A7350678CDA",
        },
        ["1921519CC4D24B659484D94C53989989"] = {
            [1] = "776E112CFC4B4C718832100332515749",
            [2] = "73D6D571BC2A4FAA832877BB5A563B46",
        },
        ["73D6D571BC2A4FAA832877BB5A563B46"] = {
            [1] = "44A6F5E824934C9FA8066184235B024B",
        },
        ["44A6F5E824934C9FA8066184235B024B"] = {
            [1] = "187FB7B80D5D473A94E446FED4A7C949",
        },
        ["070DFECD0A07416D8FDE10E29D2DD6A4"] = {
            [1] = "6C17139D367A4CE99009EEF04C7A1FFB",
        },
        ["BBB24DCBF0424F7C9A647A7350678CDA"] = {
            [1] = "9714ABE6543D47CE8835BB3F303E2B34",
        },
    },
    ["nodes"] = {
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI\
",
            ["Pos"] = {
                ["y"] = -81,
                ["x"] = 229,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4110103",
            ["Name"] = "11号小熊跟随",
            ["Static"] = true,
        },
        ["187FB7B80D5D473A94E446FED4A7C949"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 246,
                ["x"] = 1388,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "187FB7B80D5D473A94E446FED4A7C949",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["776E112CFC4B4C718832100332515749"] = {
            ["Pos"] = {
                ["y"] = 256,
                ["x"] = 853,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "776E112CFC4B4C718832100332515749",
            ["Duration"] = 2000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6C17139D367A4CE99009EEF04C7A1FFB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 43,
                ["x"] = 1596,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C17139D367A4CE99009EEF04C7A1FFB",
            ["ID"] = 346004,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5177B25E827942D08BE6E65C4BAEBA0E"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 80,
            ["NodeTag"] = "5177B25E827942D08BE6E65C4BAEBA0E",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -200,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 41102,
            ["Pos"] = {
                ["y"] = -249,
                ["x"] = 1514,
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
        ["9714ABE6543D47CE8835BB3F303E2B34"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = -71,
                ["x"] = 1132,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "9714ABE6543D47CE8835BB3F303E2B34",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["44A6F5E824934C9FA8066184235B024B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 197,
                ["x"] = 1145,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "44A6F5E824934C9FA8066184235B024B",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["1921519CC4D24B659484D94C53989989"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "1921519CC4D24B659484D94C53989989",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 11,
                ["x"] = 503,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["73D6D571BC2A4FAA832877BB5A563B46"] = {
            ["Pos"] = {
                ["y"] = 120,
                ["x"] = 849,
            },
            ["EnemyNum"] = 0,
            ["Class"] = "ConditionMonsterAliveNode",
            ["NodeTag"] = "73D6D571BC2A4FAA832877BB5A563B46",
            ["Operator"] = 1,
            ["Static"] = false,
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "05961F8AB4FC4634B60F637805B8B38F",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -281,
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
        ["070DFECD0A07416D8FDE10E29D2DD6A4"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 50,
            ["Weight"] = 20,
            ["NodeTag"] = "070DFECD0A07416D8FDE10E29D2DD6A4",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -200,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 95,
                ["x"] = 1373,
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
        ["BBB24DCBF0424F7C9A647A7350678CDA"] = {
            ["Pos"] = {
                ["y"] = -134,
                ["x"] = 700,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BBB24DCBF0424F7C9A647A7350678CDA",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}