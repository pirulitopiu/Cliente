-- Privates variables
local barPoke = nil
local isIn = 'V' --[[ 'H' = horizontal; 'V' = vertical ]]--
local namesAtks = ''
local icons = {}
-- End privates variables


-- Public functions
function init()
   barPoke = g_ui.displayUI('barpoke', modules.game_interface.getRootPanel())
   barPoke:setVisible(false)  
   barPoke:move(250,50)
   
   connect(g_game, 'onTextMessage', getParams)
   connect(g_game, { onGameEnd = hide } )
   connect(g_game, { onGameStart = show } )
   
   g_mouse.bindPress(barPoke, function() createMenu() end, MouseRightButton)

   
   createIcons()
end

function terminate()
   disconnect(g_game, { onGameEnd = hide })
   disconnect(g_game, 'onTextMessage', getParams)

   destroyIcons()
   barPoke:destroy()
end


function getParams(mode, text)
if not g_game.isOnline() then return end
   if mode == MessageModes.Failure then 
      if string.sub(text, 1, 9) == "BarClosed" then
      hide()
      elseif string.sub(text, 1, 7) == "Pokebar" then
         atualizarBar(text)
   end
end
end

function atualizarBar(text)
if not g_game.isOnline() then return end
local talk = "/poke"
show()
cleanAllPokes()
local t = string.explode(text, "/")
for i=2, #t do
x= i-1
local poke = t[i]
local progress = icons['Icon'..x].progress
changeIconPoke(x, poke)
progress.onClick = function() g_game.talk(talk.." "..poke.."")
end 
end
end


function FixTooltip(text)
   barPoke:setHeight(isIn == 'H' and 235 or 50) 
   barPoke:setWidth(isIn == 'H' and 50 or 235)
   if not text then text = namesAtks else namesAtks = text end 
   
   local t = text:explode("/")
   local count = 0
   for j = 1, 6 do
       local ic = icons['Icon'..(j-1)]
       ic.icon:setMarginLeft(isIn == 'H' and 0 or ic.dist)
       ic.icon:setMarginTop(isIn == 'H' and ic.dist or 0)
       if t[j] == 'n/n' then    
          ic.icon:hide()      
          count = count+1
       else
          ic.icon:show()
          ic.progress:setTooltip(t2[j]) 
          ic.progress:setVisible(true)
       end
   end
   if count > 0 and count ~= 6 then
      if isIn == "H" then
         barPoke:setHeight(235 - (count*34))
      else
         barPoke:setWidth(235 - (count*34))
      end
   elseif count == 6 then
      barPoke:setHeight(60)
      barPoke:setWidth(60)
      local p = icons['Icon1'].progress
      p:setTooltip(false)
      p:setVisible(false)
   end                
end

 
function changeIconPoke(i, poke)
if not g_game.isOnline() then return end
   local icon = icons['Icon'..i].icon
local image = "pokes/"..poke..".png"
   icon:setImageSource(image)
end


function createIcons()
   local d = 33
   local image = "pokes/portait.png"
   for i = 1, 6 do
      local icon = g_ui.createWidget('IconPoke', barPoke)
	  --local icon2 = g_ui.createWidget('HealthBar', barpoke)
      local progress = g_ui.createWidget('Poke', barPoke) 
      icon:setId('Icon'..i)  
      progress:setId('Progress'..i)  
      icons['Icon'..i] = {icon = icon, progress = progress, dist = (i == 1 and 5 or i == 1 and 40 or d + ((i-1.7)*38)), event = nil}
      icon:setMarginTop(icons['Icon'..i].dist)
      icon:setImageSource(image)
      icon:setMarginLeft(4)
      progress:fill(icon:getId())
   end
end

function cleanAllPokes()
   local image = "pokes/portait.png"
   for i = 1, 6 do
       local icon = icons['Icon'..i].icon
       icon.onClick = function() end
      icon:setImageSource(image)
     local progress = icons['Icon'..i].progress
     progress.onClick = function() g_game.talk("/poke") end  
end               
end

--function createMenu()
  -- local menu = g_ui.createWidget('PopupMenu')
   --menu:addOption("Set "..(isIn == 'H' and 'Vertical' or 'Horizontal'), function() toggle() end)
   --menu:display()
--end

function toggle()
if not barPoke:isVisible() then return end 
   barPoke:setVisible(false)
   if isIn == 'H' then
      isIn = 'V'
   else 
      isIn = 'H'
   end
   FixTooltip()
   show()
end

function hide()
   barPoke:setVisible(false)
end

function show()
   barPoke:setVisible(true)
end
-- End public functions