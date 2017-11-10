local widget = require("widget")
local composer = require( "composer" )
composer.recycleOnSceneChange = true;
local scene = composer.newScene()

local physics = require("physics");
physics.start();
local physicsData = (require "sprites-novos.vertexes").physicsData(1.0)
local sheetInfo = require("sprites");
local sheet = graphics.newImageSheet("sprites/sprites.png", sheetInfo:getSheet());
--physics.setDrawMode("hybrid")

local bgJumpMusic = audio.loadStream("jump.wav");
local bgUpdateScore = audio.loadStream("updateScore.mp3");
local bgPhase = audio.loadStream("phase.ogg");
local gameover = audio.loadStream("death.wav")

local largura = display.contentWidth;
local altura = display.contentHeight;
local metadeLargura = largura *.5;
local cenarioDia, cenarioNoite, nuvem1, galho1, nuvem2, banana, maca, limao, diamante, arvore1, arvore2;
local shantel = nil;
local comecou = false;
local caindo = false;
local esquerda = false;
local direita = false;
local morreu = false;
local score = 0;
local scoreText;
local transitando = true;
local scrollSpeed = 10;
local montanhas = {};
local frutasdir = {};
local frutasesq = {};
local tempo = 1000;
local fatorLevel = 1;
local tabelaObstaculos = { };
local sceneGroup = display.newGroup()
local diamantes = display.newGroup()
local groupFruits = display.newGroup()
local buttonsGroup = display.newGroup();
local emergeLoop;
local reconstruirMontanha = 20;
local aleatorio;

function primeiraNuvemIndo()
	transition.to(nuvem1, { time = 9000, x = nuvem1.x - 800, onComplete = primeiraNuvemVoltando })
end

function primeiraNuvemVoltando()
	transition.to(nuvem1, { time = 9000, x = nuvem1.x + 800, onComplete = segundaNuvemIndo })
end

function segundaNuvemIndo()
	transition.to(nuvem2, { time = 9000, x = nuvem2.x + 800, onComplete = segundaNuvemVoltando})
end

function segundaNuvemVoltando()
	transition.to(nuvem2, { time = 9000, x = nuvem2.x - 800 , onComplete = primeiraNuvemIndo })
end

sequenciaShantel = {
	{
		name = "parada",
		frames = {
			sheetInfo:getFrameIndex("player1")
		},
	},
	{
		name = "saltando1",
		frames = {
			sheetInfo:getFrameIndex("player2.1")
		}
	},
	{
		name = "saltando2",
		frames = {
			sheetInfo: getFrameIndex("player2.2")
		}
	},
	{
		name = "agarrada1",
		frames = {
			sheetInfo:getFrameIndex("player3.1")
		}
	},
	{
		name = "agarrada2",
		frames = {
			sheetInfo:getFrameIndex("player3.2")
		}
	}
}

function scene:create( event )
	local groupScene = self.view;
 end


