return {
    ["links"] = {
        ["28E4A693193C4A7AB594C881F5DB2F2C"] = {
            [1] = "B28246B6C55042B2BC35611664822855",
        },
        ["3C7BBF69AF1344DC981728BCBDF9038A"] = {
            [1] = "77D9D7C035EA4954954DA317E2C9A70C",
        },
        ["F076003A71904B3B8F271A3D737EF7A0"] = {
            [1] = "3C7BBF69AF1344DC981728BCBDF9038A",
        },
        ["B28246B6C55042B2BC35611664822855"] = {
            [1] = "52EDC0A746A8452FB6DAE88ADF8C1DB4",
        },
        ["35A8BFEEB97E4F43AB7C48ABF0050F9B"] = {
            [1] = "F076003A71904B3B8F271A3D737EF7A0",
            [2] = "28E4A693193C4A7AB594C881F5DB2F2C",
        },
    },
    ["nodes"] = {
        ["28E4A693193C4A7AB594C881F5DB2F2C"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3800,
            ["NodeTag"] = "28E4A693193C4A7AB594C881F5DB2F2C",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 452,
                ["x"] = 546,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["3C7BBF69AF1344DC981728BCBDF9038A"] = {
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 823,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "3C7BBF69AF1344DC981728BCBDF9038A",
            ["Duration"] = 1700,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F076003A71904B3B8F271A3D737EF7A0"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1700,
            ["NodeTag"] = "F076003A71904B3B8F271A3D737EF7A0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 298,
                ["x"] = 537,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["35A8BFEEB97E4F43AB7C48ABF0050F9B"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "35A8BFEEB97E4F43AB7C48ABF0050F9B",
            ["ID"] = "1012060007",
            ["Name"] = "wave7-1",
            ["Static"] = true,
        },
        ["77D9D7C035EA4954954DA317E2C9A70C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 291,
                ["x"] = 1139,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "77D9D7C035EA4954954DA317E2C9A70C",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["B28246B6C55042B2BC35611664822855"] = {
            ["Pos"] = {
                ["y"] = 478,
                ["x"] = 817,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "B28246B6C55042B2BC35611664822855",
            ["Duration"] = 3800,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["52EDC0A746A8452FB6DAE88ADF8C1DB4"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 481,
                ["x"] = 1167,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "52EDC0A746A8452FB6DAE88ADF8C1DB4",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "35A8BFEEB97E4F43AB7C48ABF0050F9B",
}