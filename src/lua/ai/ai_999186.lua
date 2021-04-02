return {
    ["links"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "7622E9CE1DDB40CB90F974FBD886D1D6",
        },
        ["5C4D514313894227BFEA9B05D93F7BDA"] = {
            [1] = "698A3460F5E740668CEF79C21ED90489",
        },
        ["7622E9CE1DDB40CB90F974FBD886D1D6"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "EB2255181C674183B5FB1157FD1051E4",
            [2] = "1286712DAE064E51B7D47035867DA9E0",
            [3] = "0E5B67F2C2AE462EA0EA8120083C7742",
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            [1] = "5C4D514313894227BFEA9B05D93F7BDA",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "D68CBD60436448728261DFF72392E8DC",
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            [1] = "8811BBACC47749C89E2B6F7019E4C384",
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            [1] = "233D3D9686EF4C1C9F6136CB0FCD987E",
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            [1] = "118AFD3F63B74F82B7F6F5BEF6D8EFB9",
        },
        ["118AFD3F63B74F82B7F6F5BEF6D8EFB9"] = {
            [1] = "FE7E10735E22427CBF14196448D0F32A",
        },
    },
    ["nodes"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "销毁\
\
",
            ["Duration"] = 0,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 578,
                ["x"] = 176,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["5C4D514313894227BFEA9B05D93F7BDA"] = {
            ["Pos"] = {
                ["y"] = 454,
                ["x"] = 485,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5C4D514313894227BFEA9B05D93F7BDA",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["7622E9CE1DDB40CB90F974FBD886D1D6"] = {
            ["Pos"] = {
                ["y"] = 691,
                ["x"] = 432,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "7622E9CE1DDB40CB90F974FBD886D1D6",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            ["Desc"] = "扔球\
\
",
            ["Duration"] = 3000,
            ["NodeTag"] = "EB2255181C674183B5FB1157FD1051E4",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 268,
                ["x"] = 219,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 192,
                ["x"] = 754,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "FE7E10735E22427CBF14196448D0F32A",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            ["Desc"] = "抓取\
\
",
            ["Duration"] = 2000,
            ["NodeTag"] = "1286712DAE064E51B7D47035867DA9E0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 409,
                ["x"] = 251,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            ["Desc"] = "--\
",
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = -54,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
            ["ID"] = "999186",
            ["Name"] = "白色守护者",
            ["Static"] = true,
        },
        ["D68CBD60436448728261DFF72392E8DC"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 640,
                ["x"] = 1231,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "D68CBD60436448728261DFF72392E8DC",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["8811BBACC47749C89E2B6F7019E4C384"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 1173,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8811BBACC47749C89E2B6F7019E4C384",
            ["ID"] = 701520,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 431,
                ["x"] = 785,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "698A3460F5E740668CEF79C21ED90489",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["233D3D9686EF4C1C9F6136CB0FCD987E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 204,
                ["x"] = 1024,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "233D3D9686EF4C1C9F6136CB0FCD987E",
            ["ID"] = 701510,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 641,
                ["x"] = 786,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["118AFD3F63B74F82B7F6F5BEF6D8EFB9"] = {
            ["Pos"] = {
                ["y"] = 212,
                ["x"] = 502,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "118AFD3F63B74F82B7F6F5BEF6D8EFB9",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}