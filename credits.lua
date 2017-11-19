local composer = require( "composer" )
composer.recycleOnSceneChange = true;

local scene = composer.newScene()

local largura = display.contentWidth;
local altura = display.contentHeight;
local objGameOver = display.newGroup();
local bgMusic = audio.loadStream("forests.mp3");

function backMenu()
    --audio.pause();
    display.remove(objGameOver); 
	composer.gotoScene("menu");
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local group = self.view
	local phase = event.phase

    if ( phase == "will" ) then
        --audio.play(bgMusic);
	    local sceneGroup = self.view;
	    local background = display.newImage(sceneGroup, "sprites-novos/credits.png");
	    background.x = display.contentCenterX;
		background.y = display.contentCenterY;
        objGameOver:insert(background);
        
        local backButton = display.newImage(sceneGroup, "sprites-novos/buttonback.png")
		backButton.x = display.contentCenterX 
		backButton.y = display.contentCenterY + 800
		backButton:addEventListener( "tap", backMenu );
        objGameOver:insert(backButton);
        
	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local group = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		composer.removeScene("howtoplay")	
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