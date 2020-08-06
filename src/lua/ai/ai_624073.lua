return {
    ["links"] = {
        ["2FDEF17EC1CD4F6F9612C8DCAFCBB1CE"] = {
            [1] = "59A192DBF35A488784E3B3F9BABDC3FB",
        },
        ["4C4D25FB0AAF48C9A408C17834648018"] = {
            [1] = "F8C34EEC65FF491BA4F6E934FF332C68",
        },
        ["59A192DBF35A488784E3B3F9BABDC3FB"] = {
            [1] = "3081D70061224B31B3F1328C32776877",
        },
        ["F8C34EEC65FF491BA4F6E934FF332C68"] = {
            [1] = "2FDEF17EC1CD4F6F9612C8DCAFCBB1CE",
        },
        ["CCC07F7C7F0F4CC58C99AEA14534CB6D"] = {
            [1] = "4C4D25FB0AAF48C9A408C17834648018",
        },
        ["8DD428BAAEFD41398E45FE32096B96FD"] = {
            [1] = "CCC07F7C7F0F4CC58C99AEA14534CB6D",
        },
    },
    ["nodes"] = {
        ["2FDEF17EC1CD4F6F9612C8DCAFCBB1CE"] = {
            ["Desc"] = "行为",
            ["LimitArea"] = 1,
            ["Weight"] = 0,
            ["NodeTag"] = "2FDEF17EC1CD4F6F9612C8DCAFCBB1CE",
            ["RangeOrigin"] = {
                ["y"] = -30,
                ["x"] = -30,
            },
            ["RunWeight"] = 0,
            ["Static"] = false,
            ["FixTarget"] = 0,
            ["Pos"] = {
                ["y"] = 260,
                ["x"] = 949,
            },
            ["Class"] = "PathfindingBevNode",
            ["WalkWeight"] = 0,
            ["RangeSize"] = {
                ["height"] = 60,
                ["width"] = 60,
            },
            ["WalkDistance"] = 0,
            ["Type"] = 0,
        },
        ["4C4D25FB0AAF48C9A408C17834648018"] = {
            ["Pos"] = {
                ["y"] = 305,
                ["x"] = 647,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "4C4D25FB0AAF48C9A408C17834648018",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3081D70061224B31B3F1328C32776877"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 1269,
            },
            ["Weight"] = 0,
            ["Class"] = "KillMySelfBevNode",
            ["NodeTag"] = "3081D70061224B31B3F1328C32776877",
            ["Type"] = 0,
            ["IsCount"] = 2,
            ["Static"] = false,
        },
        ["59A192DBF35A488784E3B3F9BABDC3FB"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 301,
                ["x"] = 1092,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "59A192DBF35A488784E3B3F9BABDC3FB",
            ["ID"] = 345462,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["F8C34EEC65FF491BA4F6E934FF332C68"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 427,
                ["x"] = 870,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "F8C34EEC65FF491BA4F6E934FF332C68",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["CCC07F7C7F0F4CC58C99AEA14534CB6D"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 1000,
            ["NodeTag"] = "CCC07F7C7F0F4CC58C99AEA14534CB6D",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 423,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 0,
            ["DurationInterval"] = {
                [1] = 0,
                [2] = 0,
            },
        },
        ["8DD428BAAEFD41398E45FE32096B96FD"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 300,
                ["x"] = 250,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "8DD428BAAEFD41398E45FE32096B96FD",
            ["ID"] = "624073",
            ["Name"] = "精灵折纸黑球",
            ["Static"] = true,
        },
    },
    ["root"] = "8DD428BAAEFD41398E45FE32096B96FD",
}