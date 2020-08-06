return {
    ["links"] = {
        ["633F23D69F754BAF90F26DC53696239B"] = {
            [1] = "8C03E3388DDD44288B21143B7FCD4AB0",
        },
        ["7E0170703ED94A0BBA6C04BBF9CB5EE3"] = {
            [1] = "5177B25E827942D08BE6E65C4BAEBA0E",
            [2] = "6C17139D367A4CE99009EEF04C7A1FFB",
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            [1] = "BBB24DCBF0424F7C9A647A7350678CDA",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "93832F12E77C41409799F4DF19663CDE",
            [2] = "05961F8AB4FC4634B60F637805B8B38F",
        },
        ["8C03E3388DDD44288B21143B7FCD4AB0"] = {
            [1] = "75E5FFCCDA2F42F4B0FEAAB678862496",
        },
        ["7138849B5FD543D0A773C89822742CF6"] = {
            [1] = "8C03E3388DDD44288B21143B7FCD4AB0",
        },
        ["93832F12E77C41409799F4DF19663CDE"] = {
            [1] = "7138849B5FD543D0A773C89822742CF6",
            [2] = "633F23D69F754BAF90F26DC53696239B",
        },
        ["BBB24DCBF0424F7C9A647A7350678CDA"] = {
            [1] = "7E0170703ED94A0BBA6C04BBF9CB5EE3",
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
            ["ID"] = "4110105",
            ["Name"] = "11号小狐狸跟随",
            ["Static"] = true,
        },
        ["633F23D69F754BAF90F26DC53696239B"] = {
            ["Pos"] = {
                ["y"] = 82,
                ["x"] = 840,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "633F23D69F754BAF90F26DC53696239B",
            ["Duration"] = 2000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6C17139D367A4CE99009EEF04C7A1FFB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 143,
                ["x"] = 1389,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C17139D367A4CE99009EEF04C7A1FFB",
            ["ID"] = 346304,
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
                ["y"] = -94,
                ["x"] = 1410,
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
        ["7E0170703ED94A0BBA6C04BBF9CB5EE3"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 2,
                ["x"] = 1138,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "7E0170703ED94A0BBA6C04BBF9CB5EE3",
            ["Type"] = 0,
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
                ["y"] = -47,
                ["x"] = 504,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["8C03E3388DDD44288B21143B7FCD4AB0"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 214,
                ["x"] = 1088,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "8C03E3388DDD44288B21143B7FCD4AB0",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["75E5FFCCDA2F42F4B0FEAAB678862496"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 1322,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "75E5FFCCDA2F42F4B0FEAAB678862496",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["7138849B5FD543D0A773C89822742CF6"] = {
            ["Pos"] = {
                ["y"] = 204,
                ["x"] = 810,
            },
            ["EnemyNum"] = 0,
            ["Class"] = "ConditionMonsterAliveNode",
            ["NodeTag"] = "7138849B5FD543D0A773C89822742CF6",
            ["Operator"] = 1,
            ["Static"] = false,
        },
        ["BBB24DCBF0424F7C9A647A7350678CDA"] = {
            ["Pos"] = {
                ["y"] = -90,
                ["x"] = 817,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BBB24DCBF0424F7C9A647A7350678CDA",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["93832F12E77C41409799F4DF19663CDE"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "93832F12E77C41409799F4DF19663CDE",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 128,
                ["x"] = 497,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}