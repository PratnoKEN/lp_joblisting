RegisterNetEvent('lp_joblisting:open', function()
			lib.registerContext({
				id = 'job_center',
				title = '',
				options = {
					['EMS'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'ambulance'
						}
					},
					['Police'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'police'
						}
					},
					['Banker Man'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'banker'
						}
					},
					['Cardealer'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'cardealer'
						}
					},
					['Mechanic'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'mechanic'
						}
					},
					['Realtor'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'realestateagent'
						}
					}
					,
					['Taxi'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'taxi'
						}
					},
					['Unemployed'] = {
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'unemployed'
						}
					}
					--[[['example jobs'] = { -- This For Label Jobs
						event = 'lp_joblisting:requestjob',
						args = {
							job   = 'examplejob' -- this for name jobs
						}
					}]]
				}
			})
			lib.showContext('job_center')
end)

RegisterNetEvent('lp_joblisting:requestjob', function(data)
	TriggerServerEvent('lp_joblisting:setJob', data.job)
	lib.notify({
		title = 'Congrats!',
		description = _U('new_job'),
		type = 'success'
	})
end)

exports.qtarget:AddBoxZone("job_center", vector3(-265.21, -963.87, 31.22), 5, 5, {
	name="job_center",
	heading=0,
    minZ=30.17,
    maxZ=33.17
	}, {
		options = {
			{
				event = "lp_joblisting:open",
				icon = "fas fa-briefcase",
				label = "Job Center",
			}
		},
		distance = 3.5
})

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
