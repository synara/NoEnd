local composer = require( "composer" )
composer.recycleOnSceneChange = true;

local widget = require("widget")
local scene = composer.newScene()

function showGame() 
	local options = {
		effect = "fade"
	}
	composer.gotoScene("principal", options);
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local group = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		 
	    local sceneGroup = self.view;
	    local background = display.newImageRect( sceneGroup, "sprites-novos/menu.png", 1080, 1920)
	    background.x = display.contentCenterX
	    background.y = display.contentCenterY

	    local playButton = display.newText( sceneGroup, "Try Again", display.contentCenterX, 700, native.systemFont, 44 )
	    playButton:setFillColor( 0.82, 0.86, 1 )
   	    playButton:addEventListener( "tap", showGame )


	elseif ( phase == "did" ) then
		--timer.performWithDelay(3000, showGame)

	end
end

function scene:hide( event )

	local group = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end

function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene;