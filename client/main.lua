RegisterNetEvent('jobcenter:ShowJobListingMenu', function() 
	ESX.TriggerServerCallback('lp_joblisting:getJobsList', function(jobs)
		local elements = {}

		for k,v in pairs(jobs) do
			elements[#elements+1] = {
				title   = k,
				header = v.label,
				event = 'jobcenter:list',
				args = {
					job = k
				}
			}
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
	lib.notify({
		title = 'Success apply job',
		description = _U('new_job'),
		type = 'success'
	})
end)

if Config.target then
	exports.ox_target:addBoxZone({
		coords = vec3(-1082.123047, -247.516479, 37.7554371),
		size = vec3(1, 1, 1),
		rotation = 19.8425,
		debug = true,
		options = {
			{
				name = 'Jobcentertarget',
				event = "jobcenter:ShowJobListingMenu",
				icon = "fas fa-sign-in-alt",
				label = "Job Center",
			},
		}
	})
else
	CreateThread(function()
		while true do
			local Sleep = 1500

			local coords = GetEntityCoords(cache.ped)

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
