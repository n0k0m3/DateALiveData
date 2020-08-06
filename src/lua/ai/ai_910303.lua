return {
    ["links"] = {
        ["B133B96C69C24C3981CF5178870B3610"] = {
            [1] = "3B9C8DFAB99A4FBC935AF7A5756E959C",
        },
        ["389A19C2A4EA4146A790459BAB4375C8"] = {
            [1] = "B133B96C69C24C3981CF5178870B3610",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "230B4B24561D4D87B66ED31837B369EF",
        },
        ["8EAA076A6E6C400FB291D0BFA48570E5"] = {
            [1] = "C971A6704C024838A22DE9155F8278DA",
        },
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            [1] = "042C09CF78DE4F8D8D51E9D8EBF6C936",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "8EAA076A6E6C400FB291D0BFA48570E5",
            [2] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["C971A6704C024838A22DE9155F8278DA"] = {
            [1] = "389A19C2A4EA4146A790459BAB4375C8",
        },
    },
    ["nodes"] = {
        ["389A19C2A4EA4146A790459BAB4375C8"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 407,
                ["x"] = 1090,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "389A19C2A4EA4146A790459BAB4375C8",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            ["Pos"] = {
                ["y"] = 222,
                ["x"] = 812,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "8565FCC068944377AD1FE7ED7AD14D97",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 214,
                ["x"] = 1083,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "230B4B24561D4D87B66ED31837B369EF",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 320,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
            ["ID"] = "910303",
            ["Name"] = "社团火焰引力",
            ["Static"] = true,
        },
        ["C971A6704C024838A22DE9155F8278DA"] = {
            ["Pos"] = {
                ["y"] = 408,
                ["x"] = 807,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C971A6704C024838A22DE9155F8278DA",
            ["Duration"] = 60000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["042C09CF78DE4F8D8D51E9D8EBF6C936"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 215,
                ["x"] = 1295,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "042C09CF78DE4F8D8D51E9D8EBF6C936",
            ["ID"] = 600111,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["B133B96C69C24C3981CF5178870B3610"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "B133B96C69C24C3981CF5178870B3610",
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = 1250,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "speedup",
            ["Type"] = 0,
        },
        ["8EAA076A6E6C400FB291D0BFA48570E5"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "8EAA076A6E6C400FB291D0BFA48570E5",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 399,
                ["x"] = 566,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3B9C8DFAB99A4FBC935AF7A5756E959C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 402,
                ["x"] = 1469,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3B9C8DFAB99A4FBC935AF7A5756E959C",
            ["ID"] = 600113,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "B4045A8FF0724111A27EE1480AC39F72",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 217,
                ["x"] = 577,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}