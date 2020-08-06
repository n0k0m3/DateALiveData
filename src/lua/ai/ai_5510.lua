return {
    ["links"] = {
        ["1C5EF0B1E32A497581AC1F3008A269AB"] = {
            [1] = "46E0BA90433344FFB2F443FA442969CB",
            [2] = "3D95212D932D422590A9F9E5ABBD07BC",
        },
        ["603CC1DAAADE4D5CAE6369F076F50A5C"] = {
            [1] = "1C5EF0B1E32A497581AC1F3008A269AB",
        },
        ["2F384AA0DEF54DE9868B7AA039EDDE86"] = {
            [1] = "491FEA07BF7E497C8CC8A8B62BEFB0F6",
        },
        ["491FEA07BF7E497C8CC8A8B62BEFB0F6"] = {
            [1] = "603CC1DAAADE4D5CAE6369F076F50A5C",
        },
    },
    ["nodes"] = {
        ["2F384AA0DEF54DE9868B7AA039EDDE86"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "2F384AA0DEF54DE9868B7AA039EDDE86",
            ["ID"] = "5510",
            ["Name"] = "变兔子",
            ["Static"] = true,
        },
        ["1C5EF0B1E32A497581AC1F3008A269AB"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 861,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "1C5EF0B1E32A497581AC1F3008A269AB",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["3D95212D932D422590A9F9E5ABBD07BC"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 419,
                ["x"] = 1059,
            },
            ["Weight"] = 70,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "3D95212D932D422590A9F9E5ABBD07BC",
            ["DelayTime"] = 1500,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["603CC1DAAADE4D5CAE6369F076F50A5C"] = {
            ["Pos"] = {
                ["y"] = 330,
                ["x"] = 617,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "603CC1DAAADE4D5CAE6369F076F50A5C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["46E0BA90433344FFB2F443FA442969CB"] = {
            ["Desc"] = "行为",
            ["Weight"] = 70,
            ["NodeTag"] = "46E0BA90433344FFB2F443FA442969CB",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 246,
                ["x"] = 1065,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["491FEA07BF7E497C8CC8A8B62BEFB0F6"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "491FEA07BF7E497C8CC8A8B62BEFB0F6",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 307,
                ["x"] = 393,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["root"] = "2F384AA0DEF54DE9868B7AA039EDDE86",
}