return {
    [1] = {
        nextStep = 0,
        flag = "dicuoprocess1002",
        trigger = {
            [1] = {
                stage = 1,
                countEnd = {
                    count = 1,
                    predungeonList = {
                        [1] = 291009,
                    },
                },
            },
        },
        execute = {
            loseCotrolTime = 3000,
            cameraFocus = {
                scale = 1.1,
                moveTime = 2000,
                levelId = 291111,
            },
        },
        id = 1,
        isFirst = false,
    },
    [2] = {
        nextStep = 0,
        flag = "dicuoprocess1003",
        trigger = {
            [1] = {
                stage = 1,
                countEnd = {
                    count = 1,
                    predungeonList = {
                        [1] = 291015,
                    },
                },
            },
        },
        execute = {
            loseCotrolTime = 3000,
            cameraFocus = {
                scale = 1.3,
                moveTime = 2000,
                levelId = 291121,
            },
        },
        id = 2,
        isFirst = false,
    },
    [3] = {
        nextStep = 0,
        flag = "dicuoprocess1004",
        trigger = {
            [1] = {
                stage = 1,
                countEnd = {
                    count = 1,
                    predungeonList = {
                        [1] = 291025,
                    },
                },
            },
        },
        execute = {
            loseCotrolTime = 3000,
            cameraFocus = {
                scale = 1.3,
                moveTime = 2000,
                levelId = 291131,
            },
        },
        id = 3,
        isFirst = false,
    },
    [4] = {
        nextStep = 0,
        flag = "dicuoprocess1005",
        trigger = {
            [1] = {
                stage = 1,
                countEnd = {
                    count = 1,
                    predungeonList = {
                        [1] = 291031,
                    },
                },
            },
        },
        execute = {
            cameraFocus = {
                scale = 1.3,
                moveTime = 2000,
                pos = {
                    [1] = 1494,
                    [2] = 652,
                },
            },
            hideVortex = 2000,
            loseCotrolTime = 4000,
        },
        id = 4,
        isFirst = false,
    },
    [5] = {
        nextStep = 0,
        flag = "",
        trigger = {
            [1] = {
                stage = 1,
            },
        },
        execute = {
            loseCotrolTime = 1000,
            cameraFocus = {
                scale = 1,
                moveTime = 1000,
                currentLevel = 1,
            },
        },
        id = 5,
        isFirst = false,
    },
}