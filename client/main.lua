RegisterNetEvent('jobcenter:ShowJobListingMenu', function() 
	ESX.TriggerServerCallback('lp_joblisting:getJobsList', function(jobs)
		local elements = {}

		for k,v in pairs(jobs) do
			table.insert(elements, {
				title   = k,
				header = v.label,
				event = 'jobcenter:list',
				args = {
					job = k
				}
			})
		end

		lib.registerContext({
			id = 'job:menu',
			title = 'Job Center',
			options = elements
		})
		
		lib.showContext('job:menu')
	end)
end)

RegisterNetEvent('jobcenter:list', function(data) 
	TriggerServerEvent('lp_joblisting:setJob', data.job)
	ESX.ShowNotification(_U('new_job'))
end)

if Config.target then
	exports.qtarget:AddBoxZone("Jobcentertarget", vector3(-265.08, -964.1, 30.3), 1.0, 1.0, {
		name="Jobcentertarget",
		heading=19.8425,
		debugPoly=false,
		minZ=29.3,
		maxZ=33.3,
		}, {
			options = {
				{
					event = "jobcenter:ShowJobListingMenu",
					icon = "fas fa-sign-in-alt",
					label = "Job Center",
				},
			},
			distance = 3.5
	})
else
	CreateThread(function()
		while true do
			local Sleep = 1500

			local coords = GetEntityCoords(PlayerPedId())

			for i=1, #Config.Zones, 1 do
				local distance = #(coords - Config.Zones[i])

				if distance < Config.DrawDistance then
					Sleep = 0
					DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end

				if distance < (Config.ZoneSize.x / 2) then
					ESX.ShowHelpNotification(_U('access_job_center'))
					if IsControlJustReleased(0, 38) then
						TriggerEvent('jobcenter:ShowJobListingMenu')
					end
				end
			end
		Wait(Sleep)
		end
	end)
end	

-- Create blips
CreateThread(function()
	for i=1, #Config.Zones, 1 do
		local blip = AddBlipForCoord(Config.Zones[i])

		SetBlipSprite (blip, Config.Blip.Sprite)
		SetBlipDisplay(blip, Config.Blip.Display)
		SetBlipScale  (blip, Config.Blip.Scale)
		SetBlipColour (blip, Config.Blip.Colour)
		SetBlipAsShortRange(blip, Config.Blip.ShortRange)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)