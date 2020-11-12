return {
    ["links"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            [1] = "CBFC49CC073942BD8B3F746F669E78AE",
        },
        ["6D88D15F893E4CE1B3ABB82C5253DE24"] = {
            [1] = "E3EAA787F51F4068AA91302466CB7343",
        },
        ["CBFC49CC073942BD8B3F746F669E78AE"] = {
            [1] = "A63F5B87C3844C8AB8D064D4FB9EEFF2",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "87A80F21AB044E178650F0BFA869B994",
            [2] = "0E5B67F2C2AE462EA0EA8120083C7742",
        },
        ["715C5B6790404CA284AFC9EB30A37368"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            [1] = "6D88D15F893E4CE1B3ABB82C5253DE24",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "715C5B6790404CA284AFC9EB30A37368",
        },
        ["87A80F21AB044E178650F0BFA869B994"] = {
            [1] = "585517229D9344808AC42B1C400677C0",
        },
    },
    ["nodes"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            ["Pos"] = {
                ["y"] = 729,
                ["x"] = 337,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "585517229D9344808AC42B1C400677C0",
            ["Duration"] = 10000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["Force"] = 0,
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
        ["E3EAA787F51F4068AA91302466CB7343"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 433,
                ["x"] = 1240,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "E3EAA787F51F4068AA91302466CB7343",
            ["Type"] = 0,
            ["IsCount"] = 2,
            ["Static"] = false,
        },
        ["87A80F21AB044E178650F0BFA869B994"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "87A80F21AB044E178650F0BFA869B994",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 682,
                ["x"] = 107,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
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
            ["ID"] = "624110",
            ["Name"] = "或守鞠奈技能2陷阱",
            ["Static"] = true,
        },
        ["715C5B6790404CA284AFC9EB30A37368"] = {
            ["Pos"] = {
                ["y"] = 555,
                ["x"] = 419,
            },
            ["Class"] = "ConditionRangeHaveEnemyNode",
            ["NodeTag"] = "715C5B6790404CA284AFC9EB30A37368",
            ["RangeOrigin"] = {
                ["y"] = -50,
                ["x"] = -175,
            },
            ["RangeSize"] = {
                ["height"] = 100,
                ["width"] = 350,
            },
            ["Static"] = false,
        },
        ["CBFC49CC073942BD8B3F746F669E78AE"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 708,
                ["x"] = 772,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "CBFC49CC073942BD8B3F746F669E78AE",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["A63F5B87C3844C8AB8D064D4FB9EEFF2"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 734,
                ["x"] = 1088,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "A63F5B87C3844C8AB8D064D4FB9EEFF2",
            ["Type"] = 0,
            ["IsCount"] = 2,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 314,
                ["x"] = 750,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6D88D15F893E4CE1B3ABB82C5253DE24"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 978,
            },
            ["Weight"] = 0,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "6D88D15F893E4CE1B3ABB82C5253DE24",
            ["DelayTime"] = 500,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "替身消失\
",
            ["Pos"] = {
                ["y"] = 558,
                ["x"] = 868,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 104581,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}