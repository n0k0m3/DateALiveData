return {
    ["links"] = {
        ["282B25C10E5644A0A4479E896FF48DC6"] = {
            [1] = "E84C95B6A0864B68AE29BF8602BF5178",
        },
        ["E84C95B6A0864B68AE29BF8602BF5178"] = {
            [1] = "82836464FF4C4BE4AE296E69B909ED61",
        },
        ["82836464FF4C4BE4AE296E69B909ED61"] = {
            [1] = "1BF39FCC1FD0416D8E80110842F50925",
        },
    },
    ["nodes"] = {
        ["282B25C10E5644A0A4479E896FF48DC6"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 303,
                ["x"] = 238,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "282B25C10E5644A0A4479E896FF48DC6",
            ["ID"] = "10020902",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
        ["E84C95B6A0864B68AE29BF8602BF5178"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 50,
            ["NodeTag"] = "E84C95B6A0864B68AE29BF8602BF5178",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 297,
                ["x"] = 495,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["1BF39FCC1FD0416D8E80110842F50925"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 291,
                ["x"] = 1080,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1BF39FCC1FD0416D8E80110842F50925",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["82836464FF4C4BE4AE296E69B909ED61"] = {
            ["Pos"] = {
                ["y"] = 313,
                ["x"] = 747,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "82836464FF4C4BE4AE296E69B909ED61",
            ["Duration"] = 50,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "282B25C10E5644A0A4479E896FF48DC6",
}