return {
    ["links"] = {
        ["256E7D68215F45FFA6925144A7FADCCE"] = {
            [1] = "8747303AFC9D41B4B53648E1F5AA1A94",
        },
        ["55EC253D3E3440F8BBDDFECBEFB53677"] = {
            [1] = "313D4C0ABFAB4FA2A4D65BC4402BB594",
        },
        ["313D4C0ABFAB4FA2A4D65BC4402BB594"] = {
            [1] = "F5053A7862E945DDB2F3DAD438A33F70",
        },
        ["95634F3B8DB746279C55C0C4111288A9"] = {
            [1] = "1E11EDDA9E534651ABC49F599AA5A68D",
            [2] = "55EC253D3E3440F8BBDDFECBEFB53677",
        },
        ["1E11EDDA9E534651ABC49F599AA5A68D"] = {
            [1] = "256E7D68215F45FFA6925144A7FADCCE",
        },
    },
    ["nodes"] = {
        ["256E7D68215F45FFA6925144A7FADCCE"] = {
            ["Pos"] = {
                ["y"] = 376,
                ["x"] = 804,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "256E7D68215F45FFA6925144A7FADCCE",
            ["Duration"] = 1000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["55EC253D3E3440F8BBDDFECBEFB53677"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 2300,
            ["NodeTag"] = "55EC253D3E3440F8BBDDFECBEFB53677",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 535,
                ["x"] = 441,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["1E11EDDA9E534651ABC49F599AA5A68D"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "1E11EDDA9E534651ABC49F599AA5A68D",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 371,
                ["x"] = 441,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["8747303AFC9D41B4B53648E1F5AA1A94"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 1127,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8747303AFC9D41B4B53648E1F5AA1A94",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["95634F3B8DB746279C55C0C4111288A9"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 371,
                ["x"] = 161,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "95634F3B8DB746279C55C0C4111288A9",
            ["ID"] = "5001002",
            ["Name"] = "wave2",
            ["Static"] = true,
        },
        ["F5053A7862E945DDB2F3DAD438A33F70"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 545,
                ["x"] = 1137,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "F5053A7862E945DDB2F3DAD438A33F70",
            ["ID"] = 2001005,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["313D4C0ABFAB4FA2A4D65BC4402BB594"] = {
            ["Pos"] = {
                ["y"] = 548,
                ["x"] = 805,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "313D4C0ABFAB4FA2A4D65BC4402BB594",
            ["Duration"] = 2300,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "95634F3B8DB746279C55C0C4111288A9",
}