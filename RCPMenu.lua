cam = true
allowthird = false
allowthirdtoggle = true
b = 0
CreateThread( function()
	while true do
		Wait(0)
		a = 1
		if ((GetFollowPedCamViewMode() == 4) and (a == b) and (cam)) then
			SendNUIMessage({ShowUI = true})
        	cam = false
        elseif not ((GetFollowPedCamViewMode() == 4) and (a == b)) then
        	b = a
        	if (allowthird and allowthirdtoggle) then
				SendNUIMessage({ShowUI = true})
        		allowthirdtoggle = false
        	elseif not allowthird then
        		SendNUIMessage({HideUI = true})
        		allowthirdtoggle = true
        	end
        	cam = true
        end
	end
end)

x = 0
weapon = true
CreateThread(function()
	while true do
		Wait(0)
		w = GetSelectedPedWeapon(PlayerPedId())
		if ((w ~= -1569615261) and (w == x) and (weapon)) then
        	SendNUIMessage({weapon = true})
        	weapon = false
        elseif not (w == x) then
        	x = w
        	weapon = true
        end
	end
end)

RegisterNUICallback('togglethirdperson', function()
	allowthird = not allowthird
end)

RegisterCommand('rcpaxon', function()
	if GetFollowPedCamViewMode() == 4 then
		SendNUIMessage({ShowPowerButton = true})
		SetNuiFocus(true,true)
	else
		DrawTextWait()
	end
end, false)

RegisterNUICallback('close', function()
	SetNuiFocus(false)	
end)

function DrawText(text,x,y)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.35,0.35)
	SetTextColour(255,0,0,255)--r,g,b,a
	SetTextCentre(true)--true,false
	SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
	SetTextEdge(1, 0, 0, 0, 255)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x,y)
end

function DrawTextWait()
	toggletext = true
	Wait(3000)
	toggletext = false
end

CreateThread(function()
	while true do
		Wait(0)
		if toggletext then
			DrawText("You Need To Be In First Person",0.5,0.92)
		end
	end
end)