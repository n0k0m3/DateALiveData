return {
    ["links"] = {
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            [1] = "447828A1C66344CE9C501840156732AB",
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            [1] = "2858705FFDD34411A42A1702B3A79449",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "13E7D11BAF354014A99EFB6CDCCC4908",
        },
        ["447828A1C66344CE9C501840156732AB"] = {
            [1] = "C2526A019C0848FD947291C629CAAD37",
        },
    },
    ["nodes"] = {
        ["447828A1C66344CE9C501840156732AB"] = {
            ["Pos"] = {
                ["y"] = 323,
                ["x"] = 672,
            },
            ["Judge"] = 2,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "447828A1C66344CE9C501840156732AB",
            ["Value"] = 1,
            ["Key"] = "speedup",
            ["Static"] = false,
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            ["Desc"] = "变快\
",
            ["Duration"] = 100,
            ["NodeTag"] = "13E7D11BAF354014A99EFB6CDCCC4908",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 295,
                ["x"] = 382,
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
                ["y"] = 303,
                ["x"] = 1094,
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
            ["ID"] = "910311",
            ["Name"] = "社团跑道",
            ["Static"] = true,
        },
        ["2858705FFDD34411A42A1702B3A79449"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 1303,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2858705FFDD34411A42A1702B3A79449",
            ["ID"] = 600112,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}