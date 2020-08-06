local RoleName = {}
if TFFileUtil:existFile("LuaScript/roleName.lua") then
    RoleName = require("LuaScript.roleName")
end

local Editor = class("Editor")

local AttackEffType ={
    list = table.concat({
        "攻击者身上播放",
        "屏幕中心播放", 
        "打横排", 
        "直线飞行单体", 
        "直线飞行竖排", 
        "攻击者脚下播放", 
        "我方阵容中心播放", 
        "敌方阵容中心播放", 
        "屏幕中心置顶",  
        "我方阵容中心置顶播放", 
        "敌方阵容中心置顶播放", 
        "横屏动画不随屏幕缩放影响", 
        "横屏动画随屏幕缩放影响 （横屏特效可设置显示到前层)",
        "特效添加到roleLayer层上（特效绑定受击者所在的格位展示，不会随受击者移动或死亡而变化)\0",
    }, '\0'),

    id = {},
    rid = {},
} 
for i = 0, 10 do 
    AttackEffType.id[i] = i
    AttackEffType.rid[i] = i
end
AttackEffType.id[11] = 20
AttackEffType.id[12] = 21
AttackEffType.id[13] = 22

AttackEffType.rid[20] = 11
AttackEffType.rid[21] = 12
AttackEffType.rid[22] = 13

function Editor:ctor()

end

