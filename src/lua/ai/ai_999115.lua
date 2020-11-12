return {
    ["links"] = {
        ["33924B878C3E4FC8A15E69018F6AB161"] = {
            [1] = "71B9386771D842068C6DBD8103AF16D4",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "177D2999CC624B62864E5BC5AB34D465",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["C8A08B40AF1D49CF8D2606899E32BBAB"] = {
            [1] = "91B5B4A88E0245AEB1499D9CD10FC707",
        },
        ["6F5DB412D6454F3EB28231669D26F24C"] = {
            [1] = "F9644B6A25774DC797CE04ACD47A7861",
        },
        ["3E4538A98A764A33AB3F5E8EEF9D3768"] = {
            [1] = "BDC25A6AE24A4592B9F81B8F1190274D",
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "33924B878C3E4FC8A15E69018F6AB161",
            [2] = "D805096B9F9E4098BA6D93859A84D14A",
            [3] = "9819F6D899A146C68C5BA9627C8AF861",
            [4] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            [5] = "C8A08B40AF1D49CF8D2606899E32BBAB",
            [6] = "85A8873EE9324E589495E14A17C2EBF3",
        },
        ["177D2999CC624B62864E5BC5AB34D465"] = {
            [1] = "6C26242DE73A45DF95446B8DDC6E066B",
        },
        ["F9644B6A25774DC797CE04ACD47A7861"] = {
            [1] = "BFA22C78BBA24438B74F74F836E0A1BE",
        },
        ["91B5B4A88E0245AEB1499D9CD10FC707"] = {
            [1] = "4BF893C130F54546830565B429FF2793",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["85A8873EE9324E589495E14A17C2EBF3"] = {
            [1] = "3505E382A7544EE2B90B4E3CF55A4C03",
            [2] = "44690C09194E416BBB208C5043D0DCB2",
        },
        ["BDC25A6AE24A4592B9F81B8F1190274D"] = {
            [1] = "AC87FCE641244A0B8DCC25D9E13A42E4",
        },
        ["3505E382A7544EE2B90B4E3CF55A4C03"] = {
            [1] = "3E4538A98A764A33AB3F5E8EEF9D3768",
        },
        ["D805096B9F9E4098BA6D93859A84D14A"] = {
            [1] = "BD579FD258944177B1D82C4B1709B69D",
        },
        ["44690C09194E416BBB208C5043D0DCB2"] = {
            [1] = "3E4538A98A764A33AB3F5E8EEF9D3768",
        },
        ["AC87FCE641244A0B8DCC25D9E13A42E4"] = {
            [1] = "93DFB855C064456DB9000D9D8F8DF156",
        },
        ["BD579FD258944177B1D82C4B1709B69D"] = {
            [1] = "088CECE2150D40F6A9C98AE28DCF3524",
        },
        ["71B9386771D842068C6DBD8103AF16D4"] = {
            [1] = "1989B20E214F45558238612D4CBBE722",
        },
    },
    ["nodes"] = {
        ["3505E382A7544EE2B90B4E3CF55A4C03"] = {
            ["HurtValue"] = 1,
            ["Pos"] = {
                ["y"] = 8,
                ["x"] = 681,
            },
            ["SkillHurt"] = 1,
            ["Class"] = "CheckHurtTypeBevNode",
            ["NodeTag"] = "3505E382A7544EE2B90B4E3CF55A4C03",
            ["hurtTime"] = 100,
            ["NormalHurt"] = 1,
            ["Static"] = false,
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 5000,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 494,
                ["x"] = 382,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 70,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 1000,
            ["NodeTag"] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 633,
                ["x"] = 377,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["6C26242DE73A45DF95446B8DDC6E066B"] = {
            ["Desc"] = "普攻",
            ["Pos"] = {
                ["y"] = 498,
                ["x"] = 954,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C26242DE73A45DF95446B8DDC6E066B",
            ["ID"] = 700110,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["71B9386771D842068C6DBD8103AF16D4"] = {
            ["Pos"] = {
                ["y"] = 221,
                ["x"] = 685,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "71B9386771D842068C6DBD8103AF16D4",
            ["RangeY"] = {
                [1] = 0,
                [2] = 40,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 400,
            },
            ["Static"] = false,
        },
        ["6F5DB412D6454F3EB28231669D26F24C"] = {
            ["Desc"] = "施放反技",
            ["Duration"] = 0,
            ["NodeTag"] = "6F5DB412D6454F3EB28231669D26F24C",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 114,
                ["x"] = 387,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 2,
            ["Priority"] = 100,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3E4538A98A764A33AB3F5E8EEF9D3768"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -60,
                ["x"] = 1091,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "3E4538A98A764A33AB3F5E8EEF9D3768",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "或守剧场-艾伦1",
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 132,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "999115",
            ["Name"] = "或守剧场-艾伦1",
            ["Static"] = true,
        },
        ["4BF893C130F54546830565B429FF2793"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "4BF893C130F54546830565B429FF2793",
            ["Reset"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -250,
                ["x"] = 930,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["177D2999CC624B62864E5BC5AB34D465"] = {
            ["Pos"] = {
                ["y"] = 494,
                ["x"] = 630,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "177D2999CC624B62864E5BC5AB34D465",
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
        ["33924B878C3E4FC8A15E69018F6AB161"] = {
            ["Desc"] = "700120-连斩k  \
700130-招架i\
700140-异域穿刺l\
700150-闪避h\
700160-觉醒m\
700190-必杀u",
            ["Duration"] = 25000,
            ["NodeTag"] = "33924B878C3E4FC8A15E69018F6AB161",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 190,
                ["x"] = 370,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 90,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["088CECE2150D40F6A9C98AE28DCF3524"] = {
            ["Desc"] = "技能1-连斩",
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 924,
            },
            ["Weight"] = 50,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "088CECE2150D40F6A9C98AE28DCF3524",
            ["ID"] = 700120,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["AC87FCE641244A0B8DCC25D9E13A42E4"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "AC87FCE641244A0B8DCC25D9E13A42E4",
            ["Reset"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -64,
                ["x"] = 1522,
            },
            ["AddValue"] = 0,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["F9644B6A25774DC797CE04ACD47A7861"] = {
            ["Pos"] = {
                ["y"] = 123,
                ["x"] = 639,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "F9644B6A25774DC797CE04ACD47A7861",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["91B5B4A88E0245AEB1499D9CD10FC707"] = {
            ["Pos"] = {
                ["y"] = -242,
                ["x"] = 657,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "91B5B4A88E0245AEB1499D9CD10FC707",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C8A08B40AF1D49CF8D2606899E32BBAB"] = {
            ["Desc"] = "反技冷却模拟",
            ["Duration"] = 100,
            ["NodeTag"] = "C8A08B40AF1D49CF8D2606899E32BBAB",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -250,
                ["x"] = 384,
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
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            ["Pos"] = {
                ["y"] = 642,
                ["x"] = 635,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EB33A5DE88414BD39580766ED5745B34",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BDC25A6AE24A4592B9F81B8F1190274D"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -62,
                ["x"] = 1242,
            },
            ["Weight"] = 1,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "BDC25A6AE24A4592B9F81B8F1190274D",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["85A8873EE9324E589495E14A17C2EBF3"] = {
            ["Desc"] = "受伤监测",
            ["Duration"] = 100,
            ["NodeTag"] = "85A8873EE9324E589495E14A17C2EBF3",
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -17,
                ["x"] = 382,
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
        ["93DFB855C064456DB9000D9D8F8DF156"] = {
            ["Desc"] = "反技",
            ["Pos"] = {
                ["y"] = -61,
                ["x"] = 1712,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "93DFB855C064456DB9000D9D8F8DF156",
            ["ID"] = 700130,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1989B20E214F45558238612D4CBBE722"] = {
            ["Desc"] = "技能2-异域穿刺",
            ["Pos"] = {
                ["y"] = 220,
                ["x"] = 988,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1989B20E214F45558238612D4CBBE722",
            ["ID"] = 700140,
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
                ["y"] = 638,
                ["x"] = 947,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["D805096B9F9E4098BA6D93859A84D14A"] = {
            ["Desc"] = "连斩",
            ["Duration"] = 15000,
            ["NodeTag"] = "D805096B9F9E4098BA6D93859A84D14A",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 396,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 80,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["44690C09194E416BBB208C5043D0DCB2"] = {
            ["Pos"] = {
                ["y"] = -89,
                ["x"] = 700,
            },
            ["Judge"] = 3,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "44690C09194E416BBB208C5043D0DCB2",
            ["Value"] = 50,
            ["Key"] = "cd1",
            ["Static"] = false,
        },
        ["BFA22C78BBA24438B74F74F836E0A1BE"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 116,
                ["x"] = 898,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "BFA22C78BBA24438B74F74F836E0A1BE",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BD579FD258944177B1D82C4B1709B69D"] = {
            ["Pos"] = {
                ["y"] = 355,
                ["x"] = 626,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "BD579FD258944177B1D82C4B1709B69D",
            ["RangeY"] = {
                [1] = 0,
                [2] = 30,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["117FAAFF7DB74678AD25C8F97BEF3045"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -192,
                ["x"] = 1439,
            },
            ["Weight"] = 1,
            ["Class"] = "ChooseAILinkBevNode",
            ["NodeTag"] = "117FAAFF7DB74678AD25C8F97BEF3045",
            ["ChooseLinkId"] = 100,
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
}