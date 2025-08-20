local data = require "data"
FONT.get(30):setLineHeight(1.4)

local hexagramCanvas = GC.newCanvas(300, 300)
local textObj = GC.newText(FONT.get(30))
local page

local shade = { 1, 1, 1, .26 }

local function refresh()
    textObj:clear()
    local d = data[page]
    textObj:add("#" .. page .. "  " .. d.name .. "卦", 0, 0, 0, 2)
    textObj:add(d.title, 26 + 2 * textObj:getWidth(), 33)
    textObj:add(d.desc, 0, 100)

    textObj:add(table.concat(TABLE.reverse(TABLE.copy(d.explain)), "\n\n"), 330, 195)

    local host, guest = d.struct:sub(1, 3), d.struct:sub(4, 6)
    textObj:add({ shade, data.base[host][2] }, -100 - 15, 510 - 20, 0, 3)
    textObj:add({ shade, data.base[guest][2] }, -100 - 15, 265 - 20, 0, 3)
    textObj:add(data.base[host][1], -100, 510, 0, 2)
    textObj:add(data.base[guest][1], -100, 265, 0, 2)
    textObj:add(tonumber(host, 2) .. ":" .. tonumber(guest, 2), 10, 666)

    GC.setCanvas(hexagramCanvas)
    GC.clear()
    for i = 1, 6 do
        local yang = d.struct:sub(i, i) == '1'
        GC.setColor(i % 2 == 1 == yang and COLOR.dR or COLOR.dS)
        if yang then
            GC.rectangle('fill', 0, 300 - 50 * i, 300, 30)
        else
            GC.rectangle('fill', 0, 300 - 50 * i, 130, 30)
            GC.rectangle('fill', 300, 300 - 50 * i, -130, 30)
        end
    end
    GC.setCanvas()
end

---@type Zenitha.Scene
local scene = {}

function scene.load()
    page = 1
    refresh()
end

function scene.keyDown(key)
    if key == 'left' and page > 1 then
        page = page - 1
        refresh()
    elseif key == 'right' and page < 64 then
        page = page + 1
        refresh()
    end
end

function scene.update(dt)
end

local bg={COLOR.HEX"BEB38AFF"}
function scene.draw()
    GC.clear(bg)
    GC.setColor(COLOR.D)
    GC.draw(textObj, 140, 71)
    GC.setColor(1, 1, 1)
    GC.draw(hexagramCanvas, 140, 260, 0, 1, 1.66)
end

return scene
