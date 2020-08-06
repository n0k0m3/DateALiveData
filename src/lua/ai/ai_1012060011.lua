return {
    ["links"] = {
        ["A428D206672B4043B68224E08F486EF5"] = {
            [1] = "83C374EB384047A0AED6F4C882487E64",
        },
        ["E8DBA3291AF34F46A45A308632949BAE"] = {
            [1] = "33EF3FBDCFAB4AEF8101CA428139A204",
            [2] = "A428D206672B4043B68224E08F486EF5",
        },
        ["33EF3FBDCFAB4AEF8101CA428139A204"] = {
            [1] = "85812869E563457CA16E80EC1A3B1DA6",
        },
        ["85812869E563457CA16E80EC1A3B1DA6"] = {
            [1] = "583EB6706C97430F902B0EADF7069209",
        },
        ["83C374EB384047A0AED6F4C882487E64"] = {
            [1] = "AF1B7448BBB8479095369EED6A0931AC",
        },
    },
    ["nodes"] = {
        ["A428D206672B4043B68224E08F486EF5"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 4400,
            ["NodeTag"] = "A428D206672B4043B68224E08F486EF5",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 499,
                ["x"] = 588,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["E8DBA3291AF34F46A45A308632949BAE"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "E8DBA3291AF34F46A45A308632949BAE",
            ["ID"] = "1012060011",
            ["Name"] = "wave8-3",
            ["Static"] = true,
        },
        ["33EF3FBDCFAB4AEF8101CA428139A204"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1100,
            ["NodeTag"] = "33EF3FBDCFAB4AEF8101CA428139A204",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 584,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["85812869E563457CA16E80EC1A3B1DA6"] = {
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 897,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "85812869E563457CA16E80EC1A3B1DA6",
            ["Duration"] = 1100,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["AF1B7448BBB8479095369EED6A0931AC"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 518,
                ["x"] = 1221,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "AF1B7448BBB8479095369EED6A0931AC",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["583EB6706C97430F902B0EADF7069209"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 1210,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "583EB6706C97430F902B0EADF7069209",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["83C374EB384047A0AED6F4C882487E64"] = {
            ["Pos"] = {
                ["y"] = 523,
                ["x"] = 928,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "83C374EB384047A0AED6F4C882487E64",
            ["Duration"] = 4400,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "E8DBA3291AF34F46A45A308632949BAE",
}