slime = {}

-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end

function slime.new (originPointX,originPointY)
    local guardMode = 1
    local attackMode = 2
    local slimeAnimaLength = 4 
    local obj = {
        slimeImgFile = love.graphics.newImage("img/slime.png"),
        slimeMoveSound = love.audio.newSource("audio/slime1.ogg", "static"),
        slimeQuads = {},
        moveIndex = 1,
        animationIndex = 1,
        alertRange = 2,
        moveMode = guardMode,
        moveStep = {},
        nowX = originPointX,
        nowY = originPointY,
        keyPointX = originPointX,
        keyPointY = originPointY,
        healthPoint = 10,
        moveSpeed = (math.random(25,30))*0.01,
        lastMoveStep=0, --this var is for when guardMode change to attackMode, save the movenode
        timeTick = 0
    }
    for i=1,16 do
        obj.moveStep[i] = math.random(4)
    end
    for i=1,slimeAnimaLength do
        obj.slimeQuads[i] = {}
        for j=1,slimeAnimaLength do
            obj.slimeQuads[i][j] = love.graphics.newQuad( (100*j)-100, (100*i)-100, 100, 100, 400, 400)
        end
    end
    obj = newObject(obj, slime)
    return obj
end

function slime:update(dt,charX,charY)
    self.timeTick = self.timeTick + dt
    if self.timeTick > self.moveSpeed then
        self.timeTick = 0 
        self.animationIndex = self.animationIndex + 1
        if self.animationIndex > 4  then
            self.distance = math.sqrt(math.pow((charX-self.keyPointX), 2)+ math.pow((charY-self.keyPointY), 2))
            self.guardRange = self.alertRange*100*math.sqrt(2)
            -- blow is for debug
            -- print("nowMode: "..self.moveMode)
            -- print("distance: "..self.distance)
            -- print("guardRange: "..self.guardRange)
            if self.distance > self.guardRange and self.moveMode == 2 then
                self.moveStep[self.moveIndex] = self.lastMoveStep
                self.moveMode = 1 --one is for guardMode
            elseif self.distance <= self.guardRange then
                self.moveMode = 2 --two is for attackMode
            else
                self.moveMode = 1
            end
            if self.moveMode == 1 then
                if self.moveStep[self.moveIndex] == 1 and (self.nowY-self.keyPointY<(100*self.alertRange)) then
                    self.nowY = self.nowY + 100
                end
                if self.moveStep[self.moveIndex] == 2 and (self.keyPointY-self.nowY<(100*self.alertRange)) then
                    self.nowY = self.nowY - 100
                end
                if self.moveStep[self.moveIndex] == 3 and (self.keyPointX-self.nowX<(100*self.alertRange))then
                    self.nowX = self.nowX - 100
                end
                if self.moveStep[self.moveIndex] == 4 and (self.nowX-self.keyPointX<(100*self.alertRange))then
                    self.nowX = self.nowX + 100
                end
                self.moveIndex = self.moveIndex + 1
            else
                self.lastMoveStep = self.moveStep[self.moveIndex]
                if charX > self.nowX then
                    self.moveStep[self.moveIndex] = 1
                    self.nowX = self.nowX + 100
                elseif charX < self.nowX then
                    self.moveStep[self.moveIndex] = 2
                    self.nowX = self.nowX - 100
                elseif charY > self.nowY then
                    self.moveStep[self.moveIndex] = 3
                    self.nowY = self.nowY + 100
                elseif charY < self.nowY then
                    self.moveStep[self.moveIndex] = 4
                    self.nowY = self.nowY - 100
                end
            end
            

            if self.moveIndex > table.getn(self.moveStep) then
                self.moveIndex = 1 
            end
            self.slimeMoveSound:play()
            self.animationIndex = 1
        end
    end
end

function slime:getPositionX()
    return self.nowX
end

function slime:getPositionY()
    return self.nowY
end