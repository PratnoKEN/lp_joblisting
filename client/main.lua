RegisterNetEvent('jobcenter:ShowJobListingMenu', function() 
	lib.callback('lp_joblisting:getJobsList', 0, function(jobs)
		local elements = {}

		for k,v in pairs(jobs) do
			elements[#elements+1] = {
				title   = k,
				header = v.label,
				event = 'jobcenter:list',
				icon = Config.JobIcons[k],
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

JobCenterPoints = function()
	for k,v in pairs(Config.Zones) do
		local coords = v.pointcoords
		local point = lib.points.new(coords, 2)

		function point:onEnter() 
			lib.showTextUI('[E] - Acces Job Center')
		end

		function point:onExit() 
			lib.hideTextUI()
		end

		function point:nearby()
			DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0,0.0, 0.0, 180.0, 0.0, 0.7, 0.7, 0.7, 225, 225, 211, 50, false,true, 2, nil, nil, false)
			if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
				TriggerEvent('jobcenter:ShowJobListingMenu')
			end
		end
		return point
	end
end

-- Create blips
CreateBlips = function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v.pointcoords.x,v.pointcoords.y,v.pointcoords.z)
		SetBlipSprite(blip,407)
		SetBlipColour(blip,27)
		SetBlipAsShortRange(blip,true)
		SetBlipScale(blip,0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end

CreateThread(function()
	while not ESX.IsPlayerLoaded() do
        Wait(100)
    end
	JobCenterPoints()
	CreateBlips()
end)
