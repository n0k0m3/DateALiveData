return {
    ["links"] = {
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            [1] = "711396D9C1B34958870908CA364A2153",
        },
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            [1] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            [1] = "70C1A75F5C6F4443BB9D31C5A183B45C",
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            [1] = "EA0D18F8EB58419DAB38337AA94567EA",
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            [1] = "C3C3916CC5C141E7BB50A7D09568DA08",
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            [1] = "5644F4BA74954D329F95F54F74627A4C",
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            [1] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
            [2] = "8E7A4B66B4A34757883A00276DCCF8C0",
        },
    },
    ["nodes"] = {
        ["70C1A75F5C6F4443BB9D31C5A183B45C"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 185,
                ["x"] = 903,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "70C1A75F5C6F4443BB9D31C5A183B45C",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["5644F4BA74954D329F95F54F74627A4C"] = {
            ["Pos"] = {
                ["y"] = 168,
                ["x"] = 643,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "5644F4BA74954D329F95F54F74627A4C",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["6AB6CD60A95147ADB77E1CE6A24AFE3E"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 184,
                ["x"] = 1084,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "6AB6CD60A95147ADB77E1CE6A24AFE3E",
            ["ID"] = 304031,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["EA0D18F8EB58419DAB38337AA94567EA"] = {
            ["Pos"] = {
                ["y"] = 420,
                ["x"] = 637,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "EA0D18F8EB58419DAB38337AA94567EA",
            ["Duration"] = 2000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["0E7C6FB79FCB479AACBD03A7A10C9A1E"] = {
            ["Desc"] = "死亡\
\
",
            ["Duration"] = 0,
            ["NodeTag"] = "0E7C6FB79FCB479AACBD03A7A10C9A1E",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 357,
                ["x"] = 426,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 10,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["C3C3916CC5C141E7BB50A7D09568DA08"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 341,
                ["x"] = 1091,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "C3C3916CC5C141E7BB50A7D09568DA08",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["711396D9C1B34958870908CA364A2153"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 336,
                ["x"] = 916,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "711396D9C1B34958870908CA364A2153",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["8E7A4B66B4A34757883A00276DCCF8C0"] = {
            ["Desc"] = "释放技能",
            ["Duration"] = 0,
            ["NodeTag"] = "8E7A4B66B4A34757883A00276DCCF8C0",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 215,
                ["x"] = 411,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 2,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["BC94AE172DAD4210B73F1EAC9C32338F"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 297,
                ["x"] = 186,
            },
            ["Category"] = 9,
            ["Class"] = "RootNode",
            ["NodeTag"] = "BC94AE172DAD4210B73F1EAC9C32338F",
            ["ID"] = "6051",
            ["Name"] = "万由里高阶远程天照NPC",
            ["Static"] = true,
        },
    },
    ["root"] = "BC94AE172DAD4210B73F1EAC9C32338F",
}