local composer = require( "composer" )
composer.recycleOnSceneChange = true;

local widget = require("widget") 
local scene = composer.newScene()

local bgMusic = audio.loadStream("forest.mp3");

function showGame() 
	local options = {
		effect = "fade"
	}
	audio.pause();
	composer.gotoScene("principal", options);
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	audio.play(bgMusic);
	if ( phase == "will" ) then
		 
	    local sceneGroup = self.view;
	    local background = display.newImageRect( sceneGroup, "sprites-novos/menu.png", 1080, 1920)
	    background.x = display.contentCenterX
	    background.y = display.contentCenterY

		local nameGame =  display.newText("NoEnd", display.contentWidth/2, 500, "slkscrb", 130);
		
	 	local playButton = display.newImage(sceneGroup, "sprites-novos/start.png")
		playButton.x = display.contentCenterX
		playButton.y = display.contentCenterY
	    playButton:addEventListener( "tap", showGame )

	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local sceneGroup = self.view
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