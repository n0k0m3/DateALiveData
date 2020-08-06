return {
    ["links"] = {
        ["457A4FC0C10E4346A1E26E2ACE34F5F9"] = {
            [1] = "4CBDBC6828EF425488D043D0B059E8BC",
        },
        ["D5CEAF21457F4772BCA0EF2DFFE67D7F"] = {
            [1] = "AF0B899A13A04C778D630E9660BB4BE8",
        },
        ["FBC1EC2BD56A43789C4ACA6750219145"] = {
            [1] = "D5CEAF21457F4772BCA0EF2DFFE67D7F",
        },
        ["4CBDBC6828EF425488D043D0B059E8BC"] = {
            [1] = "FBC1EC2BD56A43789C4ACA6750219145",
        },
    },
    ["nodes"] = {
        ["457A4FC0C10E4346A1E26E2ACE34F5F9"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "457A4FC0C10E4346A1E26E2ACE34F5F9",
            ["ID"] = "406309",
            ["Name"] = "炮台AI",
            ["Static"] = true,
        },
        ["D5CEAF21457F4772BCA0EF2DFFE67D7F"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 322,
                ["x"] = 988,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "D5CEAF21457F4772BCA0EF2DFFE67D7F",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["AF0B899A13A04C778D630E9660BB4BE8"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 296,
                ["x"] = 1186,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "AF0B899A13A04C778D630E9660BB4BE8",
            ["ID"] = 320060,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4CBDBC6828EF425488D043D0B059E8BC"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 5000,
            ["NodeTag"] = "4CBDBC6828EF425488D043D0B059E8BC",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 298,
                ["x"] = 426,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
        ["FBC1EC2BD56A43789C4ACA6750219145"] = {
            ["Pos"] = {
                ["y"] = 311,
                ["x"] = 655,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "FBC1EC2BD56A43789C4ACA6750219145",
            ["Duration"] = 5000,
            ["Type"] = 1,
            ["Static"] = false,
        },
    },
    ["root"] = "457A4FC0C10E4346A1E26E2ACE34F5F9",
}