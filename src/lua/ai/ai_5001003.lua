return {
    ["links"] = {
        ["1030263FE3E847C884A87E6838534435"] = {
            [1] = "6853BEC630484FCB8FC633297620F2D4",
        },
        ["6853BEC630484FCB8FC633297620F2D4"] = {
            [1] = "0F2EAD9AAF044213A959B9F2235323E1",
        },
        ["C675BEC2257F4516A60C6A6C07686D82"] = {
            [1] = "1030263FE3E847C884A87E6838534435",
        },
    },
    ["nodes"] = {
        ["1030263FE3E847C884A87E6838534435"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 700,
            ["NodeTag"] = "1030263FE3E847C884A87E6838534435",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 361,
                ["x"] = 440,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 1,
            ["Priority"] = 0,
        },
        ["0F2EAD9AAF044213A959B9F2235323E1"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 370,
                ["x"] = 1092,
            },
            ["Weight"] = 1,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "0F2EAD9AAF044213A959B9F2235323E1",
            ["ID"] = 2001001,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["C675BEC2257F4516A60C6A6C07686D82"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 366,
                ["x"] = 219,
            },
            ["Category"] = 5,
            ["Class"] = "RootNode",
            ["NodeTag"] = "C675BEC2257F4516A60C6A6C07686D82",
            ["ID"] = "5001003",
            ["Name"] = "wave3",
            ["Static"] = true,
        },
        ["6853BEC630484FCB8FC633297620F2D4"] = {
            ["Pos"] = {
                ["y"] = 374,
                ["x"] = 758,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "6853BEC630484FCB8FC633297620F2D4",
            ["Duration"] = 700,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "C675BEC2257F4516A60C6A6C07686D82",
}