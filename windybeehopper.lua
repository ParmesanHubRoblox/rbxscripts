repeat task.wait() until game:IsLoaded()

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local WebhookURL = "https://discord.com/api/webhooks/1257659675894218793/17LmaE04p8M7FRBFoelKEIBCFtYOqxO_ZUVK0hSvPMJryVtwlezK7K-ZNZoeIkjHTu1Q"
local Time = os.date('!*t', os.time());

local function GetWebhookInfo()
	if not game.Workspace:WaitForChild("NPCBees"):FindFirstChild("Windy") then return nil end

	local WebhookContent = ""
	local JoinLink = "Server Link: https://roblox.com/discover#/rg-join/1537690962/"..game.JobId

	for _, Monster in pairs(game.Workspace.Monsters:GetChildren()) do
		if string.find(Monster.Name, "Windy Bee") then
			local BeeData = {
				Level = tostring(Monster:WaitForChild("Level").Value),
			}

			WebhookContent = 
				"Fighting: **true** \n"..
				"Bee Level: ".."**"..BeeData.Level.."** \n"
			break
		end
	end

	if WebhookContent == "" then WebhookContent = "Fighting: **false** \n" end

	WebhookContent ..= JoinLink.."\n\n<@611984788563427345>"
	return WebhookContent
end

local function SendWebhook()
	(http_request) {
		Url = WebhookURL;
		Method = 'POST';
		Headers = {['Content-Type'] = 'application/json'};
		Body = HttpService:JSONEncode({
			embeds = {
				{
					title = "Windy Bee has been found!";
					color = "5814783";
					description = GetWebhookInfo(),
					timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
				} 
			} 
		});
	};
end

local function ServerHop()
	local Api = "https://games.roblox.com/v1/games/"

	local PlaceId = game.PlaceId
	local Servers = Api..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"

	function ListServers(cursor)
		local Raw = game:HttpGet(Servers .. ((cursor and "&cursor="..cursor) or ""))
		return HttpService:JSONDecode(Raw)
	end

	local Server, Next

	repeat
		local Servers = ListServers(Next)
		Server = Servers.data[1]
		Next = Servers.nextPageCursor
	until Server
	
	local success, response = pcall(function()
		TeleportService:TeleportToPlaceInstance(PlaceId, Server.id, Players.LocalPlayer)
	end)
	
	if success == false then ServerHop() end
end

task.wait(5)

if GetWebhookInfo() ~= nil then
	SendWebhook()
	while game.Workspace.NPCBees:FindFirstChild("Windy") do task.wait() end
end

ServerHop()
