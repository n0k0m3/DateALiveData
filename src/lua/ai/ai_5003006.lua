return {
    ["links"] = {
        ["E2B15C338E8B41379FA08058753AC133"] = {
            [1] = "DE0FE00B32F6444EB4FB83E66BD74144",
        },
        ["C84A59C719194B2B97DCAC2A0FCB909F"] = {
            [1] = "E4C997ACB8F24125B964033D24B822B0",
        },
        ["E4C997ACB8F24125B964033D24B822B0"] = {
            [1] = "E2B15C338E8B41379FA08058753AC133",
        },
    },
    ["nodes"] = {
        ["E2B15C338E8B41379FA08058753AC133"] = {
            ["Pos"] = {
                ["y"] = 306,
                ["x"] = 789,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "E2B15C338E8B41379FA08058753AC133",
            ["Duration"] = 1700,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["DE0FE00B32F6444EB4FB83E66BD74144"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 1116,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "DE0FE00B32F6444EB4FB83E66BD74144",
            ["ID"] = 2001012,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C84A59C719194B2B97DCAC2A0FCB909F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "C84A59C719194B2B97DCAC2A0FCB909F",
            ["ID"] = "5003006",
            ["Name"] = "wave8",
            ["Static"] = true,
        },
        ["E4C997ACB8F24125B964033D24B822B0"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1700,
            ["NodeTag"] = "E4C997ACB8F24125B964033D24B822B0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 299,
                ["x"] = 491,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "C84A59C719194B2B97DCAC2A0FCB909F",
}