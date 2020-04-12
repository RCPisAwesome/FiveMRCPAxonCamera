empty = true
allowthird = false
allowthirdtoggle = true
enabled = true
CreateThread( function()
	while true do
		Wait(0)
		if enabled then
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
	end
end)

RegisterCommand('rcpaxonvolume', function(source,volume)
	vol = tonumber(volume[1])
	if ((0 < vol) and (vol <= 1.0)) then
		SendNUIMessage({ShowUI = true, Volume = vol})
		datatext = "Volume Set To: "..vol
	else
		datatext = "Invalid Volume! Minimum volume is 0.01 and maximum volume is 1.0"
	end
	DrawTextWait()
end, false)

RegisterCommand('rcpaxontimeoffset', function(source,offset)
	if tostring(offset[1]) == "utc" then
		SendNUIMessage({ShowUI = true, UTC = true})
		datatext = "Time Set To UTC"
	else
		if tonumber(offset[1]) ~= nil then
			setoffset = tonumber(offset[1])
			if ((-12 <= setoffset) and (setoffset <= 12)) then
				SendNUIMessage({ShowUI = true, Offsetsend = true, Offset = setoffset})
				datatext = "Time Offset Set To: "..setoffset
			else
				datatext3 = "Invalid Offset! Minimum is -12 & maximum is +12"
				datatext2 = "This is your time zone without daylight savings compared to UTC time"
				datatext = "Do /rcpaxontimeoffset utc to reset back to utc"
			end
		else
			datatext3 = "Invalid Offset! Minimum is -12 & maximum is +12"
			datatext2 = "This is your time zone without daylight savings compared to UTC time"
			datatext = "Do /rcpaxontimeoffset utc to reset back to utc"
		end
	end
	DrawTextWait()
	datatext3 = ""
	datatext2 = ""
end, false)

local background = 0
RegisterCommand('rcpaxonbackground', function()
	if background == 0 then
		datatext = "Background Box Enabled"
		SendNUIMessage({ShowUI = true, ShowBox = true})
		background = 1
	elseif background == 1 then
		datatext = "Background Box Disabled"
		SendNUIMessage({ShowUI = true, ShowBox = false})
		background = 0
	end
	DrawTextWait()
end, false)

local thirdperson = 0
RegisterCommand('rcpaxonallowthirdperson', function()
	if thirdperson == 0 then
		datatext = "UI shows when in third person"
		allowthird = true
		thirdperson = 1
	elseif thirdperson == 1 then
		datatext = "UI doesn't show when in third person"
		allowthird = false
		thirdperson = 0
	end
	DrawTextWait()
end, false)

local show = 0
RegisterCommand('rcpaxon', function()
	if show == 0 then
		datatext = "Disabled"
		enabled = false
		SendNUIMessage({ShowUI = false})
		show = 1
	elseif show == 1 then
		datatext = "Enabled"
		enabled = true
		SendNUIMessage({ShowUI = true})
		show = 0
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
datatext3 = ""
datatext2 = ""
CreateThread( function()
	while true do
		Wait(0)
		if toggletext then
			DrawText(tostring(datatext),0.5,0.92)
			DrawText(tostring(datatext2),0.5,0.90)
			DrawText(tostring(datatext3),0.5,0.88)
		end
	end
end)