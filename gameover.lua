local composer = require( "composer" )
composer.recycleOnSceneChange = true;

local widget = require("widget")
local scene = composer.newScene()

local largura = display.contentWidth;
local altura = display.contentHeight;

function showGame() 
	composer.gotoScene("principal");
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local group = self.view
	local phase = event.phase

	local currentScore = composer.getVariable( "score" )
	print(currentScore);
	if ( phase == "will" ) then
		 
	    local sceneGroup = self.view;
	    local background = display.newImageRect( sceneGroup, "sprites-novos/menu.png", 1080, 1920)
	    background.x = display.contentCenterX
	    background.y = display.contentCenterY
		
	    local playButton = display.newText( sceneGroup, "Try Again", display.contentCenterX, 700, native.systemFont, 44 )
	    playButton:setFillColor( 0.82, 0.86, 1 )
   	    playButton:addEventListener( "tap", showGame )


	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local group = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

function scene:destroy( event )

	local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;