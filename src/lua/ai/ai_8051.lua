return {
    ["links"] = {
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "9A1168B0FD524E60B867DAFDBCC15575",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["C623F2B5C9354B89B563A732A89ADEF8"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            [1] = "4804848BEDB645769A946956F518ACFE",
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            [1] = "B4EE3137C6694033A4247717B8DA8793",
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            [1] = "10BACACBAEC44142BB3C2E30BE039DDC",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            [1] = "7FDE956703314DE4918BAEDE7271D0D7",
            [2] = "C623F2B5C9354B89B563A732A89ADEF8",
        },
        ["7FDE956703314DE4918BAEDE7271D0D7"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            [1] = "E2B9076F5448423DAAB2952E3DF36AF1",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["B4EE3137C6694033A4247717B8DA8793"] = {
            [1] = "91DD393B8F4E4D66B8455BFC17289F60",
        },
    },
    ["nodes"] = {
        ["7FDE956703314DE4918BAEDE7271D0D7"] = {
            ["Pos"] = {
                ["y"] = 73,
                ["x"] = 731,
            },
            ["Property"] = 52,
            ["Class"] = "ConditionPropertyNode",
            ["NodeTag"] = "7FDE956703314DE4918BAEDE7271D0D7",
            ["Value"] = 9999,
            ["Judge"] = 3,
            ["Static"] = false,
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -58,
                ["x"] = 902,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["10BACACBAEC44142BB3C2E30BE039DDC"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 272,
                ["x"] = 1423,
            },
            ["Weight"] = 0,
            ["Class"] = "FollowBevNode",
            ["NodeTag"] = "10BACACBAEC44142BB3C2E30BE039DDC",
            ["Distance"] = 100,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = -85,
                ["x"] = 646,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9A1168B0FD524E60B867DAFDBCC15575"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -50,
                ["x"] = 1134,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "9A1168B0FD524E60B867DAFDBCC15575",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["C623F2B5C9354B89B563A732A89ADEF8"] = {
            ["OperatorY"] = 2,
            ["Pos"] = {
                ["y"] = 257,
                ["x"] = 720,
            },
            ["OperatorX"] = 2,
            ["Class"] = "ConditionPlayerDistanceNode",
            ["NodeTag"] = "C623F2B5C9354B89B563A732A89ADEF8",
            ["DistanceY"] = 10,
            ["DistanceX"] = 100,
            ["Static"] = false,
        },
        ["768D2CCA84884A06AF834B3299052885"] = {
            ["Desc"] = "雪球手雷\
",
            ["Duration"] = 4000,
            ["NodeTag"] = "768D2CCA84884A06AF834B3299052885",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 437,
                ["x"] = 410,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 1000,
                [2] = 1000,
            },
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "推雪球",
            ["Duration"] = 0,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -4,
                ["x"] = 435,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["E2B9076F5448423DAAB2952E3DF36AF1"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 440,
                ["x"] = 913,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E2B9076F5448423DAAB2952E3DF36AF1",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["B4EE3137C6694033A4247717B8DA8793"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 600,
            ["Weight"] = 0,
            ["NodeTag"] = "B4EE3137C6694033A4247717B8DA8793",
            ["RangeOrigin"] = {
                ["y"] = -15,
                ["x"] = -800,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 435,
                ["x"] = 1076,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 30,
                ["width"] = 1600,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 383,
                ["x"] = 1242,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 309350,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 0,
            ["NodeTag"] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
            ["Force"] = 0,
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 152,
                ["x"] = 434,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["91DD393B8F4E4D66B8455BFC17289F60"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 435,
                ["x"] = 1214,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "91DD393B8F4E4D66B8455BFC17289F60",
            ["ID"] = 309360,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 155,
                ["x"] = 1062,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "711396D9C1B34958870908CA364A2153",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = -31,
                ["x"] = 185,
            },
            ["Category"] = 11,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "8051",
            ["Name"] = "雪人蓝(守护雪人)",
            ["Static"] = true,
        },
        ["4804848BEDB645769A946956F518ACFE"] = {
            ["Pos"] = {
                ["y"] = 465,
                ["x"] = 628,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4804848BEDB645769A946956F518ACFE",
            ["Duration"] = 4000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}