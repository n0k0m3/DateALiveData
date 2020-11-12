return {
    ["links"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            [1] = "FCFADB0964E04DBBA25DCA531B3D9505",
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            [1] = "102207E20A0E489490C0C511B9A0AC0C",
        },
        ["102207E20A0E489490C0C511B9A0AC0C"] = {
            [1] = "1DA93EA36DAD481BADA0B32C6744D732",
        },
        ["87A80F21AB044E178650F0BFA869B994"] = {
            [1] = "585517229D9344808AC42B1C400677C0",
        },
        ["87AC2721275C431F8AFA6EC35955C44A"] = {
            [1] = "15907E1774EB4E4F95E2070AF00732BA",
        },
        ["0A581B16B59849C0BA7D3273BFB4AFE2"] = {
            [1] = "0E5B67F2C2AE462EA0EA8120083C7742",
            [2] = "87A80F21AB044E178650F0BFA869B994",
        },
        ["FCFADB0964E04DBBA25DCA531B3D9505"] = {
            [1] = "24F99E6F54124494BC46DEB9000CB32A",
            [2] = "13C06A90EA504A06BEBFCCC006F6DFB3",
            [3] = "87AC2721275C431F8AFA6EC35955C44A",
        },
        ["13C06A90EA504A06BEBFCCC006F6DFB3"] = {
            [1] = "3007D93AEBD9493F9AA7C0E3EBC0728C",
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            [1] = "5308602880B449D48C6E6C17A10BCB7A",
        },
    },
    ["nodes"] = {
        ["585517229D9344808AC42B1C400677C0"] = {
            ["Pos"] = {
                ["y"] = 504,
                ["x"] = 484,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "585517229D9344808AC42B1C400677C0",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E5B67F2C2AE462EA0EA8120083C7742"] = {
            ["Desc"] = "普攻\
",
            ["Duration"] = 5000,
            ["NodeTag"] = "0E5B67F2C2AE462EA0EA8120083C7742",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 355,
                ["x"] = 241,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 20,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["102207E20A0E489490C0C511B9A0AC0C"] = {
            ["Pos"] = {
                ["y"] = 358,
                ["x"] = 468,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "102207E20A0E489490C0C511B9A0AC0C",
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
        ["87A80F21AB044E178650F0BFA869B994"] = {
            ["Desc"] = "巡逻\
",
            ["Duration"] = 1000,
            ["NodeTag"] = "87A80F21AB044E178650F0BFA869B994",
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 491,
                ["x"] = 236,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["87AC2721275C431F8AFA6EC35955C44A"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 567,
                ["x"] = 955,
            },
            ["Weight"] = 1,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "87AC2721275C431F8AFA6EC35955C44A",
            ["DelayTime"] = 900,
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
            ["ID"] = "999116",
            ["Name"] = "或守鞠奈分身",
            ["Static"] = true,
        },
        ["FCFADB0964E04DBBA25DCA531B3D9505"] = {
            ["Desc"] = "随机行为",
            ["Pos"] = {
                ["y"] = 492,
                ["x"] = 753,
            },
            ["Weight"] = 0,
            ["Class"] = "RandomBevNode",
            ["NodeTag"] = "FCFADB0964E04DBBA25DCA531B3D9505",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5308602880B449D48C6E6C17A10BCB7A"] = {
            ["Desc"] = "替身消失\
",
            ["Pos"] = {
                ["y"] = 359,
                ["x"] = 949,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "5308602880B449D48C6E6C17A10BCB7A",
            ["ID"] = 700300,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3007D93AEBD9493F9AA7C0E3EBC0728C"] = {
            ["Desc"] = "行为",
            ["Weight"] = 1,
            ["NodeTag"] = "3007D93AEBD9493F9AA7C0E3EBC0728C",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 503,
                ["x"] = 1149,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["13C06A90EA504A06BEBFCCC006F6DFB3"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 503,
                ["x"] = 955,
            },
            ["Weight"] = 1,
            ["Class"] = "DelayBevNode",
            ["NodeTag"] = "13C06A90EA504A06BEBFCCC006F6DFB3",
            ["DelayTime"] = 500,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["1DA93EA36DAD481BADA0B32C6744D732"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 363,
                ["x"] = 764,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "1DA93EA36DAD481BADA0B32C6744D732",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["15907E1774EB4E4F95E2070AF00732BA"] = {
            ["Desc"] = "行为",
            ["Weight"] = 1,
            ["NodeTag"] = "15907E1774EB4E4F95E2070AF00732BA",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 568,
                ["x"] = 1149,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["24F99E6F54124494BC46DEB9000CB32A"] = {
            ["Desc"] = "行为",
            ["Weight"] = 1,
            ["NodeTag"] = "24F99E6F54124494BC46DEB9000CB32A",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 439,
                ["x"] = 971,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
    },
    ["root"] = "0A581B16B59849C0BA7D3273BFB4AFE2",
}