
Citizen.CreateThread(function()
    if "https://discord.com/api/webhooks/833757384424947742/V8k2HHVOfkjzojL9cXHv9KuHc6DQutFBwfEplKNRxUBsIegOutIiJW4Q0EUrV5FES-bE" == nil then
        --print("[WARNING] Webhook Discord not Config !")
        return
    end
 
    --CODE FOR RATE
    local Trig = {}
    AddEventHandler('ext:AST', function(ids, res)
    local _source = source
	local w = "unknown"
	local x = "unknown"
	local y = "unknown"
	local z = "unknown"
	local A = "unknown"
	local B = "unknown"
	local C = "unknown"
	for m, n in ipairs(GetPlayerIdentifiers(ids)) do
	    if n:match("discord") then
			x = n:gsub("discord:", "")
		elseif n:match("license") then
			y = n
		elseif n:match("live") then
			z = n
		elseif n:match("xbl") then
			B = n
		elseif n:match("ip") then
			C = n:gsub("ip:", "")
		end
	end;
	local D = GetPlayerName(ids) or "n/a"
	logwebhookcolor = 1769216;
    if Trig[ids] ~= nil then
        if Trig[ids] ~= 'off' then
            if Trig[ids] == cfg_menustaff.RateLimit then 
                DropPlayer(ids, cfg_menustaff.KickMessage)
                    PerformHttpRequest(cfg_menustaff.WebhookLink, function(E, F, G)
                    end, "POST", json.encode({
                        embeds = {
                            {
                                author = {
                                    name = "Rate Limit",
                                    icon_url = "https://assets.stickpng.com/images/5a81af7d9123fa7bcc9b0793.png"
                                },
                                title = "KICK !",
                                description = "**Player:** "..D.."\n**ServerID:** "..ids.."\n**Violation:** ".."Spam Trigger".."\n**Details:** ".."Trigger Used : ".. res .."\n**Discord:** <@"..x..">".."\n**License:** "..y.."\n**Live:** "..z.."\n**Xbox:** "..B.."\n**IP:** "..C,
								color = 16760576
                            }
                        }
                    }), {
                        ["Content-Type"] = "application/json"
                    })        
                Trig[ids] = 'off'    
            else
                Trig[ids] = Trig[ids] + 1
            end
            else
                DropPlayer(ids, cfg_menustaff.KickMessage)
            end
        else
            Trig[ids] = 1
        end
    end)
 
    --FUNCTION START COUTING
    CountTrig()
end)
 
 
function CountTrig()
    Trig = {}
    SetTimeout(cfg_menustaff.ResetRateLimit, CountTrig)
end
