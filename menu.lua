local composer = require( "composer" )
composer.recycleOnSceneChange = true;
local physics = require("physics");
physics.start();
local scene = composer.newScene()

local largura = display.contentWidth;
local altura = display.contentHeight;
local objMenu = display.newGroup();
--physics.setDrawMode("hybrid")

local optionsAudio =
{
    channel = 1,
    loops = -1,
    fadein = 5000,
    onComplete = callbackListener
}

local bgMusic = audio.loadStream("forests.mp3");
audio.play(bgMusic, optionsAudio);

function showGame() 
	local options = {
		effect = "fade"
	}
	display.remove(objMenu)
	audio.pause();
	composer.gotoScene("principal");
end

function howtoplay () 
	display.remove(objMenu);
	--audio.pause();
	composer.gotoScene("howtoplay")
end

function credits()
	display.remove(objMenu);
	--audio.pause();
	composer.gotoScene("credits")
end

function scene:create( event )
	local sceneGroup = self.view;
 end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
	    local sceneGroup = self.view;
	    local background = display.newImageRect( sceneGroup, "sprites/cenario1.png", 1080, 1920)
	    background.x = display.contentCenterX
		background.y = display.contentCenterY
		objMenu:insert(background);

		montanha1 = display.newImage("sprites-novos/montanha35.png");
		montanha1.x = (largura *.5) + 400; 
		objMenu:insert(montanha1);
	
		montanha2 = display.newImage("sprites-novos/montanha24.png");
		montanha2.x = (largura *.5) - 400; 
		objMenu:insert(montanha2);

		montanha3 = display.newImage("sprites-novos/montanha24.png");
		montanha3.y = montanha1.y + 950;
		montanha3.x = montanha1.x;
		objMenu:insert(montanha3);
		
		montanha4 = display.newImage("sprites-novos/montanha24.png");
		montanha4.y = montanha2.y + 950;
		montanha4.x = montanha2.x;
		objMenu:insert(montanha4);

		galho1 = display.newImage("sprites-novos/galhos.png");
		galho1.x = (largura *.5);
		galho1.y = altura *.5 + 900;
		physics.addBody(galho1, "static");
		objMenu:insert(galho1);

		galho2 = display.newImage("sprites-novos/galhos.png");
		galho2.x = (largura *.5) + 100;
		galho2.y = altura *.5 + 900;
		physics.addBody(galho2, "static");		
		objMenu:insert(galho2);

		galho3 = display.newImage("sprites-novos/galhos.png");
		galho3.x = (largura *.5) - 100;
		galho3.y = altura *.5 + 900;
		physics.addBody(galho3, "static");		
		objMenu:insert(galho3);

		diamante = display.newImage("sprites-novos/diamond-menu.png");
		diamante.y = (altura *.5) - 1000;
		diamante.x = largura *.5;
		physics.addBody(diamante, { density=3.0, friction=0.8, bounce=0.3});
		objMenu:insert(diamante)

		local noend = display.newImage(sceneGroup, "sprites-novos/noend.png");
		noend.x = display.contentCenterX;
		noend.y = display.contentCenterY - 500;
		objMenu:insert(noend);

	 	local playButton = display.newImage(sceneGroup, "sprites-novos/buttonplay.png")
		playButton.x = display.contentCenterX 
		playButton.y = display.contentCenterY - 100
		playButton:addEventListener( "tap", showGame )
		objMenu:insert(playButton)

		local htpbutton = display.newImage(sceneGroup, "sprites-novos/buttonhowtoplay.png");
		htpbutton.x = display.contentCenterX 
		htpbutton.y = display.contentCenterY  + 200
		htpbutton:addEventListener("tap", howtoplay)
		objMenu:insert(htpbutton)

		local creditsbutton = display.newImage(sceneGroup, "sprites-novos/buttoncredits.png");
		creditsbutton.x = display.contentCenterX 
		creditsbutton.y = display.contentCenterY + 500;
		creditsbutton:addEventListener("tap", credits);
		objMenu:insert(creditsbutton);
	elseif ( phase == "did" ) then

	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	elseif ( phase == "did" ) then
		composer.removeScene("menu")
		

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