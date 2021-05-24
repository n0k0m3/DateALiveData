return {
    ["links"] = {
        ["7355ED3B5DDE475EBCE8B25C87519C47"] = {
            [1] = "755436FC5DEE40609604FADA65AFE095",
        },
        ["3DA5893D9E9045AC8202357FC499E5C7"] = {
            [1] = "0B4B845196404D4BB2E9AF423378E83A",
        },
        ["04F95FDE060243F9A4945BB63CD228FB"] = {
            [1] = "DD78AF5ACE564F7384569CB169F896B3",
        },
        ["D152F01A803D4F7A9B1D00EE5A07BEF8"] = {
            [1] = "3DA5893D9E9045AC8202357FC499E5C7",
        },
        ["755436FC5DEE40609604FADA65AFE095"] = {
            [1] = "04F95FDE060243F9A4945BB63CD228FB",
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            [1] = "7355ED3B5DDE475EBCE8B25C87519C47",
            [2] = "D152F01A803D4F7A9B1D00EE5A07BEF8",
        },
        ["0B4B845196404D4BB2E9AF423378E83A"] = {
            [1] = "9D0C66006DD94F0C8D4BE4F10D4C1BE8",
            [2] = "27197C65D555413CAF66B850B7AFB63D",
            [3] = "4756F7B6B8144FCAB1B9155C06FA4962",
        },
    },
    ["nodes"] = {
        ["0B4B845196404D4BB2E9AF423378E83A"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 475,
                ["x"] = 774,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "0B4B845196404D4BB2E9AF423378E83A",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["9D0C66006DD94F0C8D4BE4F10D4C1BE8"] = {
            ["Desc"] = "普攻\
",
            ["Pos"] = {
                ["y"] = 403,
                ["x"] = 967,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9D0C66006DD94F0C8D4BE4F10D4C1BE8",
            ["ID"] = 100310,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4756F7B6B8144FCAB1B9155C06FA4962"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 578,
                ["x"] = 968,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4756F7B6B8144FCAB1B9155C06FA4962",
            ["ID"] = 100370,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3DA5893D9E9045AC8202357FC499E5C7"] = {
            ["Pos"] = {
                ["y"] = 481,
                ["x"] = 499,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "3DA5893D9E9045AC8202357FC499E5C7",
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
        ["7355ED3B5DDE475EBCE8B25C87519C47"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 500,
            ["NodeTag"] = "7355ED3B5DDE475EBCE8B25C87519C47",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 288,
                ["x"] = 291,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["DD78AF5ACE564F7384569CB169F896B3"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "DD78AF5ACE564F7384569CB169F896B3",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 286,
                ["x"] = 1089,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["EBABFD4C582247658A863C88CB6A5992"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 661,
                ["x"] = 965,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "EBABFD4C582247658A863C88CB6A5992",
            ["ID"] = 100380,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["04F95FDE060243F9A4945BB63CD228FB"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 277,
                ["x"] = 901,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "04F95FDE060243F9A4945BB63CD228FB",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["27197C65D555413CAF66B850B7AFB63D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 480,
                ["x"] = 967,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "27197C65D555413CAF66B850B7AFB63D",
            ["ID"] = 100320,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["755436FC5DEE40609604FADA65AFE095"] = {
            ["Pos"] = {
                ["y"] = 289,
                ["x"] = 663,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "755436FC5DEE40609604FADA65AFE095",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 381,
                ["x"] = -3,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "51B39C60ABC1457DA23F5EC1E94F6217",
            ["ID"] = "999213",
            ["Name"] = "主线12章地狱四系乃",
            ["Static"] = true,
        },
        ["D152F01A803D4F7A9B1D00EE5A07BEF8"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 6000,
            ["NodeTag"] = "D152F01A803D4F7A9B1D00EE5A07BEF8",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 481,
                ["x"] = 267,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "51B39C60ABC1457DA23F5EC1E94F6217",
}