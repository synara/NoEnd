--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a645d2ef518e835689fd79e7ecfed93d:5e35f9b9d298f0979b8b6ba50bf13211:ce59e0ef6b4af9fefc088af809f682f1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1be96d3e76b8015
            x=1631,
            y=1190,
            width=35,
            height=11,

        },
        {
            -- abelha
            x=1087,
            y=1249,
            width=100,
            height=91,

        },
        {
            -- abelha2
            x=1189,
            y=1249,
            width=100,
            height=91,

        },
        {
            -- cenario1
            x=1,
            y=1,
            width=1084,
            height=1920,

        },
        {
            -- flecha
            x=1087,
            y=1832,
            width=75,
            height=23,

        },
        {
            -- macaco
            x=1087,
            y=1342,
            width=100,
            height=91,

        },
        {
            -- montanha1
            x=1379,
            y=610,
            width=290,
            height=578,

        },
        {
            -- montanha2
            x=1087,
            y=669,
            width=290,
            height=578,

        },
        {
            -- montanha3
            x=1379,
            y=1,
            width=290,
            height=607,

        },
        {
            -- montanha4
            x=1087,
            y=1,
            width=290,
            height=666,

        },
        {
            -- nuvem
            x=1379,
            y=1190,
            width=250,
            height=177,

        },
        {
            -- player1
            x=1087,
            y=1435,
            width=75,
            height=149,

        },
        {
            -- player2.1
            x=1291,
            y=1249,
            width=75,
            height=154,

        },
        {
            -- player2.2
            x=1189,
            y=1342,
            width=75,
            height=154,

        },
        {
            -- player3.1
            x=1087,
            y=1586,
            width=75,
            height=121,

        },
        {
            -- player3.2
            x=1087,
            y=1709,
            width=75,
            height=121,

        },
    },
    
    sheetContentWidth = 1670,
    sheetContentHeight = 1922
}

SheetInfo.frameIndex =
{

    ["1be96d3e76b8015"] = 1,
    ["abelha"] = 2,
    ["abelha2"] = 3,
    ["cenario1"] = 4,
    ["flecha"] = 5,
    ["macaco"] = 6,
    ["montanha1"] = 7,
    ["montanha2"] = 8,
    ["montanha3"] = 9,
    ["montanha4"] = 10,
    ["nuvem"] = 11,
    ["player1"] = 12,
    ["player2.1"] = 13,
    ["player2.2"] = 14,
    ["player3.1"] = 15,
    ["player3.2"] = 16,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
