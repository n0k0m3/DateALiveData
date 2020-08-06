return {
    ["links"] = {
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "7587C276F0BD4A478265C83CA8F8D51C",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "E04DC2142EDB4410BD175EDE53FCE10D",
        },
        ["7587C276F0BD4A478265C83CA8F8D51C"] = {
            [1] = "A960BCAF33EB492BB27F498F058E433B",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["1A75F26369BA45119AA4E17E88E9E48F"] = {
            [1] = "9819F6D899A146C68C5BA9627C8AF861",
            [2] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
        },
        ["A960BCAF33EB492BB27F498F058E433B"] = {
            [1] = "6C26242DE73A45DF95446B8DDC6E066B",
        },
    },
    ["nodes"] = {
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 15,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 235,
                ["x"] = 421,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
        },
        ["7587C276F0BD4A478265C83CA8F8D51C"] = {
            ["Pos"] = {
                ["y"] = 238,
                ["x"] = 684,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "7587C276F0BD4A478265C83CA8F8D51C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["E04DC2142EDB4410BD175EDE53FCE10D"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 418,
                ["x"] = 985,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E04DC2142EDB4410BD175EDE53FCE10D",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["1A75F26369BA45119AA4E17E88E9E48F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 329,
                ["x"] = 217,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "1A75F26369BA45119AA4E17E88E9E48F",
            ["ID"] = "880001",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["6C26242DE73A45DF95446B8DDC6E066B"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 222,
                ["x"] = 1166,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C26242DE73A45DF95446B8DDC6E066B",
            ["ID"] = 100110,
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
                ["y"] = 420,
                ["x"] = 1196,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["A960BCAF33EB492BB27F498F058E433B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 224,
                ["x"] = 977,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "A960BCAF33EB492BB27F498F058E433B",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 411,
                ["x"] = 436,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            ["Pos"] = {
                ["y"] = 414,
                ["x"] = 688,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EB33A5DE88414BD39580766ED5745B34",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "1A75F26369BA45119AA4E17E88E9E48F",
}