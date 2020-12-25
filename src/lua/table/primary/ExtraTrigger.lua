return {
    [1603] = {
        nextStep = 1701,
        chapterId = 2002,
        id = 1603,
        execute = {
            preViewAni = 1,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = false,
    },
    [1004] = {
        nextStep = 1005,
        chapterId = 2001,
        id = 1004,
        execute = {
            preViewAni = 1,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = false,
    },
    [1202] = {
        nextStep = 1301,
        chapterId = 2001,
        id = 1202,
        execute = {
            dialog = 20006,
        },
        trigger = {
            [1] = {
                stage = 3,
            },
        },
        isFirst = false,
    },
    [1005] = {
        nextStep = 1201,
        chapterId = 2001,
        id = 1005,
        execute = {
            cameraFocus = {
                levelId = 250000,
            },
        },
        trigger = {
            [1] = {
                stage = 3,
            },
        },
        isFirst = false,
    },
    [1701] = {
        nextStep = -2,
        chapterId = 2002,
        id = 1701,
        execute = {
            datingId = 9101012,
        },
        trigger = {
            [1] = {
                stage = 3,
                predungeon = {
                    [1] = 250005,
                },
            },
        },
        isFirst = false,
    },
    [1301] = {
        nextStep = 1302,
        chapterId = 2001,
        id = 1301,
        execute = {
            cameraFocus = {
                levelId = 250000,
            },
        },
        trigger = {
            [1] = {
                stage = 3,
                countEnd = {
                    count = 2,
                    predungeonList = {
                        [1] = 210099,
                        [2] = 220099,
                        [3] = 230099,
                        [4] = 240099,
                    },
                },
            },
        },
        isFirst = false,
    },
    [1302] = {
        nextStep = 1401,
        chapterId = 2001,
        id = 1302,
        execute = {
            dialog = 20008,
        },
        trigger = {
            [1] = {
                stage = 3,
            },
        },
        isFirst = false,
    },
    [1401] = {
        nextStep = 1402,
        chapterId = 2001,
        id = 1401,
        execute = {
            cameraFocus = {
                levelId = 250000,
            },
        },
        trigger = {
            [1] = {
                stage = 3,
                countEnd = {
                    count = 3,
                    predungeonList = {
                        [1] = 210099,
                        [2] = 220099,
                        [3] = 230099,
                        [4] = 240099,
                    },
                },
            },
        },
        isFirst = false,
    },
    [1402] = {
        nextStep = 1501,
        chapterId = 2001,
        id = 1402,
        execute = {
            dialog = 20010,
        },
        trigger = {
            [1] = {
                stage = 3,
            },
        },
        isFirst = false,
    },
    [1501] = {
        nextStep = 1502,
        chapterId = 2001,
        id = 1501,
        execute = {
            cameraFocus = {
                levelId = 250000,
            },
        },
        trigger = {
            [1] = {
                stage = 3,
                countEnd = {
                    count = 4,
                    predungeonList = {
                        [1] = 210099,
                        [2] = 220099,
                        [3] = 230099,
                        [4] = 240099,
                    },
                },
            },
        },
        isFirst = false,
    },
    [1502] = {
        nextStep = -1,
        chapterId = 2001,
        id = 1502,
        execute = {
            dialog = 20012,
        },
        trigger = {
            [1] = {
                stage = 3,
            },
        },
        isFirst = false,
    },
    [1001] = {
        nextStep = 1002,
        chapterId = 2001,
        id = 1001,
        execute = {
            datingId = 9101007,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = true,
    },
    [1201] = {
        nextStep = 1202,
        chapterId = 2001,
        id = 1201,
        execute = {
            cameraFocus = {
                levelId = 250000,
            },
        },
        trigger = {
            [1] = {
                stage = 3,
                countEnd = {
                    count = 1,
                    predungeonList = {
                        [1] = 210099,
                        [2] = 220099,
                        [3] = 230099,
                        [4] = 240099,
                    },
                },
            },
        },
        isFirst = false,
    },
    [1002] = {
        nextStep = 1003,
        chapterId = 2001,
        id = 1002,
        execute = {
            dungeonLevelId = 710006,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = false,
    },
    [1601] = {
        nextStep = 1602,
        chapterId = 2002,
        id = 1601,
        execute = {
            dialog = 25001,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = true,
    },
    [1003] = {
        nextStep = 1004,
        chapterId = 2001,
        id = 1003,
        execute = {
            dialog = 20003,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = false,
    },
    [1602] = {
        nextStep = 1603,
        chapterId = 2002,
        id = 1602,
        execute = {
            datingId = 9101013,
        },
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        isFirst = false,
    },
}