function scene:show (event) 
	local groupScene = self.view;
	--sceneGroup = display.newGroup();
	--cenaInicial();

	cenarioDia = display.newImage(sheet, sheetInfo:getFrameIndex("cenario1"));
	cenarioDia.x = largura *.5; cenarioDia.y = altura *.5;
	sceneGroup:insert(cenarioDia);
	
	nuvem1 = display.newImage(sheet, sheetInfo:getFrameIndex("nuvem"));
	nuvem1.x = (largura *.5) + 400; nuvem1.y = (altura *.5) - 550; nuvem1.alpha = 0.7
	sceneGroup:insert(nuvem1);

	nuvem2 =  display.newImage(sheet, sheetInfo:getFrameIndex("nuvem"));
	nuvem2.x = (largura *.5) - 400; nuvem2.y = (altura *.5) - 550; nuvem2.alpha = 0.7
	sceneGroup:insert(nuvem2);

	montanhas[0] = display.newImage("sprites-novos/montanha0.png");
	montanhas[0].x = (largura *.5) - 400; montanhas[0].y = (altura *.5) + 820;
	physics.addBody(montanhas[0], "static");
	sceneGroup:insert(montanhas[0]);

	montanhas[1] = display.newImage("sprites-novos/montanha1.png");
	montanhas[1].x = (largura *.5) + 400; montanhas[1].y = (altura *.5) + 820;
	physics.addBody(montanhas[1], "static");
	sceneGroup:insert(montanhas[1]);

	montanhas[2] = display.newImage("sprites-novos/montanha24.png");
	montanhas[2].x = (largura *.5) - 400; montanhas[2].y = (montanhas[0].y) + montanhas[0].contentHeight;
	sceneGroup:insert(montanhas[2]);

	montanhas[3] = display.newImage("sprites-novos/montanha35.png");
	montanhas[3].x = (largura *.5) + 400; montanhas[3].y = (montanhas[1].y) + montanhas[1].contentHeight;
	sceneGroup:insert(montanhas[3]);

	montanhas[4] = display.newImage("sprites-novos/montanha24.png");
	montanhas[4].x = (largura *.5) - 400; montanhas[4].y = (montanhas[2].y) + montanhas[2].contentHeight;
	sceneGroup:insert(montanhas[4]);

	montanhas[5] = display.newImage("sprites-novos/montanha35.png");
	montanhas[5].x = (largura *.5) + 400; montanhas[5].y = (montanhas[3].y) + montanhas[3].contentHeight;
	sceneGroup:insert(montanhas[5]);

	macaco1 = display.newImage("sprites-novos/macaco2.png");
	macaco1.x = (largura *.5) - 370; macaco1.y = (altura *.5) + 160;
	physics.addBody(macaco1, "static")
	sceneGroup:insert(macaco1);

	macaco2 = display.newImage("sprites-novos/macaco.png");
	macaco2.x = (largura *.5) + 370; macaco2.y = (altura *.5) + 160;
	sceneGroup:insert(macaco2);

	tijela1 = display.newImage("sprites-novos/tijela.png");
	tijela1.x = largura *.5 + 270; tijela1.y = altura *.5 + 183;
	sceneGroup:insert(tijela1);

	tijela2 = display.newImage("sprites-novos/tijela2.png");
	tijela2.x = (largura *.5) - 270; tijela2.y = (altura *.5) + 183;
	sceneGroup:insert(tijela2);

	banana1 = display.newImage("sprites-novos/banana.png");
	banana1.x = (largura *.5) + 320; banana1.y = (altura *.5) + 185;
	sceneGroup:insert(banana1);

	banana2 = display.newImage("sprites-novos/banana2.png");
	banana2.x = (largura *.5) - 320; banana2.y = (altura *.5) + 185;
	sceneGroup:insert(banana2);

	corda1 = display.newLine(metadeLargura, -100, metadeLargura, altura+100)
	corda1.x = metadeLargura *.82;
	corda1:setStrokeColor(0, 0, 0);
	corda1.strokeWidth = 5;
	sceneGroup:insert(corda1);	

	corda2 = display.newLine(metadeLargura, -100, metadeLargura, altura+100)
	corda2.x = metadeLargura * 1.15;
	corda2:setStrokeColor(0, 0, 0);
	corda2.strokeWidth = 5;
	sceneGroup:insert(corda2);

	galho1 = display.newImage("sprites-novos/galhos.png");
	galho1.x = (largura *.5); galho1.y = galho1.y + 50;
	sceneGroup:insert(galho1);

	galho2 = display.newImage("sprites-novos/galhos.png");
	galho2.x = (largura *.5) + 400; galho2.y = galho2.y + 50;
	sceneGroup:insert(galho2);

	galho3 = display.newImage("sprites-novos/galhos.png");
	galho3.x = (largura *.5) - 400; galho3.y = galho3.y + 50;
	sceneGroup:insert(galho3);

	shantel = display.newSprite(sheet, sequenciaShantel);	
	shantel.x = (largura *.5) - 350; shantel.y = (altura *.5) - 250;
	physics.addBody(shantel, "static", physicsData:get("player3"));
	shantel.name = "shantel";
	shantel:setSequence("parada");
	shantel:play();
	sceneGroup:insert(shantel);

	shantel.collision = onLocalCollision;
	shantel:addEventListener("collision", shantel);

	primeiraNuvemIndo()
	segundaNuvemIndo()
end

