return {
    ["links"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "EE219BD6C5824D6985D30A007B4F0889",
        },
        ["1338223F68BA42288B8B9395F63A191B"] = {
            [1] = "C251E537D8F14BF886463B2855E99309",
        },
        ["79E2E45C6DC34B1E828D465A00E0C630"] = {
            [1] = "3F7BBB0E49914AF5A2530F9B04C06DF0",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [2] = "42E9FF0EDCCF47CF8B6056D43B9596B2",
            [3] = "2D8C680626644298B763C5F189987D4B",
        },
        ["2D8C680626644298B763C5F189987D4B"] = {
            [1] = "997B0F9CF49E46CCAB1E7AF6585F5D10",
        },
        ["0C50D198697C46C79C0E2D9CC94C6611"] = {
            [1] = "CC37EA8685574DAF9BBA784B615236A0",
        },
        ["C251E537D8F14BF886463B2855E99309"] = {
            [1] = "4EEEAA624D9C4CE4B80593068DDD2EE2",
        },
        ["30EEB06AF39C46609EB98269B1DA4417"] = {
            [1] = "79E2E45C6DC34B1E828D465A00E0C630",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "C30892EBEE96406FA983A6BB3355DFD9",
        },
        ["CC37EA8685574DAF9BBA784B615236A0"] = {
            [1] = "4301BC5312774E04ADCEE796CB64F135",
            [2] = "2EBEB7C05A964B058473B92019C108EE",
        },
        ["EE219BD6C5824D6985D30A007B4F0889"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["997B0F9CF49E46CCAB1E7AF6585F5D10"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["42E9FF0EDCCF47CF8B6056D43B9596B2"] = {
            [1] = "0C50D198697C46C79C0E2D9CC94C6611",
        },
    },
    ["nodes"] = {
        ["C30892EBEE96406FA983A6BB3355DFD9"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "C30892EBEE96406FA983A6BB3355DFD9",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 1176,
                ["x"] = 976,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["1338223F68BA42288B8B9395F63A191B"] = {
            ["Desc"] = "闪现攻击\
\
",
            ["Duration"] = 15000,
            ["NodeTag"] = "1338223F68BA42288B8B9395F63A191B",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 520,
                ["x"] = 198,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 5,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["79E2E45C6DC34B1E828D465A00E0C630"] = {
            ["Pos"] = {
                ["y"] = 626,
                ["x"] = 518,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "79E2E45C6DC34B1E828D465A00E0C630",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2D8C680626644298B763C5F189987D4B"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 1000,
            ["NodeTag"] = "2D8C680626644298B763C5F189987D4B",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 1177,
                ["x"] = 265,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["0C50D198697C46C79C0E2D9CC94C6611"] = {
            ["Pos"] = {
                ["y"] = 911,
                ["x"] = 414,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "0C50D198697C46C79C0E2D9CC94C6611",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["EE219BD6C5824D6985D30A007B4F0889"] = {
            ["Pos"] = {
                ["y"] = 740,
                ["x"] = 499,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "EE219BD6C5824D6985D30A007B4F0889",
            ["RangeY"] = {
                [1] = 0,
                [2] = 100,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 300,
            },
            ["Static"] = false,
        },
        ["997B0F9CF49E46CCAB1E7AF6585F5D10"] = {
            ["Pos"] = {
                ["y"] = 1186,
                ["x"] = 566,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "997B0F9CF49E46CCAB1E7AF6585F5D10",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "普攻\
\
",
            ["Duration"] = 3000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 741,
                ["x"] = 224,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 3,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["4EEEAA624D9C4CE4B80593068DDD2EE2"] = {
            ["Desc"] = "必杀",
            ["Pos"] = {
                ["y"] = 512,
                ["x"] = 844,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4EEEAA624D9C4CE4B80593068DDD2EE2",
            ["ID"] = 700430,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C4D95EE06A1D4661B677ACF2F543CB2B"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 890,
                ["x"] = 1024,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "C4D95EE06A1D4661B677ACF2F543CB2B",
            ["DelayTime"] = 1000,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["341F1E6268784C4583FEE6B1B9203107"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 1014,
                ["x"] = 1015,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "341F1E6268784C4583FEE6B1B9203107",
            ["DelayTime"] = 1000,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["2EBEB7C05A964B058473B92019C108EE"] = {
            ["Desc"] = "沉默陷阱\
\
\
",
            ["Pos"] = {
                ["y"] = 889,
                ["x"] = 850,
            },
            ["Weight"] = 4,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2EBEB7C05A964B058473B92019C108EE",
            ["ID"] = 700492,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C251E537D8F14BF886463B2855E99309"] = {
            ["Pos"] = {
                ["y"] = 525,
                ["x"] = 518,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "C251E537D8F14BF886463B2855E99309",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["30EEB06AF39C46609EB98269B1DA4417"] = {
            ["Desc"] = "闪现攻击\
\
",
            ["Duration"] = 10000,
            ["NodeTag"] = "30EEB06AF39C46609EB98269B1DA4417",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 619,
                ["x"] = 199,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["42E9FF0EDCCF47CF8B6056D43B9596B2"] = {
            ["Desc"] = "扔陷阱\
",
            ["Duration"] = 3000,
            ["NodeTag"] = "42E9FF0EDCCF47CF8B6056D43B9596B2",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 906,
                ["x"] = 207,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Parallel"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            ["Desc"] = "--\
",
            ["Pos"] = {
                ["y"] = 903,
                ["x"] = -62,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
            ["ID"] = "999106",
            ["Name"] = "或守剧场-鞠奈2",
            ["Static"] = true,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 1179,
                ["x"] = 799,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["4301BC5312774E04ADCEE796CB64F135"] = {
            ["Desc"] = "旋涡\
\
\
\
",
            ["Pos"] = {
                ["y"] = 1014,
                ["x"] = 851,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "4301BC5312774E04ADCEE796CB64F135",
            ["ID"] = 700493,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "普通攻击\
",
            ["Pos"] = {
                ["y"] = 738,
                ["x"] = 848,
            },
            ["Weight"] = 20,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 700400,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3F7BBB0E49914AF5A2530F9B04C06DF0"] = {
            ["Desc"] = "闪现攻击\
",
            ["Pos"] = {
                ["y"] = 612,
                ["x"] = 847,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3F7BBB0E49914AF5A2530F9B04C06DF0",
            ["ID"] = 700410,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["CC37EA8685574DAF9BBA784B615236A0"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 900,
                ["x"] = 670,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "CC37EA8685574DAF9BBA784B615236A0",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}