return {
    ["links"] = {
        ["83023D5B1DF24E1D80E11CC057ECC9DF"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "83023D5B1DF24E1D80E11CC057ECC9DF",
        },
    },
    ["nodes"] = {
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "电容召唤",
            ["Duration"] = 30000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 418,
                ["x"] = 251,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["83023D5B1DF24E1D80E11CC057ECC9DF"] = {
            ["Pos"] = {
                ["y"] = 408,
                ["x"] = 520,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "83023D5B1DF24E1D80E11CC057ECC9DF",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 388,
                ["x"] = 824,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            ["Desc"] = "--\
",
            ["Pos"] = {
                ["y"] = 404,
                ["x"] = -54,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
            ["ID"] = "624121",
            ["Name"] = "或守鞠奈电容召唤",
            ["Static"] = true,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "替身消失\
",
            ["Pos"] = {
                ["y"] = 392,
                ["x"] = 1109,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 700500,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}