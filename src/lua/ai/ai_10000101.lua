return {
    ["links"] = {
        ["0C13AE8A8A3C487D988F5D5BDFD119E1"] = {
            [1] = "0EC921C31D59414CA4627C9B8990ED7C",
        },
        ["9B0CDC14316F4A7F8565702488E480EA"] = {
            [1] = "0C13AE8A8A3C487D988F5D5BDFD119E1",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "B4045A8FF0724111A27EE1480AC39F72",
            [2] = "9B0CDC14316F4A7F8565702488E480EA",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "CA7A516B64234CB0A5AC328DDD1A1123",
        },
    },
    ["nodes"] = {
        ["0C13AE8A8A3C487D988F5D5BDFD119E1"] = {
            ["Pos"] = {
                ["y"] = 437,
                ["x"] = 833,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "0C13AE8A8A3C487D988F5D5BDFD119E1",
            ["Duration"] = 2050,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 828,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "8565FCC068944377AD1FE7ED7AD14D97",
            ["Duration"] = 550,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0EC921C31D59414CA4627C9B8990ED7C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 439,
                ["x"] = 1118,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "0EC921C31D59414CA4627C9B8990ED7C",
            ["ID"] = 2001017,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9B0CDC14316F4A7F8565702488E480EA"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2050,
            ["NodeTag"] = "9B0CDC14316F4A7F8565702488E480EA",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 437,
                ["x"] = 542,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 320,
            },
            ["Category"] = 10,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
            ["ID"] = "10000101",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 550,
            ["NodeTag"] = "B4045A8FF0724111A27EE1480AC39F72",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 556,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["CA7A516B64234CB0A5AC328DDD1A1123"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 1119,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "CA7A516B64234CB0A5AC328DDD1A1123",
            ["ID"] = 2001017,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}