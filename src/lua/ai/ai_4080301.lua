return {
    ["links"] = {
        ["3953544EB10545E294127914A033CB7B"] = {
            [1] = "1FDB454C8EDB461F91A32A5971A28707",
        },
        ["88F0E9A9790E438B863066A4B567635F"] = {
            [1] = "3953544EB10545E294127914A033CB7B",
        },
        ["05961F8AB4FC4634B60F637805B8B38F"] = {
            [1] = "88F0E9A9790E438B863066A4B567635F",
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            [1] = "05961F8AB4FC4634B60F637805B8B38F",
        },
    },
    ["nodes"] = {
        ["1FDB454C8EDB461F91A32A5971A28707"] = {
            ["Desc"] = "施放技能",
            ["Pos"] = {
                ["y"] = 343,
                ["x"] = 1083,
            },
            ["Weight"] = 0,
            ["Class"] = "ReleaseSkillBevNode",
            ["NodeTag"] = "1FDB454C8EDB461F91A32A5971A28707",
            ["ID"] = 345251,
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
                ["x"] = 433,
            },
            ["Class"] = "ChildNode",
            ["Loop"] = 0,
            ["Priority"] = 1,
        },
        ["4D01484ABDF048239ED5DD1CC7A180D4"] = {
            ["Desc"] = "新的 AI",
            ["Pos"] = {
                ["y"] = 342,
                ["x"] = 246,
            },
            ["Category"] = 4,
            ["Class"] = "RootNode",
            ["NodeTag"] = "4D01484ABDF048239ED5DD1CC7A180D4",
            ["ID"] = "4080301",
            ["Name"] = "8号BOSS大引力球",
            ["Static"] = true,
        },
        ["88F0E9A9790E438B863066A4B567635F"] = {
            ["Pos"] = {
                ["y"] = 351,
                ["x"] = 664,
            },
            ["Class"] = "ConditionInFightTimeoutNode",
            ["NodeTag"] = "88F0E9A9790E438B863066A4B567635F",
            ["Duration"] = 0,
            ["Type"] = 1,
            ["Static"] = false,
        },
        ["3953544EB10545E294127914A033CB7B"] = {
            ["Desc"] = "顺序行为",
            ["Pos"] = {
                ["y"] = 344,
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