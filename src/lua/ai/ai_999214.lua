return {
    ["links"] = {
        ["088CECE2150D40F6A9C98AE28DCF3524"] = {
            [1] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "632E29B47A6847FD88BED02E13C60491",
        },
        ["BF049D7F0FC74704948B0D02F75A5509"] = {
            [1] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "E04DC2142EDB4410BD175EDE53FCE10D",
        },
        ["C6316271D41547DD8B96C0025350AA2C"] = {
            [1] = "84669459F663471D98C6EFF39EAB078B",
        },
        ["1056ED86E473461F8ECAA7A1DFA84D29"] = {
            [1] = "C6316271D41547DD8B96C0025350AA2C",
        },
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["632E29B47A6847FD88BED02E13C60491"] = {
            [1] = "5F4FD01BE16842F1A05227BD69159C05",
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            [1] = "FF9F5350CA484FAE84FC9D798CCBE748",
        },
        ["5C99A113E5944F00B3A093C9AAA536BC"] = {
            [1] = "BF049D7F0FC74704948B0D02F75A5509",
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "9819F6D899A146C68C5BA9627C8AF861",
            [2] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            [1] = "1056ED86E473461F8ECAA7A1DFA84D29",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["5F4FD01BE16842F1A05227BD69159C05"] = {
            [1] = "B9E0479831DD4A1AB84D641644AA6CB8",
            [2] = "088CECE2150D40F6A9C98AE28DCF3524",
            [3] = "593A641709F5413889B0CA564581C29D",
        },
    },
    ["nodes"] = {
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 7000,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 202,
                ["x"] = 393,
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
                ["y"] = 602,
                ["x"] = 677,
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
        ["FF324D583A7C48FEBAF32EC9C1B04A9F"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 198,
                ["x"] = 1504,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF324D583A7C48FEBAF32EC9C1B04A9F",
            ["ID"] = 481020,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "美久\
",
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 132,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "999214",
            ["Name"] = "主线12章地狱美久",
            ["Static"] = true,
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            ["Desc"] = "施放技能",
            ["Duration"] = 20000,
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
                ["y"] = 258,
                ["x"] = 884,
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
                ["y"] = 602,
                ["x"] = 1156,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "FF9F5350CA484FAE84FC9D798CCBE748",
            ["ID"] = 481050,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5AA537BB32A24D0389B4CB1FFCA0EA3D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 601,
                ["x"] = 951,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "5AA537BB32A24D0389B4CB1FFCA0EA3D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["1056ED86E473461F8ECAA7A1DFA84D29"] = {
            ["Pos"] = {
                ["y"] = 468,
                ["x"] = 641,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "1056ED86E473461F8ECAA7A1DFA84D29",
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
        ["632E29B47A6847FD88BED02E13C60491"] = {
            ["Pos"] = {
                ["y"] = 205,
                ["x"] = 620,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "632E29B47A6847FD88BED02E13C60491",
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
        ["B9E0479831DD4A1AB84D641644AA6CB8"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 39,
                ["x"] = 1270,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "B9E0479831DD4A1AB84D641644AA6CB8",
            ["ID"] = 481010,
            ["Type"] = 1,
            ["Static"] = false,
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
            ["ID"] = 481040,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6845CF3A9C9F45968CE957B5D4CDF41B"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "6845CF3A9C9F45968CE957B5D4CDF41B",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 371,
                ["x"] = 1074,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["593A641709F5413889B0CA564581C29D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 295,
                ["x"] = 1332,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "593A641709F5413889B0CA564581C29D",
            ["ID"] = 481030,
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
        ["088CECE2150D40F6A9C98AE28DCF3524"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 213,
                ["x"] = 1316,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "088CECE2150D40F6A9C98AE28DCF3524",
            ["ID"] = 481050,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
}