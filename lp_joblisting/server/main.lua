RegisterServerEvent('lp_joblisting:setJob')
AddEventHandler('lp_joblisting:setJob', function(job)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		if job then
			xPlayer.setJob(job, 0)
		end
	end
end)
