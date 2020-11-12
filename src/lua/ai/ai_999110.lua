return {
    ["links"] = {
        ["9682D00DC79346E98180A92FF3AA68AC"] = {
            [1] = "93DFB855C064456DB9000D9D8F8DF156",
        },
        ["F5018F3FCBF94007B8DD9E3387A4A7CA"] = {
            [1] = "E10538FDBAD04D918B3B7E27EE80C631",
        },
        ["0FFC7D67ACAB43E09E973355157D6799"] = {
            [1] = "3B5BC6216EA04A66B44C0DEDE0ABC5F3",
        },
        ["3505E382A7544EE2B90B4E3CF55A4C03"] = {
            [1] = "E10538FDBAD04D918B3B7E27EE80C631",
        },
        ["A77A97BB5CCB4203AD40A1B1F2A9B27A"] = {
            [1] = "2EE9DA2F12894C1893E1D973F145F486",
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            [1] = "6845CF3A9C9F45968CE957B5D4CDF41B",
        },
        ["099B50C61AFF447AB22E8390A0082FF7"] = {
            [1] = "BFA22C78BBA24438B74F74F836E0A1BE",
        },
        ["85A8873EE9324E589495E14A17C2EBF3"] = {
            [1] = "3505E382A7544EE2B90B4E3CF55A4C03",
            [2] = "F5018F3FCBF94007B8DD9E3387A4A7CA",
        },
        ["BDC25A6AE24A4592B9F81B8F1190274D"] = {
            [1] = "9682D00DC79346E98180A92FF3AA68AC",
        },
        ["6F5DB412D6454F3EB28231669D26F24C"] = {
            [1] = "099B50C61AFF447AB22E8390A0082FF7",
        },
        ["E10538FDBAD04D918B3B7E27EE80C631"] = {
            [1] = "BDC25A6AE24A4592B9F81B8F1190274D",
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            [1] = "177D2999CC624B62864E5BC5AB34D465",
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "9819F6D899A146C68C5BA9627C8AF861",
            [2] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            [3] = "E94CB20116DB4EC7AB5191B7A15F077B",
            [4] = "85A8873EE9324E589495E14A17C2EBF3",
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            [1] = "EB33A5DE88414BD39580766ED5745B34",
        },
        ["177D2999CC624B62864E5BC5AB34D465"] = {
            [1] = "6C26242DE73A45DF95446B8DDC6E066B",
        },
        ["E94CB20116DB4EC7AB5191B7A15F077B"] = {
            [1] = "0FFC7D67ACAB43E09E973355157D6799",
        },
    },
    ["nodes"] = {
        ["33924B878C3E4FC8A15E69018F6AB161"] = {
            ["Desc"] = "700120-连斩k  \
700130-招架i\
700140-异域穿刺l\
700150-闪避h\
700160-觉醒m\
700190-必杀u\
100931-反技后招",
            ["Duration"] = 13000,
            ["NodeTag"] = "33924B878C3E4FC8A15E69018F6AB161",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -419,
                ["x"] = 405,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["9819F6D899A146C68C5BA9627C8AF861"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 2000,
            ["NodeTag"] = "9819F6D899A146C68C5BA9627C8AF861",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 236,
                ["x"] = 395,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["A77A97BB5CCB4203AD40A1B1F2A9B27A"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 94,
                ["x"] = 1223,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "A77A97BB5CCB4203AD40A1B1F2A9B27A",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2EE9DA2F12894C1893E1D973F145F486"] = {
            ["Desc"] = "行为",
            ["Weight"] = 1,
            ["NodeTag"] = "2EE9DA2F12894C1893E1D973F145F486",
            ["Reset"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 69,
                ["x"] = 1487,
            },
            ["AddValue"] = 0,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "wuyiyi",
            ["Type"] = 0,
        },
        ["6C26242DE73A45DF95446B8DDC6E066B"] = {
            ["Desc"] = "普攻",
            ["Pos"] = {
                ["y"] = 240,
                ["x"] = 949,
            },
            ["Weight"] = 100,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6C26242DE73A45DF95446B8DDC6E066B",
            ["ID"] = 700110,
            ["Type"] = 1,
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
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "或守剧场-艾伦1",
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 132,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "999110",
            ["Name"] = "或守剧场-艾伦1",
            ["Static"] = true,
        },
        ["177D2999CC624B62864E5BC5AB34D465"] = {
            ["Pos"] = {
                ["y"] = 238,
                ["x"] = 636,
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
        ["E10538FDBAD04D918B3B7E27EE80C631"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = -74,
                ["x"] = 1172,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "E10538FDBAD04D918B3B7E27EE80C631",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["E94CB20116DB4EC7AB5191B7A15F077B"] = {
            ["Desc"] = "反技冷却模拟\
",
            ["Duration"] = 100,
            ["NodeTag"] = "E94CB20116DB4EC7AB5191B7A15F077B",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -198,
                ["x"] = 375,
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
        ["0FFC7D67ACAB43E09E973355157D6799"] = {
            ["Pos"] = {
                ["y"] = -202,
                ["x"] = 652,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "0FFC7D67ACAB43E09E973355157D6799",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["9682D00DC79346E98180A92FF3AA68AC"] = {
            ["Desc"] = "行为",
            ["Weight"] = 1,
            ["NodeTag"] = "9682D00DC79346E98180A92FF3AA68AC",
            ["Reset"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -61,
                ["x"] = 1668,
            },
            ["AddValue"] = 0,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["F5018F3FCBF94007B8DD9E3387A4A7CA"] = {
            ["Pos"] = {
                ["y"] = -93,
                ["x"] = 704,
            },
            ["Judge"] = 3,
            ["Class"] = "ConditionAssociationNode",
            ["NodeTag"] = "F5018F3FCBF94007B8DD9E3387A4A7CA",
            ["Value"] = 150,
            ["Key"] = "cd1",
            ["Static"] = false,
        },
        ["EB33A5DE88414BD39580766ED5745B34"] = {
            ["Pos"] = {
                ["y"] = 366,
                ["x"] = 621,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EB33A5DE88414BD39580766ED5745B34",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3B5BC6216EA04A66B44C0DEDE0ABC5F3"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "3B5BC6216EA04A66B44C0DEDE0ABC5F3",
            ["Reset"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = -209,
                ["x"] = 900,
            },
            ["AddValue"] = 1,
            ["Class"] = "AssociationBevNode",
            ["DelayTime"] = 0,
            ["Key"] = "cd1",
            ["Type"] = 0,
        },
        ["85A8873EE9324E589495E14A17C2EBF3"] = {
            ["Desc"] = "受伤监测",
            ["Duration"] = 100,
            ["NodeTag"] = "85A8873EE9324E589495E14A17C2EBF3",
            ["TriggerType"] = 1,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 0,
                ["x"] = 388,
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
                ["y"] = -63,
                ["x"] = 1885,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "93DFB855C064456DB9000D9D8F8DF156",
            ["ID"] = 700130,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["099B50C61AFF447AB22E8390A0082FF7"] = {
            ["Pos"] = {
                ["y"] = 125,
                ["x"] = 672,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "099B50C61AFF447AB22E8390A0082FF7",
            ["Duration"] = 0,
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
                ["y"] = 357,
                ["x"] = 874,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["2D6EEDDE2CE0484492D4AAA889C5CBF6"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 0,
            ["NodeTag"] = "2D6EEDDE2CE0484492D4AAA889C5CBF6",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 352,
                ["x"] = 406,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["3505E382A7544EE2B90B4E3CF55A4C03"] = {
            ["HurtValue"] = 100,
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
        ["BFA22C78BBA24438B74F74F836E0A1BE"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 117,
                ["x"] = 927,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "BFA22C78BBA24438B74F74F836E0A1BE",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BDC25A6AE24A4592B9F81B8F1190274D"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -70,
                ["x"] = 1366,
            },
            ["Weight"] = 1,
            ["Class"] = "InterruptAIBevNode",
            ["NodeTag"] = "BDC25A6AE24A4592B9F81B8F1190274D",
            ["Type"] = 0,
            ["InterruptWay"] = 2,
            ["Static"] = false,
        },
        ["117FAAFF7DB74678AD25C8F97BEF3045"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = -457,
                ["x"] = 1558,
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