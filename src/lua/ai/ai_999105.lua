return {
    ["links"] = {
        ["A14992787B404E49873E42BA6130D88E"] = {
            [1] = "4301BC5312774E04ADCEE796CB64F135",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "EE219BD6C5824D6985D30A007B4F0889",
        },
        ["42E9FF0EDCCF47CF8B6056D43B9596B2"] = {
            [1] = "A14992787B404E49873E42BA6130D88E",
        },
        ["6CA9582395764882B0D706087B1B7F77"] = {
            [1] = "11384BCAC9564E0F9468DA74D510CE9E",
            [2] = "FB179A66D9D54B5AAA2828873C2CF669",
            [3] = "00EEB2835B7043EAAAC80BFBA55478C7",
        },
        ["29EE166C8E22452B80D4139E8A0F5439"] = {
            [1] = "D8A9765ACF7C49A3879F392AE59D071C",
        },
        ["115B2982DA864EDCB75568346608EEB5"] = {
            [1] = "5958FD4B7E16453093A2FAF296FACFEA",
        },
        ["92D86354F23E4A57ACB4184BCDF643D7"] = {
            [1] = "29EE166C8E22452B80D4139E8A0F5439",
        },
        ["2D8C680626644298B763C5F189987D4B"] = {
            [1] = "997B0F9CF49E46CCAB1E7AF6585F5D10",
        },
        ["0F996F36377F4F68A0D56F47756E68CE"] = {
            [1] = "E98FC4F4D4324D019066E07D11D0D540",
        },
        ["E98FC4F4D4324D019066E07D11D0D540"] = {
            [1] = "115B2982DA864EDCB75568346608EEB5",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [2] = "42E9FF0EDCCF47CF8B6056D43B9596B2",
            [3] = "2D8C680626644298B763C5F189987D4B",
        },
        ["11384BCAC9564E0F9468DA74D510CE9E"] = {
            [1] = "0F996F36377F4F68A0D56F47756E68CE",
        },
        ["FB179A66D9D54B5AAA2828873C2CF669"] = {
            [1] = "0F996F36377F4F68A0D56F47756E68CE",
        },
        ["EE219BD6C5824D6985D30A007B4F0889"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["997B0F9CF49E46CCAB1E7AF6585F5D10"] = {
            [1] = "C30892EBEE96406FA983A6BB3355DFD9",
        },
        ["00EEB2835B7043EAAAC80BFBA55478C7"] = {
            [1] = "0F996F36377F4F68A0D56F47756E68CE",
        },
    },
    ["nodes"] = {
        ["C30892EBEE96406FA983A6BB3355DFD9"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "C30892EBEE96406FA983A6BB3355DFD9",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 558,
                ["x"] = 768,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["6CA9582395764882B0D706087B1B7F77"] = {
            ["Desc"] = "旋涡配合普攻\
",
            ["Duration"] = 100,
            ["NodeTag"] = "6CA9582395764882B0D706087B1B7F77",
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 686,
                ["x"] = 209,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 1,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["29EE166C8E22452B80D4139E8A0F5439"] = {
            ["Pos"] = {
                ["y"] = 1137,
                ["x"] = 467,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "29EE166C8E22452B80D4139E8A0F5439",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2D8C680626644298B763C5F189987D4B"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 0,
            ["NodeTag"] = "2D8C680626644298B763C5F189987D4B",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 556,
                ["x"] = 259,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EE219BD6C5824D6985D30A007B4F0889"] = {
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 495,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "EE219BD6C5824D6985D30A007B4F0889",
            ["RangeY"] = {
                [1] = 0,
                [2] = 100,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["997B0F9CF49E46CCAB1E7AF6585F5D10"] = {
            ["Pos"] = {
                ["y"] = 568,
                ["x"] = 481,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "997B0F9CF49E46CCAB1E7AF6585F5D10",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["00EEB2835B7043EAAAC80BFBA55478C7"] = {
            ["Pos"] = {
                ["y"] = 924,
                ["x"] = 592,
            },
            ["Judge"] = 3,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "00EEB2835B7043EAAAC80BFBA55478C7",
            ["Value"] = 50,
            ["Key"] = "",
            ["Static"] = false,
        },
        ["FA6D4CC6B7894DC0AC3E907C8E114CBE"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 893,
                ["x"] = 1257,
            },
            ["Weight"] = 0,
            ["Class"] = "ChooseAILinkBevNode",
            ["NodeTag"] = "FA6D4CC6B7894DC0AC3E907C8E114CBE",
            ["ChooseLinkId"] = 100,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4301BC5312774E04ADCEE796CB64F135"] = {
            ["Desc"] = "漩涡陷阱\
后面加延时防止被其他技能打断\
\
\
",
            ["Pos"] = {
                ["y"] = 443,
                ["x"] = 723,
            },
            ["Weight"] = 10,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4301BC5312774E04ADCEE796CB64F135",
            ["ID"] = 700493,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["11384BCAC9564E0F9468DA74D510CE9E"] = {
            ["HitState"] = 1,
            ["Pos"] = {
                ["y"] = 692,
                ["x"] = 547,
            },
            ["Class"] = "CheckDamageBevNode",
            ["NodeTag"] = "11384BCAC9564E0F9468DA74D510CE9E",
            ["SkillId"] = 700394,
            ["Static"] = false,
        },
        ["115B2982DA864EDCB75568346608EEB5"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 677,
                ["x"] = 1328,
            },
            ["Weight"] = 0,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "115B2982DA864EDCB75568346608EEB5",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["E98FC4F4D4324D019066E07D11D0D540"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "E98FC4F4D4324D019066E07D11D0D540",
            ["Reset"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 680,
                ["x"] = 1153,
            },
            ["AddValue"] = 0,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["5958FD4B7E16453093A2FAF296FACFEA"] = {
            ["Desc"] = "普通攻击\
",
            ["Pos"] = {
                ["y"] = 677,
                ["x"] = 1596,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5958FD4B7E16453093A2FAF296FACFEA",
            ["ID"] = 700300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["92D86354F23E4A57ACB4184BCDF643D7"] = {
            ["Desc"] = "普攻冷却模拟\
",
            ["Duration"] = 100,
            ["NodeTag"] = "92D86354F23E4A57ACB4184BCDF643D7",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 1130,
                ["x"] = 224,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["FB179A66D9D54B5AAA2828873C2CF669"] = {
            ["Pos"] = {
                ["y"] = 800,
                ["x"] = 597,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "FB179A66D9D54B5AAA2828873C2CF669",
            ["RangeY"] = {
                [1] = 0,
                [2] = 100,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["0F996F36377F4F68A0D56F47756E68CE"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 681,
                ["x"] = 985,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "0F996F36377F4F68A0D56F47756E68CE",
            ["Type"] = 0,
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
            ["ID"] = "999105",
            ["Name"] = "或守剧场-鞠奈1",
            ["Static"] = true,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "普通攻击\
",
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 782,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 700400,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "普攻\
\
",
            ["Duration"] = 3000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 256,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["341F1E6268784C4583FEE6B1B9203107"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 442,
                ["x"] = 907,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "341F1E6268784C4583FEE6B1B9203107",
            ["DelayTime"] = 1000,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["D8A9765ACF7C49A3879F392AE59D071C"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "D8A9765ACF7C49A3879F392AE59D071C",
            ["Reset"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 1130,
                ["x"] = 710,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["A14992787B404E49873E42BA6130D88E"] = {
            ["Pos"] = {
                ["y"] = 445,
                ["x"] = 464,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "A14992787B404E49873E42BA6130D88E",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["42E9FF0EDCCF47CF8B6056D43B9596B2"] = {
            ["Desc"] = "扔旋涡\
",
            ["Duration"] = 4000,
            ["NodeTag"] = "42E9FF0EDCCF47CF8B6056D43B9596B2",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 439,
                ["x"] = 248,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}