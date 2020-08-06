return {
    ["links"] = {
        ["2E85B6BCDE444F3987041724AD71987C"] = {
            [1] = "6993E4072BD34C249F2CC1BC13CE9F04",
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            [1] = "88F0E9A9790E438B863066A4B567635F",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "05961F8AB4FC4634B60F637805B8B38F",
        },
        ["6993E4072BD34C249F2CC1BC13CE9F04"] = {
            [1] = "F27DFA817BD94AA3A4DC10A3C50D8C03",
        },
        ["88F0E9A9790E438B863066A4B567635F"] = {
            [1] = "3953544EB10545E294127914A033CB7B",
        },
        ["997065038EEA4710B67D794AEA03B966"] = {
            [1] = "2E85B6BCDE444F3987041724AD71987C",
        },
        ["3953544EB10545E294127914A033CB7B"] = {
            [1] = "1FDB454C8EDB461F91A32A5971A28707",
        },
    },
    ["nodes"] = {
        ["1FDB454C8EDB461F91A32A5971A28707"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 341,
                ["x"] = 1084,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1FDB454C8EDB461F91A32A5971A28707",
            ["ID"] = 345241,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 342,
                ["x"] = 248,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4080202",
            ["Name"] = "8号BOSS小引力球",
            ["Static"] = true,
        },
        ["88F0E9A9790E438B863066A4B567635F"] = {
            ["Pos"] = {
                ["y"] = 235,
                ["x"] = 674,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "88F0E9A9790E438B863066A4B567635F",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["2E85B6BCDE444F3987041724AD71987C"] = {
            ["Pos"] = {
                ["y"] = 484,
                ["x"] = 683,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "2E85B6BCDE444F3987041724AD71987C",
            ["Duration"] = 20000,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "05961F8AB4FC4634B60F637805B8B38F",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 438,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
        ["F27DFA817BD94AA3A4DC10A3C50D8C03"] = {
            ["Desc"] = "行为",
            ["Pos"] = {
                ["y"] = 582,
                ["x"] = 1147,
            },
            ["Weight"] = 0,
            ["Class"] = "ChangeSelfHPBevNode",
            ["NodeTag"] = "F27DFA817BD94AA3A4DC10A3C50D8C03",
            ["Percent"] = 0,
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["6993E4072BD34C249F2CC1BC13CE9F04"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 585,
                ["x"] = 981,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "6993E4072BD34C249F2CC1BC13CE9F04",
            ["Type"] = 0,
            ["Static"] = false,
        },
        ["997065038EEA4710B67D794AEA03B966"] = {
            ["Desc"] = "子节点",
            ["Duration"] = 0,
            ["NodeTag"] = "997065038EEA4710B67D794AEA03B966",
            ["Force"] = 0,
            ["TriggerType"] = 0,
            ["Static"] = false,
            ["Pos"] = {
                ["y"] = 480,
                ["x"] = 421,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 2,
        },
        ["3953544EB10545E294127914A033CB7B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 342,
                ["x"] = 918,
            },
            ["Weight"] = 0,
            ["Class"] = "OrderBevNode",
            ["NodeTag"] = "3953544EB10545E294127914A033CB7B",
            ["Type"] = 0,
            ["Static"] = false,
        },
    },
    ["root"] = "4D01484ABDF048239ED5DD1CC7A180D4",
}