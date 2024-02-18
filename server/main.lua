function getJobs()
	local jobs = ESX.GetJobs()
	local availableJobs = {}
	for k,v in pairs(jobs) do 
		if v.whitelisted == false then 
			availableJobs[k] = {label = v.label}
		end
	end
	return availableJobs
end

lib.callback.register('lp_joblisting:getJobsList', function(source)
	local jobs = getJobs()
	
	return jobs
end)

RegisterNetEvent('lp_joblisting:setJob')
AddEventHandler('lp_joblisting:setJob', function(job)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local jobs = getJobs()

	if xPlayer then
		if jobs[job] then
			xPlayer.setJob(job, 0)
		end
	end
end)
