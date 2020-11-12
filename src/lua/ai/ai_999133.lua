return {
    ["links"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "EDBC766943654B10B998A555F88496E2",
        },
        ["FB181696E6534A9AA5B0F29C678C544C"] = {
            [1] = "FE7E10735E22427CBF14196448D0F32A",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "1286712DAE064E51B7D47035867DA9E0",
            [2] = "EB2255181C674183B5FB1157FD1051E4",
            [3] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [4] = "A52EEC7B54E04D8BA17A3DB8D0E8D573",
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            [1] = "FB181696E6534A9AA5B0F29C678C544C",
        },
        ["7FF978C54EF9424A8F8CC744F6F3C4A8"] = {
            [1] = "CE2F380665E146F8A829A295322144BF",
        },
        ["814E3E8431B341578FA23F5632476015"] = {
            [1] = "698A3460F5E740668CEF79C21ED90489",
        },
        ["EDBC766943654B10B998A555F88496E2"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "C6EA7946AC8245EEA631850950FC8FCF",
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            [1] = "8811BBACC47749C89E2B6F7019E4C384",
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            [1] = "233D3D9686EF4C1C9F6136CB0FCD987E",
        },
        ["A52EEC7B54E04D8BA17A3DB8D0E8D573"] = {
            [1] = "7FF978C54EF9424A8F8CC744F6F3C4A8",
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            [1] = "814E3E8431B341578FA23F5632476015",
        },
    },
    ["nodes"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "突进",
            ["Duration"] = 3000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 571,
                ["x"] = 247,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["C6EA7946AC8245EEA631850950FC8FCF"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 565,
                ["x"] = 934,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "C6EA7946AC8245EEA631850950FC8FCF",
            ["ID"] = 700730,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["FB181696E6534A9AA5B0F29C678C544C"] = {
            ["Pos"] = {
                ["y"] = 442,
                ["x"] = 469,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "FB181696E6534A9AA5B0F29C678C544C",
            ["RangeY"] = {
                [1] = 0,
                [2] = 50,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 566,
                ["x"] = 761,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["7FF978C54EF9424A8F8CC744F6F3C4A8"] = {
            ["Pos"] = {
                ["y"] = 731,
                ["x"] = 445,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "7FF978C54EF9424A8F8CC744F6F3C4A8",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A52EEC7B54E04D8BA17A3DB8D0E8D573"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 1000,
            ["NodeTag"] = "A52EEC7B54E04D8BA17A3DB8D0E8D573",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 724,
                ["x"] = 254,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            ["Desc"] = "普攻\
",
            ["Duration"] = 2000,
            ["NodeTag"] = "EB2255181C674183B5FB1157FD1051E4",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 447,
                ["x"] = 246,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EDBC766943654B10B998A555F88496E2"] = {
            ["Pos"] = {
                ["y"] = 569,
                ["x"] = 495,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "EDBC766943654B10B998A555F88496E2",
            ["RangeY"] = {
                [1] = 0,
                [2] = 200,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 1200,
            },
            ["Static"] = false,
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            ["Desc"] = "刀光\
",
            ["Duration"] = 5000,
            ["NodeTag"] = "1286712DAE064E51B7D47035867DA9E0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 304,
                ["x"] = 248,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["814E3E8431B341578FA23F5632476015"] = {
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 468,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "814E3E8431B341578FA23F5632476015",
            ["RangeY"] = {
                [1] = 0,
                [2] = 50,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 600,
            },
            ["Static"] = false,
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
            ["ID"] = "999133",
            ["Name"] = "土方普通战斗2形态",
            ["Static"] = true,
        },
        ["8811BBACC47749C89E2B6F7019E4C384"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 924,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8811BBACC47749C89E2B6F7019E4C384",
            ["ID"] = 700720,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["698A3460F5E740668CEF79C21ED90489"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 745,
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
                ["y"] = 445,
                ["x"] = 932,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "233D3D9686EF4C1C9F6136CB0FCD987E",
            ["ID"] = 700710,
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
                ["y"] = 726,
                ["x"] = 716,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["FE7E10735E22427CBF14196448D0F32A"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 446,
                ["x"] = 751,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "FE7E10735E22427CBF14196448D0F32A",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}