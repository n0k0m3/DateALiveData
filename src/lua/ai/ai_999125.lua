return {
    ["links"] = {
        ["48659897274D4A6B9611C41C86074A76"] = {
            [1] = "AB7FA0D4EA8C4692B9B584A41E0E4714",
        },
        ["81BC410DE28B47EAA09EB8D58C9FB82B"] = {
            [1] = "3AAB16BE36C14CE5BDB5A263128DE724",
        },
        ["2FC5E7CB2AB54CB597DEC78D3B87F850"] = {
            [1] = "2794DE3EA534465CA571C33C12A10F38",
        },
        ["8253CF6ED5EE4403886EF3428825DB85"] = {
            [1] = "8ECA0CCCFC074426929DE1048442CAF3",
        },
        ["A6A87F78ACF4424E975FD01284038A9E"] = {
            [1] = "81BC410DE28B47EAA09EB8D58C9FB82B",
        },
        ["3056FCD753FC41B6B1ED8CD938A0084F"] = {
            [1] = "A6A87F78ACF4424E975FD01284038A9E",
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            [1] = "2FC5E7CB2AB54CB597DEC78D3B87F850",
            [2] = "48659897274D4A6B9611C41C86074A76",
            [3] = "3ECAB69C9A9B48328E56AD67FE0E09C3",
            [4] = "3056FCD753FC41B6B1ED8CD938A0084F",
        },
        ["2794DE3EA534465CA571C33C12A10F38"] = {
            [1] = "80C375ECC3D643898924FEE218532FEA",
        },
        ["3ECAB69C9A9B48328E56AD67FE0E09C3"] = {
            [1] = "7835516D4C874DDB9BD352F044359D61",
        },
        ["AB7FA0D4EA8C4692B9B584A41E0E4714"] = {
            [1] = "8A50D5DC423445079FC0DFB9DBF864F9",
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            [1] = "2D2DE306659945C38744538E401E2A43",
        },
        ["17C80A15915E48448DF4851C7928E9A5"] = {
            [1] = "8253CF6ED5EE4403886EF3428825DB85",
        },
        ["7835516D4C874DDB9BD352F044359D61"] = {
            [1] = "17C80A15915E48448DF4851C7928E9A5",
        },
    },
    ["nodes"] = {
        ["48659897274D4A6B9611C41C86074A76"] = {
            ["Desc"] = "释放碰撞体\
",
            ["Duration"] = 0,
            ["NodeTag"] = "48659897274D4A6B9611C41C86074A76",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 319,
                ["x"] = 416,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Parallel"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["2794DE3EA534465CA571C33C12A10F38"] = {
            ["Pos"] = {
                ["y"] = 47,
                ["x"] = 697,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "2794DE3EA534465CA571C33C12A10F38",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2D2DE306659945C38744538E401E2A43"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 318,
                ["x"] = 1181,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2D2DE306659945C38744538E401E2A43",
            ["ID"] = 311114,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3AAB16BE36C14CE5BDB5A263128DE724"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 160,
                ["x"] = 1213,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3AAB16BE36C14CE5BDB5A263128DE724",
            ["ID"] = 311114,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A6A87F78ACF4424E975FD01284038A9E"] = {
            ["CheckState"] = 0,
            ["Pos"] = {
                ["y"] = 178,
                ["x"] = 718,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "A6A87F78ACF4424E975FD01284038A9E",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
            ["Static"] = false,
        },
        ["17C80A15915E48448DF4851C7928E9A5"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 534,
                ["x"] = 1169,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "17C80A15915E48448DF4851C7928E9A5",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["3ECAB69C9A9B48328E56AD67FE0E09C3"] = {
            ["Desc"] = "道具被拾取后销毁",
            ["Duration"] = 100,
            ["NodeTag"] = "3ECAB69C9A9B48328E56AD67FE0E09C3",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 533,
                ["x"] = 436,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 1,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["2FC5E7CB2AB54CB597DEC78D3B87F850"] = {
            ["Desc"] = "定时销毁\
",
            ["Duration"] = 0,
            ["NodeTag"] = "2FC5E7CB2AB54CB597DEC78D3B87F850",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 43,
                ["x"] = 399,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 100,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3056FCD753FC41B6B1ED8CD938A0084F"] = {
            ["Desc"] = "释放碰撞体\
",
            ["Duration"] = 1666,
            ["NodeTag"] = "3056FCD753FC41B6B1ED8CD938A0084F",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 183,
                ["x"] = 428,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Parallel"] = 1,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["81BC410DE28B47EAA09EB8D58C9FB82B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 165,
                ["x"] = 1029,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "81BC410DE28B47EAA09EB8D58C9FB82B",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["7835516D4C874DDB9BD352F044359D61"] = {
            ["CheckState"] = 1,
            ["Pos"] = {
                ["y"] = 541,
                ["x"] = 801,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "7835516D4C874DDB9BD352F044359D61",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
            ["Static"] = false,
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            ["Desc"] = "霸体道具怪物",
            ["Pos"] = {
                ["y"] = 425,
                ["x"] = 249,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6E7A693C05A646FAB593AF25DBAF7047",
            ["ID"] = "999125",
            ["Name"] = "霸体道具怪物",
            ["Static"] = true,
        },
        ["2BE3D438D3BE445F98099BDFD930E5A9"] = {
            ["HitState"] = 1,
            ["Pos"] = {
                ["y"] = 414,
                ["x"] = 804,
            },
            ["Class"] = "CheckDamageBevNode",
            ["NodeTag"] = "2BE3D438D3BE445F98099BDFD930E5A9",
            ["SkillId"] = 311114,
            ["Static"] = false,
        },
        ["8253CF6ED5EE4403886EF3428825DB85"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 532,
                ["x"] = 1348,
            },
            ["Weight"] = 0,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "8253CF6ED5EE4403886EF3428825DB85",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["8ECA0CCCFC074426929DE1048442CAF3"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 530,
                ["x"] = 1632,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "8ECA0CCCFC074426929DE1048442CAF3",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 316,
                ["x"] = 995,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "8A50D5DC423445079FC0DFB9DBF864F9",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["AB7FA0D4EA8C4692B9B584A41E0E4714"] = {
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 728,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "AB7FA0D4EA8C4692B9B584A41E0E4714",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["80C375ECC3D643898924FEE218532FEA"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 24,
                ["x"] = 1037,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "80C375ECC3D643898924FEE218532FEA",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "6E7A693C05A646FAB593AF25DBAF7047",
}