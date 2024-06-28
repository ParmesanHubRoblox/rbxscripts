while not game:IsLoaded() do task.wait() end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = game.Players.LocalPlayer
local playerMouse = localPlayer:GetMouse()
local ViewportSize = game.Workspace.CurrentCamera.ViewportSize

local function TurnOnDraggable(GUI)
	--// Variables
	local Hovered = false
	local Holding = false
	local MoveCon = nil
	local InitialX, InitialY, UIInitialPos

	--// Functions
	local function Drag()
		if Holding == false then MoveCon:Disconnect() return end
		local distanceMovedX = InitialX - playerMouse.X
		local distanceMovedY = InitialY - playerMouse.Y

		GUI.Position = UIInitialPos - UDim2.new(0, distanceMovedX, 0, distanceMovedY)
	end

	--// Connections
	GUI.MouseEnter:Connect(function()
		Hovered = true
	end)

	GUI.MouseLeave:Connect(function()
		Hovered = false
	end)

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Holding = Hovered
			if Holding then
				InitialX, InitialY = playerMouse.X, playerMouse.Y
				UIInitialPos = GUI.Position

				MoveCon = playerMouse.Move:Connect(Drag)
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			Holding = false
		end
	end)
end

local CommandPrompt = {}
local Library = {}
local CommandPromptSize = {X = 325, Y = 350}

local function plc() print("placeholder") end

local function printMsg(msg)
	print(msg[1])
end

local MusicTable = {
	["StealthSoundtracks"] = {
		["The Setup - Solitary Quest (a)"] = "rbxassetid://1841579249",
		["The Lockup - Tension Mounts"] = "rbxassetid://1838628050",
		["The Blacksite - Breathless Suspense (b)"] = "rbxassetid://1841578568",
		["The Financier - Lock & Load"] = "rbxassetid://1843470912",
		["The Auction - Metro Pulse (a)"] = "rbxassetid://1841578846",
		["The Gala - Bass Motion"] = "rbxassetid://1836764457",
		["The Deposit - The Final Thrust (b)"] = "rbxassetid://1841579381",
		["The Withdrawal - Aftermath"] = "rbxassetid://1843471196",
		["The Lakehouse - Under Surveillance - Underscore"] = "rbxassetid://1838617097",
		["The Cache - Hard As Iron"] = "rbxassetid://1841579363",
		["The Scientist - Looking For A Clue - Underscore"] = "rbxassetid://1838642607",
		["The SCRS - Unusual Suspect"] = "rbxassetid://1838641186",
		["Black Dusk - Restless Tension (a)"] = "rbxassetid://1841164575",
		["The Killhouse - Covert Ops (a)"] = "rbxassetid://1841694216",
		["Concept - The Final Thrust (a)"] = "rbxassetid://1841579325",
	},

	["LoudSoundtracks"] = {
		["The Lockup - Here It Comes"] = "rbxassetid://1837807597",
		["The Score - Pound For Pound - Underscore"] = "rbxassetid://1842802303",
		["The Score - Pound For Pound"] = "rbxassetid://1842802203",
		["The Blacksite - Snapped"] = "rbxassetid://1842940253",
		["The Deposit - High Velocity"] = "rbxassetid://1839898469",
		["The Withdrawal - Assault Complex"] = "rbxassetid://1842940193",
		["The Lakehouse - Complete The Mission"] = "rbxassetid://1838627720",
		["The Scientist - Lethal Conflict"] = "rbxassetid://1842934882",
		["The Scientist - Lethal Conflict - Underscore"] = "rbxassetid://1842801894",
		["The SCRS - Hijacked"] = "rbxassetid://1842559618",
		["Black Dusk - Full Force"] = "rbxassetid://1842801942",
		["The Killhouse - The Vault (a)"] = "rbxassetid://1840083133",
		["The Killhouse - No More Time (a)"] = "rbxassetid://1847027481",
	},

	["AlternateSoundtracks"] = {
		["The Lockup - Pushing Me Closer"] = "rbxassetid://1836789312",
		["The Score - Best Laid Plans - Alternative"] = "rbxassetid://1836808611",
		["The Score - Best Laid Plans"] = "rbxassetid://1837025066",
		["The Blacksite - Suicide Mission"] = "rbxassetid://1837844069",
		["The Financier - See You In Hell"] = "rbxassetid://1837853076",
		["The Financier - There Will Be Blood"] = "rbxassetid://1843513001",
		["The Deposit - Terminal Velocity"] = "rbxassetid://1842802436",
		["The Withdrawal - Pushing The Limits"] = "rbxassetid://1838627011",
		["The Lakehouse - Fight Or Flight"] = "rbxassetid://1842940300",
		["The Scientist - Phoenix Rising"] = "rbxassetid://1837798316",
		["The Scientist - Phoenix Rising - Drums And Bass"] = "rbxassetid://1837798598",
		["The SCRS - We Go Hard"] = "rbxassetid://1842940420",
		["Black Dusk - Victory Is Ours"] = "rbxassetid://1842802498",
	},

	["RemovedSoundtracks"] = {
		["The Killhouse - Chaos"] = "rbxassetid://1843497734",
		["The Financier - Mindwinder (b)"] = "rbxassetid://1838075732",
		["The Scientist - Riding High"] = "rbxassetid://1837807484",
		["The Scientist - Riding High - Drums And Bass"] = "rbxassetid://1837807505",
		["Halloween Hitlist 2020 - Ambience"] = "rbxassetid://3097850155",
		["Halloween Hitlist 2020 - Burning Action"] = "rbxassetid://1838626744",
	},
}

local specialObjects = {
	["Lobby"] = {Char = nil}, -- localPlayer.PlayerData.Character.Char1
	
}

local HelpCommands = {}

