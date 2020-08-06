return {
    ["links"] = {
        ["EAB98DD1C8A540AA9CD9A74D76B84088"] = {
            [1] = "D9697856814449B2A5F14EB620A46AB7",
        },
        ["D9697856814449B2A5F14EB620A46AB7"] = {
            [1] = "B366B575E72B46DD970885B7A6547BAD",
        },
        ["F7BDB6C82297498E8071E0420CADFEE4"] = {
            [1] = "21C9852925E84B0DAAE8CE886D6F9308",
        },
        ["90D0268189A2484591A70403BDCF60AE"] = {
            [1] = "5F18BE0F047147C4A8E63D4C582B6380",
            [2] = "613388CABFC149DD8E049E62DC488A52",
        },
        ["5F18BE0F047147C4A8E63D4C582B6380"] = {
            [1] = "EAB98DD1C8A540AA9CD9A74D76B84088",
        },
        ["613388CABFC149DD8E049E62DC488A52"] = {
            [1] = "F7BDB6C82297498E8071E0420CADFEE4",
        },
        ["21C9852925E84B0DAAE8CE886D6F9308"] = {
            [1] = "C2F1B6E0E1F64401AC269A8CB51AA58E",
        },
    },
    ["nodes"] = {
        ["EAB98DD1C8A540AA9CD9A74D76B84088"] = {
            ["Pos"] = {
                ["y"] = 440,
                ["x"] = 702,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EAB98DD1C8A540AA9CD9A74D76B84088",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["D9697856814449B2A5F14EB620A46AB7"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 521,
                ["x"] = 985,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "D9697856814449B2A5F14EB620A46AB7",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5F18BE0F047147C4A8E63D4C582B6380"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "5F18BE0F047147C4A8E63D4C582B6380",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 436,
                ["x"] = 421,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
        },
        ["C2F1B6E0E1F64401AC269A8CB51AA58E"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "C2F1B6E0E1F64401AC269A8CB51AA58E",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 287,
                ["x"] = 1194,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["F7BDB6C82297498E8071E0420CADFEE4"] = {
            ["Pos"] = {
                ["y"] = 297,
                ["x"] = 703,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F7BDB6C82297498E8071E0420CADFEE4",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["B366B575E72B46DD970885B7A6547BAD"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 515,
                ["x"] = 1181,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "B366B575E72B46DD970885B7A6547BAD",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["90D0268189A2484591A70403BDCF60AE"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "90D0268189A2484591A70403BDCF60AE",
            ["ID"] = "10006",
            ["Name"] = "6号词缀",
            ["Static"] = true,
        },
        ["613388CABFC149DD8E049E62DC488A52"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "613388CABFC149DD8E049E62DC488A52",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 422,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
        },
        ["21C9852925E84B0DAAE8CE886D6F9308"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 965,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "21C9852925E84B0DAAE8CE886D6F9308",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "90D0268189A2484591A70403BDCF60AE",
}