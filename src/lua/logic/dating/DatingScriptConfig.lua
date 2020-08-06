local DatingScriptConfig = {}

DatingScriptConfig.tableConfig = {
    Dating101 = {name = "Dating101", --表名
        scriptIdList = {1101001}, -- 剧本ID
        startIdList = {1100001},  --剧本开始剧情ID
    },

    Dating102test = {name = "Dating102test", --表名
                 scriptIdList = {1102001,1003,1004,1005,1006,1007}, -- 剧本ID
                 startIdList = {33100001,1031001,1041001,1051001,1061001,1071001},  --剧本开始剧情ID
    },

    Dating103test = {name = "Dating103test",
                scriptIdList = {2001}, -- 剧本ID
                startIdList = {201001},  --剧本开始剧情ID
    },
    
    Dating102 = {name = "Dating102",
                scriptIdList = {2102004}, -- 剧本ID
                startIdList = {120100001},  --剧本开始剧情ID
    },
    
    Dating = {name = "Dating",
        scriptIdList = {1101001,1101002,2101001,2201001,2301001},
        startIdList = {1100001,1510001,2100001,5100001,6100001},
    },

    MainScenario = {name = "MainScenario",
        scriptIdList = {1001,1005,1006,1008},
        startIdList = {1001001,1005001,1006001,1008001,},
    },

    MainDialogue = {name = "MainDialogue", --表名
        scriptIdList = {1001,10022,10023,10024,1002,2002,2105001,2001,2002,2003,2004,2005}, -- 剧本ID
        startIdList = {1011001,1022001,1023001,1024001,1021001,2021001,65701102,2011001,2021001,2031001,2041001,2051001},  --剧本开始剧情ID
    },
    
    MainDialogueTest = {name = "MainDialogueTest", --表名
        scriptIdList = {2001,2002,2003,2004,2005,1002}, -- 剧本ID
        startIdList = {2011001,2021001,2031001,2041001,2051001,1021001},  --剧本开始剧情ID
    },

    Dating105 = {name = "Dating105", --表名
        scriptIdList = {2105001,2105002}, -- 剧本ID
        startIdList = {1065100001,1071101001},  --剧本开始剧情ID
    },

    Dating101 = {name = "Dating101", --表名
        scriptIdList = {2101002}, -- 剧本ID
        startIdList = {1009100001},  --剧本开始剧情ID
    },

    Dating104test = {name = "Dating104test",
        scriptIdList = {2104003}, -- 剧本ID
        startIdList = {105100001},  --剧本开始剧情ID
    },

    FavorDating101test = {name = "FavorDating101test", --表名
        scriptIdList = {100001,101101,101201,101301,101401,101501,101601,101701,101801,201101,201201,201301,201401,201501,201601,201701,201801,201901,202001,202101,202201,301101,301201,301301,301401,301501,301601,301701,301801,301901,302001,401101,401201,401301,401401,401501,401601,401701,401801,401901,402001,501101,501201,501301,501401,501501,501601,501701,501801,501901,502001,502101,601101,601201,601301,601401,601501,601601,601701,601801,601901,602001}, -- 剧本ID
        startIdList = {100001,101101,101201,101301,101401,101501,101601,101701,101801,201101,201201,201301,201401,201501,201601,201701,201801,201901,202001,202101,202201,301101,301201,301301,301401,301501,301601,301701,301801,301901,302001,401101,401201,401301,401401,401501,401601,401701,401801,401901,402001,501101,501201,501301,501401,501501,501601,501701,501801,501901,502001,502101,601101,601201,601301,601401,601501,601601,601701,601801,601901,602001},  --剧本开始剧情ID
    },

    FavorDating113 = {name = "FavorDating113", --表名
        scriptIdList = {113010100,113010111,113010112,113010113,113010114,113010115,113010116,113010101,113010102,113010211,113010212,113010213,113010214,113010215,113010216,113010217,113010201,113010202,113010311,113010312,113010313,113010314,113010315,113010316,113010317,113010301,113010302,113010411,113010412,113010413,113010414,113010415,113010416,113010417,113010418,113010401,113010402,113010511,113010512,113010513,113010514,113010515,113010516,113010517,113010501,113010502,113010611,113010612,113010613,113010614,113010601,113010602}, -- 剧本ID
        startIdList = {459100001,459101101,459101201,459101301,459101401,459101501,459101601,459100101,459100201,459201101,459201201,459201301,459101401,459101501,459101601,459101701,459100101,459100201,459301101,459301201,459301301,459301401,459301501,459301601,459301701,459300101,459300201,459401101,459401201,459401301,459401401,459401501,459401601,459401701,459401801,459400101,459400201,459501101,459501201,459501301,459501401,459501501,459501601,459501701,459601101,459601201,459601301,459601401,459600101,459600201,459600301,459600401},  --剧本开始剧情ID
    },

    OutsideDating = {name = "OutsideDating",
        scriptIdList = {100001,100002,100003,100004},
        startIdList = {15001001,15002001,15003001,15004001,},
    },
    
    NovelDatingtest = {name = "NovelDatingtest",
        scriptIdList = {10022,10023,10024,1002},
        startIdList = {1022001,1023001,1024001,1021001,},
    },

    Dating101test = {name = "Dating101test",
        scriptIdList = {1101001}, -- 剧本ID
        startIdList = {1100001},  --剧本开始剧情ID
    },

}

DatingScriptConfig.selectType = {
    DatingName = "DatingName",
    ScriptId = "ScriptId",
}

DatingScriptConfig.fieldConfig = {
    -- {name = "roleScale1", title = "看板娘1大小", sType = "number"},
    {name = "roleScale1", title = 100000021, sType = "number"},
    {name = "roleScale2", title = 100000022, sType = "number"},
    {name = "roleScale3", title = 100000023, sType = "number"},
    {name = "position1", title = 100000024, sType = "number"},
    {name = "position2", title = 100000025, sType = "number"},
    {name = "position3", title = 100000026, sType = "number"},
    {name = "backGround", title = 100000027, sType = "string"},
    {name = "bgScale", title = 100000028, sType = "number"},
    {name = "bgOffset", title = 100000029, sType = "table"}
}

--约会类型默认所属表（具体看datingRule只试用未在datingRule配置的剧情）
DatingScriptConfig.datingTypeToTableName = {
    [EC_DatingScriptType.SPECIAL_SCRIPT] = "MainScenario",
    [EC_DatingScriptType.MAIN_SCRIPT] = "dating",
    [EC_DatingScriptType.DAY_SCRIPT] = "dating",
    [EC_DatingScriptType.RESERVE_SCRIPT] = "dating",
    [EC_DatingScriptType.TRIGGER_SCRIPT] = "dating",
    [EC_DatingScriptType.WORK_SCRIPT] = "dating",
    [EC_DatingScriptType.OUT_SCRIPT] = "dating",
    [EC_DatingScriptType.FUBEN_SCRIPT] = "MainScenario",
    [EC_DatingScriptType.OUTSIDE_SCRIPT] = "OutsideDating"
}

return DatingScriptConfig