function CommandPrompt:MainRender() -- Создание главной командной строки
	-- StarterGui.Entry_Point_2
	CommandPrompt["1"] = Instance.new("ScreenGui", RunService:IsStudio() and localPlayer.PlayerGui or game.CoreGui)
	CommandPrompt["1"]["Name"] = [[Entry_Point_2]]
	CommandPrompt["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	CommandPrompt["1"]["IgnoreGuiInset"] = true
	
	-- StarterGui.Entry_Point_2.Main
	CommandPrompt["2"] = Instance.new("Frame", CommandPrompt["1"])
	CommandPrompt["2"]["BorderSizePixel"] = 0
	CommandPrompt["2"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45)
	CommandPrompt["2"]["BackgroundTransparency"] = 0.15
	CommandPrompt["2"]["Size"] = UDim2.fromOffset(CommandPromptSize.X, CommandPromptSize.Y)
	CommandPrompt["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["2"]["Position"] = UDim2.fromOffset(
		ViewportSize.X - CommandPromptSize.X - 25,
		ViewportSize.Y / 2 - CommandPromptSize.Y / 2)
	CommandPrompt["2"]["Name"] = [[Main]]
	CommandPrompt["2"]["Visible"] = true

	-- StarterGui.Entry_Point_2.Main.UICorner
	CommandPrompt["3"] = Instance.new("UICorner", CommandPrompt["2"])

	-- StarterGui.Entry_Point_2.Main.UICorner.Folder
	CommandPrompt["4"] = Instance.new("Folder", CommandPrompt["3"])

	-- StarterGui.Entry_Point_2.Main.UICorner.Folder.root3
	CommandPrompt["5"] = Instance.new("TextLabel", CommandPrompt["4"])
	CommandPrompt["5"]["BorderSizePixel"] = 0
	CommandPrompt["5"]["TextYAlignment"] = Enum.TextYAlignment.Top
	CommandPrompt["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["5"]["TextXAlignment"] = Enum.TextXAlignment.Left
	CommandPrompt["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CommandPrompt["5"]["TextSize"] = 12
	CommandPrompt["5"]["TextColor3"] = Color3.fromRGB(255, 0, 0)
	CommandPrompt["5"]["Size"] = UDim2.new(0, 45, 0, 15)
	CommandPrompt["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["5"]["Text"] = [[root@kali:]]
	CommandPrompt["5"]["Name"] = [[root3]]
	CommandPrompt["5"]["BackgroundTransparency"] = 1
	CommandPrompt["5"]["Position"] = UDim2.new(0, 0, 0, 300)

	-- StarterGui.Entry_Point_2.Main.FileName
	CommandPrompt["6"] = Instance.new("TextLabel", CommandPrompt["2"])
	CommandPrompt["6"]["ZIndex"] = 2
	CommandPrompt["6"]["BorderSizePixel"] = 0
	CommandPrompt["6"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	CommandPrompt["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	CommandPrompt["6"]["TextSize"] = 12
	CommandPrompt["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["6"]["Size"] = UDim2.new(1, 0, 0, 25)
	CommandPrompt["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["6"]["Text"] = [[root@kali:~parmesan-hub]]
	CommandPrompt["6"]["Name"] = [[FileName]]

	-- StarterGui.Entry_Point_2.Main.FileName.UICorner
	CommandPrompt["7"] = Instance.new("UICorner", CommandPrompt["6"])

	-- StarterGui.Entry_Point_2.Main.FileName.Frame
	CommandPrompt["8"] = Instance.new("Frame", CommandPrompt["6"])
	CommandPrompt["8"]["BorderSizePixel"] = 0
	CommandPrompt["8"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	CommandPrompt["8"]["Size"] = UDim2.new(1, 0, 0, 25)
	CommandPrompt["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["8"]["Position"] = UDim2.new(0, 0, 0, 20)

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.UIListLayout
	CommandPrompt["9"] = Instance.new("UIListLayout", CommandPrompt["8"])
	CommandPrompt["9"]["FillDirection"] = Enum.FillDirection.Horizontal
	CommandPrompt["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder
	
	local function CreateDecorativeCMDButton(ButtonText)
		local decorativeButton = Instance.new("TextLabel", CommandPrompt["8"])
		decorativeButton["LineHeight"] = 1.4
		decorativeButton["BorderSizePixel"] = 0
		decorativeButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		decorativeButton["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		decorativeButton["TextSize"] = 10
		decorativeButton["TextColor3"] = Color3.fromRGB(255, 255, 255)
		decorativeButton["Size"] = UDim2.new(0, 40, 1, 0)
		decorativeButton["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		decorativeButton["Text"] = ButtonText
		decorativeButton["Name"] = ButtonText
		decorativeButton["BackgroundTransparency"] = 1
	end
	
	for _, buttonText in pairs({"File", "Edit", "View", "Search", "Terminal", "Help"}) do
		CreateDecorativeCMDButton(buttonText)
	end
	
	-- StarterGui.Entry_Point_2.Main.FileName.Frame.UIPadding
	CommandPrompt["10"] = Instance.new("UIPadding", CommandPrompt["8"])
	CommandPrompt["10"]["PaddingTop"] = UDim.new(0, 5)

	-- StarterGui.Entry_Point_2.Main.FileName.minimize
	CommandPrompt["11"] = Instance.new("ImageLabel", CommandPrompt["6"])
	CommandPrompt["11"]["BorderSizePixel"] = 0
	CommandPrompt["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["11"]["ImageTransparency"] = 0.6299999952316284
	CommandPrompt["11"]["Image"] = [[rbxassetid://15116175756]]
	CommandPrompt["11"]["Size"] = UDim2.new(0, 10, 0, 10)
	CommandPrompt["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["11"]["Name"] = [[minimize]]
	CommandPrompt["11"]["BackgroundTransparency"] = 1
	CommandPrompt["11"]["Position"] = UDim2.new(0, 275, 0, 7)

	-- StarterGui.Entry_Point_2.Main.FileName.expand
	CommandPrompt["12"] = Instance.new("ImageLabel", CommandPrompt["6"])
	CommandPrompt["12"]["BorderSizePixel"] = 0
	CommandPrompt["12"]["ScaleType"] = Enum.ScaleType.Slice
	CommandPrompt["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["12"]["Image"] = [[rbxassetid://15306952184]]
	CommandPrompt["12"]["Size"] = UDim2.new(0, 10, 0, 10)
	CommandPrompt["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["12"]["Name"] = [[expand]]
	CommandPrompt["12"]["BackgroundTransparency"] = 1
	CommandPrompt["12"]["Position"] = UDim2.new(0, 290, 0, 7)

	-- StarterGui.Entry_Point_2.Main.FileName.close
	CommandPrompt["13"] = Instance.new("ImageLabel", CommandPrompt["6"])
	CommandPrompt["13"]["BorderSizePixel"] = 0
	CommandPrompt["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["13"]["Image"] = [[rbxassetid://15116174139]]
	CommandPrompt["13"]["Size"] = UDim2.new(0, 10, 0, 10)
	CommandPrompt["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["13"]["Name"] = [[close]]
	CommandPrompt["13"]["BackgroundTransparency"] = 1
	CommandPrompt["13"]["Position"] = UDim2.new(0, 305, 0, 7)

	-- StarterGui.Entry_Point_2.Main.CommandsHolder
	CommandPrompt["14"] = Instance.new("Frame", CommandPrompt["2"])
	CommandPrompt["14"]["BorderSizePixel"] = 0
	CommandPrompt["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["14"]["BackgroundTransparency"] = 1
	CommandPrompt["14"]["Size"] = UDim2.new(1, 0, 0, 305)
	CommandPrompt["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["14"]["Position"] = UDim2.new(0, 0, 0, 45)
	CommandPrompt["14"]["Name"] = [[CommandsHolder]]

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame
	CommandPrompt["15"] = Instance.new("ScrollingFrame", CommandPrompt["14"])
	CommandPrompt["15"]["Active"] = true
	CommandPrompt["15"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
	CommandPrompt["15"]["BorderSizePixel"] = 0
	CommandPrompt["15"]["CanvasSize"] = UDim2.new(0, 0, 0, 0)
	CommandPrompt["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	CommandPrompt["15"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
	CommandPrompt["15"]["BackgroundTransparency"] = 1
	CommandPrompt["15"]["Size"] = UDim2.new(1, 0, 1, 0)
	CommandPrompt["15"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	CommandPrompt["15"]["ScrollBarThickness"] = 4

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.UIPadding
	CommandPrompt["16"] = Instance.new("UIPadding", CommandPrompt["15"])
	CommandPrompt["16"]["PaddingTop"] = UDim.new(0, 7)
	CommandPrompt["16"]["PaddingLeft"] = UDim.new(0, 7)

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.UIListLayout
	CommandPrompt["17"] = Instance.new("UIListLayout", CommandPrompt["15"])
	CommandPrompt["17"]["Padding"] = UDim.new(0, 2)
	CommandPrompt["17"]["SortOrder"] = Enum.SortOrder.LayoutOrder
	
	local function CreateDecorativeCMDCommand(Text, Name)
		local DecorativeCommand = Instance.new("TextLabel", CommandPrompt["15"])
		DecorativeCommand["LineHeight"] = 1.2
		DecorativeCommand["BorderSizePixel"] = 0
		DecorativeCommand["RichText"] = true
		DecorativeCommand["TextYAlignment"] = Enum.TextYAlignment.Top
		DecorativeCommand["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		DecorativeCommand["TextXAlignment"] = Enum.TextXAlignment.Left
		DecorativeCommand["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		DecorativeCommand["TextSize"] = 12
		DecorativeCommand["TextColor3"] = Color3.fromRGB(255, 255, 255)
		DecorativeCommand["AutomaticSize"] = Enum.AutomaticSize.Y
		DecorativeCommand["Size"] = UDim2.new(0, 315, 0, 15)
		DecorativeCommand["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		DecorativeCommand["Text"] = Text
		DecorativeCommand["Name"] = Name
		DecorativeCommand["BackgroundTransparency"] = 1
		DecorativeCommand["TextWrapped"] = true
	end
	
	local DecorativeCommands = {
		["1"] = [[<font color="#FF0000">root@kali:</font> ifconfig eth0 127.0.0.1 [-] all multi]],
		["2"] = [[          netmask 255.255.255.0 enps70 mtusize 9000]],
		["3"] = [[enp7s0: flags = 4099 <UP, BROADCAST> mtu 9]],
		["4"] = [[                   ether 70:5a:0f:c2:37:b5 txqueuelen 1000]],
		["5"] = [[                   RX packets 516 bytes 1509312 (1.44 MB)]],
		["6"] = [[                   RX errors 0 dropped 0 overruns 0 frame 0]],
		["7"] = [[                   TX errors 2 dropped 2 overruns 10 carrier 0]],
		["8"] = [[<font color="#FF0000">root@kali:</font> connect parm_hub ether 70:5a:0f:c2:37:b5 / /]],
		["9"] = [[connect: Enumerating objects: 54, done.]],
		["10"] = [[connect: Compressing objects: 100% (54/54), done.]],
		["11"] = [[connect: Total 759 (delta 2), reused 0 (delta 0), pack-reused]],
		["12"] = [[Unpacking objects: 100% (759/759), done.]],
		["13"] = [[[Parmesan Hub]: Connection is establised (56.1 GB / sec)]],
		["14"] = [[[Parmesan Hub]: type help for a list of commands, hotkeys to change hotkeys for the commands.]]
	}
	
	for buttonName, buttonText in pairs(DecorativeCommands) do
		CreateDecorativeCMDCommand(buttonText, buttonName)
	end
	
	function CommandPrompt:addCommandPromptMessage(Text)
		local Message = Instance.new("TextLabel")
		Message.Parent = CommandPrompt["15"]
		Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Message.BackgroundTransparency = 1.000
		Message.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Message.BorderSizePixel = 0
		Message.Size = UDim2.new(0, 315, 0, 15)
		Message.Font = Enum.Font.Ubuntu
		Message.LineHeight = 0.8
		Message.RichText = true
		Message.Text = Text
		Message.TextColor3 = Color3.fromRGB(255, 255, 255)
		Message.TextSize = 12
		Message.TextXAlignment = Enum.TextXAlignment.Left
		Message.TextYAlignment = Enum.TextYAlignment.Top
	end
	
	function CommandPrompt:createCommandInput()
		local CoreName = Instance.new("TextLabel")
		CoreName.Name = "CoreName"
		CoreName.Parent = CommandPrompt["15"]
		CoreName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CoreName.BackgroundTransparency = 1.000
		CoreName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CoreName.BorderSizePixel = 0
		CoreName.Size = UDim2.new(0, 315, 0, 0)
		CoreName.Font = Enum.Font.Ubuntu
		CoreName.LineHeight = 1.200
		CoreName.RichText = true
		CoreName.Text = "<font color=\"#FF0000\">root@kali</font>: "
		CoreName.TextColor3 = Color3.fromRGB(255, 255, 255)
		CoreName.TextSize = 12.000
		CoreName.TextXAlignment = Enum.TextXAlignment.Left
		CoreName.TextYAlignment = Enum.TextYAlignment.Top

		local CommandInput = Instance.new("TextBox")
		CommandInput.Parent = CommandPrompt["15"]
		CommandInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CommandInput.BackgroundTransparency = 1.000
		CommandInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CommandInput.BorderSizePixel = 0
		CommandInput.Size = UDim2.new(0, 315, 0, 12)
		CommandInput.ClearTextOnFocus = false
		CommandInput.Font = Enum.Font.Ubuntu
		CommandInput.Text = ""
		CommandInput.TextColor3 = Color3.fromRGB(255, 255, 255)
		CommandInput.TextSize = 12.000
		CommandInput.TextXAlignment = Enum.TextXAlignment.Left
		CommandInput.TextEditable = true

		local UIPadding = Instance.new("UIPadding")
		UIPadding.Parent = CommandInput
		UIPadding.PaddingBottom = UDim.new(0, 4)
		UIPadding.PaddingLeft = UDim.new(0, 55)

		return CommandInput
	end
	
	local cmdsWithSpecialArgs = {"kill", "bring", "hide", "void"}
	
	function CommandPrompt:getCommand(command)
		local commandName, commandArguments = command:match("(%w+)%s*(.*)")
		local args = {}
		
		if commandArguments then
			for arg in commandArguments:gmatch("(%w+)") do
				table.insert(args, arg)
			end
		end
		
		if #args == 0 and table.find(cmdsWithSpecialArgs, commandName) then args = {[1] = "w", [2] = "g"} end
		
		if HelpCommands[commandName] then
			HelpCommands[commandName].Command(args)
		else
			CommandPrompt:addCommandPromptMessage(os.date("%H:%M:%S", os.time()).." - [Error]: Command does not exist!")
		end
	end
	
	local CommandPromptFrame = CommandPrompt["2"]
	local previousCommandInput = nil
	local semicolonListener = nil
	
	function CommandPrompt:addCommandInputFocusLostListener()
		semicolonListener = previousCommandInput.FocusLost:Connect(function()
			CommandPromptFrame.Visible = false
			if previousCommandInput and previousCommandInput.Text ~= "" then
				previousCommandInput.TextEditable = false
				CommandPrompt:getCommand(previousCommandInput.Text)
			end
		end)
	end
	
	function CommandPrompt:addSemicolonListener()
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Semicolon and (previousCommandInput == nil or previousCommandInput:IsFocused() == false) and UserInputService:GetFocusedTextBox() == nil then
				CommandPromptFrame.Visible = true

				if previousCommandInput and previousCommandInput.Text == "" then
					previousCommandInput:CaptureFocus()
				else
					if semicolonListener then semicolonListener:Disconnect() end
					local CommandInput = CommandPrompt:createCommandInput()
					CommandInput:CaptureFocus()
					previousCommandInput = CommandInput
					CommandPrompt:addCommandInputFocusLostListener()
				end

				CommandPrompt["15"].CanvasPosition = Vector2.new(0, 10000000)

				previousCommandInput:GetPropertyChangedSignal("Text"):Connect(function()
					previousCommandInput.Text = previousCommandInput.Text:gsub(";", "")
				end)
			end
		end)
	end

	CommandPrompt:addSemicolonListener()
end

CommandPrompt:MainRender()

function Library:HelpApplication()
	-- StarterGui.Entry_Point_2.Commands
	Library["2a"] = Instance.new("Frame", CommandPrompt["1"])
	Library["2a"]["BorderSizePixel"] = 0
	Library["2a"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45)
	Library["2a"]["BackgroundTransparency"] = 0.05000000074505806
	Library["2a"]["Size"] = UDim2.new(0, 250, 0, 300)
	Library["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["2a"]["Position"] = UDim2.fromOffset((ViewportSize.X / 2) - (250 / 2), (ViewportSize.Y / 2) - (300 / 2))
	Library["2a"]["Name"] = [[Commands]]
	Library["2a"]["Visible"] = false

	TurnOnDraggable(Library["2a"])

	-- StarterGui.Entry_Point_2.Commands.FileName
	Library["2b"] = Instance.new("TextLabel", Library["2a"])
	Library["2b"]["ZIndex"] = 2
	Library["2b"]["BorderSizePixel"] = 0
	Library["2b"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	Library["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Library["2b"]["TextSize"] = 12
	Library["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
	Library["2b"]["Size"] = UDim2.new(1, 0, 0, 25)
	Library["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["2b"]["Text"] = [[root@kali:~commands]]
	Library["2b"]["Name"] = [[FileName]]

	-- StarterGui.Entry_Point_2.Commands.FileName.UICorner
	Library["2c"] = Instance.new("UICorner", Library["2b"])

	-- StarterGui.Entry_Point_2.Commands.FileName.Frame
	Library["30"] = Instance.new("Frame", Library["2b"])
	Library["30"]["BorderSizePixel"] = 0
	Library["30"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	Library["30"]["Size"] = UDim2.new(1, 0, 0, 5)
	Library["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["30"]["Position"] = UDim2.new(0, 0, 0, 20)

	-- StarterGui.Entry_Point_2.Commands.UICorner
	Library["31"] = Instance.new("UICorner", Library["2a"])


	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame
	Library["32"] = Instance.new("ScrollingFrame", Library["2a"])
	Library["32"]["Active"] = true
	Library["32"]["BorderSizePixel"] = 0
	Library["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	Library["32"]["BackgroundTransparency"] = 1
	Library["32"]["Size"] = UDim2.new(1, 0, 0, 215)
	Library["32"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0)
	Library["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["32"]["ScrollBarThickness"] = 0
	Library["32"]["Position"] = UDim2.new(0, 0, 0, 25)
	Library["32"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.UIListLayout
	Library["33"] = Instance.new("UIListLayout", Library["32"])
	Library["33"]["Padding"] = UDim.new(0, 7)
	Library["33"]["SortOrder"] = Enum.SortOrder.Name

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.list
	Library["34"] = Instance.new("TextLabel", Library["32"])
	Library["34"]["BorderSizePixel"] = 0
	Library["34"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
	Library["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Library["34"]["TextSize"] = 14
	Library["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
	Library["34"]["Size"] = UDim2.new(0, 230, 0, 25)
	Library["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["34"]["Text"] = [[List of the commands:]]
	Library["34"]["Name"] = [[aaaaa]]
	Library["34"]["BackgroundTransparency"] = 1

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.list.UICorner
	Library["35"] = Instance.new("UICorner", Library["34"])
	Library["35"]["CornerRadius"] = UDim.new(0, 2)

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.UIPadding
	Library["36"] = Instance.new("UIPadding", Library["32"])
	Library["36"]["PaddingTop"] = UDim.new(0, 5)
	Library["36"]["PaddingLeft"] = UDim.new(0, 10)


	-- StarterGui.Entry_Point_2.Commands.description1
	Library["zb"] = Instance.new("ScrollingFrame", Library["2a"])
	Library["zb"]["Active"] = true
	Library["zb"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
	Library["zb"]["BorderSizePixel"] = 0
	Library["zb"]["CanvasSize"] = UDim2.new(0, 0, 0, 0)
	Library["zb"]["BackgroundColor3"] = Color3.fromRGB(37, 41, 49)
	Library["zb"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar
	Library["zb"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
	Library["zb"]["Size"] = UDim2.new(1, -20, 0, 50)
	Library["zb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["zb"]["ScrollBarThickness"] = 2
	Library["zb"]["Position"] = UDim2.new(0, 10, 0, 260)
	Library["zb"]["Name"] = [[description1]]
	Library["zb"]["ZIndex"] = 2

	-- StarterGui.Entry_Point_2.Commands.description1.UIStroke
	Library["zc"] = Instance.new("UIStroke", Library["zb"])
	Library["zc"]["Color"] = Color3.fromRGB(24, 27, 32)
	Library["zc"]["Thickness"] = 1.100000023841858
	Library["zc"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

	-- StarterGui.Entry_Point_2.Commands.description1.description
	Library["zd"] = Instance.new("TextLabel", Library["zb"])
	Library["zd"]["TextWrapped"] = true
	Library["zd"]["ZIndex"] = 2
	Library["zd"]["BorderSizePixel"] = 0
	Library["zd"]["RichText"] = true
	Library["zd"]["TextYAlignment"] = Enum.TextYAlignment.Top
	Library["zd"]["BackgroundColor3"] = Color3.fromRGB(37, 41, 49)
	Library["zd"]["TextXAlignment"] = Enum.TextXAlignment.Left
	Library["zd"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Library["zd"]["TextSize"] = 12
	Library["zd"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
	Library["zd"]["AutomaticSize"] = Enum.AutomaticSize.Y
	Library["zd"]["Size"] = UDim2.new(1, 0, 0, 50)
	Library["zd"]["ClipsDescendants"] = true
	Library["zd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["zd"]["Text"] = [[]]
	Library["zd"]["Name"] = [[description]]
	Library["zd"]["Position"] = UDim2.new(0, 10, 0, 260)

	-- StarterGui.Entry_Point_2.Commands.description1.UIPadding
	Library["ze"] = Instance.new("UIPadding", Library["zb"])
	Library["ze"]["PaddingTop"] = UDim.new(0, 5)
	Library["ze"]["PaddingBottom"] = UDim.new(0, 1)
	Library["ze"]["PaddingLeft"] = UDim.new(0, 8)
	Library["ze"]["PaddingRight"] = UDim.new(0, 8)

	-- StarterGui.Entry_Point_2.Commands.description1.UIListLayout
	Library["zf"] = Instance.new("UIListLayout", Library["zb"])
	Library["zf"]["SortOrder"] = Enum.SortOrder.LayoutOrder

	function Library:AddTextButton(name, text)
		-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.TextButton
		Library["37"] = Instance.new("TextButton", Library["32"])
		Library["37"]["Name"] = name
		Library["37"]["BorderSizePixel"] = 0
		Library["37"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
		Library["37"]["TextSize"] = 13
		Library["37"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["37"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["37"]["Size"] = UDim2.new(0, 230, 0, 25)
		Library["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["37"]["Text"] = name

		Library["37"].MouseButton1Click:Connect(function()
			Library["zd"]["Text"] = text
		end)
	end

	for commandName, commandInfo in pairs(HelpCommands) do
		Library:AddTextButton(commandName, commandInfo.Tip)
	end

	-- StarterGui.Entry_Point_2.Commands.description.UIPadding
	Library["39"] = Instance.new("UIPadding", Library["38"])
	Library["39"]["PaddingTop"] = UDim.new(0, 5)
	Library["39"]["PaddingRight"] = UDim.new(0, 10)
	Library["39"]["PaddingBottom"] = UDim.new(0, 1)
	Library["39"]["PaddingLeft"] = UDim.new(0, 10)

	-- StarterGui.Entry_Point_2.Commands.description.UIStroke
	Library["3a"] = Instance.new("UIStroke", Library["38"])
	Library["3a"]["Color"] = Color3.fromRGB(24, 27, 32)
	Library["3a"]["Thickness"] = 1.100000023841858
	Library["3a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

	-- StarterGui.Entry_Point_2.Commands.Frame
	Library["3b"] = Instance.new("Frame", Library["2a"])
	Library["3b"]["ZIndex"] = 0
	Library["3b"]["BorderSizePixel"] = 0
	Library["3b"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	Library["3b"]["Size"] = UDim2.new(1, 0, 0, 5)
	Library["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["3b"]["Position"] = UDim2.new(0, 0, 0, 250)

	-- StarterGui.Entry_Point_2.Commands.descriptionholder
	Library["3c"] = Instance.new("Frame", Library["2a"])
	Library["3c"]["BorderSizePixel"] = 0
	Library["3c"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
	Library["3c"]["Size"] = UDim2.new(1, 0, 0, 70)
	Library["3c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	Library["3c"]["Position"] = UDim2.new(0, 0, 0, 250)
	Library["3c"]["Name"] = [[descriptionholder]]

	-- StarterGui.Entry_Point_2.Commands.descriptionholder.UICorner
	Library["3d"] = Instance.new("UICorner", Library["3c"])
end

Library:HelpApplication()

local MissionNames = {"Ironman", "Mission", "Blacksite", "Financier", "Deposit", "Lakehouse", "Withdrawal", "Scientist", "SCRS", "Black Dusk", "Killhouse", "Lockup", "Score", "Auction", "Gala", "Cache"}

function Library:lobbyMaster()
	local Toggle = {}
	
	local function DropdownTween(object, goal, callback)
		local tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), goal)
		tween.Completed:Connect(callback or function() end)
		do tween:Play() end
	end
	
	local Char = specialObjects.Lobby.Char
	local MissionName = "_Deposit"
	local LevelCap = 1
	local FriendsOnly = false
	local Difficulty = 1
	local LobbyImage = 1
	local LobbySize = 4
	local SpeedrunMode = false
	local SpeedrunSeed = 0
	local DailyChallenge = false

	local function CreateLobby()
		ReplicatedStorage.Lobby.Trig.CreateLobby:InvokeServer(Char, MissionName, LevelCap, FriendsOnly, Difficulty, LobbyImage, LobbySize, SpeedrunMode, SpeedrunSeed, DailyChallenge)
	end

	-- Render
	do
		-- StarterGui.Entry_Point_2.Library
		Library["53"] = Instance.new("Frame", CommandPrompt["1"])
		Library["53"]["BorderSizePixel"] = 0
		Library["53"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45)
		Library["53"]["BackgroundTransparency"] = 0.05000000074505806
		Library["53"]["Size"] = UDim2.new(0, 250, 0, 300)
		Library["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["53"]["Position"] = UDim2.new(0, 500, 0, 100)
		Library["53"]["Name"] = [[LobbyMaster]]
		Library["53"]["Visible"] = false

		TurnOnDraggable(Library["53"])

		-- StarterGui.Entry_Point_2.Library.FileName
		Library["54"] = Instance.new("TextLabel", Library["53"])
		Library["54"]["ZIndex"] = 2
		Library["54"]["BorderSizePixel"] = 0
		Library["54"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
		Library["54"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["54"]["TextSize"] = 12
		Library["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["54"]["Size"] = UDim2.new(1, 0, 0, 25)
		Library["54"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["54"]["Text"] = [[root@kali:~lobby-master]]
		Library["54"]["Name"] = [[FileName]]

		-- StarterGui.Entry_Point_2.Library.FileName.UICorner
		Library["55"] = Instance.new("UICorner", Library["54"])


		-- StarterGui.Entry_Point_2.Library.FileName.Frame
		Library["56"] = Instance.new("Frame", Library["54"])
		Library["56"]["BorderSizePixel"] = 0
		Library["56"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
		Library["56"]["Size"] = UDim2.new(1, 0, 0, 5)
		Library["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["56"]["Position"] = UDim2.new(0, 0, 0, 20)

		-- StarterGui.Entry_Point_2.Library.UICorner
		Library["57"] = Instance.new("UICorner", Library["53"])


		-- StarterGui.Entry_Point_2.Library.ScrollingFrame
		Library["58"] = Instance.new("ScrollingFrame", Library["53"])
		Library["58"]["Active"] = true
		Library["58"]["BorderSizePixel"] = 0
		Library["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
		Library["58"]["BackgroundTransparency"] = 1
		Library["58"]["Size"] = UDim2.new(1, 0, 0, 275)
		Library["58"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0)
		Library["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["58"]["ScrollBarThickness"] = 3
		Library["58"]["Position"] = UDim2.new(0, 0, 0, 25)
		Library["58"]["CanvasSize"] = UDim2.new(0, 0, 2, -100)
		Library["58"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.list
		Library["59"] = Instance.new("TextLabel", Library["58"])
		Library["59"]["BorderSizePixel"] = 0
		Library["59"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
		Library["59"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["59"]["TextSize"] = 14
		Library["59"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["59"]["Size"] = UDim2.new(0, 230, 0, 25)
		Library["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["59"]["Text"] = [[Create the Lobby]]
		Library["59"]["Name"] = [[list]]
		Library["59"]["BackgroundTransparency"] = 1

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.list.UICorner
		Library["5a"] = Instance.new("UICorner", Library["59"])
		Library["5a"]["CornerRadius"] = UDim.new(0, 2)

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.UIPadding
		Library["5b"] = Instance.new("UIPadding", Library["58"])
		Library["5b"]["PaddingTop"] = UDim.new(0, 5)
		Library["5b"]["PaddingLeft"] = UDim.new(0, 10)

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.UIListLayout
		Library["5c"] = Instance.new("UIListLayout", Library["58"])
		Library["5c"]["Padding"] = UDim.new(0, 7)
		Library["5c"]["SortOrder"] = Enum.SortOrder.LayoutOrder

		-- StarterGui.Entry_Point_2.LobbyMaster.uicornercloser
		Library["9e"] = Instance.new("Frame", Library["53"])
		Library["9e"]["ZIndex"] = 0
		Library["9e"]["BorderSizePixel"] = 0
		Library["9e"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
		Library["9e"]["Size"] = UDim2.new(1, 0, 0, 5)
		Library["9e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["9e"]["Position"] = UDim2.new(0, 0, 0, 270)
		Library["9e"]["Name"] = [[uicornercloser]]

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder
		Library["9f"] = Instance.new("Frame", Library["53"])
		Library["9f"]["BorderSizePixel"] = 0
		Library["9f"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
		Library["9f"]["Size"] = UDim2.new(1, 0, 0, 90)
		Library["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["9f"]["Position"] = UDim2.new(0, 0, 0, 270)
		Library["9f"]["Name"] = [[createButtonHolder]]

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.UICorner
		Library["a0"] = Instance.new("UICorner", Library["9f"])


		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"])
		Library["a1"]["BorderSizePixel"] = 0
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172)
		Library["a1"]["TextSize"] = 12
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20)
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["a1"]["Text"] = [[Create the Lobby]]
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 10)

		Library["a1"].Activated:Connect(function() CreateLobby() end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"])
		Library["a2"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"])
		Library["a1"]["BorderSizePixel"] = 0
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172)
		Library["a1"]["TextSize"] = 12
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20)
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["a1"]["Text"] = [[Leave the Lobby]]
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 35)

		Library["a1"].Activated:Connect(function() ReplicatedStorage.Lobby.Trig.LeaveLobby:FireServer() end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"])
		Library["a2"]["CornerRadius"] = UDim.new(0, 4)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"])
		Library["a1"]["BorderSizePixel"] = 0
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172)
		Library["a1"]["TextSize"] = 12
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20)
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
		Library["a1"]["Text"] = [[Start the Game]]
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 60)

		Library["a1"].Activated:Connect(function() ReplicatedStorage.Lobby.Trig.StartGame:FireServer() end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"])
		Library["a2"]["CornerRadius"] = UDim.new(0, 4)

		function Library:AddTextbox(name, callback)

			local TextBox = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character
			TextBox["5d"] = Instance.new("Frame", Library["58"])
			TextBox["5d"]["BorderSizePixel"] = 0
			TextBox["5d"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
			TextBox["5d"]["Size"] = UDim2.new(0, 230, 0, 35)
			TextBox["5d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			TextBox["5d"]["Name"] = [[name]]

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextLabel
			TextBox["5e"] = Instance.new("TextLabel", TextBox["5d"])
			TextBox["5e"]["TextWrapped"] = true
			TextBox["5e"]["BorderSizePixel"] = 0
			TextBox["5e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			TextBox["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left
			TextBox["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			TextBox["5e"]["TextSize"] = 12
			TextBox["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			TextBox["5e"]["Size"] = UDim2.new(0, 100, 1, 0)
			TextBox["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			TextBox["5e"]["Text"] = name
			TextBox["5e"]["BackgroundTransparency"] = 1
			TextBox["5e"]["Position"] = UDim2.new(0, 10, 0, 0)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox
			TextBox["5f"] = Instance.new("TextBox", TextBox["5d"])
			TextBox["5f"]["CursorPosition"] = -1
			TextBox["5f"]["BorderSizePixel"] = 0
			TextBox["5f"]["TextSize"] = 12
			TextBox["5f"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59)
			TextBox["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			TextBox["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			TextBox["5f"]["PlaceholderText"] = [[number]]
			TextBox["5f"]["Size"] = UDim2.new(0, 50, 0, 20)
			TextBox["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			TextBox["5f"]["Text"] = [[]]
			TextBox["5f"]["Position"] = UDim2.new(0, 170, 0, 8)
			TextBox["5f"]["TextWrapped"] = true

			TextBox["5f"].FocusLost:Connect(function()
				callback(TextBox["5f"]["Text"])
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UICorner
			TextBox["60"] = Instance.new("UICorner", TextBox["5f"])
			TextBox["60"]["CornerRadius"] = UDim.new(0, 2)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UIStroke
			TextBox["61"] = Instance.new("UIStroke", TextBox["5f"])
			TextBox["61"]["Color"] = Color3.fromRGB(27, 27, 27)
			TextBox["61"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.UICorner
			TextBox["62"] = Instance.new("UICorner", TextBox["5d"])
			TextBox["62"]["CornerRadius"] = UDim.new(0, 4)
		end

		function Library:AddMissionHolder()
			local Activated = false

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName
			Library["63"] = Instance.new("TextButton", Library["58"])
			Library["63"]["BorderSizePixel"] = 0
			Library["63"]["AutoButtonColor"] = false
			Library["63"]["TextXAlignment"] = Enum.TextXAlignment.Left
			Library["63"]["TextYAlignment"] = Enum.TextYAlignment.Top
			Library["63"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
			Library["63"]["TextSize"] = 12
			Library["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Library["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Library["63"]["Size"] = UDim2.new(0, 230, 0, 35)
			Library["63"]["Name"] = [[MissionName]]
			Library["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library["63"]["Text"] = [[Mission Name]]

			Library["63"].Activated:Connect(function()
				Activated = not Activated
				if Activated then
					DropdownTween(Library["63"], {Size = UDim2.new(0, 230, 0, 160)})
					DropdownTween(Library["asf"], {Rotation = 180})
					Library["66"]["Visible"] = true
				else
					DropdownTween(Library["asf"], {Rotation = 0})
					DropdownTween(Library["63"], {Size = UDim2.new(0, 230, 0, 35)})
					Library["66"]["Visible"] = false
				end
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UIPadding
			Library["64"] = Instance.new("UIPadding", Library["63"])
			Library["64"]["PaddingTop"] = UDim.new(0, 11)
			Library["64"]["PaddingLeft"] = UDim.new(0, 10)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UICorner
			Library["65"] = Instance.new("UICorner", Library["63"])
			Library["65"]["CornerRadius"] = UDim.new(0, 4)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame
			Library["66"] = Instance.new("ScrollingFrame", Library["63"])
			Library["66"]["Active"] = true
			Library["66"]["BorderSizePixel"] = 0
			Library["66"]["CanvasPosition"] = Vector2.new(0, 140)
			Library["66"]["BackgroundColor3"] = Color3.fromRGB(30, 34, 40)
			Library["66"]["Size"] = UDim2.new(0, 210, 0, 120)
			Library["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library["66"]["ScrollBarThickness"] = 2
			Library["66"]["Position"] = UDim2.new(0, 0, 0, 20)
			Library["66"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
			Library["66"]["Visible"] = false
			Library["66"]["CanvasPosition"] = Vector2.new(0, 0)
			
			-- StarterGui.Entry_Point_2.LobbyMaster.ScrollingFrame.MissionName.ScrollingFrame.ScreenGui.ImageLabel
			Library["asf"] = Instance.new("ImageLabel", Library["63"])
			Library["asf"]["BorderSizePixel"] = 0
			Library["asf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Library["asf"]["Image"] = [[rbxassetid://15114393414]]
			Library["asf"]["Size"] = UDim2.new(0, 15, 0, 15)
			Library["asf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library["asf"]["BackgroundTransparency"] = 1
			Library["asf"]["Position"] = UDim2.new(0, 190, 0, -2)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIListLayout
			Library["67"] = Instance.new("UIListLayout", Library["66"])
			Library["67"]["Padding"] = UDim.new(0, 5)
			Library["67"]["SortOrder"] = Enum.SortOrder.LayoutOrder

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIPadding
			Library["6b"] = Instance.new("UIPadding", Library["66"])
			Library["6b"]["PaddingTop"] = UDim.new(0, 6)
			Library["6b"]["PaddingLeft"] = UDim.new(0, 3)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ChosenMission
			Library["6c"] = Instance.new("TextLabel", Library["63"])
			Library["6c"]["BorderSizePixel"] = 0
			Library["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Library["6c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Library["6c"]["TextSize"] = 11
			Library["6c"]["TextColor3"] = Color3.fromRGB(181, 181, 181)
			Library["6c"]["Size"] = UDim2.new(0, 40, 0, 20)
			Library["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Library["6c"]["Text"] = [[. . .]]
			Library["6c"]["Name"] = [[ChosenMission]]
			Library["6c"]["BackgroundTransparency"] = 1
			Library["6c"]["Position"] = UDim2.new(0, 140, 0, -4)
		end

		function Library:AddMission(name, callback)
			local Mission = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton
			Mission["68"] = Instance.new("TextButton", Library["66"])
			Mission["68"]["BorderSizePixel"] = 0
			Mission["68"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51)
			Mission["68"]["TextSize"] = 12
			Mission["68"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Mission["68"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Mission["68"]["Size"] = UDim2.new(0, 200, 0, 25)
			Mission["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Mission["68"]["Text"] = name

			Mission["68"].Activated:Connect(function()
				callback()
				Library["6c"]["Text"] = name
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UIStroke
			Mission["69"] = Instance.new("UIStroke", Mission["68"])
			Mission["69"]["Color"] = Color3.fromRGB(26, 26, 26)
			Mission["69"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UICorner
			Mission["6a"] = Instance.new("UICorner", Mission["68"])
			Mission["6a"]["CornerRadius"] = UDim.new(0, 3)
		end

		function Library:AddCheckbox(name, callback)
			local Checkbox = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly
			Checkbox["73"] = Instance.new("Frame", Library["58"])
			Checkbox["73"]["BorderSizePixel"] = 0
			Checkbox["73"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37)
			Checkbox["73"]["Size"] = UDim2.new(0, 230, 0, 35)
			Checkbox["73"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Checkbox["73"]["Name"] = [[FriendsOnly]]

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.TextLabel
			Checkbox["74"] = Instance.new("TextLabel", Checkbox["73"])
			Checkbox["74"]["BorderSizePixel"] = 0
			Checkbox["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Checkbox["74"]["TextXAlignment"] = Enum.TextXAlignment.Left
			Checkbox["74"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Checkbox["74"]["TextSize"] = 12
			Checkbox["74"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
			Checkbox["74"]["Size"] = UDim2.new(0, 40, 1, 0)
			Checkbox["74"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Checkbox["74"]["Text"] = name
			Checkbox["74"]["BackgroundTransparency"] = 1
			Checkbox["74"]["Position"] = UDim2.new(0, 10, 0, 0)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.UICorner
			Checkbox["75"] = Instance.new("UICorner", Checkbox["73"])
			Checkbox["75"]["CornerRadius"] = UDim.new(0, 4)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame
			Checkbox["76"] = Instance.new("TextButton", Checkbox["73"])
			Checkbox["76"]["BorderSizePixel"] = 0
			Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51)
			Checkbox["76"]["Size"] = UDim2.new(0, 20, 0, 20)
			Checkbox["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Checkbox["76"]["Position"] = UDim2.new(0, 200, 0, 8)
			Checkbox["76"]["TextTransparency"] = 1

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.UIStroke

			Checkbox["lol"] = Instance.new("UIStroke", Checkbox["76"])
			Checkbox["lol"]["Color"] = Color3.fromRGB(26,26,26)
			Checkbox["lol"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.ImageLabel
			Checkbox["77"] = Instance.new("ImageLabel", Checkbox["76"])
			Checkbox["77"]["BorderSizePixel"] = 0
			Checkbox["77"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
			Checkbox["77"]["Image"] = [[rbxassetid://15114786962]]
			Checkbox["77"]["Size"] = UDim2.new(1, -5, 1, -5)
			Checkbox["77"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			Checkbox["77"]["BackgroundTransparency"] = 1
			Checkbox["77"]["Position"] = UDim2.new(0, 3, 0, 3)
			Checkbox["77"]["ImageTransparency"] = 1

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.UICorner
			Checkbox["78"] = Instance.new("UICorner", Checkbox["76"])
			Checkbox["78"]["CornerRadius"] = UDim.new(0, 4)

			local Toggle = {
				Hover = false,
				MouseDown = false,
				State = false
			}

			function Checkbox:Toggle(callback)

				Toggle.State = not Toggle.State

				if Toggle.State then
					Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(1, 105, 171)
					Checkbox["77"]["ImageTransparency"] = 0
				else
					Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51)
					Checkbox["77"]["ImageTransparency"] = 1
				end

				callback(Toggle.State)
			end

			Checkbox["76"].Activated:Connect(function()
				Checkbox:Toggle(callback)
			end)
		end

		Library:AddTextbox("Character (1 - 12)", function(Value)
			Char = game:GetService("Players").LocalPlayer.PlayerData.Character:FindFirstChild("Char"..Value)
		end)

		Library:AddMissionHolder()

		for i,v in pairs(MissionNames) do
			Library:AddMission(v, (function()
				MissionName = "_"..v:gsub(" ","")
			end))
		end

		Library:AddTextbox("Level Cap", function(Value)
			LevelCap = tonumber(Value)
		end)

		Library:AddCheckbox("Friends Only", function(Value)
			FriendsOnly = Value
		end)

		Library:AddTextbox("Difficulty (0 - 5)", function(Value)
			Difficulty = tonumber(Value)
		end)

		Library:AddTextbox("Lobby Image (0 - 3)", function(Value)
			LobbyImage = tonumber(Value)
		end)

		Library:AddTextbox("Lobby Size", function(Value)
			LobbySize = tonumber(Value)
		end)

		Library:AddCheckbox("Speedrun Mode", function(Value)
			SpeedrunMode = Value
		end)

		Library:AddTextbox("Speedrun Seed", function(Value)
			SpeedrunSeed = tonumber(Value)
		end)

		Library:AddCheckbox("Daily Challenge", function(Value)
			DailyChallenge = Value
		end)
	end
end

Library:lobbyMaster()

local currentMissionInfo = nil
currentMissionInfo = {
	[3200010305] = { -- blacksite
		Guards = {"SC Guard"},
		Specials = {"SC Commander"},
		Enemies = {"SC Soldier", "SC Shredder"},
		Allies = {"Rose"},
		Spot = Vector3.new(70.85807037353516, 20.098060607910156, 199.99752807617188)
	},
	[2797881676] = { -- financier
		Guards = {"Guard"},
		Specials = {"Ryan"},
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(-51.04850769042969, 14.899995803833008, -56.45438003540039),
		Assistance = function()
			local offset = 0

			for _, object in pairs(game.Workspace.Level.Geometry:GetChildren()) do
				if object.Name == "PowerBox" then
					object.Case.Interact.Time.Value = 5
					object.PrimaryPart = object.Case.BasePart
					object:SetPrimaryPartCFrame(CFrame.new(-3.205, 5.9, -30.888 + offset) * CFrame.Angles(0, math.rad(90), 0))
					offset += 2
				end
			end
		end,

	},
	[2625195454] = { -- deposit
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard"},
		Specials = {"Manager"},
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(165.1376190185547, 173.49996948242188, -160.21685791015625),
		Assistance = function()
			local ManagerComputer = workspace.Level.Geometry.ManagerComputer
			ManagerComputer.PrimaryPart = ManagerComputer.Screen
			ManagerComputer:SetPrimaryPartCFrame(CFrame.new(210.249, 191.136, 93.872) * CFrame.Angles(0, math.rad(180), 0))
			ManagerComputer.Interact.Time.Value = 2.5

			for _, v in pairs(workspace.Level.Geometry:WaitForChild("AccComputers"):GetChildren()) do
				if v:FindFirstChild("Interact") then
					v.PrimaryPart = v.Screen
					v:SetPrimaryPartCFrame(CFrame.new(210.249, 188.91, 93.872) * CFrame.Angles(0, math.rad(180), 0))
					break
				end
			end

			local Safecrack = game.Workspace.Level.Triggers.Safecrack
			Safecrack.Interact.Time.Value = 20
			Safecrack.PrimaryPart = Safecrack.ToolIcon
			Safecrack:SetPrimaryPartCFrame(CFrame.new(210.214, 190.748, 96.672) * CFrame.Angles(0, math.rad(90), 0))

			local KeycardRed = workspace.Level.GroundItems:WaitForChild("KeycardRed")
			KeycardRed.PrimaryPart = KeycardRed:WaitForChild("Base")
			KeycardRed:SetPrimaryPartCFrame(CFrame.new(210.279, 189.141, 96.687) * CFrame.Angles(math.rad(90), 0, math.rad(90)))

			local VaultKeypad = workspace.Level.Geometry.VaultKeypad
			VaultKeypad.Interact.Time.Value = 2
			VaultKeypad.PrimaryPart = VaultKeypad:FindFirstChildOfClass("Part")
			VaultKeypad:SetPrimaryPartCFrame(CFrame.new(210.294, 189.783, 98.404) * CFrame.Angles(0, math.rad(90), 0))

			while #workspace.Level.Geometry:GetChildren() ~= 1656 do task.wait() end 

			local Objectives = game:GetService("Players").LocalPlayer.PlayerGui.Weapons.WeaponGui.Objectives
			local numMatch = nil
			local depositDoor = nil

			local lockpickDistance = 1000000
			local lockpick = nil
			local drillDistance = 1000000
			local drill = nil

			while numMatch == nil and task.wait() do
				for _, objective in pairs(Objectives:GetChildren()) do
					if objective.Name == "ObjectiveTitle" then
						numMatch = objective.Text:match("%d+")
						if numMatch ~= nil then break end
					end
				end
			end

			for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
				if v.Name == "DepositDoor" then
					if v.Number.SurfaceGui.TextLabel.Text == numMatch then
						depositDoor = v.Center
					end
				end
			end

			for _, v in pairs(workspace.Level.Triggers:GetChildren()) do
				if v.Name == "Lockpick" then
					if (depositDoor.Position - v.ToolIcon.Position).Magnitude < lockpickDistance then
						lockpickDistance = (depositDoor.Position - v.ToolIcon.Position).Magnitude
						lockpick = v
					end
				elseif v.Name == "Drill" then
					if (depositDoor.Position - v.ToolIcon.Position).Magnitude < drillDistance then
						drillDistance = (depositDoor.Position - v.ToolIcon.Position).Magnitude
						drill = v
					end
				end
			end

			lockpick.Interact.Time.Value = 5
			lockpick.PrimaryPart = lockpick.ToolIcon
			lockpick:SetPrimaryPartCFrame(CFrame.new(210.417, 190.706, 100.155) * CFrame.Angles(0, math.rad(90), 0))

			drill.Interact.Time.Value = 0
			drill.PrimaryPart = drill.ToolIcon
			drill:SetPrimaryPartCFrame(CFrame.new(210.417, 189.16, 100.155) * CFrame.Angles(0, math.rad(90), 0))

			local PhoenixStash = workspace.Level.GroundItems:WaitForChild("PhoenixStash")
			PhoenixStash.PrimaryPart = PhoenixStash.Base
			PhoenixStash:SetPrimaryPartCFrame(CFrame.new(210.492, 187.55, 100.238) * CFrame.Angles(0, math.rad(90), 0))
		end,
	},
	[3590667014] = { -- lakehouse
		Guards = {"Phoenix Operative"},
		Enemies = {"SC Soldier", "SC Shredder"},
		Spot = Vector3.new(21.38668441772461, 18.50002670288086, -32.37154006958008),
		KillBoss = function()
			local Base = workspace.Level.Actors:WaitForChild("Helo"):WaitForChild("Base").Position
			localPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
		end,
		GetDoor = function()
			for _, currentObject in pairs(workspace.Level.Geometry:GetChildren()) do
				if currentObject:FindFirstChild("Escape") and currentObject.Escape:FindFirstChild("Interact") then
					return currentObject
				end
			end
			return nil
		end,
		SpeedUp = function()
			local Geometry = workspace.Level.Geometry
			while Geometry:GetChildren()[1836] == nil do RunService.RenderStepped:Wait() end
			local GeometryChildren = Geometry:GetChildren()

			for index = 1831, 1836 do
				GeometryChildren[index].ServerPickup.Interact.Value = true
				GeometryChildren[index].ServerPickup.PickupTime.Value = 0
			end
		end,
		NPCSort = function(NPC)
			if NPC:WaitForChild("Character") and NPC.Character:WaitForChild("Interact") and NPC.Character.Interact:WaitForChild("ObjectName") then
				local NPCName = NPC.Character.Interact.ObjectName.Value
				local SeparatedNPCS = workspace.Level.Actors.SeparatedNPCS
				
				if NPC.Character.Interact:FindFirstChild("Intel") then
					NPC.Parent = SeparatedNPCS.Workers
				elseif NPC.Character.Inventory:FindFirstChild("KeycardBlue") then
					NPC.Parent = SeparatedNPCS.Specials
				elseif NPCName == "Phoenix Operative" then
					NPC.Parent = SeparatedNPCS.Guards
				else
					NPC.Parent = SeparatedNPCS.Enemies
				end
			end
		end,
	},
	[2951213182] = { -- withdrawal
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard"},
		Specials = {"Manager"},
		Enemies = {"Police", "SWAT", "Aegis Unit"},
		Spot = Vector3.new(39.4105339050293, 3.4001095294952393, 113.61088562011719),
		GetDoor = function()
			for _, currentObject in pairs(workspace.Level.Geometry:GetChildren()) do
				if currentObject:FindFirstChild("AccessDoorScript") and currentObject:FindFirstChild("OpenTrig") then
					return currentObject
				end
			end
			return nil
		end,
		SpeedUp = function()
			for _, cashBag in pairs(workspace.Level.GroundBags:GetChildren()) do
				if cashBag.Name == "Cash" then cashBag.PickupTime.Value = 0 end
			end
		end,
	},
	[4518266946] = { -- scientist
		Workers = {"Halcyon Operative"},
		Guards = {"Halcyon Operative"},
		Specials = {"Falcon"},
		Enemies = {"TRU", "Aegis Unit"},
		Allies = {"Rivera"},
		Spot = Vector3.new(-21.118181228637695, 3.500000476837158, -20.95203971862793),
		Autofarm = function()
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RawParmesann/test/main/scientist.lua"),true))()
		end,
		NPCSort = function(NPC)
			if NPC:WaitForChild("Character") and NPC.Character:WaitForChild("Interact") and NPC.Character.Interact:WaitForChild("ObjectName") then
				local NPCName = NPC.Character.Interact.ObjectName.Value
				local SeparatedNPCS = workspace.Level.Actors.SeparatedNPCS
				
				if NPC.Character.Inventory:FindFirstChild("KeycardHS") and NPC.Character.Inventory:FindFirstChild("USB") then
					NPC.Parent = SeparatedNPCS.Specials
				elseif NPC.Character.Inventory:FindFirstChild("KeycardHS") and not NPC.Character.Inventory:FindFirstChild("USB") then
					NPC.Parent = SeparatedNPCS.Workers
				elseif NPCName == "Halcyon Operative" then
					NPC.Parent = SeparatedNPCS.Guards
				elseif NPCName == "Rivera" then
					NPC.Parent = SeparatedNPCS.Allies
				else
					NPC.Parent = SeparatedNPCS.Enemies
				end
			end
		end,
	},
	[4661507759] = { -- SCRS
		Workers = {"Analyst", "Tech"},
		Guards = {"Security", "Janitor"},
		Specials = {"Agent Nightshade", "Agent Hemlock"},
		Enemies = {"ETF", "Aegis Unit"},
		Spot = Vector3.new(52.52033233642578, 15, 188.01849365234375),
		KillBoss = function()
			local Helo = workspace.Level.Actors:WaitForChild("Helo"):WaitForChild("Base").Position
			local Base = Helo:WaitForChild("Base").Position
			while Helo:WaitForChild("ObjectHealth").Value ~= 17150 do
				localPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
				task.wait(1)
			end
		end,
	},
	[4768829954] = { -- Black Dusk
		Workers = {"Workshop Tech", "Programmer"},
		Guards = {"Base Security"},
		Specials = {"Elite Operative", "Onyx Unit"},
		Enemies = {"Halcyon Operative", "Juggernaut"},
		Spot = Vector3.new(94.17521667480469, 21.497360229492188, 216.7227325439453)
	},
	[2215221144] = { -- Killhouse
		Guards = {"Guard"},
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(20.715, 7.23954, 62.0234),
		NPCSort = function(NPC)
			if NPC:WaitForChild("Character") and NPC.Character:WaitForChild("Interact") and NPC.Character.Interact:WaitForChild("ObjectName") then
				local NPCName = NPC.Character.Interact.ObjectName.Value
				local SeparatedNPCS = workspace.Level.Actors.SeparatedNPCS
				
				if NPC.Character.Inventory:FindFirstChild("KeycardRed") then
					NPC.Parent = SeparatedNPCS.Specials
				elseif NPCName == "Guard" then
					NPC.Parent = SeparatedNPCS.Guards
				else
					NPC.Parent = SeparatedNPCS.Enemies
				end
			end
		end,
	},
	[4134003540] = { -- Auction
		Civilians = {"Civilian"},
		Workers = {"Staff"},
		Guards = {"Guard"},
		Specials = {"Auctioneer"},
		Spot = Vector3.new(37.45741271972656, 3.4001107215881348, 98.5108871459961)
	},
	[3925577908] = { -- Gala
		Civilians = {"Civilian"},
		Workers = {"Staff"},
		Guards = {"Guard"},
		Specials = {"Guard"},
		Spot = Vector3.new(-4.096112251281738, 7.500090599060059, -54.025657653808594),
		NPCSort = function(NPC)
			if NPC:WaitForChild("Character") and NPC.Character:WaitForChild("Interact") and NPC.Character.Interact:WaitForChild("ObjectName") then
				local NPCName = NPC.Character.Interact.ObjectName.Value
				local SeparatedNPCS = workspace.Level.Actors.SeparatedNPCS
				
				if NPC.Character.Inventory:FindFirstChild("KeycardRed") or (NPC.Character.Interact:FindFirstChild("Intel") and NPC.Character.Interact.Intel:FindFirstChild("KeypadCode")) then
					NPC.Parent = SeparatedNPCS.Specials
				elseif NPCName == "Guard" then
					NPC.Parent = SeparatedNPCS.Guards
				elseif NPCName == "Staff" then
					NPC.Parent = SeparatedNPCS.Workers
				end
			end
		end,
	},
	[4388762338] = { -- Cache
		Guards = {"Guard"},
		Spot = Vector3.new(165.1376190185547, 173.49996948242188, -160.21685791015625)
	},
	[5071816792] = { -- Setup
		Guards = {"Guard"},
		Spot = Vector3.new(88.99303436279297, 23.910255432128906, -1.1216182708740234)
	},
	[5188855685] = { -- Lockup
		Civilians = {"Civilian"},
		Spot = Vector3.new(2.96498, 3.48513, 90.5891)
	},
	[5862433299] = { -- Score
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(237.0268096923828, 16.700029373168945, 45.57285690307617),
		KillBoss = function()
			local Base = workspace.Level.Actors:WaitForChild("Turret"):WaitForChild("Gun").Position
			localPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
		end,
		SpeedUp = function()
			for _, goldBag in pairs(workspace.Level.GroundBags:GetChildren()) do
				if goldBag.Name == "Gold" then goldBag.PickupTime.Value = 0 end
			end
		end,
	},
	[7799530284] = { -- Concept
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard", "Elite Guard"},
		Specials = {"Manager", "Manager's Assistant"},
		Spot = Vector3.new(46.8819, 5.31316, 5.74569)
	},
}

local function EasySortFunction(NPC)
	if NPC:WaitForChild("Character") and NPC.Character:WaitForChild("Interact") and NPC.Character.Interact:WaitForChild("ObjectName") then
		local NPCName = NPC.Character.Interact.ObjectName.Value
		for NpcGroup, Names in pairs (currentMissionInfo[game.PlaceId]) do
			if type(Names) == "table" and table.find(Names, NPCName) then
				NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild(NpcGroup)
			end
		end
	end
end

local NPCSortFunction = nil

if table.find({3590667014, 4518266946, 2215221144, 3925577908}, game.PlaceId) then
	NPCSortFunction = currentMissionInfo[game.PlaceId].NPCSort
else
	NPCSortFunction = EasySortFunction
end


local GroupsAndColors = {
	["Civilians"] = Color3.new(0, 0, 0),
	["Workers"] = Color3.new(1, 1, 1),
	["Guards"] = Color3.new(1, 0, 0),
	["Specials"] = Color3.new(0, 0, 1),
	["Enemies"] = Color3.new(255, 0, 0),
	["Allies"] = Color3.new(255, 171, 0),
	["Cams"] = Color3.new(0, 1, 0),
	["Items"] = Color3.new(255, 171, 0),
	["Objects"] = Color3.new(255, 255, 255)
}

local function addHighlightGroups()
	local Actors = workspace:WaitForChild("Level"):WaitForChild("Actors")

	local SeparatedNPCS = Instance.new("Folder", Actors)
	SeparatedNPCS.Name = "SeparatedNPCS"

	for groupName, groupColor in pairs(GroupsAndColors) do
		local HighlightGroup = Instance.new("Model", SeparatedNPCS)
		HighlightGroup.Name = groupName

		local NewHighlight = Instance.new("Highlight", HighlightGroup)
		NewHighlight.OutlineColor = (Color3.new(0,0,0))
		NewHighlight.OutlineTransparency = 0.5
		NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		NewHighlight.FillColor = groupColor
		NewHighlight.Enabled = false
	end
end

local SeparatedNPCs, Groups = nil, nil

if currentMissionInfo[game.PlaceId] then
	addHighlightGroups()
	SeparatedNPCs = workspace.Level.Actors:WaitForChild("SeparatedNPCS")
	
	Groups = {
		["c"] = SeparatedNPCs:WaitForChild("Civilians"),
		["w"] = SeparatedNPCs:WaitForChild("Workers"),
		["g"] = SeparatedNPCs:WaitForChild("Guards"),
		["s"] = SeparatedNPCs:WaitForChild("Specials"),
		["e"] = SeparatedNPCs:WaitForChild("Enemies"),
		["bag"] = workspace.Level:WaitForChild("GroundBags"),
		["item"] = workspace.Level:WaitForChild("GroundItems"),
	}
	
	local Actors = workspace.Level.Actors
	
	RunService.RenderStepped:Connect(function()
		localPlayer.MaximumSimulationRadius = 5000
		sethiddenproperty(localPlayer,"SimulationRadius", 2500)
		if Actors:FindFirstChildOfClass("Model") then
			for _, currentNPC in pairs(Actors:GetChildren()) do
				if currentNPC.ClassName == "Model" then
					NPCSortFunction(currentNPC)
				end
			end
		end
	end)
	
	Actors.ChildAdded:Connect(function(currentNPC) task.spawn(NPCSortFunction, currentNPC) end)
end




local function getPlayer()	
	local playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	playerCharacter:WaitForChild("Humanoid")
	playerCharacter:WaitForChild("HumanoidRootPart")
	return playerCharacter
end

local function npcNoclip(NPC)
	if NPC.Character:FindFirstChild("Spot") then NPC.Character.Spot:Destroy() end
	for _, part in pairs(NPC:GetDescendants()) do
		if part:IsA("BasePart") then part.CanCollide = false end
	end
end

local function tpNpc(NPC, tpPos)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("HumanoidRootPart") then
		local NPCHumanoidRootPart = NPC.Character.HumanoidRootPart
		
		npcNoclip(NPC)
		
		for _, BodyForce in pairs({"Hold", "Turn", "BodyPosition"}) do
			if NPCHumanoidRootPart:FindFirstChild(BodyForce) then
				NPCHumanoidRootPart:FindFirstChild(BodyForce):Destroy()
			end
		end
		
		if not NPCHumanoidRootPart:FindFirstChild("MyForceInstance") then
			local ForceInstance = Instance.new("BodyPosition", NPCHumanoidRootPart)
			ForceInstance.Name = "MyForceInstance"
			ForceInstance.P = 1000000
			ForceInstance.MaxForce = Vector3.new(2500000, 2500000, 2500000)
		end
		
		NPCHumanoidRootPart.MyForceInstance.Position = tpPos
	end
end

local function tpObject(Object, tpPos)
	if Object:FindFirstChild("Base") and Object.Base.Anchored == false then
		if not Object.Base:FindFirstChild("MyForceInstance") then
			local ForceInstance = Instance.new("BodyPosition", Object.Base)
			ForceInstance.Name = "MyForceInstance"
			ForceInstance.P = 1000000
			ForceInstance.MaxForce = Vector3.new(2500000, 2500000, 2500000)
		end
		Object.Base.MyForceInstance.Position = tpPos
	end
end

local function NPCRayCast()
	local ray = Ray.new(playerMouse.UnitRay.Origin, playerMouse.UnitRay.Direction * 1000)
	local IntersectionPart = workspace:FindPartOnRayWithWhitelist(ray, {workspace.Level.Actors.SeparatedNPCS})
	if IntersectionPart then return IntersectionPart.Parent.Parent end
	return
end

local loopwalkFunc = nil
local loopjumpFunc = nil
local noclipFunc = nil
local infjumpFunc = nil
local killauraFunc = nil
local loopitemFunc = nil
local loopbagFunc = nil
local stoploudFunc = nil
local removeshieldsFunc = nil
local opendoorsFunc = nil
local speedupbagsFunc = nil
local npcinteractionFunc = nil

_G.PlayerNoclip = false
_G.InfJump = false
_G.InfAmmo = false
_G.KillAura = false
_G.LoopItem = false
_G.LoopBag = false
_G.StopLoud = false
_G.RemoveShields = false
_G.OpenDoors = false
_G.SpeedUpBags = false
_G.NpcInteraction = false
_G.ESP = false

local function objectsESP() -- esp
	_G.ESP = not _G.ESP
	
	for _, group in pairs(game.Workspace.Level.Actors.SeparatedNPCS:GetChildren()) do
		group.Highlight.Enabled = _G.ESP
	end
end

local function loopWalkSpeed(args) -- loopwalk
	local playerCharacter = getPlayer()
	local playerHumanoid = playerCharacter.Humanoid
	if loopwalkFunc then loopwalkFunc:Disconnect() end
	if args then	
		playerHumanoid.WalkSpeed = args[1]
		loopwalkFunc = playerHumanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			playerHumanoid.WalkSpeed = args[1]
		end)
	else
		playerHumanoid.WalkSpeed = 16
	end
end

local function loopJumpPower(args) -- loopjump
	local playerCharacter = getPlayer()
	local playerHumanoid = playerCharacter.Humanoid
	if loopjumpFunc then loopjumpFunc:Disconnect() end
	if args then
		playerHumanoid.UseJumpPower = true playerHumanoid.JumpPower = args[1]
		loopjumpFunc = playerHumanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
			playerHumanoid.JumpPower = args[1]
		end)
	else
		playerHumanoid.JumpPower = 50
	end
end

local function playerNoclip() -- noclip
	local playerCharacter = getPlayer()
	_G.PlayerNoclip = not _G.PlayerNoclip
	
	if _G.PlayerNoclip then
		noclipFunc = RunService.RenderStepped:Connect(function()
			for _, playerPart in pairs(playerCharacter:GetChildren()) do
				if playerPart.ClassName == "Part" or playerPart == "MeshPart" and playerPart.CanCollide == true then
					playerPart.CanCollide = false
				end
			end
		end)
	else
		noclipFunc:Disconnect()
		for _, playerPart in pairs(playerCharacter:GetChildren()) do
			if playerPart.Name == "Torso" or playerPart.Name == "UpperTorso" then
				playerPart.CanCollide = true
			end
		end
	end
end

local function playerInifniteJump() -- infjump
	local playerCharacter = getPlayer()
	local playerHumanoid = playerCharacter.Humanoid
	_G.InfJump = not _G.InfJump

	if _G.InfJump then
		infjumpFunc = UserInputService.InputBegan:Connect(function(UserInput)
			if UserInput.KeyCode == Enum.KeyCode.Space and UserInputService:GetFocusedTextBox() == nil then
				while UserInputService:IsKeyDown(Enum.KeyCode.Space) and RunService.RenderStepped:Wait() do
					playerHumanoid:ChangeState("Jumping")
				end
			end
		end)
	else
		infjumpFunc:Disconnect()
	end
end

local function infiniteAmmo() -- infammo
	local playerCharacter = getPlayer()
	local playerAmmo = localPlayer.Status.Ammo:GetChildren()
	_G.InfAmmo = not _G.InfAmmo
	while _G.InfAmmo and RunService.RenderStepped:Wait() do
		for _, ammoType in pairs(playerAmmo) do
			if ammoType.Value ~= 500 then ammoType.Value = 500 end
		end
	end
end

local function resetCharacter() -- reset
	local playerCharacter = localPlayer.Character or nil
	if playerCharacter == nil then
		playerCharacter.ChildAdded:Wait()
		task.wait(3)
	end
	playerCharacter:WaitForChild("Humanoid").Health = -1
end

local function killNpc(NPC)
	local npcCharacter = NPC.Character
	if npcCharacter:FindFirstChild("Humanoid") then
		npcCharacter.Humanoid.Health = -1
	end
	if npcCharacter:FindFirstChild("Head") and npcCharacter.Head:FindFirstChild("Neck") then
		npcCharacter.Head.Neck:Destroy()
	end
	if npcCharacter:FindFirstChild("HumanoidRootPart") and npcCharacter.HumanoidRootPart:FindFirstChild("MyForceInstance") then
		npcCharacter.HumanoidRootPart.MyForceInstance:Destroy()
	end
end

local function killGroup(args) -- kill
	print("Packed:", args, "Unpacked:", unpack(args))
	for _, npcGroup in pairs(args) do
		if Groups[npcGroup] then
			for _, npc in pairs(Groups[npcGroup]:GetChildren()) do
				if npc.Name ~= "Highlight" then killNpc(npc) end
			end
		end
	end
end

local function killAura() -- killaura
	_G.KillAura = not _G.KillAura
	
	if _G.KillAura then
		killauraFunc = RunService.RenderStepped:Connect(function()
			local args = {[1] = "c", [2] = "w", [3] = "g", [4] = "s", [5] = "e"}
			killGroup(args)
		end)
	else
		killauraFunc:Disconnect()
	end
end

local function bringGroup(args) -- bring
	for _, Group in pairs(args) do
		if Groups[Group] then
			local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
			if Group == "bag" or Group == "item" then
				for _, Object in pairs(Groups[Group]:GetChildren()) do
					tpObject(Object, playerHumanoidRootPart.Position + Vector3.new(0, -1, 0))
				end
			else
				for _, npc in pairs(Groups[Group]:GetChildren()) do
					tpNpc(npc, playerHumanoidRootPart.Position)
				end
			end
		end
	end
end

local function hideGroup(args) -- hide
	for _, Group in pairs(args) do
		if Groups[Group] then
			for _, npc in pairs(Groups[Group]:GetChildren()) do
				tpNpc(npc, currentMissionInfo[game.PlaceId].Spot)
			end
		end
	end
end

local function voidGroup(args) -- void
	for _, Group in pairs(args) do
		if Groups[Group] then
			for _, npc in pairs(Groups[Group]:GetChildren()) do
				tpNpc(npc, Vector3.new(0,-450,0))
			end
		end
	end
end

local function loopbringItems() -- loopitem
	local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
	_G.LoopItem = not _G.LoopItem
	
	if _G.LoopItem then
		loopitemFunc = RunService.RenderStepped:Connect(function()
			for _, item in pairs(Groups["item"]:GetChildren()) do
				tpObject(item, playerHumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		end)
	else
		loopitemFunc:Disconnect()
		for _, item in pairs(Groups["item"]:GetChildren()) do
			if item.Base:FindFirstChild("MyForceInstance") then
				item.Base.MyForceInstance:Destroy()
			end
		end
	end
end

local function loopbringBags()
	local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
	_G.LoopBag = not _G.LoopBag

	if _G.LoopBag then
		loopbagFunc = RunService.RenderStepped:Connect(function()
			for _, item in pairs(Groups["bag"]:GetChildren()) do
				tpObject(item, playerHumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		end)
	else
		loopbagFunc:Disconnect()
		for _, item in pairs(Groups["bag"]:GetChildren()) do
			if item.Base:FindFirstChild("MyForceInstance") then
				item.Base.MyForceInstance:Destroy()
			end
		end
	end
end

local function killClosest() -- forcekill
	local NPC = NPCRayCast()
	if NPC then killNpc(NPC) end
end

local function bringClosest() -- forcebring 
	local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
	local NPC = NPCRayCast()
	if NPC then tpNpc(NPC, playerHumanoidRootPart.Position) end
end

local function hideClosest() -- forcehide
	local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
	local NPC = NPCRayCast()
	if NPC then tpNpc(NPC, currentMissionInfo[game.PlaceId].Spot) end
end

local function voidClosest() -- forcevoid
	local playerHumanoidRootPart = getPlayer():WaitForChild("HumanoidRootPart")
	local NPC = NPCRayCast()
	if NPC then tpNpc(NPC, Vector3.new(0,-450,0)) end
end

local function startGame() -- startgame
	ReplicatedStorage.Lobby.Trig.StartGame:FireServer()
end

local function leaveLobby() -- leavelobby
	ReplicatedStorage.Lobby.Trig.LeaveLobby:FireServer()
end

local function stopLoud()
	_G.StopLoud = not _G.StopLoud
	
	if _G.StopLoud then
		stoploudFunc = RunService.RenderStepped:Connect(function()
			for _, enemy in pairs(Groups["e"]:GetChildren()) do
				tpNpc(enemy, Vector3.new(2500000,2500000,2500000))
			end
		end)
	else
		stoploudFunc:Disconnect()
	end
end

local function noShields()
	_G.RemoveShields = not _G.RemoveShields

	if _G.RemoveShields then
		for _, enemy in pairs(Groups["e"]:GetChildren()) do
			if enemy:FindFirstChild("S97Shield") and enemy.S97Shield.FindFirstChild("BallisticShield") then
				enemy.S97Shield.BallisticShield:Destroy()
			end
		end
		removeshieldsFunc = Groups["e"].ChildAdded:Connect(function(enemy)
			if enemy:WaitForChild("S97Shield", 5) and enemy.S97Shield:WaitForChild("BallisticShield", 5) then
				enemy.S97Shield.BallisticShield:Destroy()
			end
		end)
	else
		removeshieldsFunc:Disconnect()
	end
end

local function noFlashbang() -- noflash
	getPlayer()
	for _, effect in pairs(workspace.Camera:GetChildren()) do
		if effect.Name == "Blur" then effect:Destroy() end
	end
	localPlayer.PlayerGui:WaitForChild("Weapons"):WaitForChild("WeaponGui"):WaitForChild("Flashbang").Visible = false
end

local function destroyBoss() -- killboss
	if game.PlaceId == 3590667014 or game.PlaceId == 4661507759 or game.PlaceId == 5862433299 then
		currentMissionInfo[game.PlaceId].KillBoss()
	end
end

local function autofarm() -- autofarm
	if game.PlaceId == 4518266946 then
		currentMissionInfo[game.PlaceId].Autofarm()
	end
end

local function difficultyRequest(args) -- diffrequest
	ReplicatedStorage.GameState.SetGameDifficulty:InvokeServer(tonumber(args[1]))
end

local function simulateShot(v, damage)
	local ohVector31 = v.HumanoidRootPart.Position -- game.Players.LocalPlayer.Character.HeadM
	local ohVector32 = v.HumanoidRootPart.Position -- 
	local ohVector33 = Vector3.new(0, 1, 0) -- HeadM LookVector
	local ohNumber4 = damage
	local ohNumber5 = 100
	local ohNumber6 = 100
	local ohNumber7 = 100
	local ohNumber8 = 100

	localPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(ohVector31, ohVector32, ohVector33, ohNumber4, ohNumber5, ohNumber6, ohNumber7, ohNumber8)
end

local function godMode(args) -- godMode
	local playerCharacter = getPlayer()

	if args[1] ~= nil then
		local target = game.workspace.Level.Players:FindFirstChild(args[1]).Character
		if target:FindFirstChild("HumanoidRootPart") then simulateShot(target, 0/0) end
	else
		for _, currentPlayer in pairs(game.workspace.Level.Players:GetChildren()) do
			if currentPlayer ~= playerCharacter then simulateShot(currentPlayer, 0/0) end
		end
	end
end

local function killOthers() -- killothers
	local playerCharacter = getPlayer()
	for _, currentPlayer in pairs(game.workspace.Level.Players:GetChildren()) do
		if currentPlayer ~= playerCharacter then simulateShot(currentPlayer, 0/0) end
	end
end

local function openDoors()
	_G.OpenDoors = not _G.Opendoors
	
	if _G.OpenDoors then
		if game.PlaceId == 3590667014 then
			local LakeHouseDoor = currentMissionInfo[3590667014].GetDoor()
			if LakeHouseDoor then LakeHouseDoor.Escape.Interact.Active.Value = true end
		elseif game.PlaceId == 2951213182 then
			local WithdrawalDoor = currentMissionInfo[2951213182].GetDoor()
			if WithdrawalDoor then WithdrawalDoor.OpenTrig.Interact.Active.Value = true end
		end

		opendoorsFunc = RunService.RenderStepped:Connect(function()
			for _, currentDoor in pairs(workspace.Level.Geometry.Doors:GetChildren()) do
				if currentDoor:FindFirstChild("Interact") and currentDoor.Interact:FindFirstChild("Opened") then
					currentDoor.Interact.Opened.Value = true
				end
			end
		end)
	end
end

local function speedUpBags()
	_G.SpeedUpBags = not _G.SpeedUpBags
	
	if _G.SpeedUpBags then
		if game.PlaceId == 3590667014 or game.PlaceId == 2951213182 or game.PlaceId == 5862433299 then
			speedupbagsFunc = RunService.RenderStepped:Connect(function()
				currentMissionInfo[game.PlaceId].SpeedUp()
			end)
		end
	else
		speedupbagsFunc:Disconnect()
	end
end

local function metalDetectors() -- metaldetectors
	local Level = game.Workspace.Level
	for _, v in pairs(Level.Glass:GetChildren()) do
		if v.Name == "MetalDetectorPart1" or v.Name == "MetalDetectorPart2" or v.Name == "MetalDetectorPart3" then
			v:Destroy()
		end
	end
	for _, v in pairs(Level.Triggers:GetChildren()) do
		if v.Name == "Detector" then
			v:Destroy()
		end
	end
end

local function allyImmunity() -- allyimmunity
	for _, ally in pairs(workspace.Level.SeparatedNPCS.Allies:GetChildren()) do
		if ally:FindFirstChild("Character") and ally.Character:FindFirstChild("Humanoid") and ally.Character:FindFirstChild("Interact") then
			ally.Character.Humanoid.Team:Destroy()
		end
	end
end

local function npcInteract()
	_G.NpcInteraction = not _G.NpcInteraction

	if _G.NpcInteraction then
		for GroupIndex, Group in pairs(Groups) do
			if GroupIndex ~= "item" and GroupIndex ~= "bag" then
				for npcIndex, npc in pairs(Group:GetChildren()) do
					if npc:FindFirstChild("Character") and npc.Character:FindFirstChild("Interact") and npc.Character.Interact:FindFirstChild("Active") then
						npc.Character.Interact.Active.Value = true
					end
				end
			end
		end
		npcinteractionFunc = SeparatedNPCs.DescendantAdded:Connect(function(child)
			if child.Parent.Parent == SeparatedNPCs and child:FindFirstChild("Character") and child.Character:FindFirstChild("Interact") and child.Character.Interact:FindFirstChild("Active")then
				child.Character.Interact.Active.Value = true
			end
		end)
	else
		npcinteractionFunc:Disconnect()
	end
end

local function uiVisible()
	getPlayer()
	local WeaponGUIHandler = localPlayer.PlayerGui:WaitForChild("Weapons")
	local WeaponGUI = WeaponGUIHandler:WaitForChild("WeaponGui")
	local Team = WeaponGUIHandler:WaitForChild("TeamGui"):WaitForChild("Team")
	
	WeaponGUI.MainPlayer.Visible = true
	WeaponGUI.Objectives.Visible = true
	WeaponGUI.CharModel.Visible = true
	WeaponGUI.Clock.TextTransparency = 0
	Team.Visible = true
	Team.TeamTracker.TeammateTemplate.Visible = true
	Team.TeamTracker.TeammateTemplate.Health.Visible = true
end

local function breakArms(args)
	if args[1] == "1" then
		localPlayer.PlayerGui.Animate.SetAnim:Fire("HipPosition", 1, tonumber(args[2]), 0.15)
	elseif args[1] == "2" then
		localPlayer.PlayerGui.Animate.SetWeight:Fire(tonumber(args[2]), 0.15)
	end
end

local function breakShoulders(args) -- breakshoulders
	localPlayer.PlayerGui.Animate.SetShoulders:Fire(tonumber(args[1]), 0.17)
end

local function breakBack(args) -- breakback
	localPlayer.PlayerGui.Animate.SetLean:Fire(tonumber(args[1]))
end

local function changeMusic(MusicType, Value, IsCustom, CustomSoundId)
	getPlayer()
	
	local Music = localPlayer.PlayerGui:WaitForChild("SpectateGui"):WaitForChild("Music")
	local StealthMusic = Music:WaitForChild("Stealth")
	local LoudMusic = Music:WaitForChild("Loud")

	if MusicType == "Stealth" then
		while StealthMusic.Playing == false do RunService.RenderStepped:Wait() end

		if IsCustom == false then StealthMusic.SoundId = MusicTable[Value]
		else StealthMusic.SoundId = "rbxassetid://"..CustomSoundId end

	elseif MusicType == "Loud" then
		while LoudMusic.Playing == false do RunService.RenderStepped:Wait() end

		if IsCustom == false then LoudMusic.SoundId = MusicTable[Value]
		else LoudMusic.SoundId = "rbxassetid://"..CustomSoundId end
	end
end

local function objectiveAssist()
	if game.PlaceId == 2797881676 or game.PlaceId == 2625195454 then
		currentMissionInfo[game.PlaceId].Assistance()
	end
end

local function AddHighlight(Group, Color)
	if not Group:FindFirstChild("Highlight") then		
		local NewHighlight = Instance.new("Highlight", Group)
		NewHighlight.OutlineColor = (Color3.new(0,0,0))
		NewHighlight.OutlineTransparency = 0.5
		NewHighlight.Adornee = Group
		NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		NewHighlight.FillColor = Color
		NewHighlight.Enabled = false
	end
end

HelpCommands = {
	["help"] = {Tip = "help: Shows the list of commands", Command = plc},
	["esp"] = {Tip = "esp: turn on / off npcs, cams and objects ESP", Command = objectsESP},
	["hotkeys"] = {Tip = "hotkeys: Opens GUI that allows you to change the current hotkeys", Command = plc},
	["loopwalk"] = {Tip = "loopwalk \"number\": Changes player's walkspeed", Command = loopWalkSpeed},
	["loopjump"] = {Tip = "loopjump \"number\": Changes player's jumppower", Command = loopJumpPower},
	["noclip"] = {Tip = "noclip: Disables character collision, allowing you to pass through objects", Command = playerNoclip},
	["infjump"] = {Tip = "infjump: Allows you to jump on the air", Command = playerInifniteJump}, 
	["infammo"] = {Tip = "infammo: The number of bullets for all weapons (except Thumper) will always be 500", Command = infiniteAmmo},
	["reset"] = {Tip = "reset: Kills your character", Command = resetCharacter},
	["killaura"] = {Tip = "killaura: Kills all NPCs around you (depends on executor and network ownership)", Command = killAura},
	["free"] = {Tip = "free: Manually stops all operations on NPCs, weapons, items and bags", Command = plc},
	["kill"] = {Tip = "kill \"NPCType\": Kills all NPCs of the selected type", Command = killGroup},
	["bring"] = {Tip = "bring \"NPCType\" | items | weapons | bags\": Brings selected object(s) to the character", Command = bringGroup},
	["hide"] = {Tip = "hide \"NPCType\": Teleports the selected NPC group to a place they cant get out of", Command = hideGroup},
	["void"] = {Tip = "void \"NPCType\": Throws the selected NPC group to the void", Command = voidGroup},
	["forcekill"] = {Tip = "forcekill: Kills NPC in front of you", Command = killClosest},
	["forcebring"] = {Tip = "forcebring: Brings NPC in front of you", Command = bringClosest},
	["forcehide"] = {Tip = "forcehide: Hides NPC in front of you", Command = hideClosest},
	["forcevoid"] = {Tip = "forcevoid: Throws NPC in front of you to the void", Command = voidClosest},
	["loopbag"] = {Tip = "loopbag: Teleports the bags to the character each rendered frame", Command = loopbringBags},
	["loopitem"] = {Tip = "loopitem: Teleports the items and weapons to the character each rendered frame", Command = loopbringItems},
	["lobby"] = {Tip = "lobby: Opens a GUI that allows you to create impossible lobbies", Command = plc},
	["startgame"] = {Tip = "startgame: Starts the game in the lobby youre in (you should be the creator of the lobby)", Command = plc},
	["leavelobby"] = {Tip = "leavelobby: Disconnects you from the lobby youre in", Command = plc},
	["loud"] = {Tip = "loud: disables enemies spawn (depends on executor and network ownership)", Command = stopLoud},
	["noshield"] = {Tip = "removeshields: Removes enemies shields", Command = noShields},
	["noflash"] = {Tip = "noflash: Кemoves blindness from flashbangs", Command = noFlashbang},
	["killboss"] = {Tip = "killboss: Instantly destroys the gunship or SWAT van (depends on mission)", Command = destroyBoss},
	["autofarm"] = {Tip = "autofarm: Automatically complete the mission (stealth, legend difficulty only). Only 4 missions are currently available: The Deposit, The Lakehouse, The Scientist, Black Dusk.\n\nRequirements for missions:\n\nThe Deposit - Infiltrator, Silent Drill\nBlack Dusk - Empty Inventory\n\nDont use any functions before autofarm in a current run\n\n Dont Move Camera or Press Any Buttons During Autofarm", Command = autofarm},
	["teleport"] = {Tip = "teleport: Opens the GUI that allows you to teleport to the mission, cutscene or the place of the game. if you have teleported to the mission, then after the teleportation you need to use the command difficultyrequest", Command = plc},
	["diffrequest"] = {Tip = "difficultyrequest: Sends a request to set the mission difficulty if you have teleported to the mission or created a lobby with difficulty 0", Command = plc},
	["godmode"] = {Tip = "godmode: Makes other players immune to any type of damage. Players with godmode shouldnt use medkits, otherwise they will lose the immunity", Command = godMode},
	["killothers"] = {Tip = "killothers: Instantly kills other players", Command = killOthers},
	["opendoors"] = {Tip = "opendoors: Allows you to open most locked doors", Command = openDoors},
	["metaldetectors"] = {Tip = "metaldetectors: Allows you to pass through with weapons", Command = metalDetectors},
	["allyimmunity"] = {Tip = "allyimmunityoff: Makes allied NPCs vulnerable to damage", Command = allyImmunity},
	["npcinteract"] = {Tip = "npcinteract: Allows you to lay npc on the ground without the hostage taking", Command = npcInteract},
	["uivisible"] = {Tip = "uivisible: Makes player UI visible in the challenges", Command = uiVisible},
	["breakarms"] = {Tip = "breakarms \"force\": Breaks your arms (you should hold the weapon)", Command = breakArms},
	["breakshoulders"] = {Tip = "breakshoulders \"force\": Breaks your shoulders (you should hold the weapon)", Command = breakShoulders},
	["breakback"] = {Tip = "breakback \"force\": Breaks your back (you should hold the weapon)", Command = breakBack},
	["disablecam"] = {Tip = "disablecam: Throws all camera operators to the void (they wont die, but they wont be able to watch the cameras)", Command = plc},
	["hitbox"] = {Tip = "hitbox: Expands hitbox of all npc", Command = plc},
	["nofog"] = {Tip = "nofog: Removes the fog", Command = plc},
	--["telekinesis"] = "telekinesis: Allows you to move npc",
	--["wallhack"] = "wallhack: Allows you to shoot through walls while aiming",
	["music"] = {Tip = "music: Opens the GUI that allows you to change stealth and loud music of the mission", Command = plc},
	["speedbag"] = {Tip = "speedbag: Allows you to pickup some bags instantly", Command = speedUpBags},
	["print"] = {Tip = "DEBUG", Command = printMsg},
}
