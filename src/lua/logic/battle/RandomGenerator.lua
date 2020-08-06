if RandomGenerator then
    return
end
RandomGenerator = {}

local engine = TFMath:new(os.time(),os.time())
-- 用法：(和math.random无异)
-- 1.无参调用，产生[0, 1)之间的浮点随机数。
-- 2.一个参数n，产生[1, n]之间的整数。
-- 3.两个参数，产生[n, m]之间的整数。

--随机一个boolean
function RandomGenerator.randomBool()
    return RandomGenerator.random(2) == 1
end

function RandomGenerator.randomSign()
    if RandomGenerator.randomBool() then
        return 1
    end
    return -1
end

function RandomGenerator.random(...)
    -- print("random:",...)
    -- printError("FUck")
   return math.random(...)
end

function RandomGenerator.randomseed(initState,initSeq)
    math.randomseed(initState)
end

function RandomGenerator.triggerTest(a,b,value)
    return RandomGenerator.random(a,b) <= value
end




---------------------------------------------------------------------------------------


-- function RandomGenerator.random_A(n , m)
--     -- print("randomA:",n , m)

--     if n and m then -- 两个参数，产生[n, m]之间的整数。
--         m = math.max(n,m)
--         return engine:nextInt(m - n + 1) + n
--     elseif n then -- 一个参数n，产生[1, n]之间的整数。
--         return 1 + engine:nextInt(n)
--     else --无参调用，产生[0, 1)之间的浮点随机数
--         return (1 + engine:nextInt(9))/10
--     end
-- end
-- --随机一个boolean
-- function RandomGenerator.randomBoolA()
--     return RandomGenerator.randomA(2) == 1
-- end

-- function RandomGenerator.randomSignA()
--     if RandomGenerator.randomBoolA() then
--         return 1
--     end
--     return -1
-- end
-- local index = 0
-- function RandomGenerator.randomA(n , m)
--     index = index + 1
--     local value = RandomGenerator.random_A(n , m)
--     -- print("index=",index,"random["..tostring(n)..","..tostring(m).."]="..value)
--     return value
-- end

-- function RandomGenerator.randomseedA(initState,initSeq)
--     initState = initState or tonumber(tostring(os.time()):reverse():sub(1, 7))
--     initSeq   = initSeq   or tonumber(tostring(os.time()):reverse():sub(1, 7))
--     engine:seed(initState,initSeq)
--     index = 0
-- end

-- function RandomGenerator.triggerTestA(a,b,value)
--     return RandomGenerator.randomA(a,b) <= value
-- end




--饮下随机不影响逻辑 通过Math.random随机

function RandomGenerator._random(n , m)

    if n and m then -- 两个参数，产生[n, m]之间的整数。
        m = math.max(n,m)
        return engine:nextInt(m - n + 1) + n
    elseif n then -- 一个参数n，产生[1, n]之间的整数。
        return 1 + engine:nextInt(n)
    else --无参调用，产生[0, 1)之间的浮点随机数
        return (1 + engine:nextInt(9))/10
    end
end

function RandomGenerator._randomBool()
    return RandomGenerator._random(2) == 1
end

function RandomGenerator._randomSign()
    if RandomGenerator._randomBool() then
        return 1
    end
    return -1
end

function RandomGenerator._triggerTest(a,b,value)
    return RandomGenerator._random(a,b) <= value
end

function RandomGenerator._triggerTest100(value)
    return RandomGenerator._triggerTest(1,100,value)
end

function RandomGenerator._triggerTest1000(value)
    return RandomGenerator._triggerTest(1,1000,value)
end

function RandomGenerator._triggerTest10000(value)
    return RandomGenerator._triggerTest(1,10000,value)
end



-- for i=1,10 do
--     print(RandomGenerator.random(2))
--     print(RandomGenerator.random_A(2))
-- end
-- for i=1,10 do
--     print(RandomGenerator.random(2,3))

--     print(RandomGenerator.random_A(2,3))
-- end

-- Box("AAA")
return RandomGenerator



