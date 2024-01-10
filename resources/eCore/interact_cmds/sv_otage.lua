
RegisterServerEvent('cmg3_animations:syncExtasyyy')
AddEventHandler('cmg3_animations:syncExtasyyy', function(token, target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
    if not CheckToken(token, source, "cmg3_animations:syncExtasyyy") then return end
	print("got to srv cmg3_animations:sync")
	print("got that fucking attach flag as: " .. tostring(attachFlag))
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(token, targetSrc)
	if not CheckToken(token, source, "cmg3_animations:stop") then return end
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)
