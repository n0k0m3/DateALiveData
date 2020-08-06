return {
    ["links"] = {
        ["118C046869A44C85A457057708CBC816"] = {
            [1] = "290A1EFB2EE44216B1425D28500C382F",
        },
        ["290A1EFB2EE44216B1425D28500C382F"] = {
            [1] = "14B11A29D28D4BE4B2B13A6D533A085D",
        },
        ["A4FAF17B9B4546BEB13BB366492BDF7B"] = {
            [1] = "77F851ADA7944F819B5C5ACBC354F084",
        },
        ["77F851ADA7944F819B5C5ACBC354F084"] = {
            [1] = "3971FD60AA9143BAA4E81E3FCE9782F4",
        },
        ["627D1E8CA6824C0E96FBCAE488A1BED4"] = {
            [1] = "118C046869A44C85A457057708CBC816",
            [2] = "A4FAF17B9B4546BEB13BB366492BDF7B",
        },
    },
    ["nodes"] = {
        ["118C046869A44C85A457057708CBC816"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1500,
            ["NodeTag"] = "118C046869A44C85A457057708CBC816",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 290,
                ["x"] = 505,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["290A1EFB2EE44216B1425D28500C382F"] = {
            ["Pos"] = {
                ["y"] = 268,
                ["x"] = 792,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "290A1EFB2EE44216B1425D28500C382F",
            ["Duration"] = 1500,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["14B11A29D28D4BE4B2B13A6D533A085D"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 1134,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "14B11A29D28D4BE4B2B13A6D533A085D",
            ["ID"] = 2001016,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["77F851ADA7944F819B5C5ACBC354F084"] = {
            ["Pos"] = {
                ["y"] = 450,
                ["x"] = 792,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "77F851ADA7944F819B5C5ACBC354F084",
            ["Duration"] = 3700,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["627D1E8CA6824C0E96FBCAE488A1BED4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 2,
            ["Class"] = "RootNode",
            ["NodeTag"] = "627D1E8CA6824C0E96FBCAE488A1BED4",
            ["ID"] = "10020904",
            ["Name"] = "wave4",
            ["Static"] = true,
        },
        ["3971FD60AA9143BAA4E81E3FCE9782F4"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 442,
                ["x"] = 1144,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "3971FD60AA9143BAA4E81E3FCE9782F4",
            ["ID"] = 2001006,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["A4FAF17B9B4546BEB13BB366492BDF7B"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 3700,
            ["NodeTag"] = "A4FAF17B9B4546BEB13BB366492BDF7B",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 432,
                ["x"] = 496,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
    },
    ["root"] = "627D1E8CA6824C0E96FBCAE488A1BED4",
}