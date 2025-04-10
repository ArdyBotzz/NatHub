local function SendFischFinderWebhook(eventName, WEBHOOK_URL, jobId)
	jobId = jobId or game.JobId
    local HttpService = game:GetService("HttpService")
    local placeId = game.PlaceId
    local players = #game.Players:GetPlayers()
    local maxPlayers = game.Players.MaxPlayers

	local Seaplace = game:GetService("ReplicatedStorage"):FindFirstChild("Place")
	local sea = (Seaplace and Seaplace.Value == "secondsea") and "Second Sea" or "First Sea"
	
    local embed = {
        title = "NatHub Fisch Finder",
        description = "Enter this job id using nathub below to join.",
        color = 0x0080FF,
        fields = {
            {name = "[🔎] Event", value = "```" .. eventName .. "```"},
            {name = "[📂] JobId", value = "```" .. jobId .. "```"},
            {name = "[👥] Players", value = "```" .. players .. " / " .. maxPlayers .. "```", inline = true},
			{name = "[🌊] Sea Location", value = "```" .. sea .. "```", inline = true},
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local webhookData = {
        username = "NatHub Fisch-Finder",
        avatar_url = "https://media.discordapp.net/attachments/1348594194020831266/1350710374625705994/undefined_-_Imgur.jpg?ex=67d7ba90&is=67d66910&hm=1dfea8f4dff7582682e4803f13775faf71398c94a14f3d671bea8bdbcad286da&=&format=webp&width=561&height=561",
        embeds = {embed}
    }

    local success, response = pcall(function()
        return (syn and syn.request or http_request) {
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(webhookData)
        }
    end)

    if success then
        print("NatHub Fisch-Finder: Webhook sent for event - " .. eventName)
    else
        warn("NatHub Fisch-Finder: Failed to send webhook!")
    end
	task.wait(2)
end

return SendFischFinderWebhook
