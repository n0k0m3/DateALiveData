return {
    ["links"] = {
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            [1] = "AE66E0144B014A04835D31857D7B2562",
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            [1] = "BE139382F7AB405EA9AC4A9CBC2FFE36",
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            [1] = "FF7B543B26B6422593DF22FF69759008",
        },
        ["BE139382F7AB405EA9AC4A9CBC2FFE36"] = {
            [1] = "8BF964295B904100B15C56F03E74623B",
        },
        ["2ED9ED8D5CEE4FB99795F9C0A8EA5706"] = {
            [1] = "EE83A04E2B9649F8A0AAB1E829F71D81",
        },
        ["8B1D918C8E5E419F8D6CBBA8A59DC2C4"] = {
            [1] = "D26E55258E28402E9D654BBE64D8725A",
        },
        ["D26E55258E28402E9D654BBE64D8725A"] = {
            [1] = "756B45CB1BA14F5981DB546D9FFF2E64",
        },
        ["756B45CB1BA14F5981DB546D9FFF2E64"] = {
            [1] = "2ED9ED8D5CEE4FB99795F9C0A8EA5706",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "8B1D918C8E5E419F8D6CBBA8A59DC2C4",
            [2] = "8E7A4B66B4A34757883A00276DCCF8C0",
            [3] = "13E7D11BAF354014A99EFB6CDCCC4908",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["AE66E0144B014A04835D31857D7B2562"] = {
            [1] = "C2526A019C0848FD947291C629CAAD37",
        },
    },
    ["nodes"] = {
        ["FF7B543B26B6422593DF22FF69759008"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 486,
                ["x"] = 1369,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "FF7B543B26B6422593DF22FF69759008",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 486,
                ["x"] = 949,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 302,
                ["x"] = 187,
            },
            ["Category"] = 12,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "910307",
            ["Name"] = "社团地雷",
            ["Static"] = true,
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = 477,
                ["x"] = 655,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 18000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["13E7D11BAF354014A99EFB6CDCCC4908"] = {
            ["Desc"] = "布雷\
",
            ["Duration"] = 1000,
            ["NodeTag"] = "13E7D11BAF354014A99EFB6CDCCC4908",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 155,
                ["x"] = 407,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["C2526A019C0848FD947291C629CAAD37"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 156,
                ["x"] = 933,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "C2526A019C0848FD947291C629CAAD37",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 486,
                ["x"] = 1164,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 303032,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2ED9ED8D5CEE4FB99795F9C0A8EA5706"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 642,
                ["x"] = 1159,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "2ED9ED8D5CEE4FB99795F9C0A8EA5706",
            ["ID"] = 303032,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["BE139382F7AB405EA9AC4A9CBC2FFE36"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 159,
                ["x"] = 1162,
            },
            ["Weight"] = 50,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "BE139382F7AB405EA9AC4A9CBC2FFE36",
            ["ID"] = 303032,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["756B45CB1BA14F5981DB546D9FFF2E64"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 644,
                ["x"] = 939,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "756B45CB1BA14F5981DB546D9FFF2E64",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["8B1D918C8E5E419F8D6CBBA8A59DC2C4"] = {
            ["Desc"] = "自我销毁(地图外)",
            ["Duration"] = 0,
            ["NodeTag"] = "8B1D918C8E5E419F8D6CBBA8A59DC2C4",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 665,
                ["x"] = 396,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["D26E55258E28402E9D654BBE64D8725A"] = {
            ["Pos"] = {
                ["y"] = 788,
                ["x"] = 685,
            },
            ["Class"] = "ConditionIsOnWalkingSurfaceNode",
            ["NodeTag"] = "D26E55258E28402E9D654BBE64D8725A",
            ["Operator"] = 2,
            ["Static"] = false,
        },
        ["8BF964295B904100B15C56F03E74623B"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 164,
                ["x"] = 1391,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "8BF964295B904100B15C56F03E74623B",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["EE83A04E2B9649F8A0AAB1E829F71D81"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 641,
                ["x"] = 1352,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "EE83A04E2B9649F8A0AAB1E829F71D81",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "自我销毁",
            ["Duration"] = 1500,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 471,
                ["x"] = 399,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 4,
            ["DurationInterval"] = {
                [1] = 200,
                [2] = 200,
            },
        },
        ["AE66E0144B014A04835D31857D7B2562"] = {
            ["Pos"] = {
                ["y"] = 152,
                ["x"] = 637,
            },
            ["Class"] = "ConditionTargetDistanceNode",
            ["NodeTag"] = "AE66E0144B014A04835D31857D7B2562",
            ["RangeY"] = {
                [1] = 0,
                [2] = 30,
            },
            ["RangeX"] = {
                [1] = 0,
                [2] = 50,
            },
            ["Static"] = false,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}