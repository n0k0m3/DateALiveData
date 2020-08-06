return {
    ["links"] = {
        ["494EC6F33FBC48CE990B584B6343E17B"] = {
            [1] = "14E17CC1B75C4EBFBE90551E9166EAD4",
        },
        ["14E17CC1B75C4EBFBE90551E9166EAD4"] = {
            [1] = "5B761782CA3D46FB8C556B5810CC86A0",
        },
        ["5B761782CA3D46FB8C556B5810CC86A0"] = {
            [1] = "76B3AF68A3BC41B5B499AF184393644C",
        },
    },
    ["nodes"] = {
        ["494EC6F33FBC48CE990B584B6343E17B"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 311,
                ["x"] = 235,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "494EC6F33FBC48CE990B584B6343E17B",
            ["ID"] = "5004002",
            ["Name"] = "wave2",
            ["Static"] = true,
        },
        ["14E17CC1B75C4EBFBE90551E9166EAD4"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 50,
            ["NodeTag"] = "14E17CC1B75C4EBFBE90551E9166EAD4",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 486,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["76B3AF68A3BC41B5B499AF184393644C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 322,
                ["x"] = 1082,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "76B3AF68A3BC41B5B499AF184393644C",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5B761782CA3D46FB8C556B5810CC86A0"] = {
            ["Pos"] = {
                ["y"] = 320,
                ["x"] = 781,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5B761782CA3D46FB8C556B5810CC86A0",
            ["Duration"] = 50,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "494EC6F33FBC48CE990B584B6343E17B",
}