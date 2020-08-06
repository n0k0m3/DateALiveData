return {
    ["links"] = {
        ["5EBB0F2C6E4D4D3F9B44F961527E8E68"] = {
            [1] = "1B73DFE25D104B1994C377C9EE2E7FD0",
        },
        ["3938326460C8453BB76C32D462AB3A3B"] = {
            [1] = "02FA953088CE45918C5AE8FD3D2A65E2",
        },
        ["1B73DFE25D104B1994C377C9EE2E7FD0"] = {
            [1] = "3938326460C8453BB76C32D462AB3A3B",
        },
    },
    ["nodes"] = {
        ["5EBB0F2C6E4D4D3F9B44F961527E8E68"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 408,
                ["x"] = 199,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "5EBB0F2C6E4D4D3F9B44F961527E8E68",
            ["ID"] = "5001004",
            ["Name"] = "wave6",
            ["Static"] = true,
        },
        ["3938326460C8453BB76C32D462AB3A3B"] = {
            ["Pos"] = {
                ["y"] = 412,
                ["x"] = 685,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "3938326460C8453BB76C32D462AB3A3B",
            ["Duration"] = 200,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1B73DFE25D104B1994C377C9EE2E7FD0"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 200,
            ["NodeTag"] = "1B73DFE25D104B1994C377C9EE2E7FD0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 407,
                ["x"] = 406,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["02FA953088CE45918C5AE8FD3D2A65E2"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 394,
                ["x"] = 1020,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "02FA953088CE45918C5AE8FD3D2A65E2",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "5EBB0F2C6E4D4D3F9B44F961527E8E68",
}