function Editor:saveToFile()
    local path = "lua/table/t_s_skill_display.lua"
    local fullpath = me.FileUtils:fullPathForFilename(path)

    local head = [==[  
-- 	id = 1, 			
-- 	remote = 0,			是否远程：0近程 1远程
-- 	attackEff = {0},		攻击特效id
-- 	attackEffTime = {0}, 	攻击特效开始时间(毫秒),相对于攻击动作起始点
-- 	attackEffType = {0},  
--[[
	攻击特效类型 
	0攻击者身上播放 
	1屏幕中心播放 
	2打横排 
	3直线飞行单体 
	4直线飞行竖排 
	5攻击者脚下播放 
	6我方阵容中心播放 
	7敌方阵容中心播放 
	8屏幕中心置顶  
	9我方阵容中心置顶播放 
	10敌方阵容中心置顶播放 
	20横屏动画不随屏幕缩放影响 
	21横屏动画随屏幕缩放影响 （横屏特效可设置显示到前层
	22特效添加到roleLayer层上（特效绑定受击者所在的格位展示，不会随受击者移动或死亡而变化
]]
--  hitEffType = {0},  攻击特效类型 0攻击者身上播放 1屏幕中心播放 2打横排 3直线飞行单体 4直线飞行竖排 5攻击者脚下播放 6我方阵容中心播放 7敌方阵容中心播放 8屏幕中心置顶  9我方阵容中心置顶播放 10敌方阵容中心置顶播放 
-- 	hitAnimTime1 = 100, 受击动作播放时间(毫秒),相对于攻击动作起始点
-- 	hitEff = { 0}, 		受击特效id 所有受击特效在受击者身上播放
--<---------------------------以上是必填项-------------------------------------->
--<---------------------------以下是选填项-------------------------------------->
--  moveDistance = 0,	当remote = 0 需要移动时,攻击者距离目标的距离 不填默认30
--  movePathType = 0,	当remote = 0 需要移动时,攻击者的移动路径 0直线 1曲线 不填默认直线
--  backPathType = 0,	当remote = 0 需要移动时,攻击者的返回路径 0直线 1曲线 不填默认直线
--  needMoveCenter = 0,	移动到屏幕中心释放 默认0
--  attackEffOffsetX= {0},攻击特效X偏移量，不填默认0
--  attackEffOffsetY= {0},攻击特效Y偏移量，不填默认0
--  flyEffRotate= 0,    飞行特效是否旋转，0不旋转 1旋转 不填默认0
-- 	hitAnimTime2 = 200, 多段攻击时第2次受击动作播放时间(毫秒),相对于攻击动作起始点 最多可配置到hitAnimTime10
-- 	hitAnimTime3 = 300, 多段攻击时第3次受击动作播放时间(毫秒),相对于攻击动作起始点 注意后面的时间一定要比前面大 
--  hitEffOffsetX={ 0},   受击特效X偏移量，不填默认0
--  hitEffOffsetY={ 0},   受击特效Y偏移量，不填默认0
-- 	hitEffTime = {0},		受击特效开始时间(毫秒),相对于受击动作起始点	不填默认0
-- 	hitEffShowOnce = 0,	多次受击时是否只显示一次受击特效 默认0
-- 	attackAnimMove = 1,	攻击动作是否带位移，带位移隐藏血条 默认0
--  attackSound = 1000, 攻击音效，文件夹为Resource\sound\effect
--  attackSoundTime = 100, 攻击音效开始时间(毫秒),相对于攻击动作起始点 不填默认0
--  hitSound = 1001, 	受击音效，文件夹为Resource\sound\effect
--  hitSoundTime = 100, 受击音效开始时间(毫秒),相对于受击动作起始点 不填默认0
--  attackAnim = "attack", 攻击动作名称，不填普攻调用attack 技能调用skill
--  needMoveSameRow = 1,移动到目标同一排释放 默认0
--  beforeMoveAnim = "drink" 移动前播放的动作
--  shake = 10 屏幕抖动值，未填远程默认6，近战默认3
--  extraShowHit = true 额外buff动画是否显示被击打动画
--  extraEff  额外动画参数 类似 hitEff 改成extraEff就好了


-- 古龙新增 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
-- attackScale = 1.3, 			角色攻击时屏幕拉近倍速
-- attackScaleDuration = 5000,	角色攻击时屏幕拉近倍速持续时间(单位毫秒)

-- hitScale = 1.3,				角色受击时屏幕拉近倍速
-- hitScaleDelay = 0,			角色受击延迟多少时间开始执行屏幕拉近动作
-- hitScaleDuration = 4000,		角色受击时屏幕拉近倍速持续时间(单位毫秒) 

-- hitSpeed = 0.5,				角色受击时游戏速度缩放倍速
-- hitSpeedDelay = 0,			延迟多少时间开始hitSpeed动作
-- hitSpeedDuration = 5000,		hitSpeed动作持续时间(单位毫秒)

-- hitAnim = "hit",				角色受击时动作
-- changeHitAnim = "hit2",		角色受击时需要转换的动作
-- changeHitAnimDelay = 100,	受击多长时间开始转换动作
-- changeHitAnimPlay = 6000,	受击多长时间开始播放新动作

-- changeHitAnimMoveDelay = 300,		延迟移动动作位置
-- changeHitAnimMoveDuration = 1000,	移动动作持续时间
-- changeHitAnimMove = {x = 50, y = 50},偏移量
-- bRoleSkill true为侠客技能 false为神兵技能
-- attackZOrder = {-1,1}            特效层级显示，负数表示人后面（越小越远），正数表示人前面（越大越近）
-- hitZOrder = {-1,1}            特效层级显示，负数表示人后面（越小越远），正数表示人前面（越大越近）
-- updateZorder = 300				更新角色的层级关系延迟时间,使角色层级低于黑底的持续时间
-- changeHitRoleZOrderStart = 100 将受击特效提至前层的开始时间点
-- changeHitRoleZOrderEnd = 50 将受击特效回到原来位置的时间段
-- needHurtDelay = 1000 延迟伤害表现
-- showLightEffect = true 确定是否需要曝光特效
--  xuliEff = {10101}, 	蓄力特效id 不填默认0
--  xuliEffTime = {50},   蓄力特效开始时间(毫秒),相对于整个action起始点 不填默认0
--  xuliEffOffsetX= 0,  蓄力特效X偏移量，不填默认0
--  xuliEffOffsetY= 0,  蓄力特效Y偏移量，不填默认0
--  xuliEffEndTime = 0  蓄力特效结束 actionBegain
--  moveVisible = true
--  backVisible = true

--特效类型 1spine 2江湖
--特效命名规则
--[[
	第1位：标识特效类型(1)spine(2)xml
	2-4位：roleID 如李寻欢 001 ，神兵从300开始，例302为泪痕剑
	第5位：表示是普攻(1)还是技能(2)
	6-8：  文件自增
	如李寻欢普攻文件命名为: attackEff = {10011001}
	如李寻欢技能由两个特效组成，则文件命名为10012001和10012002.填入attackEff则为 attackEff = {10012001,10012002}
]]

local mapArray = MEMapArray:new()
]==]

    local file = io.open(fullpath, "wb+")
    if not file then return end
    file:close()

    local file = io.open(fullpath, "rb+")
    print(file, fullpath)
    if not file then return end

    local format = string.format

    local function foreach(t, func) 
        t = t or {}
        for k, v in ipairs(t) do 
            func(k, v or 0)
        end
    end

    local function writeInt(file, key, val, def)
        if val and val ~= def then
            file:write(format("%s = %d, ", key, val or 0))
        end
    end

    local function writeFloat(file, key, val, def)
        if val and val ~= def then
            file:write(format("%s = %s, ", key, tostring(val or 0)))
        end
    end

    local function writeString(file, key, val, def)
        if val and val ~= def then
            file:write(format("%s = \"%s\", ", key, val or ""))
        end
    end

    local function writeTabInt(file, info, key, ignoreWhenEMpty)
        if ignoreWhenEMpty then 
            if not info[key] or #info[key] == 0 then 
                return
            end
        end
        file:write(format("%s = {", key))
            foreach(info[key], function(k, v) file:write(format("%d, ", v)) end)
        file:write("}, ")
    end

    file:write(head)

    for info in SkillDisplayData:iterator() do 
        file:write("mapArray:push({")

        file:write(format("id = %d,\t", info.id or 0))
        writeInt(file, "remote", info.remote, -1)
        writeTabInt(file, info, "attackEff")
        writeTabInt(file, info, "attackEffTime")
        writeTabInt(file, info, "attackEffType")
        writeTabInt(file, info, "hitEffType")
        writeTabInt(file, info, "hitEff")
        for i = 1, 10 do 
            local name = "hitAnimTime" .. i
            writeInt(file, name, info[name], -1)
        end
        
        writeInt(file, "moveDistance", info.moveDistance, 30)
        writeInt(file, "movePathType", info.movePathType, 0)
        writeInt(file, "backPathType", info.backPathType, 0)
        writeInt(file, "needMoveCenter", info.needMoveCenter, 0)
        writeInt(file, "flyEffRotate", info.flyEffRotate, 0)
        
        writeTabInt(file, info, "attackEffOffsetX", true)
        writeTabInt(file, info, "attackEffOffsetY", true)
        writeTabInt(file, info, "hitEffOffsetX", true)
        writeTabInt(file, info, "hitEffOffsetY", true)
        writeTabInt(file, info, "hitEffTime", true)
        
        writeInt(file, "hitEffShowOnce", info.hitEffShowOnce, 0)
        writeInt(file, "attackAnimMove", info.attackAnimMove, 0)
        writeInt(file, "attackSound", info.attackSound, 0)
        writeInt(file, "attackSoundTime", info.attackSoundTime, 0)
        writeInt(file, "hitSound", info.hitSound, 0)
        writeInt(file, "hitSoundTime", info.hitSoundTime, 0)
        writeString(file, "attackAnim", info.attackAnim, nil)
        writeInt(file, "needMoveSameRow", info.needMoveSameRow, 0)
        writeString(file, "beforeMoveAnim", info.beforeMoveAnim, nil)

        local def = info.remote == 0 and 3 or 6
        writeInt(file, "shake", info.shake, def)
        writeFloat(file, "attackScale", info.attackScale, 1)
        writeInt(file, "attackScaleDuration", info.attackScaleDuration, 0)
                
        writeFloat(file, "hitScale", info.hitScale, 1)
        writeInt(file, "hitScaleDelay", info.hitScaleDelay, 0)
        writeInt(file, "hitScaleDuration", info.hitScaleDuration, 0)
                
        writeFloat(file, "hitSpeed", info.hitSpeed, 1)
        writeInt(file, "hitSpeedDelay", info.hitSpeedDelay, 0)
        writeInt(file, "hitSpeedDuration", info.hitSpeedDuration, 0)
        
        writeString(file, "hitAnim", info.hitAnim, nil)
        writeString(file, "changeHitAnim", info.changeHitAnim, nil)
        writeInt(file, "changeHitAnimDelay", info.changeHitAnimDelay, 0)
        writeInt(file, "changeHitAnimPlay", info.changeHitAnimPlay, 0)
        writeInt(file, "changeHitAnimMoveDelay", info.changeHitAnimMoveDelay, 0)
        writeInt(file, "changeHitAnimMoveDuration", info.changeHitAnimMoveDuration, 0)

        if info.changeHitAnimMove then
            local x, y = info.changeHitAnimMove.x or 0, info.changeHitAnimMove.y or 0
            if x ~= 0 or y ~= 0 then
                file:write(format("changeHitAnimMove = {x = %d, y = %d}, ", x, y))
            end
        end

        if info.bRoleSkill == false then
            file:write("bRoleSkill = false, ")
        end
        
        writeTabInt(file, info, "attackZOrder", true)
        writeTabInt(file, info, "hitZOrder", true)
        writeInt(file, "updateZorder", info.updateZorder, 0)
        writeInt(file, "changeHitRoleZOrderStart", info.changeHitRoleZOrderStart, 0)
        writeInt(file, "changeHitRoleZOrderEnd", info.changeHitRoleZOrderEnd, 0)
        writeInt(file, "needHurtDelay", info.needHurtDelay, 0)

        if info.showLightEffect == true then
            file:write("showLightEffect = true, ")
        end
        writeTabInt(file, info, "xuliEff", true)
        writeTabInt(file, info, "xuliEffTime", true)
        writeInt(file, "xuliEffOffsetX", info.xuliEffOffsetX, 0)
        writeInt(file, "xuliEffOffsetY", info.xuliEffOffsetY, 0)
        writeInt(file, "xuliEffEndTime", info.xuliEffEndTime, 0)

        if info.moveVisible == false then
            file:write("moveVisible = false, ")
        end
        if info.backVisible == false then
            file:write("backVisible = false, ")
        end

        file:write("})\n")
    end

    file:write("\nreturn mapArray\n")
    
    file:close()
