return {
    ["links"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "BC16723DA75C4A43AA141E8012022D00",
        },
        ["BC16723DA75C4A43AA141E8012022D00"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["A466F19FD3FD4B3391EE0D5803D54E76"] = {
            [1] = "FE7E10735E22427CBF14196448D0F32A",
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            [1] = "A466F19FD3FD4B3391EE0D5803D54E76",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "C6EA7946AC8245EEA631850950FC8FCF",
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            [1] = "E7CA87B12F0D4BEA8FE860DA01830FC7",
        },
        ["565BCB55067F4E40B37D203B7D249E7B"] = {
            [1] = "D8735D9036C04026A2D344E5680C8198",
        },
        ["E7CA87B12F0D4BEA8FE860DA01830FC7"] = {
            [1] = "698A3460F5E740668CEF79C21ED90489",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "1286712DAE064E51B7D47035867DA9E0",
            [2] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [3] = "EB2255181C674183B5FB1157FD1051E4",
            [4] = "565BCB55067F4E40B37D203B7D249E7B",
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            [1] = "8811BBACC47749C89E2B6F7019E4C384",
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            [1] = "CE2F380665E146F8A829A295322144BF",
        },
        ["CE2F380665E146F8A829A295322144BF"] = {
            [1] = "233D3D9686EF4C1C9F6136CB0FCD987E",
        },
        ["D8735D9036C04026A2D344E5680C8198"] = {
            [1] = "26D5EBF5A77042BA8054D8BD843F955B",
        },
    },
    ["nodes"] = {
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            ["Desc"] = "普攻\
",
            ["Duration"] = 3000,
            ["NodeTag"] = "EB2255181C674183B5FB1157FD1051E4",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 135,
                ["x"] = 153,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            ["Desc"] = "针刺\
",
            ["Duration"] = 2000,
            ["NodeTag"] = "1286712DAE064E51B7D47035867DA9E0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 351,
                ["x"] = 178,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["E7CA87B12F0D4BEA8FE860DA01830FC7"] = {
            ["Pos"] = {
                ["y"] = 330,
                ["x"] = 420,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "E7CA87B12F0D4BEA8FE860DA01830FC7",
            ["RangeY"] = {
                [1] = 0,
                [2] = 10,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 50,
            },
            ["Static"] = false,
        },
        ["8811BBACC47749C89E2B6F7019E4C384"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 1034,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8811BBACC47749C89E2B6F7019E4C384",
            ["ID"] = 701120,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 529,
                ["x"] = 732,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "飞刀",
            ["Duration"] = 5000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 543,
                ["x"] = 191,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["565BCB55067F4E40B37D203B7D249E7B"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 2000,
            ["NodeTag"] = "565BCB55067F4E40B37D203B7D249E7B",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 661,
                ["x"] = 195,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["A466F19FD3FD4B3391EE0D5803D54E76"] = {
            ["Pos"] = {
                ["y"] = 136,
                ["x"] = 374,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "A466F19FD3FD4B3391EE0D5803D54E76",
            ["RangeY"] = {
                [1] = 0,
                [2] = 50,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 200,
            },
            ["Static"] = false,
        },
        ["26D5EBF5A77042BA8054D8BD843F955B"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "26D5EBF5A77042BA8054D8BD843F955B",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 660,
                ["x"] = 637,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
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
            ["ID"] = "999150",
            ["Name"] = "人偶形态1-level14",
            ["Static"] = true,
        },
        ["BC16723DA75C4A43AA141E8012022D00"] = {
            ["Pos"] = {
                ["y"] = 543,
                ["x"] = 450,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BC16723DA75C4A43AA141E8012022D00",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 103,
                ["x"] = 731,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "FE7E10735E22427CBF14196448D0F32A",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C6EA7946AC8245EEA631850950FC8FCF"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 532,
                ["x"] = 925,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "C6EA7946AC8245EEA631850950FC8FCF",
            ["ID"] = 701130,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 346,
                ["x"] = 749,
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
                ["y"] = 134,
                ["x"] = 1155,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "233D3D9686EF4C1C9F6136CB0FCD987E",
            ["ID"] = 701110,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["CE2F380665E146F8A829A295322144BF"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "CE2F380665E146F8A829A295322144BF",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 108,
                ["x"] = 914,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["D8735D9036C04026A2D344E5680C8198"] = {
            ["Pos"] = {
                ["y"] = 665,
                ["x"] = 383,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "D8735D9036C04026A2D344E5680C8198",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}