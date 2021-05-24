return {
    ["links"] = {
        ["C6316271D41547DD8B96C0025350AA2C"] = {
            [1] = "84669459F663471D98C6EFF39EAB078B",
        },
        ["B12666EAC91E4D69A4390B9A977DF4A5"] = {
            [1] = "97362B0CBCB1476CB85726465EBA0114",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "7C92C0E552834970BFE9652B89369719",
        },
        ["BF049D7F0FC74704948B0D02F75A5509"] = {
            [1] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
        },
        ["97362B0CBCB1476CB85726465EBA0114"] = {
            [1] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
        },
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "E04DC2142EDB4410BD175EDE53FCE10D",
        },
        ["73CB421137DC4A2D8C63E41D4BC2E375"] = {
            [1] = "B12666EAC91E4D69A4390B9A977DF4A5",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["7C92C0E552834970BFE9652B89369719"] = {
            [1] = "5F4FD01BE16842F1A05227BD69159C05",
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            [1] = "FF9F5350CA484FAE84FC9D798CCBE748",
        },
        ["5C99A113E5944F00B3A093C9AAA536BC"] = {
            [1] = "BF049D7F0FC74704948B0D02F75A5509",
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "73CB421137DC4A2D8C63E41D4BC2E375",
            [2] = "9819F6D899A146C68C5BA9627C8AF861",
            [3] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            [1] = "AC14A384CEA947D0B8FF0FAB2A1C988A",
        },
        ["AC14A384CEA947D0B8FF0FAB2A1C988A"] = {
            [1] = "C6316271D41547DD8B96C0025350AA2C",
        },
        ["5F4FD01BE16842F1A05227BD69159C05"] = {
            [1] = "B9E0479831DD4A1AB84D641644AA6CB8",
            [2] = "593A641709F5413889B0CA564581C29D",
        },
    },
    ["nodes"] = {
        ["B12666EAC91E4D69A4390B9A977DF4A5"] = {
            ["Pos"] = {
                ["y"] = 197,
                ["x"] = 669,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "B12666EAC91E4D69A4390B9A977DF4A5",
            ["RangeY"] = {
                [1] = 0,
                [2] = 100,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 600,
            },
            ["Static"] = false,
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 3000,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 42,
                ["x"] = 423,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["BF049D7F0FC74704948B0D02F75A5509"] = {
            ["Pos"] = {
                ["y"] = 615,
                ["x"] = 641,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "BF049D7F0FC74704948B0D02F75A5509",
            ["RangeY"] = {
                [1] = 1,
                [2] = 200,
            },
            ["RangeX"] = {
                [1] = 220,
                [2] = 600,
            },
            ["Static"] = false,
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 500,
            ["NodeTag"] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 361,
                ["x"] = 389,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["73CB421137DC4A2D8C63E41D4BC2E375"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 5000,
            ["NodeTag"] = "73CB421137DC4A2D8C63E41D4BC2E375",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 193,
                ["x"] = 406,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["593A641709F5413889B0CA564581C29D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 59,
                ["x"] = 1232,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "593A641709F5413889B0CA564581C29D",
            ["ID"] = 430190,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "无敌",
            ["Pos"] = {
                ["y"] = 400,
                ["x"] = 76,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "999210",
            ["Name"] = "主线12章地狱十香",
            ["Static"] = true,
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            ["Desc"] = "施放技能",
            ["Duration"] = 15000,
            ["NodeTag"] = "F321BD80CB39463F8258E317C001B334",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 483,
                ["x"] = 386,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["AC14A384CEA947D0B8FF0FAB2A1C988A"] = {
            ["Pos"] = {
                ["y"] = 478,
                ["x"] = 650,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "AC14A384CEA947D0B8FF0FAB2A1C988A",
            ["RangeY"] = {
                [1] = 0,
                [2] = 15,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 250,
            },
            ["Static"] = false,
        },
        ["5F4FD01BE16842F1A05227BD69159C05"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 24,
                ["x"] = 991,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "5F4FD01BE16842F1A05227BD69159C05",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C6316271D41547DD8B96C0025350AA2C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 480,
                ["x"] = 949,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "C6316271D41547DD8B96C0025350AA2C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["FF9F5350CA484FAE84FC9D798CCBE748"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 610,
                ["x"] = 1104,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF9F5350CA484FAE84FC9D798CCBE748",
            ["ID"] = 430140,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 605,
                ["x"] = 934,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["97362B0CBCB1476CB85726465EBA0114"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 201,
                ["x"] = 994,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "97362B0CBCB1476CB85726465EBA0114",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["B9E0479831DD4A1AB84D641644AA6CB8"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = -28,
                ["x"] = 1229,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "B9E0479831DD4A1AB84D641644AA6CB8",
            ["ID"] = 430110,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["7C92C0E552834970BFE9652B89369719"] = {
            ["Pos"] = {
                ["y"] = 38,
                ["x"] = 682,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "7C92C0E552834970BFE9652B89369719",
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
        ["6845CF3A9C9F45968CE957B5D4CDF41B"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "6845CF3A9C9F45968CE957B5D4CDF41B",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 1068,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["84669459F663471D98C6EFF39EAB078B"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 480,
                ["x"] = 1294,
            },
            ["Weight"] = 10,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "84669459F663471D98C6EFF39EAB078B",
            ["ID"] = 430120,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5C99A113E5944F00B3A093C9AAA536BC"] = {
            ["Desc"] = "闪避",
            ["Duration"] = 10000,
            ["NodeTag"] = "5C99A113E5944F00B3A093C9AAA536BC",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 602,
                ["x"] = 385,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 5,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            ["Pos"] = {
                ["y"] = 366,
                ["x"] = 664,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EB33A5DE88414BD39580766ED5745B34",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 908,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E04DC2142EDB4410BD175EDE53FCE10D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["FF324D583A7C48FEBAF32EC9C1B04A9F"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 200,
                ["x"] = 1413,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
            ["ID"] = 430180,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
}