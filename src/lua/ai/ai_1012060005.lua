return {
    ["links"] = {
        ["63B64DD381674A5D924F4D463374738E"] = {
            [1] = "C12143AF5875433BBBDA7B3269420C8A",
            [2] = "7CDFCE0803AB40B097BF01A3A7D66936",
        },
        ["E28324AC67A34E35970DAA75F2B15E9C"] = {
            [1] = "95832723990B487EADA9A36DF1E281E4",
        },
        ["DFC959F1B6FD46209343F03AEB9ACDD1"] = {
            [1] = "197C93899A314EB4ABD65501F906B138",
        },
        ["C12143AF5875433BBBDA7B3269420C8A"] = {
            [1] = "E28324AC67A34E35970DAA75F2B15E9C",
        },
        ["7CDFCE0803AB40B097BF01A3A7D66936"] = {
            [1] = "DFC959F1B6FD46209343F03AEB9ACDD1",
        },
    },
    ["nodes"] = {
        ["95832723990B487EADA9A36DF1E281E4"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 363,
                ["x"] = 1134,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "95832723990B487EADA9A36DF1E281E4",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["63B64DD381674A5D924F4D463374738E"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 376,
                ["x"] = 237,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "63B64DD381674A5D924F4D463374738E",
            ["ID"] = "1012060005",
            ["Name"] = "wave5",
            ["Static"] = true,
        },
        ["E28324AC67A34E35970DAA75F2B15E9C"] = {
            ["Pos"] = {
                ["y"] = 378,
                ["x"] = 786,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "E28324AC67A34E35970DAA75F2B15E9C",
            ["Duration"] = 1000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["DFC959F1B6FD46209343F03AEB9ACDD1"] = {
            ["Pos"] = {
                ["y"] = 555,
                ["x"] = 773,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "DFC959F1B6FD46209343F03AEB9ACDD1",
            ["Duration"] = 3000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C12143AF5875433BBBDA7B3269420C8A"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "C12143AF5875433BBBDA7B3269420C8A",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 378,
                ["x"] = 474,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["7CDFCE0803AB40B097BF01A3A7D66936"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3000,
            ["NodeTag"] = "7CDFCE0803AB40B097BF01A3A7D66936",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 551,
                ["x"] = 481,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["197C93899A314EB4ABD65501F906B138"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 555,
                ["x"] = 1127,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "197C93899A314EB4ABD65501F906B138",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "63B64DD381674A5D924F4D463374738E",
}