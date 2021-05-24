return {
    ["links"] = {
        ["D72E338D12E647B3A0678C3CCB875580"] = {
            [1] = "07650EA7E73F47FFAECBA0791E000321",
        },
        ["EEA80D327B20409895AB9AD3033F1FBD"] = {
            [1] = "A14288304ADE4ED6AF23C4E38DAF7314",
        },
        ["C86563B5C3C84F23A60FC7A9B50131D8"] = {
            [1] = "A01DEDA1244D4F66BE1A25D93FC8F355",
        },
        ["A14288304ADE4ED6AF23C4E38DAF7314"] = {
            [1] = "643FAD09D9064B0B988C84DBE935D5E3",
        },
        ["94BB9406C3D747DA91C481562C12C1EC"] = {
            [1] = "9177757D7090468787EF958BAE4B89C6",
        },
        ["D70682AA0049415090B60AA8F206511A"] = {
            [1] = "0B0F5B33795E4EBAB101BE415DACFDC7",
        },
        ["A01DEDA1244D4F66BE1A25D93FC8F355"] = {
            [1] = "94BB9406C3D747DA91C481562C12C1EC",
        },
        ["FB506240F0F643268741530DD7870E17"] = {
            [1] = "D70682AA0049415090B60AA8F206511A",
        },
        ["32F286C9C9B44C6DA9B57154FA4CF5B2"] = {
            [1] = "AC81211F6CEE42388E7561E77F3CEA83",
        },
        ["07650EA7E73F47FFAECBA0791E000321"] = {
            [1] = "4D575CBDAB9447778558DDA3263F253A",
        },
        ["4D575CBDAB9447778558DDA3263F253A"] = {
            [1] = "D4F027BA257F48D68BD480FFB0CD217A",
        },
        ["0B0F5B33795E4EBAB101BE415DACFDC7"] = {
            [1] = "9D4A1941C641428B975C8C7EF423D3D3",
            [2] = "32F286C9C9B44C6DA9B57154FA4CF5B2",
            [3] = "EFAB2EBC347948908382C2B928B9A9ED",
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            [1] = "FB506240F0F643268741530DD7870E17",
            [2] = "D72E338D12E647B3A0678C3CCB875580",
        },
        ["643FAD09D9064B0B988C84DBE935D5E3"] = {
            [1] = "EE8EB5DE73394BB383B310992C72E619",
        },
    },
    ["nodes"] = {
        ["EEA80D327B20409895AB9AD3033F1FBD"] = {
            ["Desc"] = "闪避",
            ["Duration"] = 10000,
            ["NodeTag"] = "EEA80D327B20409895AB9AD3033F1FBD",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 1226,
                ["x"] = 120,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 5,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["9D4A1941C641428B975C8C7EF423D3D3"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 697,
                ["x"] = 869,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9D4A1941C641428B975C8C7EF423D3D3",
            ["ID"] = 430710,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C86563B5C3C84F23A60FC7A9B50131D8"] = {
            ["Desc"] = "施放技能",
            ["Duration"] = 15000,
            ["NodeTag"] = "C86563B5C3C84F23A60FC7A9B50131D8",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 1107,
                ["x"] = 121,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["A14288304ADE4ED6AF23C4E38DAF7314"] = {
            ["Pos"] = {
                ["y"] = 1226,
                ["x"] = 412,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "A14288304ADE4ED6AF23C4E38DAF7314",
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
        ["94BB9406C3D747DA91C481562C12C1EC"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 1104,
                ["x"] = 684,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "94BB9406C3D747DA91C481562C12C1EC",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["9177757D7090468787EF958BAE4B89C6"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 1108,
                ["x"] = 873,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "9177757D7090468787EF958BAE4B89C6",
            ["ID"] = 430780,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["D4F027BA257F48D68BD480FFB0CD217A"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "D4F027BA257F48D68BD480FFB0CD217A",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 986,
                ["x"] = 818,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["FB506240F0F643268741530DD7870E17"] = {
            ["Desc"] = "普通攻击",
            ["Duration"] = 3000,
            ["NodeTag"] = "FB506240F0F643268741530DD7870E17",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 826,
                ["x"] = 128,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["32F286C9C9B44C6DA9B57154FA4CF5B2"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 803,
                ["x"] = 877,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "32F286C9C9B44C6DA9B57154FA4CF5B2",
            ["ID"] = 430740,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["AC81211F6CEE42388E7561E77F3CEA83"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 800,
                ["x"] = 1073,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "AC81211F6CEE42388E7561E77F3CEA83",
            ["ID"] = 430790,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["643FAD09D9064B0B988C84DBE935D5E3"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 1225,
                ["x"] = 686,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "643FAD09D9064B0B988C84DBE935D5E3",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["D72E338D12E647B3A0678C3CCB875580"] = {
            ["Desc"] = "巡逻",
            ["Duration"] = 500,
            ["NodeTag"] = "D72E338D12E647B3A0678C3CCB875580",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 985,
                ["x"] = 124,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["EE8EB5DE73394BB383B310992C72E619"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 1226,
                ["x"] = 891,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "EE8EB5DE73394BB383B310992C72E619",
            ["ID"] = 430740,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["D70682AA0049415090B60AA8F206511A"] = {
            ["Pos"] = {
                ["y"] = 829,
                ["x"] = 357,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "D70682AA0049415090B60AA8F206511A",
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
        ["A01DEDA1244D4F66BE1A25D93FC8F355"] = {
            ["Pos"] = {
                ["y"] = 1103,
                ["x"] = 391,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "A01DEDA1244D4F66BE1A25D93FC8F355",
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
        ["07650EA7E73F47FFAECBA0791E000321"] = {
            ["Pos"] = {
                ["y"] = 990,
                ["x"] = 399,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "07650EA7E73F47FFAECBA0791E000321",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4D575CBDAB9447778558DDA3263F253A"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 982,
                ["x"] = 643,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "4D575CBDAB9447778558DDA3263F253A",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["0B0F5B33795E4EBAB101BE415DACFDC7"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 826,
                ["x"] = 670,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "0B0F5B33795E4EBAB101BE415DACFDC7",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["EFAB2EBC347948908382C2B928B9A9ED"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 881,
                ["x"] = 875,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "EFAB2EBC347948908382C2B928B9A9ED",
            ["ID"] = 430720,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 1019,
                ["x"] = -166,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "51B39C60ABC1457DA23F5EC1E94F6217",
            ["ID"] = "999215",
            ["Name"] = "主线12章地狱耶俱矢",
            ["Static"] = true,
        },
    },
    ["root"] = "51B39C60ABC1457DA23F5EC1E94F6217",
}