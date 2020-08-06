return {
    ["links"] = {
        ["13B1B3A74A914F9E953B6372550F67E2"] = {
            [1] = "E795DC69AB8843B1AA0BDD23855EFFA2",
        },
        ["3B908F2AEFE84FC8972D41054477EFD3"] = {
            [1] = "13B1B3A74A914F9E953B6372550F67E2",
        },
        ["6F6AEFE63AF54BE9986633CA6C981132"] = {
            [1] = "CD39630A826041BCBCCCBBD575F16EE7",
        },
        ["E795DC69AB8843B1AA0BDD23855EFFA2"] = {
            [1] = "6F6AEFE63AF54BE9986633CA6C981132",
        },
    },
    ["nodes"] = {
        ["13B1B3A74A914F9E953B6372550F67E2"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 5000,
            ["NodeTag"] = "13B1B3A74A914F9E953B6372550F67E2",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 267,
                ["x"] = 352,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
        },
        ["3B908F2AEFE84FC8972D41054477EFD3"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 221,
            },
            ["Category"] = 8,
            ["Class"] = "RootNode",
            ["NodeTag"] = "3B908F2AEFE84FC8972D41054477EFD3",
            ["ID"] = "5040",
            ["Name"] = "南瓜炸弹",
            ["Static"] = true,
        },
        ["CD39630A826041BCBCCCBBD575F16EE7"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 1046,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "CD39630A826041BCBCCCBBD575F16EE7",
            ["ID"] = 280341,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["E795DC69AB8843B1AA0BDD23855EFFA2"] = {
            ["Pos"] = {
                ["y"] = 392,
                ["x"] = 586,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "E795DC69AB8843B1AA0BDD23855EFFA2",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6F6AEFE63AF54BE9986633CA6C981132"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 257,
                ["x"] = 827,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "6F6AEFE63AF54BE9986633CA6C981132",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "3B908F2AEFE84FC8972D41054477EFD3",
}