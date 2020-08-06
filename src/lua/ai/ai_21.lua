return {
    ["links"] = {
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            [1] = "F321BD80CB39463F8258E317C001B334",
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            [1] = "72367D3DC1494159967E56DCED990E69",
        },
        ["72367D3DC1494159967E56DCED990E69"] = {
            [1] = "C22DDE1F3A994DCF915FC082725A0051",
        },
        ["C22DDE1F3A994DCF915FC082725A0051"] = {
            [1] = "AD65DB9657AA44B6A59C0AFB399CA726",
        },
    },
    ["nodes"] = {
        ["AD65DB9657AA44B6A59C0AFB399CA726"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 564,
                ["x"] = 1191,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "AD65DB9657AA44B6A59C0AFB399CA726",
            ["Type"] = 0,
            ["IsCount"] = 2,
            ["Static"] = false,
        },
        ["F704226FA6C74EC6A3C6BF7A0A01030D"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 562,
                ["x"] = 108,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
            ["ID"] = "21",
            ["Name"] = "质点回血球",
            ["Static"] = true,
        },
        ["F321BD80CB39463F8258E317C001B334"] = {
            ["Desc"] = "施放技能",
            ["Duration"] = 10000,
            ["NodeTag"] = "F321BD80CB39463F8258E317C001B334",
            ["Force"] = 1,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 566,
                ["x"] = 351,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["72367D3DC1494159967E56DCED990E69"] = {
            ["Pos"] = {
                ["y"] = 570,
                ["x"] = 676,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "72367D3DC1494159967E56DCED990E69",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C22DDE1F3A994DCF915FC082725A0051"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 562,
                ["x"] = 995,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "C22DDE1F3A994DCF915FC082725A0051",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "F704226FA6C74EC6A3C6BF7A0A01030D",
}