end

function Editor:drawRoleResList()
    local fightUiLayer = TFDirector:currentScene().fightUiLayer
    local roleReslistVector = fightUiLayer.roleReslistVector

    imgui.beginGroup()
        imgui.text("角色资源:")

        imgui.sameLine()
        if imgui.button("添加##角色资源") then 
            fightUiLayer:addRoleBtnClickHandle()
        end    
        if imgui.isItemHovered() then
            imgui.setTooltip("添加选中角色到场景")
        end

        imgui.sameLine()
        if imgui.button("刷新##角色资源") then 
            fightUiLayer:refreshRoleResBtnClickHandle()
        end
        if imgui.isItemHovered() then
            imgui.setTooltip("刷新角色资源")
        end

        imgui.pushItemWidth(120)
        _, self.roleResFilter = imgui.inputText("搜索##角色资源##技能信息", self.roleResFilter or "", 256)
        imgui.popItemWidth()

        imgui.beginChild("角色资源", 150, 250) 
            local selectRoleResLabel = fightUiLayer.selectRoleResLabel or {}
            for i = #roleReslistVector, 1, -1  do 
                local label = roleReslistVector[i]
                local newlabel = label .. string.format(" - %s", RoleName[label] or "无")
                if self.roleResFilter == "" or newlabel:find(self.roleResFilter or "") then 
                    if imgui.selectable(newlabel, selectRoleResLabel.txt == label) then 
                        fightUiLayer.selectRoleResLabel = fightUiLayer.roleReslistMap[label]
                    end
                end
            end
        imgui.endChild()
    imgui.endGroup()
end

function Editor:drawEffectResList()
    local fightUiLayer = TFDirector:currentScene().fightUiLayer
    local effectReslistVector = fightUiLayer.effectReslistVector
    
    imgui.beginGroup()
        imgui.text("特效资源:")

        imgui.sameLine()
        if imgui.button("添加##特效资源") then 
            fightUiLayer:addEffectBtnClickHandle()
        end    
        if imgui.isItemHovered() then
            imgui.setTooltip("添加特效")
        end

        imgui.sameLine()
        if imgui.button("刷新##特效资源") then 
            fightUiLayer:refreshEffectResBtnClickHandle()
        end
        if imgui.isItemHovered() then
            imgui.setTooltip("刷新特效资源")
        end

        imgui.pushItemWidth(120)
        _, self.effectResFilter = imgui.inputText("搜索##特效资源##技能信息", self.effectResFilter or "", 256)
        imgui.popItemWidth()

        imgui.beginChild("特效资源", 150, 250) 
            local selectEffectResLabel = fightUiLayer.selectEffectResLabel or {}
            for i = 1, #effectReslistVector do 
                local label = effectReslistVector[i]
                if self.effectResFilter == "" or label:find(self.effectResFilter or "") then 
                    if imgui.selectable(label, selectEffectResLabel.txt == label) then 
                        fightUiLayer.selectEffectResLabel = fightUiLayer.effectResListMap[label]
                    end
                end
            end
        imgui.endChild()
    imgui.endGroup()
end

