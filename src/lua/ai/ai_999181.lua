return {
    ["links"] = {
        ["2526DEC60276423E833F8007E605C21C"] = {
            [1] = "D1B42AF35B0943CEB2FD12DA39DFE995",
        },
        ["D1B42AF35B0943CEB2FD12DA39DFE995"] = {
            [1] = "8ECA0CCCFC074426929DE1048442CAF3",
        },
        ["27EB8965CEE14B17B74D681B0ADAEBB5"] = {
            [1] = "2526DEC60276423E833F8007E605C21C",
        },
        ["F3F55A15FF8C4E5BAAFCB07C344720F1"] = {
            [1] = "BF552E1BB98943EAB0271C775B34918C",
        },
        ["C36C4D39DA894CCAA13156D6288FE3DC"] = {
            [1] = "F3F55A15FF8C4E5BAAFCB07C344720F1",
        },
        ["A4772CC5B05B43629BB6DDF7C9C31810"] = {
            [1] = "27EB8965CEE14B17B74D681B0ADAEBB5",
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            [1] = "111C0ABA7D03415C8E93FAF6C147C6C0",
            [2] = "48659897274D4A6B9611C41C86074A76",
            [3] = "A4772CC5B05B43629BB6DDF7C9C31810",
            [4] = "67EAC3DD74584A41B21893F4DD6ADC7C",
        },
        ["C5364C42BC8E469F8FA00858B82E54DA"] = {
            [1] = "4CF59DE1C11246ECAECA9EC11C653017",
        },
        ["67EAC3DD74584A41B21893F4DD6ADC7C"] = {
            [1] = "C36C4D39DA894CCAA13156D6288FE3DC",
        },
        ["111C0ABA7D03415C8E93FAF6C147C6C0"] = {
            [1] = "C5364C42BC8E469F8FA00858B82E54DA",
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            [1] = "2D2DE306659945C38744538E401E2A43",
        },
        ["BCA5E91DBB1E4DB9A77AB67E83CE40F8"] = {
            [1] = "8A50D5DC423445079FC0DFB9DBF864F9",
        },
        ["48659897274D4A6B9611C41C86074A76"] = {
            [1] = "BCA5E91DBB1E4DB9A77AB67E83CE40F8",
        },
    },
    ["nodes"] = {
        ["111C0ABA7D03415C8E93FAF6C147C6C0"] = {
            ["Desc"] = "定时销毁\
\
",
            ["Duration"] = 0,
            ["NodeTag"] = "111C0ABA7D03415C8E93FAF6C147C6C0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -81,
                ["x"] = 443,
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
        ["48659897274D4A6B9611C41C86074A76"] = {
            ["Desc"] = "释放碰撞体\
",
            ["Duration"] = 0,
            ["NodeTag"] = "48659897274D4A6B9611C41C86074A76",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 350,
                ["x"] = 449,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Parallel"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["F3F55A15FF8C4E5BAAFCB07C344720F1"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 129,
                ["x"] = 1008,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "F3F55A15FF8C4E5BAAFCB07C344720F1",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2D2DE306659945C38744538E401E2A43"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 326,
                ["x"] = 1196,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2D2DE306659945C38744538E401E2A43",
            ["ID"] = 311129,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BF552E1BB98943EAB0271C775B34918C"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 122,
                ["x"] = 1213,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "BF552E1BB98943EAB0271C775B34918C",
            ["ID"] = 311129,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2526DEC60276423E833F8007E605C21C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 490,
                ["x"] = 1156,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "2526DEC60276423E833F8007E605C21C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4CF59DE1C11246ECAECA9EC11C653017"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -91,
                ["x"] = 1117,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "4CF59DE1C11246ECAECA9EC11C653017",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["27EB8965CEE14B17B74D681B0ADAEBB5"] = {
            ["CheckState"] = 1,
            ["Pos"] = {
                ["y"] = 520,
                ["x"] = 823,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "27EB8965CEE14B17B74D681B0ADAEBB5",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
            ["Static"] = false,
        },
        ["8ECA0CCCFC074426929DE1048442CAF3"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 490,
                ["x"] = 1610,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "8ECA0CCCFC074426929DE1048442CAF3",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["C36C4D39DA894CCAA13156D6288FE3DC"] = {
            ["CheckState"] = 0,
            ["Pos"] = {
                ["y"] = 139,
                ["x"] = 707,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "C36C4D39DA894CCAA13156D6288FE3DC",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
            ["Static"] = false,
        },
        ["67EAC3DD74584A41B21893F4DD6ADC7C"] = {
            ["Desc"] = "释放碰撞体\
",
            ["Duration"] = 1666,
            ["NodeTag"] = "67EAC3DD74584A41B21893F4DD6ADC7C",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 137,
                ["x"] = 449,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Parallel"] = 1,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            ["Desc"] = "加攻道具怪物",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6E7A693C05A646FAB593AF25DBAF7047",
            ["ID"] = "999181",
            ["Name"] = "加攻道具怪物",
            ["Static"] = true,
        },
        ["C5364C42BC8E469F8FA00858B82E54DA"] = {
            ["Pos"] = {
                ["y"] = -53,
                ["x"] = 743,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C5364C42BC8E469F8FA00858B82E54DA",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C0769D59B5B449919D142C6B63F77E11"] = {
            ["HitState"] = 1,
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = 796,
            },
            ["Class"] = "CheckDamageBevNode",
            ["NodeTag"] = "C0769D59B5B449919D142C6B63F77E11",
            ["SkillId"] = 311113,
            ["Static"] = false,
        },
        ["D1B42AF35B0943CEB2FD12DA39DFE995"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 485,
                ["x"] = 1328,
            },
            ["Weight"] = 0,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "D1B42AF35B0943CEB2FD12DA39DFE995",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["8A50D5DC423445079FC0DFB9DBF864F9"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 339,
                ["x"] = 978,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "8A50D5DC423445079FC0DFB9DBF864F9",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BCA5E91DBB1E4DB9A77AB67E83CE40F8"] = {
            ["Pos"] = {
                ["y"] = 339,
                ["x"] = 726,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "BCA5E91DBB1E4DB9A77AB67E83CE40F8",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A4772CC5B05B43629BB6DDF7C9C31810"] = {
            ["Desc"] = "道具被拾取后销毁",
            ["Duration"] = 100,
            ["NodeTag"] = "A4772CC5B05B43629BB6DDF7C9C31810",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 478,
                ["x"] = 456,
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
    },
    ["root"] = "6E7A693C05A646FAB593AF25DBAF7047",
}