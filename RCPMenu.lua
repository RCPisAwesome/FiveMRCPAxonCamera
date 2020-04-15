empty = true
allowthird = false
allowthirdtoggle = true
CreateThread( function()
	while true do
		Wait(0)
		if (GetFollowPedCamViewMode() == 4 and empty) then
        	SendNUIMessage({ShowUI = true})
        	empty = false
        elseif not (GetFollowPedCamViewMode() == 4) then
        	if (allowthird and allowthirdtoggle) then
        		SendNUIMessage({ShowUI = true})
        		allowthirdtoggle = false
        	elseif not allowthird then
        		SendNUIMessage({ShowUI = false})
        		allowthirdtoggle = true
        	end
        	empty = true
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