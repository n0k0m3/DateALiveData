
local Recorder = class("Recorder")
function Recorder:ctor(data,team,host)
    self.time  =  0    
    self.datas =  {}
end

local function collect(hero)
    local data    = {}
    data.position = clone(hero.position3D)
    data.hp       = hero:getHp()
    return data
end

function Recorder:update(time,hero)
    self.time =  self.time + time
    if self.time >= 1000 then 
        table.insert(self.datas, 1, collect(hero))
        if #self.datas > 10 then 
            table.remove(self.datas,#self.datas)
        end
        self.time = 0    
    end
end

function Recorder:getData(sec)
    local data = self.datas[sec]
    while not data and sec > 1 do
        sec = sec - 1
        data = self.datas[sec]
    end
    return data
end

return Recorder
