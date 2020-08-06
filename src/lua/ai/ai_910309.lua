return {
    ["links"] = {
        ["22D8952F7B85440A8EB1BAB3346AC4CB"] = {
            [1] = "C2526A019C0848FD947291C629CAAD37",
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "E005F187D1B74C92BEBDAC272901A68F",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            [1] = "22D8952F7B85440A8EB1BAB3346AC4CB",
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            [1] = "107268F22F8D458A99CEA50FA6AB53F7",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "8E7A4B66B4A34757883A00276DCCF8C0",
            [2] = "13E7D11BAF354014A99EFB6CDCCC4908",
        },
    },
    ["nodes"] = {
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 469,
                ["x"] = 965,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = 477,
                ["x"] = 663,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 30000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            ["Desc"] = "可同时释放的数量控制\
\
",
            ["Duration"] = 30000,
            ["NodeTag"] = "13E7D11BAF354014A99EFB6CDCCC4908",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 155,
                ["x"] = 407,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 155,
                ["x"] = 1037,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "C2526A019C0848FD947291C629CAAD37",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 187,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "910309",
            ["Name"] = "社团激光总控",
            ["Static"] = true,
        },
        ["E005F187D1B74C92BEBDAC272901A68F"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "E005F187D1B74C92BEBDAC272901A68F",
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 465,
                ["x"] = 1172,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "c",
            ["Type"] = 0,
        },
        ["107268F22F8D458A99CEA50FA6AB53F7"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "107268F22F8D458A99CEA50FA6AB53F7",
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 159,
                ["x"] = 1224,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "n",
            ["Type"] = 0,
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "CD控制",
            ["Duration"] = 20000,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 471,
                ["x"] = 399,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["22D8952F7B85440A8EB1BAB3346AC4CB"] = {
            ["Pos"] = {
                ["y"] = 163,
                ["x"] = 748,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "22D8952F7B85440A8EB1BAB3346AC4CB",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}