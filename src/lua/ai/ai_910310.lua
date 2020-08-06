return {
    ["links"] = {
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            [1] = "22D8952F7B85440A8EB1BAB3346AC4CB",
        },
        ["22D8952F7B85440A8EB1BAB3346AC4CB"] = {
            [1] = "C2526A019C0848FD947291C629CAAD37",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "13E7D11BAF354014A99EFB6CDCCC4908",
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            [1] = "528E5FC5F0E74FEDACDF3B844EFF3C68",
        },
    },
    ["nodes"] = {
        ["22D8952F7B85440A8EB1BAB3346AC4CB"] = {
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 768,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "22D8952F7B85440A8EB1BAB3346AC4CB",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            ["Desc"] = "释放间隔",
            ["Duration"] = 1000,
            ["NodeTag"] = "13E7D11BAF354014A99EFB6CDCCC4908",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 395,
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
                ["y"] = 308,
                ["x"] = 1075,
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
            ["ID"] = "910310",
            ["Name"] = "社团发炸弹",
            ["Static"] = true,
        },
        ["528E5FC5F0E74FEDACDF3B844EFF3C68"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 308,
                ["x"] = 1280,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "528E5FC5F0E74FEDACDF3B844EFF3C68",
            ["ID"] = 600151,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}