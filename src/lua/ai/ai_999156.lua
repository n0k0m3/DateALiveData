return {
    ["links"] = {
        ["0B3FAFED2B7A4EA68990202069DC8BB0"] = {
            [1] = "0A070EF6F61A456FAD3719E00B054223",
        },
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            [1] = "845688F68F4948AAAA13CB7BF160A1FB",
        },
        ["4C783F828C5B43D584203A838AA866E4"] = {
            [1] = "41BA71BA3D7F4421AEA82EE58141EEF5",
        },
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            [1] = "8594BF87BF684CDE8DE52ABB4F5BF999",
        },
        ["0A070EF6F61A456FAD3719E00B054223"] = {
            [1] = "4C783F828C5B43D584203A838AA866E4",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "C6EA7946AC8245EEA631850950FC8FCF",
        },
        ["A56158D9A2C043959BD7B99CC63E5B08"] = {
            [1] = "E9AE73AAFFE04E35B6259F2DECECF9A5",
        },
        ["C6EA7946AC8245EEA631850950FC8FCF"] = {
            [1] = "5354AF5CE75648028CD1EF7B6C2D603A",
        },
        ["8594BF87BF684CDE8DE52ABB4F5BF999"] = {
            [1] = "698A3460F5E740668CEF79C21ED90489",
        },
        ["5A8D00683E61414F9099D2B8AADEB2F6"] = {
            [1] = "A56158D9A2C043959BD7B99CC63E5B08",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "894DA289B96B44C8A27242529F47AE82",
        },
        ["5354AF5CE75648028CD1EF7B6C2D603A"] = {
            [1] = "A61AC2DD80884084BE25D4903EF8A399",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0B3FAFED2B7A4EA68990202069DC8BB0",
            [2] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [3] = "1286712DAE064E51B7D47035867DA9E0",
            [4] = "EB2255181C674183B5FB1157FD1051E4",
            [5] = "5A8D00683E61414F9099D2B8AADEB2F6",
        },
        ["845688F68F4948AAAA13CB7BF160A1FB"] = {
            [1] = "FE7E10735E22427CBF14196448D0F32A",
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
        ["894DA289B96B44C8A27242529F47AE82"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
    },
    ["nodes"] = {
        ["0B3FAFED2B7A4EA68990202069DC8BB0"] = {
            ["Desc"] = "瞬移",
            ["Duration"] = 8000,
            ["NodeTag"] = "0B3FAFED2B7A4EA68990202069DC8BB0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 635,
                ["x"] = 250,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["894DA289B96B44C8A27242529F47AE82"] = {
            ["Pos"] = {
                ["y"] = 506,
                ["x"] = 499,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "894DA289B96B44C8A27242529F47AE82",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4C783F828C5B43D584203A838AA866E4"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 643,
                ["x"] = 726,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "4C783F828C5B43D584203A838AA866E4",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["A61AC2DD80884084BE25D4903EF8A399"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 493,
                ["x"] = 1340,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "A61AC2DD80884084BE25D4903EF8A399",
            ["ID"] = 701230,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0A070EF6F61A456FAD3719E00B054223"] = {
            ["Pos"] = {
                ["y"] = 649,
                ["x"] = 454,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "0A070EF6F61A456FAD3719E00B054223",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8811BBACC47749C89E2B6F7019E4C384"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 945,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "8811BBACC47749C89E2B6F7019E4C384",
            ["ID"] = 701220,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 497,
                ["x"] = 795,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["A56158D9A2C043959BD7B99CC63E5B08"] = {
            ["Pos"] = {
                ["y"] = 754,
                ["x"] = 484,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "A56158D9A2C043959BD7B99CC63E5B08",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "飞刀",
            ["Duration"] = 7000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 488,
                ["x"] = 252,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 15,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["E9AE73AAFFE04E35B6259F2DECECF9A5"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "E9AE73AAFFE04E35B6259F2DECECF9A5",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 741,
                ["x"] = 729,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["5A8D00683E61414F9099D2B8AADEB2F6"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 2000,
            ["NodeTag"] = "5A8D00683E61414F9099D2B8AADEB2F6",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 746,
                ["x"] = 256,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["8594BF87BF684CDE8DE52ABB4F5BF999"] = {
            ["Pos"] = {
                ["y"] = 336,
                ["x"] = 463,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "8594BF87BF684CDE8DE52ABB4F5BF999",
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
        ["1286712DAE064E51B7D47035867DA9E0"] = {
            ["Desc"] = "针刺",
            ["Duration"] = 2000,
            ["NodeTag"] = "1286712DAE064E51B7D47035867DA9E0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 329,
                ["x"] = 242,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
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
            ["ID"] = "999156",
            ["Name"] = "人偶形态2-level15",
            ["Static"] = true,
        },
        ["41BA71BA3D7F4421AEA82EE58141EEF5"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 643,
                ["x"] = 895,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "41BA71BA3D7F4421AEA82EE58141EEF5",
            ["ID"] = 701240,
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
        ["EB2255181C674183B5FB1157FD1051E4"] = {
            ["Desc"] = "普攻\
",
            ["Duration"] = 2500,
            ["NodeTag"] = "EB2255181C674183B5FB1157FD1051E4",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 109,
                ["x"] = 230,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["C6EA7946AC8245EEA631850950FC8FCF"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 501,
                ["x"] = 982,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "C6EA7946AC8245EEA631850950FC8FCF",
            ["ID"] = 701230,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["845688F68F4948AAAA13CB7BF160A1FB"] = {
            ["Pos"] = {
                ["y"] = 105,
                ["x"] = 435,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "845688F68F4948AAAA13CB7BF160A1FB",
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
            ["ID"] = 701210,
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
        ["5354AF5CE75648028CD1EF7B6C2D603A"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 500,
                ["x"] = 1183,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5354AF5CE75648028CD1EF7B6C2D603A",
            ["ID"] = 701230,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}