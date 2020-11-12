return {
    ["links"] = {
        ["48659897274D4A6B9611C41C86074A76"] = {
            [1] = "BFCB3A47B05B4BD2BF51241097796912",
        },
        ["963C704F9E1F40D39C08B6585669FA89"] = {
            [1] = "27FC8F1B18C8411F971A0D824E5E6C96",
        },
        ["BBAEBE5106A04DDEAFE941214A0D7F1C"] = {
            [1] = "4C4FAE7E772D4EE4A7570227DB6022D5",
        },
        ["27FC8F1B18C8411F971A0D824E5E6C96"] = {
            [1] = "BBAEBE5106A04DDEAFE941214A0D7F1C",
        },
        ["E5AE77D6F0E2455CBD6FFAFDC28157AE"] = {
            [1] = "D4E5156EEADC4B869C8C7DCA7991D6BE",
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            [1] = "D892B74BC48F469B886F3D4F192917FB",
            [2] = "48659897274D4A6B9611C41C86074A76",
            [3] = "963C704F9E1F40D39C08B6585669FA89",
        },
        ["4C4FAE7E772D4EE4A7570227DB6022D5"] = {
            [1] = "8ECA0CCCFC074426929DE1048442CAF3",
        },
        ["BFCB3A47B05B4BD2BF51241097796912"] = {
            [1] = "8A50D5DC423445079FC0DFB9DBF864F9",
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            [1] = "2D2DE306659945C38744538E401E2A43",
        },
        ["D892B74BC48F469B886F3D4F192917FB"] = {
            [1] = "E5AE77D6F0E2455CBD6FFAFDC28157AE",
        },
    },
    ["nodes"] = {
        ["48659897274D4A6B9611C41C86074A76"] = {
            ["Desc"] = "释放碰撞体",
            ["Duration"] = 0,
            ["NodeTag"] = "48659897274D4A6B9611C41C86074A76",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 337,
                ["x"] = 453,
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
        ["D4E5156EEADC4B869C8C7DCA7991D6BE"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 213,
                ["x"] = 1014,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "D4E5156EEADC4B869C8C7DCA7991D6BE",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["E5AE77D6F0E2455CBD6FFAFDC28157AE"] = {
            ["Pos"] = {
                ["y"] = 224,
                ["x"] = 720,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "E5AE77D6F0E2455CBD6FFAFDC28157AE",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8ECA0CCCFC074426929DE1048442CAF3"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 459,
                ["x"] = 1569,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "8ECA0CCCFC074426929DE1048442CAF3",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["963C704F9E1F40D39C08B6585669FA89"] = {
            ["Desc"] = "道具被拾取后销毁",
            ["Duration"] = 100,
            ["NodeTag"] = "963C704F9E1F40D39C08B6585669FA89",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 361,
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
        ["2D2DE306659945C38744538E401E2A43"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 335,
                ["x"] = 1201,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2D2DE306659945C38744538E401E2A43",
            ["ID"] = 311123,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 337,
                ["x"] = 1041,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "8A50D5DC423445079FC0DFB9DBF864F9",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            ["Desc"] = "回血道具怪物",
            ["Pos"] = {
                ["y"] = 334,
                ["x"] = 254,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6E7A693C05A646FAB593AF25DBAF7047",
            ["ID"] = "999175",
            ["Name"] = "回血道具怪物",
            ["Static"] = true,
        },
        ["27FC8F1B18C8411F971A0D824E5E6C96"] = {
            ["CheckState"] = 1,
            ["Pos"] = {
                ["y"] = 513,
                ["x"] = 725,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "27FC8F1B18C8411F971A0D824E5E6C96",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
            ["Static"] = false,
        },
        ["BFCB3A47B05B4BD2BF51241097796912"] = {
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 721,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BFCB3A47B05B4BD2BF51241097796912",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4C4FAE7E772D4EE4A7570227DB6022D5"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 459,
                ["x"] = 1294,
            },
            ["Weight"] = 0,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "4C4FAE7E772D4EE4A7570227DB6022D5",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["5FE1D0B25F8E42C79965AF91C2B1F05C"] = {
            ["HitState"] = 1,
            ["Pos"] = {
                ["y"] = 425,
                ["x"] = 685,
            },
            ["Class"] = "CheckDamageBevNode",
            ["NodeTag"] = "5FE1D0B25F8E42C79965AF91C2B1F05C",
            ["SkillId"] = 311112,
            ["Static"] = false,
        },
        ["BBAEBE5106A04DDEAFE941214A0D7F1C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 461,
                ["x"] = 1123,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "BBAEBE5106A04DDEAFE941214A0D7F1C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["D892B74BC48F469B886F3D4F192917FB"] = {
            ["Desc"] = "定时销毁\
",
            ["Duration"] = 0,
            ["NodeTag"] = "D892B74BC48F469B886F3D4F192917FB",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 195,
                ["x"] = 446,
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
    },
    ["root"] = "6E7A693C05A646FAB593AF25DBAF7047",
}