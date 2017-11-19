local composer = require( "composer" )
composer.recycleOnSceneChange = true;

local widget = require("widget")
local scene = composer.newScene()

local largura = display.contentWidth;
local altura = display.contentHeight;
local objGameOver = display.newGroup();

function showGame()
	display.remove(objGameOver)
	composer.gotoScene("principal");
end

function backMenu()
	display.remove(objGameOver)	
	composer.gotoScene("menu")
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local group = self.view
	local phase = event.phase

	currentScore = composer.getVariable( "score" )
	print(currentScore)

	if ( phase == "will" ) then
	    local sceneGroup = self.view;
	    local background = display.newImageRect( sceneGroup, "sprites-novos/gameover.png", 1080, 1920)
	    background.x = display.contentCenterX;
		background.y = display.contentCenterY;
		objGameOver:insert(background);
		
		youLoseText = "You lose!"
		youlose = display.newText(youLoseText, 0, 0, "slkscrb", 100)
		youlose.x = display.contentCenterX;
		youlose.y = display.contentCenterY - 700;
		objGameOver:insert(youlose);

		youScoreText = "Your score is " 
		scoreText = display.newText(youScoreText, 0, 0, "slkscrb", 100)
		scoreText.x = display.contentCenterX;
		scoreText.y = display.contentCenterY - 500;
		objGameOver:insert(scoreText);

		score = currentScore
		scoreTextPontuation = display.newText(score, 0, 0, "slkscrb", 150)
		scoreTextPontuation.x = display.contentCenterX;
		scoreTextPontuation.y = display.contentCenterY	- 300;
		objGameOver:insert(scoreTextPontuation);

		seconds = "seconds!"
		secondsText = display.newText(seconds, 0, 0, "slkscrb", 100)
		secondsText.x = display.contentCenterX;
		secondsText.y = display.contentCenterY - 50;
		objGameOver:insert(secondsText)

		dead = display.newImage("sprites-novos/dead.png");
		dead.x = display.contentCenterX;
		dead.y = display.contentCenterY + 250;
		objGameOver:insert(dead)

		
		local playButton = display.newImage(sceneGroup, "sprites-novos/buttonplayagain.png");
		playButton.x = display.contentCenterX - 250;
		playButton.y = display.contentCenterY + 700; 
   	    playButton:addEventListener( "tap", showGame )
		objGameOver:insert(playButton);

		local buttonMenu = display.newImage(sceneGroup, "sprites-novos/buttonmenu.png");
		buttonMenu.x = display.contentCenterX + 250;
		buttonMenu.y = display.contentCenterY + 700; 
		buttonMenu:addEventListener( "tap", backMenu )
		objGameOver:insert(buttonMenu);

	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local group = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		composer.removeScene("gameover");
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