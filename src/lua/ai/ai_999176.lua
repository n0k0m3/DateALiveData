return {
    ["links"] = {
        ["45EB3506C7F14F8DAA733BCA9016F747"] = {
            [1] = "3AB122FDFAD140BFB78F70C10C3E150F",
        },
        ["2526DEC60276423E833F8007E605C21C"] = {
            [1] = "D1B42AF35B0943CEB2FD12DA39DFE995",
        },
        ["D1B42AF35B0943CEB2FD12DA39DFE995"] = {
            [1] = "8ECA0CCCFC074426929DE1048442CAF3",
        },
        ["1D364A9AA7A346F7B353875EB37223FC"] = {
            [1] = "89CB5D47FC1343D3AF9E514980AD0E54",
        },
        ["27EB8965CEE14B17B74D681B0ADAEBB5"] = {
            [1] = "2526DEC60276423E833F8007E605C21C",
        },
        ["A4772CC5B05B43629BB6DDF7C9C31810"] = {
            [1] = "27EB8965CEE14B17B74D681B0ADAEBB5",
        },
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            [1] = "111C0ABA7D03415C8E93FAF6C147C6C0",
            [2] = "48659897274D4A6B9611C41C86074A76",
            [3] = "A4772CC5B05B43629BB6DDF7C9C31810",
            [4] = "1D364A9AA7A346F7B353875EB37223FC",
        },
        ["C5364C42BC8E469F8FA00858B82E54DA"] = {
            [1] = "4CF59DE1C11246ECAECA9EC11C653017",
        },
        ["89CB5D47FC1343D3AF9E514980AD0E54"] = {
            [1] = "45EB3506C7F14F8DAA733BCA9016F747",
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
        ["45EB3506C7F14F8DAA733BCA9016F747"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 139,
                ["x"] = 1035,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "45EB3506C7F14F8DAA733BCA9016F747",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["111C0ABA7D03415C8E93FAF6C147C6C0"] = {
            ["Desc"] = "定时销毁\
\
",
            ["Duration"] = 0,
            ["NodeTag"] = "111C0ABA7D03415C8E93FAF6C147C6C0",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -42,
                ["x"] = 460,
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
        ["2D2DE306659945C38744538E401E2A43"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 326,
                ["x"] = 1196,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2D2DE306659945C38744538E401E2A43",
            ["ID"] = 311124,
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
                ["y"] = -101,
                ["x"] = 1094,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "4CF59DE1C11246ECAECA9EC11C653017",
            ["Type"] = 0,
            ["IsCount"] = 1,
            ["Static"] = false,
        },
        ["1D364A9AA7A346F7B353875EB37223FC"] = {
            ["Desc"] = "释放碰撞体\
",
            ["Duration"] = 1666,
            ["NodeTag"] = "1D364A9AA7A346F7B353875EB37223FC",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 139,
                ["x"] = 430,
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
        ["6E7A693C05A646FAB593AF25DBAF7047"] = {
            ["Desc"] = "加攻道具怪物",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "6E7A693C05A646FAB593AF25DBAF7047",
            ["ID"] = "999176",
            ["Name"] = "加攻道具怪物",
            ["Static"] = true,
        },
        ["3AB122FDFAD140BFB78F70C10C3E150F"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 150,
                ["x"] = 1204,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3AB122FDFAD140BFB78F70C10C3E150F",
            ["ID"] = 311124,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["89CB5D47FC1343D3AF9E514980AD0E54"] = {
            ["CheckState"] = 0,
            ["Pos"] = {
                ["y"] = 139,
                ["x"] = 709,
            },
            ["MonsterId"] = 0,
            ["Class"] = "CheckStateBevNode",
            ["NodeTag"] = "89CB5D47FC1343D3AF9E514980AD0E54",
            ["CheckHero"] = 0,
            ["StateId"] = 73,
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
        ["C5364C42BC8E469F8FA00858B82E54DA"] = {
            ["Pos"] = {
                ["y"] = -37,
                ["x"] = 732,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C5364C42BC8E469F8FA00858B82E54DA",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "6E7A693C05A646FAB593AF25DBAF7047",
}