function initGame() 

		aleatorio = math.random(0, 2);

		frutasdir[0] = display.newImage("sprites-novos/banana.png");
		frutasdir[0].x = largura *.5 + 270; frutasdir[0].y = altura *.5 + 183;
		frutasdir[0].isVisible = false;
		groupFruits:insert(frutasdir[0])

		frutasdir[1] = display.newImage("sprites-novos/maca.png");
		frutasdir[1].x = largura *.5 + 270; frutasdir[1].y = altura *.5 + 183;
		frutasdir[1].isVisible = false;
		groupFruits:insert(frutasdir[1])

		frutasdir[2] = display.newImage("sprites-novos/limao.png");
		frutasdir[2].x = largura *.5 + 270; frutasdir[2].y = altura *.5 + 183;
		frutasdir[2].isVisible = false;
		groupFruits:insert(frutasdir[2])
		
		transition.to(frutasdir[aleatorio], { time = 500, y = 950, x = 600})
		frutasdir[aleatorio].isVisible = true;
		physics.addBody(frutasdir[aleatorio], "dynamic")

		table.insert(tabelaObstaculos, frutasdir[0]);
		table.insert(tabelaObstaculos, frutasdir[1]);
		table.insert(tabelaObstaculos, frutasdir[2]);
		
		frutasesq[0] = display.newImage("sprites-novos/banana.png");
		frutasesq[0].x = largura *.5 - 270; frutasesq[0].y = altura *.5 + 183;
		frutasesq[0].isVisible = false;
		groupFruits:insert(frutasesq[0])
		
		frutasesq[1] = display.newImage("sprites-novos/maca.png");
		frutasesq[1].x = largura *.5 - 270; frutasesq[1].y = altura *.5 + 183;
		frutasesq[1].isVisible = false;
		groupFruits:insert(frutasesq[1])
		
		frutasesq[2] = display.newImage("sprites-novos/limao.png");
		frutasesq[2].x = largura *.5 - 270; frutasesq[2].y = altura *.5 + 183;
		frutasesq[2].isVisible = false;
		groupFruits:insert(frutasesq[2])
		
		transition.to(frutasesq[aleatorio], { time = 500, y = frutasesq[aleatorio].y - 200, x = frutasesq[aleatorio].x + 180})
		frutasesq[aleatorio].isVisible = true;
		physics.addBody(frutasesq[aleatorio], "dynamic")

		table.insert(tabelaObstaculos, frutasesq[0]);
		table.insert(tabelaObstaculos, frutasesq[1]);
		table.insert(tabelaObstaculos, frutasesq[2]);
end

init = timer.performWithDelay(900, initGame, 1)

function song()
	audio.play(bgPhase);
end

songbg = timer.performWithDelay(2, song, -1);

function scene:hide( event )

	local groupScene = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		display.remove(sceneGroup);

	elseif ( phase == "did" ) then
		--physics.pause()
		composer.removeScene("principal")
		composer.hideOverlay()
		Runtime:removeEventListener( "collision", onLocalCollision)
		Runtime:removeEventListener("touch", toque)
	end
end

function scene:destroy( event )
	local groupScene = self.view
end

function toque(event)
	if(comecou == false and caindo == false and event.phase == "began" ) then
		comecou = true;
		audio.play(bgJumpMusic);
		shantel:setSequence("saltando1");
		shantel:play();
		transition.to(shantel,{ time = 500, y = 500, x = shantel.x + 217, onComplete = function () 
			shantel:setSequence("agarrada1");
			shantel:play();
			permitirColisao = true;
			caindo = true;
			esquerda = true;
			transition.to(shantel, { time = 300, y = altura*.4})
			transitando = false;
			end})		
		emergeLoop = timer.performWithDelay(1, loop, -1)
	 end
	 
	  	
 	if(esquerda == true and event.phase == "began" and caindo == true and transitando == false) then 
		 transitando = true;
		 audio.play(bgJumpMusic);
 		 shantel:setSequence("saltando1");
		 shantel:play();
		 transition.to(shantel, { time = 300, x = shantel.x + 250, onComplete = function ()
 			shantel:setSequence("agarrada2");
 			shantel:play();
 			esquerda = false;
 			direita = true;
 			transitando = false;
 		end})

	 	else if(direita == true and event.phase == "began" and caindo == true and transitando == false) then
	 		transitando = true;
			audio.play(bgJumpMusic);
	 		shantel:setSequence("saltando2");
			shantel:play();
	 		transition.to(shantel, { time = 300, x = shantel.x - 250, onComplete = function ()
	 			shantel:setSequence("agarrada1");
	 			shantel:play();
	 			esquerda = true;
	 			direita = false;
	 			transitando = false;
	 		end})
	 	end	
	end
end


scoreText =  display.newText("", 950, 100, "slkscrb", 65);
scoreText:setTextColor(0, 0, 0);

local function updateScore()
	local changeTime = 10;
	local primeiro = true;
	if(comecou == true) then
		score = score + 1;
		scoreText.text = score;

		if score == changeTime then
			reconstruirMontanha = reconstruirMontanha + 5;
			changeTime = changeTime + 20;
			scrollSpeed = scrollSpeed + 2;		
		end
	end
end

local scoreTimer = timer.performWithDelay(tempo, updateScore, 0)