function Editor:drawRoleList()
    local fightUiLayer = TFDirector:currentScene().fightUiLayer
    local roleListVector = fightUiLayer.roleListVector
    local roleActionListVector = fightUiLayer.roleActionListVector

    imgui.beginGroup()
        imgui.beginGroup()
            imgui.text("角色列表:")
            imgui.sameLine()
            if imgui.button("删除##角色列表") then 
                fightUiLayer:delRoleBtnClickHandle()
            end
            if imgui.isItemHovered() then
                imgui.setTooltip("删除选中角色")
            end
            imgui.beginChild("Role##角色列表", 150, 0) 
                for posindex, role in pairs(roleListVector) do 
                    local selectRoleLabel = fightUiLayer.selectRoleLabel or {}
                    if imgui.selectable(role.logicInfo.typeid .. "##角色列表" .. posindex, selectRoleLabel.role and selectRoleLabel.role.logicInfo.posindex == posindex) then 
                        fightUiLayer.selectRoleLabel = role.label
                        fightUiLayer:UpdateSelectRole(role)
                    end
                end
            imgui.endChild()
        imgui.endGroup()
        imgui.sameLine()
        imgui.beginGroup()
            imgui.text("动作列表:")
            imgui.beginChild("Action##动作列表", 150, 0) 
                for idx, actName in ipairs(roleActionListVector) do 
                    local selectAnimLabel = fightUiLayer.selectAnimLabel or {}
                    if imgui.selectable(actName, selectAnimLabel.txt == actName) then 
                        fightUiLayer.selectAnimLabel = roleActionListVector[actName]
                        fightUiLayer:UpdateAnimEffectInfo()
                        fightUiLayer:PlayAnim()
                    end
                end
            imgui.endChild()
        imgui.endGroup()

    imgui.endGroup()
end

