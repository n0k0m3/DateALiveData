return {
    ["links"] = {
        ["907F4B2200334F18A45294AEBEB566B2"] = {
            [1] = "2AAB31E7A8DC467C88C4FBF7203FF01F",
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            [1] = "230B4B24561D4D87B66ED31837B369EF",
        },
        ["2AAB31E7A8DC467C88C4FBF7203FF01F"] = {
            [1] = "1604109CBA9A41078763D3BEFCC18C64",
        },
        ["230B4B24561D4D87B66ED31837B369EF"] = {
            [1] = "042C09CF78DE4F8D8D51E9D8EBF6C936",
        },
        ["5DFEA2C52E5544618E03BCD9B9B28B08"] = {
            [1] = "84E8DD05126B4E939ADC9E2BD929EBC0",
            [2] = "B4045A8FF0724111A27EE1480AC39F72",
        },
        ["B4045A8FF0724111A27EE1480AC39F72"] = {
            [1] = "8565FCC068944377AD1FE7ED7AD14D97",
        },
        ["84E8DD05126B4E939ADC9E2BD929EBC0"] = {
            [1] = "907F4B2200334F18A45294AEBEB566B2",
        },
    },
    ["nodes"] = {
        ["907F4B2200334F18A45294AEBEB566B2"] = {
            ["Pos"] = {
                ["y"] = 465,
                ["x"] = 827,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "907F4B2200334F18A45294AEBEB566B2",
            ["Duration"] = 17500,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8565FCC068944377AD1FE7ED7AD14D97"] = {
            ["Pos"] = {
                ["y"] = 140,
                ["x"] = 827,
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
                ["y"] = 152,
                ["x"] = 1122,
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
            ["ID"] = "910312",
            ["Name"] = "社团箱子斥力",
            ["Static"] = true,
        },
        ["84E8DD05126B4E939ADC9E2BD929EBC0"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "84E8DD05126B4E939ADC9E2BD929EBC0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 456,
                ["x"] = 557,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["042C09CF78DE4F8D8D51E9D8EBF6C936"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 138,
                ["x"] = 1367,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "042C09CF78DE4F8D8D51E9D8EBF6C936",
            ["ID"] = 600121,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2AAB31E7A8DC467C88C4FBF7203FF01F"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 457,
                ["x"] = 1138,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "2AAB31E7A8DC467C88C4FBF7203FF01F",
            ["Type"] = 0,
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
                ["y"] = 131,
                ["x"] = 570,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["1604109CBA9A41078763D3BEFCC18C64"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 454,
                ["x"] = 1342,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "1604109CBA9A41078763D3BEFCC18C64",
            ["DelayTime"] = 99999,
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "5DFEA2C52E5544618E03BCD9B9B28B08",
}