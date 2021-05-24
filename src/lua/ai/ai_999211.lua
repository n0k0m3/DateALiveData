return {
    ["links"] = {
        ["C6316271D41547DD8B96C0025350AA2C"] = {
            [1] = "84669459F663471D98C6EFF39EAB078B",
        },
        ["0360B42CCB8A40738351E7211A550B10"] = {
            [1] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "AC787433B9894B17B6C4CBC7D1861DA1",
        },
        ["BF049D7F0FC74704948B0D02F75A5509"] = {
            [1] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
        },
        ["C01D98D53B7444C3AA5C1102A024232B"] = {
            [1] = "0360B42CCB8A40738351E7211A550B10",
        },
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            [1] = "FF9F5350CA484FAE84FC9D798CCBE748",
        },
        ["5C99A113E5944F00B3A093C9AAA536BC"] = {
            [1] = "BF049D7F0FC74704948B0D02F75A5509",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "E04DC2142EDB4410BD175EDE53FCE10D",
        },
        ["CD723BDB3506406BA992320D4ED54B7C"] = {
            [1] = "C01D98D53B7444C3AA5C1102A024232B",
        },
        ["F7E99A9D71694F03B44AF8BC034DB637"] = {
            [1] = "C6316271D41547DD8B96C0025350AA2C",
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "CD723BDB3506406BA992320D4ED54B7C",
            [2] = "9819F6D899A146C68C5BA9627C8AF861",
            [3] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            [1] = "F7E99A9D71694F03B44AF8BC034DB637",
        },
        ["AC787433B9894B17B6C4CBC7D1861DA1"] = {
            [1] = "5F4FD01BE16842F1A05227BD69159C05",
        },
        ["5F4FD01BE16842F1A05227BD69159C05"] = {
            [1] = "593A641709F5413889B0CA564581C29D",
            [2] = "6C26242DE73A45DF95446B8DDC6E066B",
        },
    },
    ["nodes"] = {
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 4000,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 61,
                ["x"] = 384,
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
                ["y"] = 605,
                ["x"] = 620,
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
        ["6C26242DE73A45DF95446B8DDC6E066B"] = {
            ["Desc"] = "连斩",
            ["Pos"] = {
                ["y"] = 118,
                ["x"] = 1122,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C26242DE73A45DF95446B8DDC6E066B",
            ["ID"] = 430280,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["593A641709F5413889B0CA564581C29D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 40,
                ["x"] = 1121,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "593A641709F5413889B0CA564581C29D",
            ["ID"] = 430270,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F7E99A9D71694F03B44AF8BC034DB637"] = {
            ["Pos"] = {
                ["y"] = 482,
                ["x"] = 633,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "F7E99A9D71694F03B44AF8BC034DB637",
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
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "无敌",
            ["Pos"] = {
                ["y"] = 356,
                ["x"] = 12,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "999211",
            ["Name"] = "主线12章地狱折纸",
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
        ["5F4FD01BE16842F1A05227BD69159C05"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 67,
                ["x"] = 901,
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
        ["0360B42CCB8A40738351E7211A550B10"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 212,
                ["x"] = 908,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "0360B42CCB8A40738351E7211A550B10",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["FF9F5350CA484FAE84FC9D798CCBE748"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 603,
                ["x"] = 1289,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF9F5350CA484FAE84FC9D798CCBE748",
            ["ID"] = 430240,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 601,
                ["x"] = 944,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C01D98D53B7444C3AA5C1102A024232B"] = {
            ["Pos"] = {
                ["y"] = 210,
                ["x"] = 619,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "C01D98D53B7444C3AA5C1102A024232B",
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
        ["CD723BDB3506406BA992320D4ED54B7C"] = {
            ["Desc"] = "格林枪",
            ["Duration"] = 5000,
            ["NodeTag"] = "CD723BDB3506406BA992320D4ED54B7C",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 207,
                ["x"] = 383,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
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
        ["BE0A8E2BC7914F5682557B077EA8BF21"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 0,
            ["Weight"] = 0,
            ["NodeTag"] = "BE0A8E2BC7914F5682557B077EA8BF21",
            ["RangeOrigin"] = {
                ["y"] = -100,
                ["x"] = -600,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 599,
                ["x"] = 1106,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 200,
                ["width"] = 1200,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["6845CF3A9C9F45968CE957B5D4CDF41B"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "6845CF3A9C9F45968CE957B5D4CDF41B",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 355,
                ["x"] = 1085,
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
            ["ID"] = 430220,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5C99A113E5944F00B3A093C9AAA536BC"] = {
            ["Desc"] = "闪避",
            ["Duration"] = 30000,
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
        ["AC787433B9894B17B6C4CBC7D1861DA1"] = {
            ["Pos"] = {
                ["y"] = 69,
                ["x"] = 633,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "AC787433B9894B17B6C4CBC7D1861DA1",
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
        ["FF324D583A7C48FEBAF32EC9C1B04A9F"] = {
            ["Desc"] = "格林枪",
            ["Pos"] = {
                ["y"] = 210,
                ["x"] = 1091,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
            ["ID"] = 430290,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
}