function criarObstaculos() 
	local whereFrom = math.random( 150 )
	local posicaoX = math.random(440, 640)

		local criarDiamante = function()
            	if(whereFrom == 2) then
					diamante = display.newImage("sprites-novos/diamond.png");
					table.insert(tabelaObstaculos, diamante);
					diamantes:insert(diamante)
					physics.addBody(diamante, "dynamic");
					diamante.name = "diamante";
					diamante.x = posicaoX;
					diamante.y = -60;
					diamante:setLinearVelocity(0, 10*fatorLevel)
				end
        end
        	timer.performWithDelay( 9000, criarDiamante )

		if( whereFrom == 1 ) then
	        banana = display.newImage("sprites-novos/banana2.png");
	        sceneGroup:insert(banana);
	         table.insert(tabelaObstaculos , banana );
	         physics.addBody( banana, "dynamic", { physicsData:get("banana"), bounce = 0.3 } );
	         banana.name = "obstaculo";			
		 		banana.x = posicaoX;
		        banana.y = -60;
		        banana:setLinearVelocity(0, 10*fatorLevel);
	    
	    elseif( whereFrom == 50 ) then
		    maca = display.newImage("sprites-novos/maca.png")
		    sceneGroup:insert(maca)
		    table.insert( tabelaObstaculos, maca )
		    physics.addBody( maca, "dynamic", { bounce = 0.3, physicsData:get("maca") } )
		    maca.name = "obstaculo"
		    	maca.x = posicaoX;
		        maca.y = -60;
		        maca:setLinearVelocity( 0, 10* fatorLevel );

		else if(whereFrom == 99) then
			limao = display.newImage("sprites-novos/limao.png")
			sceneGroup:insert(limao)
		 	table.insert(tabelaObstaculos, limao)
		 	physics.addBody(limao, "dynamic", { bounce = 0.3, physicsData:get("limao") })
		 	limao.name="obstaculo"
		 		limao.x = posicaoX;
		        limao.y = -60;
		end
	end
end


function loop(event)
	if(caindo == true and morreu == false) then
		
		for i = 0, 5 do
			montanhas[i].y = montanhas[i].y - scrollSpeed;
			physics.addBody(montanhas[i], "static")	

			if(montanhas[2].y <= -1 * montanhas[2].contentHeight/2) then
				montanhas[2].y = montanhas[4].y + montanhas[4].contentHeight - reconstruirMontanha;
			end

			if(montanhas[4].y <= -1 * montanhas[4].contentHeight/2) then
				montanhas[4].y = montanhas[2].y + montanhas[2].contentHeight - reconstruirMontanha;
			end

			if(montanhas[5].y <= -1 * montanhas[5].contentHeight/2) then
				montanhas[5].y = montanhas[3].y + montanhas[3].contentHeight - reconstruirMontanha;
			end

			if(montanhas[3].y <= -1 * montanhas[3].contentHeight/2) then
				montanhas[3].y = montanhas[5].y + montanhas[5].contentHeight - reconstruirMontanha;
			end
		end
		
		nuvem1.y = nuvem1.y - scrollSpeed;
		nuvem2.y = nuvem2.y - scrollSpeed;
		macaco1.y = macaco1.y - scrollSpeed;
		macaco2.y = macaco2.y - scrollSpeed;
		tijela1.y = tijela1.y - scrollSpeed;
		tijela2.y = tijela2.y - scrollSpeed;
		banana1.y = banana1.y - scrollSpeed;
		banana2.y = banana2.y - scrollSpeed;
		galho1.y = galho1.y - scrollSpeed;
		galho2.y = galho2.y - scrollSpeed;
		galho3.y = galho3.y - scrollSpeed;
		
		if score >= 2 then 
			criarObstaculos();
		end

		for i = #tabelaObstaculos, 1, -1 do
	        local thisObstaculo = tabelaObstaculos[i]
	 
	        if ( thisObstaculo.x < -100 or thisObstaculo.x > display.contentWidth + 100 or thisObstaculo.y < -100 or thisObstaculo.y > display.contentHeight + 100 ) then
	            display.remove( thisObstaculo )
	            table.remove( tabelaObstaculos, i )
	        end
    	end
	end
end

emergeLoop = timer.performWithDelay(1, loop, -1)

function onLocalCollision(self, event) 
	if(event.phase == "ended") then
		if(event.target.name == "shantel" and event.other.name == "diamante") then
			audio.play(bgUpdateScore)
			score = score + 5;
			local hideObject = function()
				event.other.isBodyActive = false;
				event.other.isVisible = false;
        	end
        	timer.performWithDelay( 0.1, hideObject, 1 )
		end

		if(event.target.name == "shantel" and event.other.name == "obstaculo") then
			audio.play(gameover);
			caindo = false;
			comecou = false;
			transitando = false;
			physics.pause();
			timer.cancel(init);
			Runtime:removeEventListener("touch", toque)			

			
		for i = diamantes.numChildren, 1, -1 do 
			local d = diamantes[i];
			d.isVisible = false;
		end

		for j = groupFruits.numChildren, 1, -1 do
			local f = groupFruits[j];
			f.isVisible = false;
		end
			
			timer.performWithDelay(500, callGameOver, 1)
		end
	end	
end

function callGameOver()
	composer.setVariable( "score", score )	
	audio.pause();
	score = 0;
	composer.gotoScene("gameover")
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener( "touch", toque )
updateScore()
return scene;