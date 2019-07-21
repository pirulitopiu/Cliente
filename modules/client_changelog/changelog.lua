local changelogWindow = nil
local changelogButton = nil

local changes = {
    [1] = {
        patch = "-----------------------------------------------------------------------------------------------------------",
        changes = {
            "",
            "- Regras:",
			"",
			"- Trade world em nosso servidor e extremamente proibido, banimendo da conta.",
			"- Ofensas ao nosso servidor e proibido, notation ou ate banimendo da conta.",
			"- Ofensas a staff do nosso servidor e proibido, notation ou ate banimendo da conta.",
			"- Ofensas ao jogadores em nosso canais publicos e proibido, notation",
			"- Abuso de falhas em nosso servidor e proibido, banimendo da conta.",
			"- Conversas sobre outros servidor em canal publico e proibido, notation.",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",	
            "[-----------------------------------------------------------------------------------------------------------]"			
			
        }
    }
}

function init()
  changelogWindow = g_ui.displayUI('changelog')
  changelogWindow:hide()

  changelogButton = modules.client_topmenu.addLeftButton('changelogButton', tr('Comandos'), 'changelog', toggle)
  
  changelogWindow:breakAnchors()
  changelogWindow:setPosition({x = 100, y = 100})
  changelogWindow.onEnter = hide
  changelogWindow.onEscape = hide
 
end

function terminate()
  changelogWindow:destroy()
  changelogButton:destroy()
end

function toggle()
    if changelogWindow:isVisible() then
        changelogWindow:hide()
        changelogButton:setOn(false)
    else
        changelogWindow:show()
        changelogButton:setOn(true)
        changelogWindow:focus()
    end
end

function hide()
    changelogWindow:hide()
    changelogButton:setOn(false)
end

function Butom()
	g_game.talk('!task')
end

function Buton()
	g_game.talk('correr')
end

function Btton()
	g_game.talk('!comandos')
end

function Buttona()
	g_game.talk('!rank')
end

function Buttona2()
	g_game.talk('!love')
end

function flyUp()
	g_game.talk('H1')
end

function flyDown()
	g_game.talk('H2')
end

function cd()
	g_game.talk('!buyhouse')
end

function tc()
	g_game.talk('cure')
end

function teste()
	g_game.talk('!leave')
end