function Editor:drawSkills()
    local fightUiLayer = TFDirector:currentScene().fightUiLayer
    local roleActionListVector = fightUiLayer.roleActionListVector

    imgui.beginGroup()
        imgui.beginGroup()
        imgui.text("技能列表:")
        imgui.sameLine()
        if imgui.button("刷新##技能列表") then 
            fightUiLayer:refreshSkillBtnClickHandle()
        end
        if imgui.isItemHovered() then
            imgui.setTooltip("Refresh Skills Info")
        end

        imgui.pushItemWidth(120)
        _, self.skillResFilter = imgui.inputText("搜索##技能列表##技能信息", self.skillResFilter or "", 256)
        imgui.popItemWidth()

        imgui.beginChild("技能列表", 150, 0) 
            local selectSkillResLabel = fightUiLayer.selectSkillResLabel or {}
            for label in fightUiLayer.skillResList.children:iterator() do 
                if self.skillResFilter == "" or tostring(label.txt):find(self.skillResFilter or "") then 
                    if imgui.selectable(label.txt, selectSkillResLabel.txt == label.txt) then 
                        fightUiLayer.selectSkillResLabel = label
                        fightUiLayer:PlaySkill()
                    end
                end
            end
        imgui.endChild()        
        imgui.endGroup()

        imgui.sameLine()

        imgui.beginGroup()
        imgui.text("技能信息:")
        imgui.sameLine()
        if imgui.button("保存##技能信息") then 
            self:saveToFile()
        end
        imgui.beginChild("技能信息", 0, 0) 
            if fightUiLayer.selectSkillResLabel then 
                local skillID = tonumber(fightUiLayer.selectSkillResLabel:getText())
                local info = SkillDisplayData:objectByID(skillID)

                info.name = info.name or ""
                imgui.pushItemWidth(150)

                imgui.inputText("技能ID", info.id or "nil", 256)
                _, info.name = imgui.inputText("技能名称##技能信息", info.name, 256)
                _, info.remote = imgui.combo("攻击模式##技能信息", info.remote, "近程\0远程\0")
                if info.remote > 1 then info.remote = 1 end

                if imgui.collapsingHeader("攻击特效##技能信息", {imgui.ImGuiTreeNodeFlags_DefaultOpen}) then 
                    if imgui.button("添加##攻击特效##技能信息") then 
                        info.attackEff = info.attackEff or {}
                        info.attackEffTime = info.attackEffTime or {}
                        info.attackEffType = info.attackEffType or {}
                        
                        table.insert(info.attackEff, 0)
                        table.insert(info.attackEffTime, 0)
                        table.insert(info.attackEffType, 0)                            
                    end
                    imgui.sameLine()
                    if imgui.button("删除##攻击特效##技能信息") then 
                        if #info.attackEff > 1 then 
                            table.remove(info.attackEff, #info.attackEff)
                        end                           
                    end
                    info.hitEffType = info.hitEffType or {}
                    info.hitEff = info.hitEff or {}
                    info.hitEffOffsetX = info.hitEffOffsetX or {}
                    info.hitEffOffsetY = info.hitEffOffsetY or {}
                    info.attackEffOffsetX = info.attackEffOffsetX or {}
                    info.attackEffOffsetY = info.attackEffOffsetY or {}
                    info.hitEffTime = info.hitEffTime or {}
                    info.attackZOrder = info.attackZOrder or {}
                    info.hitZOrder = info.hitZOrder or {}

                    if info.attackEff then
                        for idx, val in ipairs(info.attackEff) do 
                            if imgui.treeNode("编号:" .. idx .. "##攻击特效##技能信息") then 
                            
                                if imgui.treeNode("攻击##攻击特效##技能信息" .. i) then 
                                    info.attackEffType[idx] = info.attackEffType[idx] or 0                                
                                    info.attackEffType[idx] = AttackEffType.rid[info.attackEffType[idx]]

                                    _, info.attackEffType[idx] = imgui.combo("攻击模式##攻击特效##技能信息" .. i, info.attackEffType[idx], AttackEffType.list)

                                    _, info.attackEff[idx] = imgui.inputText("攻击特效##攻击特效##技能信息" .. i, val, 256)
                                    if info.attackEff[idx] == '' then 
                                        info.attackEff[idx] = 0
                                    end
                                    info.attackEff[idx] = tonumber(info.attackEff[idx]) or 0
                                    
                                    info.attackEffTime[idx] = info.attackEffTime[idx] or 0
                                    _, info.attackEffTime[idx] = imgui.dragInt("攻击开始时间##攻击特效##技能信息" .. i, info.attackEffTime[idx], 1)
                                    
                                    if info.attackEffType[idx] > #AttackEffType.id then
                                        info.attackEffType[idx] = #AttackEffType.id
                                    end
                                    info.attackEffType[idx] = AttackEffType.id[info.attackEffType[idx]]

                                    info.attackEffOffsetX[idx] = info.attackEffOffsetX[idx] or 0
                                    _, info.attackEffOffsetX[idx] = imgui.dragInt("攻击特效X偏移量##攻击特效##技能信息" .. i, info.attackEffOffsetX[idx], 1)
                                    
                                    info.attackEffOffsetY[idx] = info.attackEffOffsetY[idx] or 0
                                    _, info.attackEffOffsetY[idx] = imgui.dragInt("攻击特效Y偏移量##攻击特效##技能信息" .. i, info.attackEffOffsetY[idx], 1)

                                    info.attackZOrder[idx] = info.attackZOrder[idx] or 0
                                    _, info.attackZOrder[idx] = imgui.dragInt("攻击特效层级显示##攻击特效##技能信息" .. i, info.attackZOrder[idx], 1)

                                    imgui.treePop()
                                end
                                
                                if imgui.treeNode("受击##攻击特效##技能信息" .. i) then 
                                    info.hitEffType[idx] = info.hitEffType[idx] or 0                                
                                    info.hitEffType[idx] = AttackEffType.rid[info.hitEffType[idx]]
                                    _, info.hitEffType[idx] = imgui.combo("受击模式##攻击特效##技能信息" .. i, info.hitEffType[idx], AttackEffType.list)
                                    
                                    if info.hitEffType[idx] > 10 then
                                        info.hitEffType[idx] = 10
                                    end
                                    info.hitEffType[idx] = AttackEffType.id[info.hitEffType[idx]]

                                    info.hitEff[idx] = info.hitEff[idx] or 0
                                    _, info.hitEff[idx] = imgui.inputText("受击特效##攻击特效##技能信息" .. i, info.hitEff[idx], 256)
                                    if info.hitEff[idx] == '' then 
                                        info.hitEff[idx] = 0
                                    end
                                    info.hitEff[idx] = tonumber(info.hitEff[idx]) or 0
                                    
                                    info.hitEffTime[idx] = info.hitEffTime[idx] or 0
                                    _, info.hitEffTime[idx] = imgui.dragInt("受击特效开始时间##攻击特效##技能信息" .. i, info.hitEffTime[idx], 1)

                                    info.hitEffOffsetX[idx] = info.hitEffOffsetX[idx] or 0
                                    _, info.hitEffOffsetX[idx] = imgui.dragInt("受击特效X偏移量##攻击特效##技能信息" .. i, info.hitEffOffsetX[idx], 1)
                                    
                                    info.hitEffOffsetY[idx] = info.hitEffOffsetY[idx] or 0
                                    _, info.hitEffOffsetY[idx] = imgui.dragInt("受击特效Y偏移量##攻击特效##技能信息" .. i, info.hitEffOffsetY[idx], 1)

                                    info.hitZOrder[idx] = info.hitZOrder[idx] or 0
                                    _, info.hitZOrder[idx] = imgui.dragInt("受击特效层级显示##攻击特效##技能信息" .. i, info.hitZOrder[idx], 1)

                                    imgui.treePop()
                                end
                                imgui.treePop()
                            end
                        end

                    end
                end
                
                if imgui.collapsingHeader("受击动作延时##技能信息", {imgui.ImGuiTreeNodeFlags_DefaultOpen}) then 
                    info.hitAnimTime1 = info.hitAnimTime1 or 0
                    _, info.hitAnimTime1 = imgui.dragInt("受击动作延时1##受击动作延时##技能信息", info.hitAnimTime1, 1)
                    
                    info.hitAnimTimeCount = info.hitAnimTimeCount or 1

                    if imgui.button("添加##受击动作延时##技能信息") then 
                        if info.hitAnimTimeCount < 10 then
                            local cnt = info.hitAnimTimeCount + 1
                            info["hitAnimTime" .. cnt] = info["hitAnimTime" .. (cnt-1)] + 10
                        end
                    end
                    imgui.sameLine()
                    
                    if imgui.button("删除##受击动作延时##技能信息") then 
                        if info.hitAnimTimeCount > 1 then
                            info["hitAnimTime" .. info.hitAnimTimeCount] = nil
                            info.hitAnimTimeCount = info.hitAnimTimeCount - 1
                        end
                    end

                    for i = 2, 10 do 
                        local hitanim = info["hitAnimTime" .. i]
                        if hitanim then 
                            _, hitanim = imgui.dragInt(string.format("受击动作延时%d##受击动作延时##技能信息", i), hitanim, 1)
                            if hitanim < info["hitAnimTime" .. (i - 1)] then 
                                print(hitanim, info["hitAnimTime" .. (i - 1)], i, i - 1)
                                info["hitAnimTime" .. i] = info["hitAnimTime" .. (i - 1)] + 5
                            else 
                                info["hitAnimTime" .. i] = hitanim
                            end
                        else    
                            info.hitAnimTimeCount = i - 1
                            break
                        end
                    end
                end
                
                if imgui.collapsingHeader("选填属性##技能信息", {imgui.ImGuiTreeNodeFlags_DefaultOpen}) then 
                    info.movePathType = info.movePathType or 0
                    info.backPathType = info.backPathType or 0
                    info.needMoveCenter = info.needMoveCenter or 0
                    info.flyEffRotate = info.flyEffRotate or 0
                    info.hitEffShowOnce = info.hitEffShowOnce or 0
                    info.attackAnimMove = info.attackAnimMove or 0
                    info.needMoveSameRow = info.needMoveSameRow or 0
                    info.extraShowHit = info.extraShowHit or 0
                    info.shake = info.shake or (info.remote == 0 and 3 or 6)
                    info.attackAnim = info.attackAnim or "attack"

                    
                    local _, ret = imgui.checkbox("是否移动到屏幕中心释放##选填属性##技能信息", info.needMoveCenter)
                    info.needMoveCenter = ret and 1 or 0
                    if info.needMoveCenter == 0 then info.needMoveCenter = nil end

                    local _, ret = imgui.checkbox("飞行特效是否旋转##选填属性##技能信息", info.flyEffRotate)
                    info.flyEffRotate = ret and 1 or 0
                    if info.flyEffRotate == 0 then info.flyEffRotate = nil end

                    local _, ret = imgui.checkbox("多次受击时是否只显示一次受击特效##选填属性##技能信息", info.hitEffShowOnce)
                    info.hitEffShowOnce = ret and 1 or 0
                    if info.hitEffShowOnce == 0 then info.hitEffShowOnce = nil end

                    local _, ret = imgui.checkbox("攻击动作是否带位移，带位移隐藏血条##选填属性##技能信息", info.attackAnimMove)
                    info.attackAnimMove = ret and 1 or 0
                    if info.attackAnimMove == 0 then info.attackAnimMove = nil end

                    local _, ret = imgui.checkbox("移动到目标同一排释放##选填属性##技能信息", info.needMoveSameRow)
                    info.needMoveSameRow = ret and 1 or 0
                    if info.needMoveSameRow == 0 then info.needMoveSameRow = nil end
                    
                    if info.remote == 0 then 
                        local moveDistance = info.moveDistance or 30
                        _, moveDistance = imgui.dragInt("攻击者距离目标的距离##选填属性##技能信息", moveDistance, 1)
                        if moveDistance == 30 then 
                            info.moveDistance = nil
                        else 
                            info.moveDistance = moveDistance
                        end
                    else 
                        info.moveDistance = nil
                    end
                    _, info.movePathType = imgui.combo("移动路径类型##选填属性##技能信息", info.movePathType, "直线\0曲线\0")
                    _, info.backPathType = imgui.combo("返回路径类型##选填属性##技能信息", info.backPathType, "直线\0曲线\0")

                    if info.movePathType == 0 then info.movePathType = nil end
                    if info.backPathType == 0 then info.backPathType = nil end

                    if not roleActionListVector.animCombos then
                        if #roleActionListVector > 0 then 
                            roleActionListVector.animCombos = table.concat(roleActionListVector, '\0')
                            roleActionListVector.animCombos = roleActionListVector.animCombos .. '\0'

                            roleActionListVector.rmap = {}
                            for idx, actName in ipairs(roleActionListVector) do 
                                roleActionListVector.rmap[actName] = idx - 1
                            end
                        else 

                        end
                    end
                    if roleActionListVector.animCombos then
                        local attackAnim = info.attackAnim

                        local animID = attackAnim and (roleActionListVector.rmap[attackAnim] or 0) or 0
                        local _, animID = imgui.combo("攻击动作名称##选填属性##技能信息", animID, "无\0"..roleActionListVector.animCombos)
                        if animID == 0 then 
                            info.attackAnim = nil
                        else 
                            info.attackAnim = roleActionListVector[animID + 1] or "attack"
                        end
                    end
                    if roleActionListVector.animCombos then
                        local beforeMoveAnim = info.beforeMoveAnim

                        local animID = beforeMoveAnim and (roleActionListVector.rmap[beforeMoveAnim] or 0) or 0
                        local _, animID = imgui.combo("移动前播放的动作##选填属性##技能信息", animID, "无\0"..roleActionListVector.animCombos)
                        if animID == 0 then 
                            info.beforeMoveAnim = nil
                        else 
                            info.beforeMoveAnim = roleActionListVector[animID + 1] or "attack"
                        end
                    end

                    
                    _, info.shake = imgui.dragInt("屏幕抖动值##选填属性##技能信息", info.shake, 1)

                    info.attackSound = info.attackSound or 0
                    info.attackSoundTime = info.attackSoundTime or 0
                    _, info.attackSound = imgui.inputText("攻击音效##选填属性##技能信息", info.attackSound, 256)
                    if info.attackSound == '' then 
                        info.attackSound = 0
                    end
                    info.attackSound = tonumber(info.attackSound) or 0
                    _, info.attackSoundTime = imgui.dragInt("攻击音效开始时间(毫秒)##选填属性##技能信息", info.attackSoundTime, 1)

                    info.hitSound = info.hitSound or 0
                    info.hitSoundTime = info.hitSoundTime or 0
                    _, info.hitSound = imgui.inputText("受击音效##选填属性##技能信息", info.hitSound, 256)
                    if info.hitSound == '' then 
                        info.hitSound = 0
                    end
                    info.hitSound = tonumber(info.hitSound) or 0
                    _, info.hitSoundTime = imgui.dragInt("受击音效开始时间(毫秒)##选填属性##技能信息", info.hitSoundTime, 1)

                end
                
                if imgui.collapsingHeader("选填属性2##技能信息", {imgui.ImGuiTreeNodeFlags_DefaultOpen}) then 
                    local bRoleSkill = info.bRoleSkill == nil and true or info.bRoleSkill
                    local _, ret = imgui.checkbox("是否为侠客技能##选填属性2##技能信息", bRoleSkill and 1 or 0)
                    if _ then info.bRoleSkill = ret end
                    if info.bRoleSkill == true then info.bRoleSkill = nil end

                    local moveVisible = info.moveVisible == nil and true or info.moveVisible
                    local _, ret = imgui.checkbox("移动时是否显示##选填属性2##技能信息", moveVisible and 1 or 0)
                    if _ then info.moveVisible = ret end
                    if info.moveVisible == true then info.moveVisible = nil end

                    local backVisible = info.backVisible == nil and true or info.backVisible
                    local _, ret = imgui.checkbox("返回时是否显示##选填属性2##技能信息", backVisible and 1 or 0)
                    if _ then info.backVisible = ret end
                    if info.backVisible == true then info.backVisible = nil end

                    local showLightEffect 
                    if info.showLightEffect == nil then 
                        showLightEffect = false 
                    else 
                        showLightEffect = info.showLightEffect 
                    end
                    local _, ret = imgui.checkbox("是否需要曝光特效##选填属性2##技能信息", showLightEffect and 1 or 0)
                    if _ then info.showLightEffect = ret end
                    
                    info.needHurtDelay = info.needHurtDelay or 0
                    _, info.needHurtDelay = imgui.dragInt("延迟伤害表现(毫秒)##选填属性2##技能信息", info.needHurtDelay, 1)
                    if info.needHurtDelay == 0 then info.needHurtDelay = nil end
                    
                    info.updateZorder = info.updateZorder or 0
                    _, info.updateZorder = imgui.dragInt("更新角色的层级关系延迟时间##选填属性2##技能信息", info.updateZorder, 1)
                    if info.updateZorder == 0 then info.updateZorder = nil end
                    
                    if imgui.treeNode("受击特效提至前层的时间##选填属性2##技能信息") then
                        info.changeHitRoleZOrderStart = info.changeHitRoleZOrderStart or 0
                        _, info.changeHitRoleZOrderStart = imgui.dragInt("开始##选填属性2##受击特效提至前层的时间", info.changeHitRoleZOrderStart, 1)
                        if info.changeHitRoleZOrderStart == 0 then info.changeHitRoleZOrderStart = nil end

                        info.changeHitRoleZOrderEnd = info.changeHitRoleZOrderEnd or 0
                        _, info.changeHitRoleZOrderEnd = imgui.dragInt("结束##选填属性2##受击特效提至前层的时间", info.changeHitRoleZOrderEnd, 1)
                        if info.changeHitRoleZOrderEnd == 0 then info.changeHitRoleZOrderEnd = nil end

                        imgui.treePop()
                    end

                    if imgui.treeNode("蓄力特效##选填属性2##技能信息") then
                        info.xuliEff = info.xuliEff or {}
                        info.xuliEffTime = info.xuliEffTime or {}

                        info.xuliEffEndTime = info.xuliEffEndTime or 0
                        _, info.xuliEffEndTime = imgui.dragInt("蓄力特效结束##蓄力特效##选填属性2##技能信息", info.xuliEffEndTime, 1)

                        info.xuliEffOffsetX = info.xuliEffOffsetX or 0
                        _, info.xuliEffOffsetX = imgui.dragInt("蓄力特效X偏移量##蓄力特效##选填属性2##技能信息", info.xuliEffOffsetX, 1)
                        
                        info.xuliEffOffsetY = info.xuliEffOffsetY or 0
                        _, info.xuliEffOffsetY = imgui.dragInt("蓄力特效Y偏移量##蓄力特效##选填属性2##技能信息", info.xuliEffOffsetY, 1)

                        if imgui.button("添加##蓄力特效##选填属性2##技能信息") then 
                            table.insert(info.xuliEff, 0)
                            table.insert(info.xuliEffTime, 0)
                        end
                        imgui.sameLine()
                        if imgui.button("删除##蓄力特效##选填属性2##技能信息") then 
                            if #info.xuliEff > 1 then 
                                table.remove(info.xuliEff, #info.xuliEff)
                                table.remove(info.xuliEffTime, #info.xuliEff)
                            end
                        end
                        for i = 1, #info.xuliEff do 
                            if imgui.treeNode("编号" .. i .."##蓄力特效##选填属性2##技能信息") then
                                local xuliID = info.xuliEff[i] or 0
                                _, xuliID = imgui.inputText("蓄力特效 ID##蓄力特效##选填属性2##技能信息" ..i, xuliID, 256)
                                if xuliID == '' then 
                                    xuliID = 0
                                end
                                info.xuliEff[i] = tonumber(xuliID) or 0

                                info.xuliEffTime[i] = info.xuliEffTime[i] or 0
                                _, info.xuliEffTime[i] = imgui.dragInt("蓄力特效开始时间(毫秒)##蓄力特效##选填属性2##技能信息" .. i, info.xuliEffTime[i], 1)
                                imgui.treePop()
                            end
                        end

                        imgui.treePop()
                    end

                    if imgui.treeNode("角色攻击时屏幕拉近##选填属性2##技能信息") then 
                        local attackScale = info.attackScale or 1
                        changed, attackScale = imgui.dragFloat("倍速##角色攻击时屏幕拉近##选填属性2", attackScale, 0.01, 0.5, 2, "%.2f")
                        if changed then 
                            if attackScale == 1 then 
                                info.attackScale = nil
                            else 
                                info.attackScale = attackScale
                            end
                        end
                        info.attackScaleDuration = info.attackScaleDuration or 0
                        _, info.attackScaleDuration = imgui.dragInt("持续时间##角色攻击时屏幕拉近##选填属性2", info.attackScaleDuration, 1)

                        imgui.treePop()
                    end

                    if imgui.treeNode("角色受击时屏幕拉近##选填属性2##技能信息") then
                        local hitScale = info.hitScale or 1
                        changed, hitScale = imgui.dragFloat("倍速##选填属性2##技能信息", hitScale, 0.01, 0.5, 2, "%.2f")
                        if changed then 
                            if hitScale == 1 then 
                                info.hitScale = nil
                            else 
                                info.hitScale = hitScale
                            end
                        end
                        info.hitScaleDelay = info.hitScaleDelay or 0
                        _, info.hitScaleDelay = imgui.dragInt("延迟##选填属性2##技能信息", info.hitScaleDelay, 1)
                        info.hitScaleDuration = info.hitScaleDuration or 0
                        _, info.hitScaleDuration = imgui.dragInt("持续时间##选填属性2##技能信息", info.hitScaleDuration, 1)

                        imgui.treePop()
                    end

                    if imgui.treeNode("角色受击时游戏速度缩放##选填属性2##技能信息") then
                        local hitSpeed = info.hitSpeed or 1
                        changed, hitSpeed = imgui.dragFloat("倍速##选填属性2##技能信息", hitSpeed, 0.01, 0.1, 3, "%.2f")
                        if changed then 
                            if hitSpeed == 1 then 
                                info.hitSpeed = nil
                            else 
                                info.hitSpeed = hitSpeed
                            end
                        end
                        info.hitSpeedDelay = info.hitSpeedDelay or 0
                        _, info.hitSpeedDelay = imgui.dragInt("延迟##选填属性2##技能信息", info.hitSpeedDelay, 1)
                        info.hitSpeedDuration = info.hitSpeedDuration or 0
                        _, info.hitSpeedDuration = imgui.dragInt("持续时间##选填属性2##技能信息", info.hitSpeedDuration, 1)

                        imgui.treePop()
                    end

                    if imgui.treeNode("受击额外参数##选填属性2##技能信息") then
                        _, info.hitAnim = imgui.inputText("角色受击时动作##受击额外参数##选填属性2##技能信息", info.hitAnim or "", 256)
                        if info.hitAnim == "" then info.hitAnim = nil end
                        _, info.changeHitAnim = imgui.inputText("角色受击时需要转换的动作##受击额外参数##选填属性2##技能信息", info.changeHitAnim or "", 256)
                        if info.changeHitAnim == "" then info.changeHitAnim = nil end

                        info.changeHitAnimDelay = info.changeHitAnimDelay or 0
                        _, info.changeHitAnimDelay = imgui.dragInt("受击多长时间开始转换动作##受击额外参数##选填属性2##技能信息", info.changeHitAnimDelay, 1)
                        info.changeHitAnimPlay = info.changeHitAnimPlay or 0
                        _, info.changeHitAnimPlay = imgui.dragInt("受击多长时间开始播放新动作##受击额外参数##选填属性2##技能信息", info.changeHitAnimPlay, 1)
                        info.changeHitAnimMoveDelay = info.changeHitAnimMoveDelay or 0
                        _, info.changeHitAnimMoveDelay = imgui.dragInt("延迟移动动作位置##受击额外参数##选填属性2##技能信息", info.changeHitAnimMoveDelay, 1)
                        info.changeHitAnimMoveDuration = info.changeHitAnimMoveDuration or 0
                        _, info.changeHitAnimMoveDuration = imgui.dragInt("移动动作持续时间##受击额外参数##选填属性2##技能信息", info.changeHitAnimMoveDuration, 1)
                        
                        info.changeHitAnimMove = info.changeHitAnimMove or  { x = 0, y = 0 }
                        _, info.changeHitAnimMove.x, info.changeHitAnimMove.y 
                            = imgui.dragInt2("偏移量(X, Y)##受击额外参数##选填属性2##技能信息", info.changeHitAnimMove.x or 0, info.changeHitAnimMove.y or 0, 1)

                        if info.changeHitAnimDelay == 0 then info.changeHitAnimDelay = nil end
                        if info.changeHitAnimPlay == 0 then info.changeHitAnimPlay = nil end
                        if info.changeHitAnimMoveDelay == 0 then info.changeHitAnimMoveDelay = nil end
                        if info.changeHitAnimMoveDuration == 0 then info.changeHitAnimMoveDuration = nil end
                        if info.changeHitAnimMove.x == 0 and info.changeHitAnimMove.y == 0 then info.changeHitAnimMove = nil end

                        imgui.treePop()
                    end
                    
                end
                imgui.popItemWidth()
            end
        imgui.endChild()     
        imgui.endGroup()

    imgui.endGroup()
end

if TFFileUtil:existFile("editor_config.lua") then
    local editor_config = require("editor_config")
end

local function saveEditorConfig(win_width, win_height) 
    local file = io.open("editor_config.lua", "wb+")
    if not file then return end

    file:write(string.format("EDITOR_SIZE = ccs(%d, %d)", win_width, win_height))

    file:close()
end

local animScale = 1
local speedBtnName = "暂停"
local size = EDITOR_SIZE or ccs(1843, 1044)--me.Director:getWinSize()
local win_width, win_height, ok = size.width, size.height
me.EGLView:setFrameSize(win_width, win_height)
me.EGLView:setDesignResolutionSize(win_width, win_height, kResolutionShowAll);
TFResolution:setResolutionRect(win_width, win_height, win_width, win_height);
function Editor:draw()
    if imgui.begin("Editor", true, {}) then
    imgui.pushItemWidth(180)
    ok, win_width, win_height = imgui.dragFloat2("Win Size", win_width, win_height)
    imgui.sameLine()
    okAnim, animScale = imgui.dragFloat("动画速度", animScale, 0.01, -2, 2, "%.2f")

    if okAnim then
        FightManager:setSpeedCoefficient(animScale)
        speedBtnName = "暂停"
    end

    imgui.sameLine()
    if imgui.button(speedBtnName) then 
        if speedBtnName == "开始" then
            speedBtnName = "暂停"
            FightManager:setSpeedCoefficient(animScale)
        else 
            speedBtnName = "开始"
            FightManager:setSpeedCoefficient(0)
        end
    end
    imgui.popItemWidth()

    if (ok) then
        print("Change Win Size:", win_width, win_height)
        me.EGLView:setFrameSize(win_width, win_height)
        me.EGLView:setDesignResolutionSize(win_width, win_height, kResolutionShowAll);
        TFResolution:setResolutionRect(win_width, win_height, win_width, win_height);

        saveEditorConfig(win_width, win_height)
    end
        imgui.beginGroup()
            imgui.beginGroup()
                self:drawRoleResList()
                imgui.sameLine()
                self:drawEffectResList()
            imgui.endGroup()
            
            imgui.separator()
            imgui.separator()
            imgui.separator()

            imgui.beginGroup()
                self:drawRoleList()
            imgui.endGroup()
        imgui.endGroup()
        imgui.sameLine()
        imgui.beginGroup()

            self:drawSkills()

        imgui.endGroup()
    end
    imgui.endToLua()
end

local editor = Editor:new()

function imgui.draw()
    -- imgui.demo()

    editor:draw()
end

return Editor