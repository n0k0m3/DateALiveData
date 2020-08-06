return {
    ["links"] = {
        ["7355ED3B5DDE475EBCE8B25C87519C47"] = {
            [1] = "755436FC5DEE40609604FADA65AFE095",
        },
        ["755436FC5DEE40609604FADA65AFE095"] = {
            [1] = "04F95FDE060243F9A4945BB63CD228FB",
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            [1] = "7355ED3B5DDE475EBCE8B25C87519C47",
        },
        ["04F95FDE060243F9A4945BB63CD228FB"] = {
            [1] = "DD78AF5ACE564F7384569CB169F896B3",
        },
    },
    ["nodes"] = {
        ["7355ED3B5DDE475EBCE8B25C87519C47"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "7355ED3B5DDE475EBCE8B25C87519C47",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 288,
                ["x"] = 406,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
        ["DD78AF5ACE564F7384569CB169F896B3"] = {
            ["Desc"] = "行为",
            ["Weight"] = 0,
            ["NodeTag"] = "DD78AF5ACE564F7384569CB169F896B3",
            ["RunWeight"] = 0,
            ["WalkDistance"] = 0,
            ["Pos"] = {
                ["y"] = 286,
                ["x"] = 1089,
            },
            ["Class"] = "PatrolBevNode",
            ["WalkWeight"] = 0,
            ["TriggerType"] = 2,
            ["Static"] = false,
            ["Type"] = 9,
        },
        ["04F95FDE060243F9A4945BB63CD228FB"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 277,
                ["x"] = 901,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "04F95FDE060243F9A4945BB63CD228FB",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["755436FC5DEE40609604FADA65AFE095"] = {
            ["Pos"] = {
                ["y"] = 289,
                ["x"] = 663,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "755436FC5DEE40609604FADA65AFE095",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["51B39C60ABC1457DA23F5EC1E94F6217"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 249,
                ["x"] = 247,
            },
            ["Category"] = 1,
            ["Class"] = "RootNode",
            ["NodeTag"] = "51B39C60ABC1457DA23F5EC1E94F6217",
            ["ID"] = "666666",
            ["Name"] = "新的 AI",
            ["Static"] = true,
        },
    },
    ["root"] = "51B39C60ABC1457DA23F5EC1E94F6217",
}