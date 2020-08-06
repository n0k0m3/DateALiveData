local CountDown = class("CountDown")
function CountDown:ctor(time)
    self.nCDTime   = time
    self.nTime     = 0    --计时器
    self.nProgress = 0
    self.listener  = nil
end
--是否正在冷却
function CountDown:isCD()
    return self.nTime > 0
end
--增加全局冷却
function CountDown:addGlobalCD(time)
    self.nTime = self.nTime + time
    self.nTime = math.min(self.nTime,self.nCDTime)
    self:calcuProgress(true)
end
function CountDown:start()
    self.nTime = self.nCDTime
    self:calcuProgress(true)
end
function CountDown:stop()
    self.nTime = 0
    self:calcuProgress()
end

function CountDown:update(dt)
    -- print("dt::::::::::::::::::",dt)
    if self.nTime > 0 then
        self.nTime = self.nTime - dt
        if self.nTime < 0 then
            self.nTime = 0
        end
        self:calcuProgress()
    end
end

function CountDown:setListener(listener)
    self.listener = listener
end

function CountDown:onProgress(progress)
    --print("progress:::::::::::::::::::::::::::::",progress)
    if self.listener then
        self.listener(progress)
    end
end

function CountDown:getProgress()
    return self.nProgress
end
--剩余时间
function CountDown:getRemainTime()
    return self.nTime
end
function CountDown:calcuProgress(force)
    local progress = self.nTime*100/self.nCDTime
    progress = math.ceil(progress)
    if force then
        self.nProgress = progress
        self:onProgress(self.nProgress)
    else
        if self.nProgress ~= progress then
            self.nProgress = progress
            self:onProgress(self.nProgress)
        end
    end
end


return CountDown