empty = true
CreateThread( function()
	while true do
		Wait(0)
		if (GetFollowPedCamViewMode() == 4 and empty) then
        	SendNUIMessage({ShowUI = true})
        	empty = false
        elseif not (GetFollowPedCamViewMode() == 4) then
        	SendNUIMessage({ShowUI = false})
        	empty = true
        end
	end
end)

RegisterCommand('rcpaxonvolume', function(source,volume,rawcommand)
	vol = tonumber(volume[1])
	if ((0 < vol) and (vol <= 1.0)) then
		SendNUIMessage({ShowUI = true, Volume = vol})
		datatext = "Volume Set To: "..vol
	else
		datatext = "Invalid Volume! Minimum volume is 0.01 and maximum volume is 1.0"
	end
	DrawTextWait()
end, false)

function DrawText(text,x,y)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)--r,g,b,a
	SetTextCentre(true)--true,false
	SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
	SetTextEdge(1, 0, 0, 0, 255)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x,y)
end

function DrawTextWait()
	toggletext = not toggletext
	Wait(3000)
	toggletext = not toggletext
end

CreateThread( function()
	while true do
		Wait(0)
		if toggletext then
			DrawText(tostring(datatext),0.5,0.92)
		end
	end
end)