tree={}
forest={}
stone={}
grass={}
questionMark={}
q3Trap={}
npc={}
questionKey={}
-- this function is for OOP
function newObject(o, class)
    class.__index = class
    return setmetatable(o, class)
end
function npc.new (originPointX,originPointY)
    local obj = {
        Image = love.graphics.newImage("img/books.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, tree)
    return obj
end
function tree.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/tree.png"),
        Barrier=false,
        moveable=true,
        nx= originPointX,
        ny= originPointX,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, tree)
    return obj
end

function forest.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/forest.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, forest)
    return obj
end

function stone.new (originPointX,originPointY)
   local obj = {
        Image = love.graphics.newImage("img/stone.png"),
        Barrier=true,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, stone)
    return obj
end

function grass.new (originPointX,originPointY)
   local num = love.math.random(1, 4)
   local grassImg
   if num == 1 then
       grassImg = "img/grass1.png"
   elseif num == 2 then
       grassImg = "img/grass2.png"
   elseif num == 3 then
       grassImg = "img/grass3.png"
   elseif num == 4 then
       grassImg = "img/grass4.png"
   end
   local obj = {
        Image = love.graphics.newImage(grassImg),
        Barrier=false,
        x = originPointX,
        y = originPointY
    }
    obj = newObject(obj, grass)
    return obj
end
