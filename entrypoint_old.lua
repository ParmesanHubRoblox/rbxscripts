loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()

local MainHolder = {}

------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- MAIN GUI ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------






----------------------------------------------------------- MAIN GUI VARIABLES -----------------------------------------------------

local viewport = workspace.CurrentCamera.ViewportSize

local WALKSPEED = nil
local JUMPPOWER = nil




------------------------------------------------------------- MAIN GUI TABLES -------------------------------------------------------

local objectsHighlights = {}

local HelpCommands = {
	["help"] = "help: Shows the list of commands",
	["esp"] = "esp: turn on / off npcs, cams and objects ESP",
	["itemesp"] = "itemesp: turn on / off items ESP",
	["hotkeys"] = "hotkeys: Opens GUI that allows you to change the current hotkeys",
	["loopwalk"] = "loopwalk \"number\": Changes player's walkspeed",
	["loopjump"] = "loopjump \"number\": Changes player's jumppower",
	["noclip"] = "noclip: Disables character collision, allowing you to pass through objects",
	["infjump"] = "infjump: Allows you to jump on the air", 
	["infammo"] = "infammo: The number of bullets for all weapons (except Thumper) will always be 500",
	["reset"] = "reset: Kills your character",
	["killaura"] = "killaura: Kills all NPCs around you (depends on executor and network ownership)",
	["free"] = "free: Manually stops all operations on NPCs, weapons, items and bags",
	["kill"] = "kill \"NPCType\": Kills all NPCs of the selected type",
	["bring"] = "bring \"NPCType\" | items | weapons | bags\": Brings selected object(s) to the character",
	["hide"] = "hide \"NPCType\": Teleports the selected NPC group to a place they cant get out of",
	["void"] = "void \"NPCType\": Throws the selected NPC group to the void",
	["forcekill"] = "forcekill: Kills NPC in front of you",
	["forcebring"] = "forcebring: Brings NPC in front of you",
	["forcehide"] = "forcehide: Hides NPC in front of you",
	["forcevoid"] = "forcevoid: Throws NPC in front of you to the void",
	["loopbag"] = "loopbag: Teleports the bags to the character each rendered frame",
	["loopitem"] = "loopitem: Teleports the items and weapons to the character each rendered frame",
	["lobby"] = "lobby: Opens a GUI that allows you to create impossible lobbies",
	["startgame"] = "startgame: Starts the game in the lobby youre in (you should be the creator of the lobby)",
	["leavelobby"] = "leavelobby: Disconnects you from the lobby youre in",
	["loud"] = "loud: disables enemies spawn (depends on executor and network ownership)",
	["noshield"] = "removeshields: Removes enemies shields",
	["noflash"] = "noflash: Кemoves blindness from flashbangs",
	["killboss"] = "killboss: Instantly destroys the gunship or SWAT van (depends on mission)",
	["autofarm"] = "autofarm: Automatically complete the mission (stealth, legend difficulty only). Only 4 missions are currently available: The Deposit, The Lakehouse, The Scientist, Black Dusk.\n\nRequirements for missions:\n\nThe Deposit - Infiltrator, Silent Drill\nBlack Dusk - Empty Inventory\n\nDont use any functions before autofarm in a current run\n\n Dont Move Camera or Press Any Buttons During Autofarm",
	["teleport"] = "teleport: Opens the GUI that allows you to teleport to the mission, cutscene or the place of the game. if you have teleported to the mission, then after the teleportation you need to use the command difficultyrequest",
	["diffrequest"] = "difficultyrequest: Sends a request to set the mission difficulty if you have teleported to the mission or created a lobby with difficulty 0",
	["godmode"] = "godmode: Makes other players immune to any type of damage. Players with godmode shouldnt use medkits, otherwise they will lose the immunity",
	["killothers"] = "killothers: Instantly kills other players",
	["opendoors"] = "opendoors: Allows you to open most locked doors",
	["metaldetectors"] = "metaldetectors: Allows you to pass through with weapons",
	["allyimmunity"] = "allyimmunityoff: Makes allied NPCs vulnerable to damage",
	["npcinteract"] = "npcinteract: Allows you to lay npc on the ground without the hostage taking",
	["uivisible"] = "uivisible: Makes player UI visible in the challenges",
	["breakarms"] = "breakarms \"force\": Breaks your arms (you should hold the weapon)",
	["breakshoulders"] = "breakshoulders \"force\": Breaks your shoulders (you should hold the weapon)",
	["breakback"] = "breakback \"force\": Breaks your back (you should hold the weapon)",
	["disablecam"] = "disablecam: Throws all camera operators to the void (they wont die, but they wont be able to watch the cameras)",
	["hitbox"] = "hitbox: Expands hitbox of all npc",
	["nofog"] = "nofog: Removes the fog",
	--["telekinesis"] = "telekinesis: Allows you to move npc",
	--["wallhack"] = "wallhack: Allows you to shoot through walls while aiming",
	["music"] = "music: Opens the GUI that allows you to change stealth and loud music of the mission",
	["speedbag"] = "speedbag: Allows you to pickup some bags instantly"
}

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

local PlacesTable = {
	["StoryMissions"] = {
		["The Blacksite"] = 3200010305,
		["The Financier"] = 2797881676,
		["The Deposit"] = 2625195454,
		["The Lakehouse"] = 3590667014,
		["The Withdrawal"] = 2951213182,
		["The Scientist"] = 2951213182,
		["The SCRS"] = 4661507759,
		["The Black Dusk"] = 4768829954, 
	},

	["ExpansionMissions"] = {
		["The Auction"] = 4134003540,
		["The Gala"] = 3925577908,
		["The Cache"] = 4388762338,
		["The Setup"] = 5071816792,
		["The Lockup"] = 5188855685,
		["The Score"] = 5862433299,
	},

	["ExtraMissions"] = {
		["The Killhouse"] = 2215221144,
		["The Concept"] = 7799530284,
	},

	["StoryCutscenes"] = {
		["Black Dawn"] = 740584350,
		["Halcyon"] = 1789049984,
		["Rose"] = 2677301983,
		["Ashes"] = 4980299165,
		["Critical"] = 3217976952,
		["Dedication"] = 3637958652,
		["Retribution"] = 4582472402,
		["Payoff"] = 2957989822,
		["Jackdaw"] = 4980319824,
		["Epilogue"] = 4980337923,
		["Sunset"] = 4988643789,
	},

	["ExpansionCutscenes"] = {
		["Prelude"] = 5564290777,
		["Take"] = 6214650900,
		["Departure"] = 6214651226,
	},

	["Miscellaneous"] = {
		["Character Creation"] = 1169749759,
		["Shadow War"] = 2981901025,
		["PVP Elmination"] = 1169750464,
		["PVP Deathmatch"] = 2048182775,
		["Halcyon Range"] = 2652896498,
		["Ironman Final"] = 2500111229,
	},
}

local MissionNames = {"Ironman", "Mission", "Blacksite", "Financier", "Deposit", "Lakehouse", "Withdrawal", "Scientist", "SCRS", "Black Dusk", "Killhouse", "Lockup", "Score", "Auction", "Gala", "Cache"}

local AvalaibleHotkeys = {
	["O"] = "",
	["P"] = "",
	["K"] = "",
	["L"] = "",
	["N"] = "",
	["M"] = ""
}

local Library = {}



-------------------------------------------------------- MAIN GUI GLOBALS ----------------------------------------------------------

_G.ChangeWalkSpeed = false
_G.ChangeJumpPower = false



-------------------------------------------------------- MAIN GUI FUNCTIONS --------------------------------------------------------

local function TurnOnDraggable(GUI)
	--// Variables
	local UI = GUI
	local Hovered = false
	local Holding = false
	local MoveCon = nil
	local InitialX, InitialY, UIInitialPos
	--// Functions
	local function Drag()
		if Holding == false then MoveCon:Disconnect(); return end
		local distanceMovedX = InitialX - game:GetService("Players").LocalPlayer:GetMouse().X
		local distanceMovedY = InitialY - game:GetService("Players").LocalPlayer:GetMouse().Y

		UI.Position = UIInitialPos - UDim2.new(0, distanceMovedX, 0, distanceMovedY)
	end
	--// Connections
	UI.MouseEnter:Connect(function()
		Hovered = true
	end)
	UI.MouseLeave:Connect(function()
		Hovered = false
	end)
	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Holding = Hovered
			if Holding then
				InitialX, InitialY = game:GetService("Players").LocalPlayer:GetMouse().X, game:GetService("Players").LocalPlayer:GetMouse().Y
				UIInitialPos = UI.Position

				MoveCon = game:GetService("Players").LocalPlayer:GetMouse().Move:Connect(Drag)
			end
		end
	end)
	game:GetService("UserInputService").InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Holding = false
		end
	end)
end

function MainHolder:MainRender()
	-- StarterGui.Entry_Point_2
	MainHolder["1"] = Instance.new("ScreenGui", game:WaitForChild("CoreGui"));
	MainHolder["1"]["Enabled"] = true;
	MainHolder["1"]["Name"] = [[Entry_Point_2]];
	MainHolder["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

	-- StarterGui.Entry_Point_2.Main
	MainHolder["2"] = Instance.new("Frame", MainHolder["1"]);
	MainHolder["2"]["BorderSizePixel"] = 0;
	MainHolder["2"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
	MainHolder["2"]["BackgroundTransparency"] = 0.15000000596046448;
	MainHolder["2"]["Size"] = UDim2.new(0, 325, 0, 350);
	MainHolder["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["2"]["Position"] = UDim2.new(0, 925, 0, 70);
	MainHolder["2"]["Name"] = [[Main]];
	MainHolder["2"]["Visible"] = false

	-- StarterGui.Entry_Point_2.Main.UICorner
	MainHolder["3"] = Instance.new("UICorner", MainHolder["2"]);

	-- StarterGui.Entry_Point_2.Main.UICorner.Folder
	MainHolder["4"] = Instance.new("Folder", MainHolder["3"]);

	-- StarterGui.Entry_Point_2.Main.UICorner.Folder.root3
	MainHolder["5"] = Instance.new("TextLabel", MainHolder["4"]);
	MainHolder["5"]["BorderSizePixel"] = 0;
	MainHolder["5"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	MainHolder["5"]["TextSize"] = 12;
	MainHolder["5"]["TextColor3"] = Color3.fromRGB(255, 0, 0);
	MainHolder["5"]["Size"] = UDim2.new(0, 45, 0, 15);
	MainHolder["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["5"]["Text"] = [[root@kali:]];
	MainHolder["5"]["Name"] = [[root3]];
	MainHolder["5"]["BackgroundTransparency"] = 1;
	MainHolder["5"]["Position"] = UDim2.new(0, 0, 0, 300);

	-- StarterGui.Entry_Point_2.Main.FileName
	MainHolder["6"] = Instance.new("TextLabel", MainHolder["2"]);
	MainHolder["6"]["ZIndex"] = 2;
	MainHolder["6"]["BorderSizePixel"] = 0;
	MainHolder["6"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	MainHolder["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["6"]["TextSize"] = 12;
	MainHolder["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["6"]["Size"] = UDim2.new(1, 0, 0, 25);
	MainHolder["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["6"]["Text"] = [[root@kali:~parmesan-hub]];
	MainHolder["6"]["Name"] = [[FileName]];

	-- StarterGui.Entry_Point_2.Main.FileName.UICorner
	MainHolder["7"] = Instance.new("UICorner", MainHolder["6"]);

	-- StarterGui.Entry_Point_2.Main.FileName.Frame
	MainHolder["8"] = Instance.new("Frame", MainHolder["6"]);
	MainHolder["8"]["BorderSizePixel"] = 0;
	MainHolder["8"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	MainHolder["8"]["Size"] = UDim2.new(1, 0, 0, 25);
	MainHolder["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["8"]["Position"] = UDim2.new(0, 0, 0, 20);

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.UIListLayout
	MainHolder["9"] = Instance.new("UIListLayout", MainHolder["8"]);
	MainHolder["9"]["FillDirection"] = Enum.FillDirection.Horizontal;
	MainHolder["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.File
	MainHolder["a"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["a"]["LineHeight"] = 1.399999976158142;
	MainHolder["a"]["BorderSizePixel"] = 0;
	MainHolder["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["a"]["TextSize"] = 10;
	MainHolder["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["a"]["Size"] = UDim2.new(0, 40, 1, 0);
	MainHolder["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["a"]["Text"] = [[File]];
	MainHolder["a"]["Name"] = [[File]];
	MainHolder["a"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.Edit
	MainHolder["b"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["b"]["LineHeight"] = 1.399999976158142;
	MainHolder["b"]["BorderSizePixel"] = 0;
	MainHolder["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["b"]["TextSize"] = 10;
	MainHolder["b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["b"]["Size"] = UDim2.new(0, 30, 1, 0);
	MainHolder["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["b"]["Text"] = [[Edit]];
	MainHolder["b"]["Name"] = [[Edit]];
	MainHolder["b"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.View
	MainHolder["c"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["c"]["LineHeight"] = 1.399999976158142;
	MainHolder["c"]["BorderSizePixel"] = 0;
	MainHolder["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["c"]["TextSize"] = 10;
	MainHolder["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["c"]["Size"] = UDim2.new(0, 40, 1, 0);
	MainHolder["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["c"]["Text"] = [[View]];
	MainHolder["c"]["Name"] = [[View]];
	MainHolder["c"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.Search
	MainHolder["d"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["d"]["LineHeight"] = 1.399999976158142;
	MainHolder["d"]["BorderSizePixel"] = 0;
	MainHolder["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["d"]["TextSize"] = 10;
	MainHolder["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["d"]["Size"] = UDim2.new(0, 40, 1, 0);
	MainHolder["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["d"]["Text"] = [[Search]];
	MainHolder["d"]["Name"] = [[Search]];
	MainHolder["d"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.Terminal
	MainHolder["e"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["e"]["LineHeight"] = 1.399999976158142;
	MainHolder["e"]["BorderSizePixel"] = 0;
	MainHolder["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["e"]["TextSize"] = 10;
	MainHolder["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["e"]["Size"] = UDim2.new(0, 50, 1, 0);
	MainHolder["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["e"]["Text"] = [[Terminal]];
	MainHolder["e"]["Name"] = [[Terminal]];
	MainHolder["e"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.Help
	MainHolder["f"] = Instance.new("TextLabel", MainHolder["8"]);
	MainHolder["f"]["LineHeight"] = 1.399999976158142;
	MainHolder["f"]["BorderSizePixel"] = 0;
	MainHolder["f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["f"]["TextSize"] = 10;
	MainHolder["f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["f"]["Size"] = UDim2.new(0, 30, 1, 0);
	MainHolder["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["f"]["Text"] = [[Help]];
	MainHolder["f"]["Name"] = [[Help]];
	MainHolder["f"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Main.FileName.Frame.UIPadding
	MainHolder["10"] = Instance.new("UIPadding", MainHolder["8"]);
	MainHolder["10"]["PaddingTop"] = UDim.new(0, 5);

	-- StarterGui.Entry_Point_2.Main.FileName.minimize
	MainHolder["11"] = Instance.new("ImageLabel", MainHolder["6"]);
	MainHolder["11"]["BorderSizePixel"] = 0;
	MainHolder["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["11"]["ImageTransparency"] = 0.6299999952316284;
	MainHolder["11"]["Image"] = [[rbxassetid://15116175756]];
	MainHolder["11"]["Size"] = UDim2.new(0, 10, 0, 10);
	MainHolder["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["11"]["Name"] = [[minimize]];
	MainHolder["11"]["BackgroundTransparency"] = 1;
	MainHolder["11"]["Position"] = UDim2.new(0, 275, 0, 7);

	-- StarterGui.Entry_Point_2.Main.FileName.expand
	MainHolder["12"] = Instance.new("ImageLabel", MainHolder["6"]);
	MainHolder["12"]["BorderSizePixel"] = 0;
	MainHolder["12"]["ScaleType"] = Enum.ScaleType.Slice;
	MainHolder["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["12"]["Image"] = [[rbxassetid://15306952184]];
	MainHolder["12"]["Size"] = UDim2.new(0, 10, 0, 10);
	MainHolder["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["12"]["Name"] = [[expand]];
	MainHolder["12"]["BackgroundTransparency"] = 1;
	MainHolder["12"]["Position"] = UDim2.new(0, 290, 0, 7);

	-- StarterGui.Entry_Point_2.Main.FileName.close
	MainHolder["13"] = Instance.new("ImageLabel", MainHolder["6"]);
	MainHolder["13"]["BorderSizePixel"] = 0;
	MainHolder["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["13"]["Image"] = [[rbxassetid://15116174139]];
	MainHolder["13"]["Size"] = UDim2.new(0, 10, 0, 10);
	MainHolder["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["13"]["Name"] = [[close]];
	MainHolder["13"]["BackgroundTransparency"] = 1;
	MainHolder["13"]["Position"] = UDim2.new(0, 305, 0, 7);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder
	MainHolder["14"] = Instance.new("Frame", MainHolder["2"]);
	MainHolder["14"]["BorderSizePixel"] = 0;
	MainHolder["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["14"]["BackgroundTransparency"] = 1;
	MainHolder["14"]["Size"] = UDim2.new(1, 0, 0, 305);
	MainHolder["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["14"]["Position"] = UDim2.new(0, 0, 0, 45);
	MainHolder["14"]["Name"] = [[CommandsHolder]];

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame
	MainHolder["15"] = Instance.new("ScrollingFrame", MainHolder["14"]);
	MainHolder["15"]["Active"] = true;
	MainHolder["15"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
	MainHolder["15"]["BorderSizePixel"] = 0;
	MainHolder["15"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
	MainHolder["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["15"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
	MainHolder["15"]["BackgroundTransparency"] = 1;
	MainHolder["15"]["Size"] = UDim2.new(1, 0, 1, 0);
	MainHolder["15"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["15"]["ScrollBarThickness"] = 4;

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.UIPadding
	MainHolder["16"] = Instance.new("UIPadding", MainHolder["15"]);
	MainHolder["16"]["PaddingTop"] = UDim.new(0, 7);
	MainHolder["16"]["PaddingLeft"] = UDim.new(0, 7);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.UIListLayout
	MainHolder["17"] = Instance.new("UIListLayout", MainHolder["15"]);
	MainHolder["17"]["Padding"] = UDim.new(0, 2);
	MainHolder["17"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.1
	MainHolder["18"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["18"]["LineHeight"] = 1.2000000476837158;
	MainHolder["18"]["BorderSizePixel"] = 0;
	MainHolder["18"]["RichText"] = true;
	MainHolder["18"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["18"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["18"]["TextSize"] = 12;
	MainHolder["18"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["18"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["18"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["18"]["Text"] = [[<font color="#FF0000">root@kali:</font> ifconfig eth0 127.0.0.1 [-] all multi]];
	MainHolder["18"]["Name"] = [[1]];
	MainHolder["18"]["BackgroundTransparency"] = 1;


	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.2
	MainHolder["19"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["19"]["LineHeight"] = 1.2000000476837158;
	MainHolder["19"]["BorderSizePixel"] = 0;
	MainHolder["19"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["19"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["19"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["19"]["TextSize"] = 12;
	MainHolder["19"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["19"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["19"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["19"]["Text"] = [[          netmask 255.255.255.0 enps70 mtusize 9000]];
	MainHolder["19"]["Name"] = [[2]];
	MainHolder["19"]["BackgroundTransparency"] = 1;
	MainHolder["19"]["Position"] = UDim2.new(0, 0, 0, 61);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.3
	MainHolder["1a"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1a"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1a"]["BorderSizePixel"] = 0;
	MainHolder["1a"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1a"]["TextSize"] = 12;
	MainHolder["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1a"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1a"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1a"]["Text"] = [[enp7s0: flags = 4099 <UP, BROADCAST> mtu 9]];
	MainHolder["1a"]["Name"] = [[3]];
	MainHolder["1a"]["BackgroundTransparency"] = 1;
	MainHolder["1a"]["Position"] = UDim2.new(0, 0, 0, 80);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.4
	MainHolder["1b"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1b"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1b"]["BorderSizePixel"] = 0;
	MainHolder["1b"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1b"]["TextSize"] = 12;
	MainHolder["1b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1b"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1b"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1b"]["Text"] = [[                   ether 70:5a:0f:c2:37:b5 txqueuelen 1000]];
	MainHolder["1b"]["Name"] = [[4]];
	MainHolder["1b"]["BackgroundTransparency"] = 1;
	MainHolder["1b"]["Position"] = UDim2.new(0, 0, 0, 97);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.5
	MainHolder["1c"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1c"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1c"]["BorderSizePixel"] = 0;
	MainHolder["1c"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1c"]["TextSize"] = 12;
	MainHolder["1c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1c"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1c"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1c"]["Text"] = [[                   RX packets 516 bytes 1509312 (1.44 MB)]];
	MainHolder["1c"]["Name"] = [[5]];
	MainHolder["1c"]["BackgroundTransparency"] = 1;
	MainHolder["1c"]["Position"] = UDim2.new(0, 0, 0, 114);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.6
	MainHolder["1d"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1d"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1d"]["BorderSizePixel"] = 0;
	MainHolder["1d"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1d"]["TextSize"] = 12;
	MainHolder["1d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1d"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1d"]["Text"] = [[                   RX errors 0 dropped 0 overruns 0 frame 0]];
	MainHolder["1d"]["Name"] = [[6]];
	MainHolder["1d"]["BackgroundTransparency"] = 1;
	MainHolder["1d"]["Position"] = UDim2.new(0, 0, 0, 130);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.7
	MainHolder["1e"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1e"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1e"]["BorderSizePixel"] = 0;
	MainHolder["1e"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1e"]["TextSize"] = 12;
	MainHolder["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1e"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1e"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1e"]["Text"] = [[                   TX errors 2 dropped 2 overruns 10 carrier 0]];
	MainHolder["1e"]["Name"] = [[7]];
	MainHolder["1e"]["BackgroundTransparency"] = 1;
	MainHolder["1e"]["Position"] = UDim2.new(0, 0, 0, 146);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.8
	MainHolder["1f"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["1f"]["LineHeight"] = 1.2000000476837158;
	MainHolder["1f"]["BorderSizePixel"] = 0;
	MainHolder["1f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["1f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["1f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["1f"]["TextSize"] = 12;
	MainHolder["1f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["1f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["1f"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["1f"]["Text"] = [[root@kali: connect parm_hub ether 70:5a:0f:c2:37:b5 / /]];
	MainHolder["1f"]["Name"] = [[8]];
	MainHolder["1f"]["BackgroundTransparency"] = 1;
	MainHolder["1f"]["Position"] = UDim2.new(0, 0, 0, 164);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.9
	MainHolder["20"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["20"]["LineHeight"] = 1.2000000476837158;
	MainHolder["20"]["BorderSizePixel"] = 0;
	MainHolder["20"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["20"]["TextSize"] = 12;
	MainHolder["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["20"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["20"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["20"]["Text"] = [[connect: Enumerating objects: 54, done.]];
	MainHolder["20"]["Name"] = [[9]];
	MainHolder["20"]["BackgroundTransparency"] = 1;
	MainHolder["20"]["Position"] = UDim2.new(0, 0, 0, 180);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.10
	MainHolder["21"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["21"]["LineHeight"] = 1.2000000476837158;
	MainHolder["21"]["BorderSizePixel"] = 0;
	MainHolder["21"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["21"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["21"]["TextSize"] = 12;
	MainHolder["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["21"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["21"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["21"]["Text"] = [[connect: Compressing objects: 100% (54/54), done.]];
	MainHolder["21"]["Name"] = [[10]];
	MainHolder["21"]["BackgroundTransparency"] = 1;
	MainHolder["21"]["Position"] = UDim2.new(0, 0, 0, 196);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.11
	MainHolder["22"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["22"]["TextWrapped"] = true;
	MainHolder["22"]["LineHeight"] = 1.2000000476837158;
	MainHolder["22"]["BorderSizePixel"] = 0;
	MainHolder["22"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["22"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["22"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["22"]["TextSize"] = 12;
	MainHolder["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["22"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["22"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["22"]["Text"] = [[connect: Total 759 (delta 2), reused 0 (delta 0), pack-reused]];
	MainHolder["22"]["Name"] = [[11]];
	MainHolder["22"]["BackgroundTransparency"] = 1;
	MainHolder["22"]["Position"] = UDim2.new(0, 0, 0, 212);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.12
	MainHolder["23"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["23"]["LineHeight"] = 1.2000000476837158;
	MainHolder["23"]["BorderSizePixel"] = 0;
	MainHolder["23"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["23"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["23"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["23"]["TextSize"] = 12;
	MainHolder["23"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["23"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["23"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["23"]["Text"] = [[Unpacking objects: 100% (759/759), done.]];
	MainHolder["23"]["Name"] = [[12]];
	MainHolder["23"]["BackgroundTransparency"] = 1;
	MainHolder["23"]["Position"] = UDim2.new(0, 0, 0, 228);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.13
	MainHolder["24"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["24"]["LineHeight"] = 1.2000000476837158;
	MainHolder["24"]["BorderSizePixel"] = 0;
	MainHolder["24"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["24"]["TextSize"] = 12;
	MainHolder["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["24"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["24"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["24"]["Text"] = [[[Parmesan Hub]: Connection is establised (56.1 GB / sec)]];
	MainHolder["24"]["Name"] = [[13]];
	MainHolder["24"]["BackgroundTransparency"] = 1;
	MainHolder["24"]["Position"] = UDim2.new(0, 0, 0, 250);

	-- StarterGui.Entry_Point_2.Main.CommandsHolder.ScrollingFrame.14
	MainHolder["25"] = Instance.new("TextLabel", MainHolder["15"]);
	MainHolder["25"]["TextWrapped"] = true;
	MainHolder["25"]["LineHeight"] = 1.2000000476837158;
	MainHolder["25"]["BorderSizePixel"] = 0;
	MainHolder["25"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	MainHolder["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["25"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	MainHolder["25"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	MainHolder["25"]["TextSize"] = 12;
	MainHolder["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	MainHolder["25"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	MainHolder["25"]["Size"] = UDim2.new(0, 315, 0, 15);
	MainHolder["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	MainHolder["25"]["Text"] = [[[Parmesan Hub]: type help for a list of commands, hotkeys to change hotkeys for the commands.]];
	MainHolder["25"]["Name"] = [[14]];
	MainHolder["25"]["BackgroundTransparency"] = 1;
	MainHolder["25"]["Position"] = UDim2.new(0, 0, 0, 266);
end

MainHolder:MainRender()

function Ttween(object, goal, callback)
	local tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), goal)
	tween.Completed:Connect(callback or function() end)
	do tween:Play() end
end

local function addMessage(text)
	local message = Instance.new("TextLabel")
	message.Parent = MainHolder["15"]
	message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	message.BackgroundTransparency = 1.000
	message.BorderColor3 = Color3.fromRGB(0, 0, 0)
	message.BorderSizePixel = 0
	message.Size = UDim2.new(0, 315, 0, 15)
	message.Font = Enum.Font.Ubuntu
	message.LineHeight = 0.8
	message.RichText = true
	message.Text = text
	message.TextColor3 = Color3.fromRGB(255, 255, 255)
	message.TextSize = 12.000
	message.TextXAlignment = Enum.TextXAlignment.Left
	message.TextYAlignment = Enum.TextYAlignment.Top
end



function Library:Help()


	-- StarterGui.Entry_Point_2.Commands
	Library["2a"] = Instance.new("Frame", MainHolder["1"]);
	Library["2a"]["BorderSizePixel"] = 0;
	Library["2a"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
	Library["2a"]["BackgroundTransparency"] = 0.05000000074505806;
	Library["2a"]["Size"] = UDim2.new(0, 250, 0, 300);
	Library["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["2a"]["Position"] = UDim2.fromOffset((viewport.X / 2) - (250 / 2), (viewport.Y / 2) - (300 / 2));
	Library["2a"]["Name"] = [[Commands]];
	Library["2a"]["Visible"] = false

	TurnOnDraggable(Library["2a"])

	-- StarterGui.Entry_Point_2.Commands.FileName
	Library["2b"] = Instance.new("TextLabel", Library["2a"]);
	Library["2b"]["ZIndex"] = 2;
	Library["2b"]["BorderSizePixel"] = 0;
	Library["2b"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["2b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["2b"]["TextSize"] = 12;
	Library["2b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["2b"]["Size"] = UDim2.new(1, 0, 0, 25);
	Library["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["2b"]["Text"] = [[root@kali:~commands]];
	Library["2b"]["Name"] = [[FileName]];

	-- StarterGui.Entry_Point_2.Commands.FileName.UICorner
	Library["2c"] = Instance.new("UICorner", Library["2b"]);

	-- StarterGui.Entry_Point_2.Commands.FileName.Frame
	Library["30"] = Instance.new("Frame", Library["2b"]);
	Library["30"]["BorderSizePixel"] = 0;
	Library["30"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["30"]["Size"] = UDim2.new(1, 0, 0, 5);
	Library["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["30"]["Position"] = UDim2.new(0, 0, 0, 20);

	-- StarterGui.Entry_Point_2.Commands.UICorner
	Library["31"] = Instance.new("UICorner", Library["2a"]);


	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame
	Library["32"] = Instance.new("ScrollingFrame", Library["2a"]);
	Library["32"]["Active"] = true;
	Library["32"]["BorderSizePixel"] = 0;
	Library["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Library["32"]["BackgroundTransparency"] = 1;
	Library["32"]["Size"] = UDim2.new(1, 0, 0, 215);
	Library["32"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	Library["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["32"]["ScrollBarThickness"] = 0;
	Library["32"]["Position"] = UDim2.new(0, 0, 0, 25);
	Library["32"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.UIListLayout
	Library["33"] = Instance.new("UIListLayout", Library["32"]);
	Library["33"]["Padding"] = UDim.new(0, 7);
	Library["33"]["SortOrder"] = Enum.SortOrder.Name;

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.list
	Library["34"] = Instance.new("TextLabel", Library["32"]);
	Library["34"]["BorderSizePixel"] = 0;
	Library["34"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
	Library["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["34"]["TextSize"] = 14;
	Library["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["34"]["Size"] = UDim2.new(0, 230, 0, 25);
	Library["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["34"]["Text"] = [[List of the commands:]];
	Library["34"]["Name"] = [[aaaaa]];
	Library["34"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.list.UICorner
	Library["35"] = Instance.new("UICorner", Library["34"]);
	Library["35"]["CornerRadius"] = UDim.new(0, 2);

	-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.UIPadding
	Library["36"] = Instance.new("UIPadding", Library["32"]);
	Library["36"]["PaddingTop"] = UDim.new(0, 5);
	Library["36"]["PaddingLeft"] = UDim.new(0, 10);


	-- StarterGui.Entry_Point_2.Commands.description1
	Library["zb"] = Instance.new("ScrollingFrame", Library["2a"]);
	Library["zb"]["Active"] = true;
	Library["zb"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
	Library["zb"]["BorderSizePixel"] = 0;
	Library["zb"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
	Library["zb"]["BackgroundColor3"] = Color3.fromRGB(37, 41, 49);
	Library["zb"]["HorizontalScrollBarInset"] = Enum.ScrollBarInset.ScrollBar;
	Library["zb"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
	Library["zb"]["Size"] = UDim2.new(1, -20, 0, 50);
	Library["zb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["zb"]["ScrollBarThickness"] = 2;
	Library["zb"]["Position"] = UDim2.new(0, 10, 0, 260);
	Library["zb"]["Name"] = [[description1]];
	Library["zb"]["ZIndex"] = 2;

	-- StarterGui.Entry_Point_2.Commands.description1.UIStroke
	Library["zc"] = Instance.new("UIStroke", Library["zb"]);
	Library["zc"]["Color"] = Color3.fromRGB(24, 27, 32);
	Library["zc"]["Thickness"] = 1.100000023841858;
	Library["zc"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Entry_Point_2.Commands.description1.description
	Library["zd"] = Instance.new("TextLabel", Library["zb"]);
	Library["zd"]["TextWrapped"] = true;
	Library["zd"]["ZIndex"] = 2;
	Library["zd"]["BorderSizePixel"] = 0;
	Library["zd"]["RichText"] = true;
	Library["zd"]["TextYAlignment"] = Enum.TextYAlignment.Top;
	Library["zd"]["BackgroundColor3"] = Color3.fromRGB(37, 41, 49);
	Library["zd"]["TextXAlignment"] = Enum.TextXAlignment.Left;
	Library["zd"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["zd"]["TextSize"] = 12;
	Library["zd"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["zd"]["AutomaticSize"] = Enum.AutomaticSize.Y;
	Library["zd"]["Size"] = UDim2.new(1, 0, 0, 50);
	Library["zd"]["ClipsDescendants"] = true;
	Library["zd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["zd"]["Text"] = [[]];
	Library["zd"]["Name"] = [[description]];
	Library["zd"]["Position"] = UDim2.new(0, 10, 0, 260);

	-- StarterGui.Entry_Point_2.Commands.description1.UIPadding
	Library["ze"] = Instance.new("UIPadding", Library["zb"]);
	Library["ze"]["PaddingTop"] = UDim.new(0, 5);
	Library["ze"]["PaddingBottom"] = UDim.new(0, 1);
	Library["ze"]["PaddingLeft"] = UDim.new(0, 8);
	Library["ze"]["PaddingRight"] = UDim.new(0, 8);

	-- StarterGui.Entry_Point_2.Commands.description1.UIListLayout
	Library["zf"] = Instance.new("UIListLayout", Library["zb"]);
	Library["zf"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	function Library:AddTextButton(name, text)
		-- StarterGui.Entry_Point_2.Commands.ScrollingFrame.TextButton
		Library["37"] = Instance.new("TextButton", Library["32"]);
		Library["37"]["Name"] = name
		Library["37"]["BorderSizePixel"] = 0;
		Library["37"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		Library["37"]["TextSize"] = 13;
		Library["37"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["37"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["37"]["Size"] = UDim2.new(0, 230, 0, 25);
		Library["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["37"]["Text"] = name;

		Library["37"].MouseButton1Click:Connect(function()
			Library["zd"]["Text"] = text
		end)
	end

	for name, text in pairs(HelpCommands) do
		Library:AddTextButton(name, text)
	end

	-- StarterGui.Entry_Point_2.Commands.description.UIPadding
	Library["39"] = Instance.new("UIPadding", Library["38"]);
	Library["39"]["PaddingTop"] = UDim.new(0, 5);
	Library["39"]["PaddingRight"] = UDim.new(0, 10);
	Library["39"]["PaddingBottom"] = UDim.new(0, 1);
	Library["39"]["PaddingLeft"] = UDim.new(0, 10);

	-- StarterGui.Entry_Point_2.Commands.description.UIStroke
	Library["3a"] = Instance.new("UIStroke", Library["38"]);
	Library["3a"]["Color"] = Color3.fromRGB(24, 27, 32);
	Library["3a"]["Thickness"] = 1.100000023841858;
	Library["3a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

	-- StarterGui.Entry_Point_2.Commands.Frame
	Library["3b"] = Instance.new("Frame", Library["2a"]);
	Library["3b"]["ZIndex"] = 0;
	Library["3b"]["BorderSizePixel"] = 0;
	Library["3b"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["3b"]["Size"] = UDim2.new(1, 0, 0, 5);
	Library["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["3b"]["Position"] = UDim2.new(0, 0, 0, 250);

	-- StarterGui.Entry_Point_2.Commands.descriptionholder
	Library["3c"] = Instance.new("Frame", Library["2a"]);
	Library["3c"]["BorderSizePixel"] = 0;
	Library["3c"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["3c"]["Size"] = UDim2.new(1, 0, 0, 70);
	Library["3c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["3c"]["Position"] = UDim2.new(0, 0, 0, 250);
	Library["3c"]["Name"] = [[descriptionholder]];

	-- StarterGui.Entry_Point_2.Commands.descriptionholder.UICorner
	Library["3d"] = Instance.new("UICorner", Library["3c"]);
end

Library:Help()

function Library:lobbyMaster()
	local Toggle = {}

	local Char = game:GetService("Players").LocalPlayer.PlayerData.Character.Char1
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
		game:GetService("ReplicatedStorage").Lobby.Trig.CreateLobby:InvokeServer(Char, MissionName, LevelCap, FriendsOnly, Difficulty, LobbyImage, LobbySize, SpeedrunMode, SpeedrunSeed, DailyChallenge)
	end

	-- Render
	do
		-- StarterGui.Entry_Point_2.Library
		Library["53"] = Instance.new("Frame", MainHolder["1"]);
		Library["53"]["BorderSizePixel"] = 0;
		Library["53"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
		Library["53"]["BackgroundTransparency"] = 0.05000000074505806;
		Library["53"]["Size"] = UDim2.new(0, 250, 0, 300);
		Library["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["53"]["Position"] = UDim2.new(0, 500, 0, 100);
		Library["53"]["Name"] = [[Library]];
		Library["53"]["Visible"] = false

		TurnOnDraggable(Library["53"])

		-- StarterGui.Entry_Point_2.Library.FileName
		Library["54"] = Instance.new("TextLabel", Library["53"]);
		Library["54"]["ZIndex"] = 2;
		Library["54"]["BorderSizePixel"] = 0;
		Library["54"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
		Library["54"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["54"]["TextSize"] = 12;
		Library["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["54"]["Size"] = UDim2.new(1, 0, 0, 25);
		Library["54"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["54"]["Text"] = [[root@kali:~lobby-master]];
		Library["54"]["Name"] = [[FileName]];

		-- StarterGui.Entry_Point_2.Library.FileName.UICorner
		Library["55"] = Instance.new("UICorner", Library["54"]);


		-- StarterGui.Entry_Point_2.Library.FileName.Frame
		Library["56"] = Instance.new("Frame", Library["54"]);
		Library["56"]["BorderSizePixel"] = 0;
		Library["56"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
		Library["56"]["Size"] = UDim2.new(1, 0, 0, 5);
		Library["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["56"]["Position"] = UDim2.new(0, 0, 0, 20);

		-- StarterGui.Entry_Point_2.Library.UICorner
		Library["57"] = Instance.new("UICorner", Library["53"]);


		-- StarterGui.Entry_Point_2.Library.ScrollingFrame
		Library["58"] = Instance.new("ScrollingFrame", Library["53"]);
		Library["58"]["Active"] = true;
		Library["58"]["BorderSizePixel"] = 0;
		Library["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		Library["58"]["BackgroundTransparency"] = 1;
		Library["58"]["Size"] = UDim2.new(1, 0, 0, 275);
		Library["58"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		Library["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["58"]["ScrollBarThickness"] = 3;
		Library["58"]["Position"] = UDim2.new(0, 0, 0, 25);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.list
		Library["59"] = Instance.new("TextLabel", Library["58"]);
		Library["59"]["BorderSizePixel"] = 0;
		Library["59"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		Library["59"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["59"]["TextSize"] = 14;
		Library["59"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["59"]["Size"] = UDim2.new(0, 230, 0, 25);
		Library["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["59"]["Text"] = [[Create the Lobby]];
		Library["59"]["Name"] = [[list]];
		Library["59"]["BackgroundTransparency"] = 1;

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.list.UICorner
		Library["5a"] = Instance.new("UICorner", Library["59"]);
		Library["5a"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.UIPadding
		Library["5b"] = Instance.new("UIPadding", Library["58"]);
		Library["5b"]["PaddingTop"] = UDim.new(0, 5);
		Library["5b"]["PaddingLeft"] = UDim.new(0, 10);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.UIListLayout
		Library["5c"] = Instance.new("UIListLayout", Library["58"]);
		Library["5c"]["Padding"] = UDim.new(0, 7);
		Library["5c"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.Entry_Point_2.LobbyMaster.uicornercloser
		Library["9e"] = Instance.new("Frame", Library["53"]);
		Library["9e"]["ZIndex"] = 0;
		Library["9e"]["BorderSizePixel"] = 0;
		Library["9e"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
		Library["9e"]["Size"] = UDim2.new(1, 0, 0, 5);
		Library["9e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["9e"]["Position"] = UDim2.new(0, 0, 0, 270);
		Library["9e"]["Name"] = [[uicornercloser]];

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder
		Library["9f"] = Instance.new("Frame", Library["53"]);
		Library["9f"]["BorderSizePixel"] = 0;
		Library["9f"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
		Library["9f"]["Size"] = UDim2.new(1, 0, 0, 90);
		Library["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["9f"]["Position"] = UDim2.new(0, 0, 0, 270);
		Library["9f"]["Name"] = [[createButtonHolder]];

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.UICorner
		Library["a0"] = Instance.new("UICorner", Library["9f"]);


		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"]);
		Library["a1"]["BorderSizePixel"] = 0;
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172);
		Library["a1"]["TextSize"] = 12;
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20);
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["a1"]["Text"] = [[Create the Lobby]];
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 10);

		Library["a1"].Activated:Connect(function()
			CreateLobby()
		end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"]);
		Library["a2"]["CornerRadius"] = UDim.new(0, 4);

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"]);
		Library["a1"]["BorderSizePixel"] = 0;
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172);
		Library["a1"]["TextSize"] = 12;
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20);
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["a1"]["Text"] = [[Leave the Lobby]];
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 35);

		Library["a1"].Activated:Connect(function()
			game:GetService("ReplicatedStorage").Lobby.Trig.LeaveLobby:FireServer()
		end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"]);
		Library["a2"]["CornerRadius"] = UDim.new(0, 4);

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton
		Library["a1"] = Instance.new("TextButton", Library["9f"]);
		Library["a1"]["BorderSizePixel"] = 0;
		Library["a1"]["BackgroundColor3"] = Color3.fromRGB(2, 106, 172);
		Library["a1"]["TextSize"] = 12;
		Library["a1"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["a1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["a1"]["Size"] = UDim2.new(0, 175, 0, 20);
		Library["a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["a1"]["Text"] = [[Start the Game]];
		Library["a1"]["Position"] = UDim2.new(0, 38, 0, 60);

		Library["a1"].Activated:Connect(function()
			game:GetService("ReplicatedStorage").Lobby.Trig.StartGame:FireServer()
		end)

		-- StarterGui.Entry_Point_2.LobbyMaster.createButtonHolder.TextButton.UICorner
		Library["a2"] = Instance.new("UICorner", Library["a1"]);
		Library["a2"]["CornerRadius"] = UDim.new(0, 4);

		function Library:AddTextbox(name, callback)

			local TextBox = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character
			TextBox["5d"] = Instance.new("Frame", Library["58"]);
			TextBox["5d"]["BorderSizePixel"] = 0;
			TextBox["5d"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
			TextBox["5d"]["Size"] = UDim2.new(0, 230, 0, 35);
			TextBox["5d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			TextBox["5d"]["Name"] = [[name]];

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextLabel
			TextBox["5e"] = Instance.new("TextLabel", TextBox["5d"]);
			TextBox["5e"]["TextWrapped"] = true;
			TextBox["5e"]["BorderSizePixel"] = 0;
			TextBox["5e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			TextBox["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			TextBox["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			TextBox["5e"]["TextSize"] = 12;
			TextBox["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			TextBox["5e"]["Size"] = UDim2.new(0, 100, 1, 0);
			TextBox["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			TextBox["5e"]["Text"] = name;
			TextBox["5e"]["BackgroundTransparency"] = 1;
			TextBox["5e"]["Position"] = UDim2.new(0, 10, 0, 0);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox
			TextBox["5f"] = Instance.new("TextBox", TextBox["5d"]);
			TextBox["5f"]["CursorPosition"] = -1;
			TextBox["5f"]["BorderSizePixel"] = 0;
			TextBox["5f"]["TextSize"] = 12;
			TextBox["5f"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
			TextBox["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			TextBox["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			TextBox["5f"]["PlaceholderText"] = [[number]];
			TextBox["5f"]["Size"] = UDim2.new(0, 50, 0, 20);
			TextBox["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			TextBox["5f"]["Text"] = [[]];
			TextBox["5f"]["Position"] = UDim2.new(0, 170, 0, 8);
			TextBox["5f"]["TextWrapped"] = true

			TextBox["5f"].FocusLost:Connect(function()
				callback(TextBox["5f"]["Text"])
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UICorner
			TextBox["60"] = Instance.new("UICorner", TextBox["5f"]);
			TextBox["60"]["CornerRadius"] = UDim.new(0, 2);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UIStroke
			TextBox["61"] = Instance.new("UIStroke", TextBox["5f"]);
			TextBox["61"]["Color"] = Color3.fromRGB(27, 27, 27);
			TextBox["61"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.UICorner
			TextBox["62"] = Instance.new("UICorner", TextBox["5d"]);
			TextBox["62"]["CornerRadius"] = UDim.new(0, 4);
		end

		function Library:AddMissionHolder()
			local Activated = false

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName
			Library["63"] = Instance.new("TextButton", Library["58"]);
			Library["63"]["BorderSizePixel"] = 0;
			Library["63"]["AutoButtonColor"] = false;
			Library["63"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Library["63"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			Library["63"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
			Library["63"]["TextSize"] = 12;
			Library["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Library["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Library["63"]["Size"] = UDim2.new(0, 230, 0, 35);
			Library["63"]["Name"] = [[MissionName]];
			Library["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Library["63"]["Text"] = [[Mission Name]];

			Library["63"].Activated:Connect(function()
				Activated = not Activated
				if Activated then
					Ttween(Library["63"], {Size = UDim2.new(0, 230, 0, 160)})
					Ttween(Library["asf"], {Rotation = 180})
					Library["66"]["Visible"] = true
				else
					Ttween(Library["asf"], {Rotation = 0})
					Ttween(Library["63"], {Size = UDim2.new(0, 230, 0, 35)})
					Library["66"]["Visible"] = false
				end
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UIPadding
			Library["64"] = Instance.new("UIPadding", Library["63"]);
			Library["64"]["PaddingTop"] = UDim.new(0, 11);
			Library["64"]["PaddingLeft"] = UDim.new(0, 10);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UICorner
			Library["65"] = Instance.new("UICorner", Library["63"]);
			Library["65"]["CornerRadius"] = UDim.new(0, 4);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame
			Library["66"] = Instance.new("ScrollingFrame", Library["63"]);
			Library["66"]["Active"] = true;
			Library["66"]["BorderSizePixel"] = 0;
			Library["66"]["CanvasPosition"] = Vector2.new(0, 140);
			Library["66"]["BackgroundColor3"] = Color3.fromRGB(30, 34, 40);
			Library["66"]["Size"] = UDim2.new(0, 210, 0, 120);
			Library["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Library["66"]["ScrollBarThickness"] = 2;
			Library["66"]["Position"] = UDim2.new(0, 0, 0, 20);
			Library["66"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
			Library["66"]["Visible"] = false

			-- StarterGui.Entry_Point_2.LobbyMaster.ScrollingFrame.MissionName.ScrollingFrame.ScreenGui.ImageLabel
			Library["asf"] = Instance.new("ImageLabel", Library["63"]);
			Library["asf"]["BorderSizePixel"] = 0;
			Library["asf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Library["asf"]["Image"] = [[rbxassetid://15114393414]];
			Library["asf"]["Size"] = UDim2.new(0, 15, 0, 15);
			Library["asf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Library["asf"]["BackgroundTransparency"] = 1;
			Library["asf"]["Position"] = UDim2.new(0, 190, 0, -2);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIListLayout
			Library["67"] = Instance.new("UIListLayout", Library["66"]);
			Library["67"]["Padding"] = UDim.new(0, 5);
			Library["67"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIPadding
			Library["6b"] = Instance.new("UIPadding", Library["66"]);
			Library["6b"]["PaddingTop"] = UDim.new(0, 6);
			Library["6b"]["PaddingLeft"] = UDim.new(0, 3);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ChosenMission
			Library["6c"] = Instance.new("TextLabel", Library["63"]);
			Library["6c"]["BorderSizePixel"] = 0;
			Library["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Library["6c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Library["6c"]["TextSize"] = 11;
			Library["6c"]["TextColor3"] = Color3.fromRGB(181, 181, 181);
			Library["6c"]["Size"] = UDim2.new(0, 40, 0, 20);
			Library["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Library["6c"]["Text"] = [[. . .]];
			Library["6c"]["Name"] = [[ChosenMission]];
			Library["6c"]["BackgroundTransparency"] = 1;
			Library["6c"]["Position"] = UDim2.new(0, 140, 0, -4);
		end

		function Library:AddMission(name, callback)
			local Mission = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton
			Mission["68"] = Instance.new("TextButton", Library["66"]);
			Mission["68"]["BorderSizePixel"] = 0;
			Mission["68"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51);
			Mission["68"]["TextSize"] = 12;
			Mission["68"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Mission["68"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Mission["68"]["Size"] = UDim2.new(0, 200, 0, 25);
			Mission["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Mission["68"]["Text"] = name;

			Mission["68"].Activated:Connect(function()
				callback()
				Library["6c"]["Text"] = name
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UIStroke
			Mission["69"] = Instance.new("UIStroke", Mission["68"]);
			Mission["69"]["Color"] = Color3.fromRGB(26, 26, 26);
			Mission["69"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UICorner
			Mission["6a"] = Instance.new("UICorner", Mission["68"]);
			Mission["6a"]["CornerRadius"] = UDim.new(0, 3);
		end

		function Library:AddCheckbox(name, callback)
			local Checkbox = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly
			Checkbox["73"] = Instance.new("Frame", Library["58"]);
			Checkbox["73"]["BorderSizePixel"] = 0;
			Checkbox["73"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
			Checkbox["73"]["Size"] = UDim2.new(0, 230, 0, 35);
			Checkbox["73"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Checkbox["73"]["Name"] = [[FriendsOnly]];

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.TextLabel
			Checkbox["74"] = Instance.new("TextLabel", Checkbox["73"]);
			Checkbox["74"]["BorderSizePixel"] = 0;
			Checkbox["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Checkbox["74"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Checkbox["74"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Checkbox["74"]["TextSize"] = 12;
			Checkbox["74"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Checkbox["74"]["Size"] = UDim2.new(0, 40, 1, 0);
			Checkbox["74"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Checkbox["74"]["Text"] = name;
			Checkbox["74"]["BackgroundTransparency"] = 1;
			Checkbox["74"]["Position"] = UDim2.new(0, 10, 0, 0);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.UICorner
			Checkbox["75"] = Instance.new("UICorner", Checkbox["73"]);
			Checkbox["75"]["CornerRadius"] = UDim.new(0, 4);

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame
			Checkbox["76"] = Instance.new("TextButton", Checkbox["73"]);
			Checkbox["76"]["BorderSizePixel"] = 0;
			Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51);
			Checkbox["76"]["Size"] = UDim2.new(0, 20, 0, 20);
			Checkbox["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Checkbox["76"]["Position"] = UDim2.new(0, 200, 0, 8);
			Checkbox["76"]["TextTransparency"] = 1

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.UIStroke

			Checkbox["lol"] = Instance.new("UIStroke", Checkbox["76"])
			Checkbox["lol"]["Color"] = Color3.fromRGB(26,26,26)
			Checkbox["lol"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.ImageLabel
			Checkbox["77"] = Instance.new("ImageLabel", Checkbox["76"]);
			Checkbox["77"]["BorderSizePixel"] = 0;
			Checkbox["77"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Checkbox["77"]["Image"] = [[rbxassetid://15114786962]];
			Checkbox["77"]["Size"] = UDim2.new(1, -5, 1, -5);
			Checkbox["77"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Checkbox["77"]["BackgroundTransparency"] = 1;
			Checkbox["77"]["Position"] = UDim2.new(0, 3, 0, 3);
			Checkbox["77"]["ImageTransparency"] = 1

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.FriendsOnly.Frame.UICorner
			Checkbox["78"] = Instance.new("UICorner", Checkbox["76"]);
			Checkbox["78"]["CornerRadius"] = UDim.new(0, 4);

			local Toggle = {
				Hover = false,
				MouseDown = false,
				State = false
			}

			function Checkbox:Toggle(callback)

				Toggle.State = not Toggle.State

				if Toggle.State then
					Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(1, 105, 171)
					Checkbox["77"]["ImageTransparency"] = 0;
				else
					Checkbox["76"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51)
					Checkbox["77"]["ImageTransparency"] = 1;
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

function Library:Music()

	local MusicHolder = {}

	-- StarterGui.Entry_Point_2.Music
	Library["a8"] = Instance.new("Frame", MainHolder["1"]);
	Library["a8"]["BorderSizePixel"] = 0;
	Library["a8"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
	Library["a8"]["BackgroundTransparency"] = 0.05000000074505806;
	Library["a8"]["Size"] = UDim2.new(0, 250, 0, 300);
	Library["a8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["a8"]["Position"] = UDim2.new(0, 500, 0, 100);
	Library["a8"]["Name"] = [[Music]];
	Library["a8"]["Visible"] = false

	TurnOnDraggable(Library["a8"])

	-- StarterGui.Entry_Point_2.Music.FileName
	Library["a9"] = Instance.new("TextLabel", Library["a8"]);
	Library["a9"]["ZIndex"] = 2;
	Library["a9"]["BorderSizePixel"] = 0;
	Library["a9"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["a9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["a9"]["TextSize"] = 12;
	Library["a9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["a9"]["Size"] = UDim2.new(1, 0, 0, 25);
	Library["a9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["a9"]["Text"] = [[root@kali:~music.elf]];
	Library["a9"]["Name"] = [[FileName]];

	-- StarterGui.Entry_Point_2.Music.FileName.UICorner
	Library["aa"] = Instance.new("UICorner", Library["a9"]);


	-- StarterGui.Entry_Point_2.Music.FileName.Frame
	Library["ab"] = Instance.new("Frame", Library["a9"]);
	Library["ab"]["BorderSizePixel"] = 0;
	Library["ab"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["ab"]["Size"] = UDim2.new(1, 0, 0, 5);
	Library["ab"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ab"]["Position"] = UDim2.new(0, 0, 0, 20);

	-- StarterGui.Entry_Point_2.Music.UICorner
	Library["ac"] = Instance.new("UICorner", Library["a8"]);


	-- StarterGui.Entry_Point_2.Music.ScrollingFrame
	Library["ad"] = Instance.new("ScrollingFrame", Library["a8"]);
	Library["ad"]["Active"] = true;
	Library["ad"]["BorderSizePixel"] = 0;
	Library["ad"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Library["ad"]["BackgroundTransparency"] = 1;
	Library["ad"]["Size"] = UDim2.new(1, 0, 0, 275);
	Library["ad"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ad"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ad"]["ScrollBarThickness"] = 3;
	Library["ad"]["Position"] = UDim2.new(0, 0, 0, 25);
	Library["ad"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
	-- StarterGui.Entry_Point_2.Music.ScrollingFrame.UIListLayout
	Library["ae"] = Instance.new("UIListLayout", Library["ad"]);
	Library["ae"]["Padding"] = UDim.new(0, 7);
	Library["ae"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	function MusicHolder:CreateSection(name)
		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.hotkeys
		Library["af"] = Instance.new("TextLabel", Library["ad"]);
		Library["af"]["BorderSizePixel"] = 0;
		Library["af"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		Library["af"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Library["af"]["TextSize"] = 14;
		Library["af"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Library["af"]["Size"] = UDim2.new(0, 230, 0, 25);
		Library["af"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Library["af"]["Text"] = name;
		Library["af"]["Name"] = [[hotkeys]];
		Library["af"]["BackgroundTransparency"] = 1;

		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.hotkeys.UICorner
		Library["b0"] = Instance.new("UICorner", Library["af"]);
		Library["b0"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.UIPadding
		Library["b1"] = Instance.new("UIPadding", Library["ad"]);
		Library["b1"]["PaddingTop"] = UDim.new(0, 5);
		Library["b1"]["PaddingLeft"] = UDim.new(0, 10);
	end

	function MusicHolder:CreateDropdown(name)
		local Dropdown = {}

		local Activated = false

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName
		Dropdown["63"] = Instance.new("TextButton", Library["ad"]);
		Dropdown["63"]["BorderSizePixel"] = 0;
		Dropdown["63"]["AutoButtonColor"] = false;
		Dropdown["63"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		Dropdown["63"]["TextYAlignment"] = Enum.TextYAlignment.Top;
		Dropdown["63"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		Dropdown["63"]["TextSize"] = 12;
		Dropdown["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Dropdown["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Dropdown["63"]["Size"] = UDim2.new(0, 230, 0, 35);
		Dropdown["63"]["Name"] = [[MissionName]];
		Dropdown["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["63"]["Text"] = name;

		Dropdown["63"].Activated:Connect(function()
			Activated = not Activated
			if Activated then
				Ttween(Dropdown["63"], {Size = UDim2.new(0, 230, 0, 160)})
				Ttween(Dropdown["asf"], {Rotation = 180})
				Dropdown["66"]["Visible"] = true
			else
				Ttween(Dropdown["asf"], {Rotation = 0})
				Ttween(Dropdown["63"], {Size = UDim2.new(0, 230, 0, 35)})
				Dropdown["66"]["Visible"] = false
			end
		end)

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UIPadding
		Dropdown["64"] = Instance.new("UIPadding", Dropdown["63"]);
		Dropdown["64"]["PaddingTop"] = UDim.new(0, 11);
		Dropdown["64"]["PaddingLeft"] = UDim.new(0, 10);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UICorner
		Dropdown["65"] = Instance.new("UICorner", Dropdown["63"]);
		Dropdown["65"]["CornerRadius"] = UDim.new(0, 4);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame
		Dropdown["66"] = Instance.new("ScrollingFrame", Dropdown["63"]);
		Dropdown["66"]["Active"] = true;
		Dropdown["66"]["BorderSizePixel"] = 0;
		Dropdown["66"]["CanvasPosition"] = Vector2.new(0, 140);
		Dropdown["66"]["BackgroundColor3"] = Color3.fromRGB(30, 34, 40);
		Dropdown["66"]["Size"] = UDim2.new(0, 210, 0, 120);
		Dropdown["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["66"]["ScrollBarThickness"] = 2;
		Dropdown["66"]["Position"] = UDim2.new(0, 0, 0, 20);
		Dropdown["66"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
		Dropdown["66"]["Visible"] = false

		-- StarterGui.Entry_Point_2.LobbyMaster.ScrollingFrame.MissionName.ScrollingFrame.ScreenGui.ImageLabel
		Dropdown["asf"] = Instance.new("ImageLabel", Dropdown["63"]);
		Dropdown["asf"]["BorderSizePixel"] = 0;
		Dropdown["asf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		Dropdown["asf"]["Image"] = [[rbxassetid://15114393414]];
		Dropdown["asf"]["Size"] = UDim2.new(0, 15, 0, 15);
		Dropdown["asf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["asf"]["BackgroundTransparency"] = 1;
		Dropdown["asf"]["Position"] = UDim2.new(0, 190, 0, -2);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIListLayout
		Dropdown["67"] = Instance.new("UIListLayout", Dropdown["66"]);
		Dropdown["67"]["Padding"] = UDim.new(0, 5);
		Dropdown["67"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIPadding
		Dropdown["6b"] = Instance.new("UIPadding", Dropdown["66"]);
		Dropdown["6b"]["PaddingTop"] = UDim.new(0, 6);
		Dropdown["6b"]["PaddingLeft"] = UDim.new(0, 3);

		function MusicHolder:AddMusicOption(name, callback)
			local MusicOption = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton
			MusicOption["68"] = Instance.new("TextButton", Dropdown["66"]);
			MusicOption["68"]["BorderSizePixel"] = 0;
			MusicOption["68"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51);
			MusicOption["68"]["TextSize"] = 12;
			MusicOption["68"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			MusicOption["68"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			MusicOption["68"]["Size"] = UDim2.new(0, 200, 0, 25);
			MusicOption["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			MusicOption["68"]["Text"] = name;

			MusicOption["68"].Activated:Connect(function()
				callback(name)
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UIStroke
			MusicOption["69"] = Instance.new("UIStroke", MusicOption["68"]);
			MusicOption["69"]["Color"] = Color3.fromRGB(26, 26, 26);
			MusicOption["69"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UICorner
			MusicOption["6a"] = Instance.new("UICorner", MusicOption["68"]);
			MusicOption["6a"]["CornerRadius"] = UDim.new(0, 3);
		end
	end

	function MusicHolder:CreateTextBox(name, callback)
		local TextBox = {}
		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character
		TextBox["5d"] = Instance.new("Frame", Library["ad"]);
		TextBox["5d"]["BorderSizePixel"] = 0;
		TextBox["5d"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		TextBox["5d"]["Size"] = UDim2.new(0, 230, 0, 35);
		TextBox["5d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		TextBox["5d"]["Name"] = [[name]];

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextLabel
		TextBox["5e"] = Instance.new("TextLabel", TextBox["5d"]);
		TextBox["5e"]["TextWrapped"] = true;
		TextBox["5e"]["BorderSizePixel"] = 0;
		TextBox["5e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		TextBox["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		TextBox["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		TextBox["5e"]["TextSize"] = 12;
		TextBox["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		TextBox["5e"]["Size"] = UDim2.new(0, 100, 1, 0);
		TextBox["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		TextBox["5e"]["Text"] = name;
		TextBox["5e"]["BackgroundTransparency"] = 1;
		TextBox["5e"]["Position"] = UDim2.new(0, 10, 0, 0);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox
		TextBox["5f"] = Instance.new("TextBox", TextBox["5d"]);
		TextBox["5f"]["CursorPosition"] = -1;
		TextBox["5f"]["BorderSizePixel"] = 0;
		TextBox["5f"]["TextSize"] = 12;
		TextBox["5f"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
		TextBox["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		TextBox["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		TextBox["5f"]["PlaceholderText"] = [[ID]];
		TextBox["5f"]["Size"] = UDim2.new(0, 50, 0, 20);
		TextBox["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		TextBox["5f"]["Text"] = [[]];
		TextBox["5f"]["Position"] = UDim2.new(0, 170, 0, 8);
		TextBox["5f"]["TextWrapped"] = true

		TextBox["5f"].FocusLost:Connect(function()
			callback(TextBox["5f"]["Text"])
		end)

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UICorner
		TextBox["60"] = Instance.new("UICorner", TextBox["5f"]);
		TextBox["60"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.TextBox.UIStroke
		TextBox["61"] = Instance.new("UIStroke", TextBox["5f"]);
		TextBox["61"]["Color"] = Color3.fromRGB(27, 27, 27);
		TextBox["61"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.Character.UICorner
		TextBox["62"] = Instance.new("UICorner", TextBox["5d"]);
		TextBox["62"]["CornerRadius"] = UDim.new(0, 4);
	end

	MusicHolder:CreateSection("Change the Stealth Music to:")

	MusicHolder:CreateDropdown("Stealth Soundtracks")

	local Music = nil
	spawn(function() Music = game.Players.LocalPlayer.PlayerGui:WaitForChild("SpectateGui"):WaitForChild("Music") end)

	for MusicName, MusicId in pairs(MusicTable.StealthSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			Music:WaitForChild("Stealth").SoundId = MusicTable.StealthSoundtracks[name]
			--print(name, MusicTable.StealthSoundtracks[name])
		end)
	end

	MusicHolder:CreateDropdown("Loud Soundtracks")

	for MusicName, MusicId in pairs(MusicTable.LoudSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--	print(name, MusicTable.LoudSoundtracks[name])
			Music:WaitForChild("Stealth").SoundId = MusicTable.LoudSoundtracks[name]
		end)
	end

	MusicHolder:CreateDropdown("Alternate Loud Soundtracks")
	for MusicName, MusicId in pairs(MusicTable.AlternateSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.AlternateSoundtracks[name])
			Music:WaitForChild("Stealth").SoundId = MusicTable.AlternateSoundtracks[name]
		end)
	end

	MusicHolder:CreateDropdown("Removed Soundtracks")

	for MusicName, MusicId in pairs(MusicTable.RemovedSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.RemovedSoundtracks[name])
			Music:WaitForChild("Stealth").SoundId = MusicTable.RemovedSoundtracks[name]
		end)
	end


	MusicHolder:CreateTextBox("Custom Soundtrack", function(Value)
		Music:WaitForChild("Stealth").SoundId = "rbxassetid://"..Value
	end)

	MusicHolder:CreateSection("Change the Loud Music to:")

	MusicHolder:CreateDropdown("Stealth Soundtracks")

	for MusicName, MusicId in pairs(MusicTable.StealthSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.StealthSoundtracks[name])
			Music:WaitForChild("Loud").SoundId = MusicTable.StealthSoundtracks[name]
		end)
	end

	MusicHolder:CreateDropdown("Loud Soundtracks")

	for MusicName, MusicId in pairs(MusicTable.LoudSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.LoudSoundtracks[name])
			Music:WaitForChild("Loud").SoundId = MusicTable.LoudSoundtracks[name]
		end)
	end

	MusicHolder:CreateDropdown("Alternate Loud Soundtracks")
	for MusicName, MusicId in pairs(MusicTable.AlternateSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.AlternateSoundtracks[name])
			Music:WaitForChild("Loud").SoundId = MusicTable.AlternateSoundtracks[name]
		end)
	end

	MusicHolder:CreateDropdown("Removed Soundtracks")

	for MusicName, MusicId in pairs(MusicTable.RemovedSoundtracks) do
		MusicHolder:AddMusicOption(MusicName, function(name)
			--print(name, MusicTable.RemovedSoundtracks[name])
			Music:WaitForChild("Loud").SoundId = MusicTable.RemovedSoundtracks[name]
		end)
	end


	MusicHolder:CreateTextBox("Custom Soundtrack", function(Value)
		Music:WaitForChild("Loud").SoundId = "rbxassetid://"..Value
	end)

end

Library:Music()

function Library:Teleport()
	local TeleportHolder = {}

	-- StarterGui.Entry_Point_2.Teleport
	Library["ea"] = Instance.new("Frame", MainHolder["1"]);
	Library["ea"]["BorderSizePixel"] = 0;
	Library["ea"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
	Library["ea"]["BackgroundTransparency"] = 0.05000000074505806;
	Library["ea"]["Size"] = UDim2.new(0, 250, 0, 300);
	Library["ea"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ea"]["Position"] = UDim2.new(0, 500, 0, 100);
	Library["ea"]["Name"] = [[Teleport]];
	Library["ea"]["Visible"] = false

	TurnOnDraggable(Library["ea"])

	-- StarterGui.Entry_Point_2.Teleport.FileName
	Library["eb"] = Instance.new("TextLabel", Library["ea"]);
	Library["eb"]["ZIndex"] = 2;
	Library["eb"]["BorderSizePixel"] = 0;
	Library["eb"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["eb"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["eb"]["TextSize"] = 12;
	Library["eb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["eb"]["Size"] = UDim2.new(1, 0, 0, 25);
	Library["eb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["eb"]["Text"] = [[root@kali:~teleport]];
	Library["eb"]["Name"] = [[FileName]];

	-- StarterGui.Entry_Point_2.Teleport.FileName.UICorner
	Library["ec"] = Instance.new("UICorner", Library["eb"]);


	-- StarterGui.Entry_Point_2.Teleport.FileName.Frame
	Library["ed"] = Instance.new("Frame", Library["eb"]);
	Library["ed"]["BorderSizePixel"] = 0;
	Library["ed"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["ed"]["Size"] = UDim2.new(1, 0, 0, 5);
	Library["ed"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ed"]["Position"] = UDim2.new(0, 0, 0, 20);

	-- StarterGui.Entry_Point_2.Teleport.UICorner
	Library["ee"] = Instance.new("UICorner", Library["ea"]);


	-- StarterGui.Entry_Point_2.Teleport.ScrollingFrame
	Library["ef"] = Instance.new("ScrollingFrame", Library["ea"]);
	Library["ef"]["Active"] = true;
	Library["ef"]["BorderSizePixel"] = 0;
	Library["ef"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Library["ef"]["BackgroundTransparency"] = 1;
	Library["ef"]["Size"] = UDim2.new(1, 0, 0, 275);
	Library["ef"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ef"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["ef"]["ScrollBarThickness"] = 3;
	Library["ef"]["Position"] = UDim2.new(0, 0, 0, 25);

	-- StarterGui.Entry_Point_2.Teleport.ScrollingFrame.UIListLayout
	Library["f0"] = Instance.new("UIListLayout", Library["ef"]);
	Library["f0"]["Padding"] = UDim.new(0, 7);
	Library["f0"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

	-- StarterGui.Entry_Point_2.Teleport.ScrollingFrame.UIPadding
	Library["f1"] = Instance.new("UIPadding", Library["ef"]);
	Library["f1"]["PaddingTop"] = UDim.new(0, 5)
	Library["f1"]["PaddingLeft"] = UDim.new(0, 10)

	function TeleportHolder:CreateSection(name)
		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.hotkeys
		TeleportHolder["af"] = Instance.new("TextLabel", Library["ef"]);
		TeleportHolder["af"]["BorderSizePixel"] = 0;
		TeleportHolder["af"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		TeleportHolder["af"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		TeleportHolder["af"]["TextSize"] = 14;
		TeleportHolder["af"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		TeleportHolder["af"]["Size"] = UDim2.new(0, 230, 0, 25);
		TeleportHolder["af"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		TeleportHolder["af"]["Text"] = name;
		TeleportHolder["af"]["Name"] = [[hotkeys]];
		TeleportHolder["af"]["BackgroundTransparency"] = 1;

		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.hotkeys.UICorner
		TeleportHolder["b0"] = Instance.new("UICorner", TeleportHolder["af"]);
		TeleportHolder["b0"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Music.ScrollingFrame.UIPadding
		TeleportHolder["b1"] = Instance.new("UIPadding", TeleportHolder["ad"]);
		TeleportHolder["b1"]["PaddingTop"] = UDim.new(0, 5);
		TeleportHolder["b1"]["PaddingLeft"] = UDim.new(0, 10);
	end

	function TeleportHolder:CreateDropdown(name)
		local Dropdown = {}

		local Activated = false

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName
		Dropdown["63"] = Instance.new("TextButton", Library["ef"]);
		Dropdown["63"]["BorderSizePixel"] = 0;
		Dropdown["63"]["AutoButtonColor"] = false;
		Dropdown["63"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		Dropdown["63"]["TextYAlignment"] = Enum.TextYAlignment.Top;
		Dropdown["63"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
		Dropdown["63"]["TextSize"] = 12;
		Dropdown["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Dropdown["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Dropdown["63"]["Size"] = UDim2.new(0, 230, 0, 35);
		Dropdown["63"]["Name"] = [[MissionName]];
		Dropdown["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["63"]["Text"] = name;

		Dropdown["63"].Activated:Connect(function()
			Activated = not Activated
			if Activated then
				Ttween(Dropdown["63"], {Size = UDim2.new(0, 230, 0, 160)})
				Ttween(Dropdown["asf"], {Rotation = 180})
				task.wait(0.2)
				Dropdown["66"]["Visible"] = true
			else
				Dropdown["66"]["Visible"] = false
				Ttween(Dropdown["asf"], {Rotation = 0})
				Ttween(Dropdown["63"], {Size = UDim2.new(0, 230, 0, 35)})
			end
		end)

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UIPadding
		Dropdown["64"] = Instance.new("UIPadding", Dropdown["63"]);
		Dropdown["64"]["PaddingTop"] = UDim.new(0, 11);
		Dropdown["64"]["PaddingLeft"] = UDim.new(0, 10);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.UICorner
		Dropdown["65"] = Instance.new("UICorner", Dropdown["63"]);
		Dropdown["65"]["CornerRadius"] = UDim.new(0, 4);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame
		Dropdown["66"] = Instance.new("ScrollingFrame", Dropdown["63"]);
		Dropdown["66"]["Active"] = true;
		Dropdown["66"]["BorderSizePixel"] = 0;
		Dropdown["66"]["CanvasPosition"] = Vector2.new(0, 140);
		Dropdown["66"]["BackgroundColor3"] = Color3.fromRGB(30, 34, 40);
		Dropdown["66"]["Size"] = UDim2.new(0, 210, 0, 120);
		Dropdown["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["66"]["ScrollBarThickness"] = 2;
		Dropdown["66"]["Position"] = UDim2.new(0, 0, 0, 20);
		Dropdown["66"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
		Dropdown["66"]["Visible"] = false

		-- StarterGui.Entry_Point_2.LobbyMaster.ScrollingFrame.MissionName.ScrollingFrame.ScreenGui.ImageLabel
		Dropdown["asf"] = Instance.new("ImageLabel", Dropdown["63"]);
		Dropdown["asf"]["BorderSizePixel"] = 0;
		Dropdown["asf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		Dropdown["asf"]["Image"] = [[rbxassetid://15114393414]];
		Dropdown["asf"]["Size"] = UDim2.new(0, 15, 0, 15);
		Dropdown["asf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Dropdown["asf"]["BackgroundTransparency"] = 1;
		Dropdown["asf"]["Position"] = UDim2.new(0, 190, 0, -2);

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIListLayout
		Dropdown["67"] = Instance.new("UIListLayout", Dropdown["66"]);
		Dropdown["67"]["Padding"] = UDim.new(0, 5);
		Dropdown["67"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.UIPadding
		Dropdown["6b"] = Instance.new("UIPadding", Dropdown["66"]);
		Dropdown["6b"]["PaddingTop"] = UDim.new(0, 6);
		Dropdown["6b"]["PaddingLeft"] = UDim.new(0, 3);

		function TeleportHolder:AddMusicOption(name, callback)
			local MusicOption = {}
			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton
			MusicOption["68"] = Instance.new("TextButton", Dropdown["66"]);
			MusicOption["68"]["BorderSizePixel"] = 0;
			MusicOption["68"]["BackgroundColor3"] = Color3.fromRGB(38, 42, 51);
			MusicOption["68"]["TextSize"] = 12;
			MusicOption["68"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			MusicOption["68"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			MusicOption["68"]["Size"] = UDim2.new(0, 200, 0, 25);
			MusicOption["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			MusicOption["68"]["Text"] = name;

			MusicOption["68"].Activated:Connect(function()
				callback(name)
			end)

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UIStroke
			MusicOption["69"] = Instance.new("UIStroke", MusicOption["68"]);
			MusicOption["69"]["Color"] = Color3.fromRGB(26, 26, 26);
			MusicOption["69"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

			-- StarterGui.Entry_Point_2.Library.ScrollingFrame.MissionName.ScrollingFrame.TextButton.UICorner
			MusicOption["6a"] = Instance.new("UICorner", MusicOption["68"]);
			MusicOption["6a"]["CornerRadius"] = UDim.new(0, 3);
		end
	end

	TeleportHolder:CreateSection("Story Missions")

	TeleportHolder:CreateDropdown("Teleport to the Story Mission")

	for PlaceName, PlaceId in pairs(PlacesTable.StoryMissions) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.StoryMissions[PlaceName])
		end)
	end

	TeleportHolder:CreateSection("Expansions Missions")

	TeleportHolder:CreateDropdown("Teleport to the Expansions Mission")

	for PlaceName, PlaceId in pairs(PlacesTable.ExpansionMissions) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.ExpansionMissions[PlaceName])
		end)
	end

	TeleportHolder:CreateSection("Extra Missions")

	TeleportHolder:CreateDropdown("Teleport to the Extra Mission")

	for PlaceName, PlaceId in pairs(PlacesTable.ExtraMissions) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.ExtraMissions[PlaceName])
		end)
	end

	TeleportHolder:CreateSection("Story Cutscenes")

	TeleportHolder:CreateDropdown("Teleport to the Story Cutscene")

	for PlaceName, PlaceId in pairs(PlacesTable.StoryCutscenes) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.StoryCutscenes[PlaceName])
		end)
	end

	TeleportHolder:CreateSection("Expansions Cutscenes")

	TeleportHolder:CreateDropdown("Teleport to the Expansions Cutscene")

	for PlaceName, PlaceId in pairs(PlacesTable.ExpansionCutscenes) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.ExpansionCutscenes[PlaceName])
		end)
	end

	TeleportHolder:CreateSection("Miscellaneous")

	TeleportHolder:CreateDropdown("Miscellaneous")

	for PlaceName, PlaceId in pairs(PlacesTable.Miscellaneous) do
		TeleportHolder:AddMusicOption(PlaceName, function(name)
			game:GetService("TeleportService"):Teleport(PlacesTable.Miscellaneous[PlaceName])
		end)
	end
end

Library:Teleport()

local function CreateTextBox()
	local test = Instance.new("TextLabel")

	test.Name = "test"
	test.Parent = MainHolder["15"]
	test.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	test.BackgroundTransparency = 1.000
	test.BorderColor3 = Color3.fromRGB(0, 0, 0)
	test.BorderSizePixel = 0
	test.Size = UDim2.new(0, 315, 0, 0)
	test.Font = Enum.Font.Ubuntu
	test.LineHeight = 1.200
	test.RichText = true
	test.Text = "<font color=\"#FF0000\">root@kali</font>: "
	test.TextColor3 = Color3.fromRGB(255, 255, 255)
	test.TextSize = 12.000
	test.TextXAlignment = Enum.TextXAlignment.Left
	test.TextYAlignment = Enum.TextYAlignment.Top

	local TextBox = Instance.new("TextBox")
	TextBox.Parent = MainHolder["15"]
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1.000
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Size = UDim2.new(0, 315, 0, 12)
	TextBox.ClearTextOnFocus = false
	TextBox.Font = Enum.Font.Ubuntu
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 12.000
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	TextBox.TextEditable = true

	local UIPadding_3 = Instance.new("UIPadding")

	UIPadding_3.Parent = TextBox
	UIPadding_3.PaddingBottom = UDim.new(0, 4)
	UIPadding_3.PaddingLeft = UDim.new(0, 55)

	return TextBox
end

local function addHelpOption(name, text)

end

local frame = MainHolder["2"]
local previousTextBox = nil
local listener = nil

------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------- SCRIPT FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------- GLOBALS ------------------------------------------------------------

_G.WalkSpeed = nil
_G.WalkSpeedToggle = false
_G.JumpPower = nil
_G.JumpPowerToggle = false
_G.Player = nil
_G.Noclip = false
_G.OpenDoors = false
_G.NpcESP = false
_G.CamsESP = false
_G.ItemsESP = false
_G.ObjectsESP = false
_G.RemoveShields = false
_G.KillAura = false
_G.InfJump = false
_G.InfAmmo = false
_G.StopSpawn = false
_G.SpeedUpInteract = false
_G.NpcInteract = false
_G.LoopBag = false
_G.LoopItem = false

_G.HideCivs = false
_G.HideWorkers = false
_G.HideGuards = false
_G.HideSpecial = false
_G.HideAllies = false

_G.ThrowCivs = false
_G.ThrowWorkers = false
_G.ThrowGuards = false
_G.ThrowSpecial = false
_G.ThrowAllies = false

_G.HideSpot = nil

_G.SpeedUp = false


----------------------------------------- TABLES -------------------------------------------



local groupMapping = {
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
		Spot = Vector3.new(-51.04850769042969, 14.899995803833008, -56.45438003540039)

	},
	[2625195454] = { -- deposit
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard"},
		Specials = {"Manager"},
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(165.1376190185547, 173.49996948242188, -160.21685791015625)
	},
	[3590667014] = { -- lakehouse
		Guards = {"Phoenix Operative"},
		Enemies = {"SC Soldier", "SC Shredder"},
		Spot = Vector3.new(21.38668441772461, 18.50002670288086, -32.37154006958008)
	},
	[2951213182] = { -- withdrawal
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard"},
		Specials = {"Manager"},
		Enemies = {"Police", "SWAT", "Aegis Unit"},
		Spot = Vector3.new(39.4105339050293, 3.4001095294952393, 113.61088562011719)
	},
	[4518266946] = { -- scientist
		Workers = {"Halcyon Operative"},
		Guards = {"Halcyon Operative"},
		Specials = {"Falcon"},
		Enemies = {"TRU", "Aegis Unit"},
		Allies = {"Rivera"},
		Spot = Vector3.new(-21.118181228637695, 3.500000476837158, -20.95203971862793)
	},
	[4661507759] = { -- SCRS
		Workers = {"Analyst", "Tech"},
		Guards = {"Security", "Janitor"},
		Specials = {"Agent Nightshade", "Agent Hemlock"},
		Enemies = {"ETF", "Aegis Unit"},
		Spot = Vector3.new(52.52033233642578, 15, 188.01849365234375)
	},
	[4768829954] = { -- Black Dusk
		Workers = {"Workshop Tech", "Programmer"},
		Guards = {"Base Security"},
		Specials = {"Elite Operative"},
		Enemies = {"Halcyon Operative", "Juggernaut"},
		Spot = Vector3.new(94.17521667480469, 21.497360229492188, 216.7227325439453)
	},
	[2215221144] = { -- Killhouse
		Guards = {"Guard"},
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(20.715, 7.23954, 62.0234)
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
		Spot = Vector3.new(-4.096112251281738, 7.500090599060059, -54.025657653808594)
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
		Spot = Vector3.new(2.96498, 3.48513, 90.5891)
	},
	[5862433299] = { -- Score
		Enemies = {"SWAT", "Aegis Unit"},
		Spot = Vector3.new(237.0268096923828, 16.700029373168945, 45.57285690307617)
	},
	[7799530284] = { -- Concept
		Civilians = {"Civilian"},
		Workers = {"Employee"},
		Guards = {"Guard", "Elite Guard"},
		Specials = {"Manager", "Manager's Assistant"},
		Spot = Vector3.new(46.8819, 5.31316, 5.74569)
	},
}

local GroupsAndColors = {
	["Civilians"] = Color3.new(0, 0, 0),
	["Workers"] = Color3.new(1,1,1),
	["Guards"] = Color3.new(1,0,0),
	["Specials"] = Color3.new(0,0,1),
	["Enemies"] = Color3.new(255,0,0),
	["Allies"] = Color3.new(255,171,0),
	["Cams"] = Color3.new(0,1,0),
	["Items"] = Color3.new(255,171,0),
	["Objects"] = Color3.new(255,255,255)
}

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

local BodyForces = {"Hold", "Turn", "BodyPosition"}
local BodyParts = {"LowerTorso", "UpperTorso", "Head", "HeadM", "HumanoidRootPart", "Spot", "Hat"}

if groupMapping[game.PlaceId] then
	_G.HideSpot = groupMapping[game.PlaceId].Spot
end

local LobbyData = {
	["Character"] = nil,
	["MissionName"] = "_Deposit",
	["LevelCap"] = 1,
	["FriendsOnly"] = false,
	["Difficulty"] = 1,
	["LobbyImage"] = 1,
	["LobbySize"] = 4,
	["SpeedrunMode"] = false,
	["SpeedrunSeed"] = 1,
	["DailyChallenge"] = false
}

----------------------------------------- FUNCTIONS -------------------------------------------



--------------------------------------- GAME FUNCTIONS ----------------------------------------

-- SORT FUNCTIONSf

local function EasySortFunction(NPC)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Interact") then
		local NPCName = NPC.Character.Interact.ObjectName.Value
		for NpcGroup, Names in pairs (groupMapping[game.PlaceId]) do
			if type(Names) == "table" and table.find(Names, NPCName) then
				NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild(NpcGroup)
			end
		end
	end
end

local function LakehouseSort(NPC)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Interact") then
		local NPCName = NPC.Character.Interact.ObjectName.Value
		
		if NPC.Character.Interact:FindFirstChild("Intel") then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Workers")
		elseif NPC.Character.Inventory:FindFirstChild("KeycardBlue") then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Specials")
		elseif NPCName == "Phoenix Operative" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Guards")
		else
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Enemies")
		end
	end
end

local function ScientistSort(NPC)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Interact") then
		local NPCName = NPC.Character.Interact.ObjectName.Value

		if NPC.Character.Inventory:FindFirstChild("KeycardHS") and NPC.Character.Inventory:FindFirstChild("USB") then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Specials")
		elseif NPC.Character.Inventory:FindFirstChild("KeycardHS") and not NPC.Character.Inventory:FindFirstChild("USB") then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Workers")
		elseif NPCName == "Halcyon Operative" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Guards")
		elseif NPCName == "Rivera" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Allies")
		else
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Enemies")
		end
	end
end

local function KillhouseSort(NPC)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Interact") then
		local NPCName = NPC.Character.Interact.ObjectName.Value

		if NPC.Character.Inventory:FindFirstChild("KeycardRed") then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Specials")
		elseif NPCName == "Guard" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Guards")
		else
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Enemies")
		end
	end
end

local function GalaSort(NPC)
	if NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Interact") then
		local NPCName = NPC.Character.Interact.ObjectName.Value
		if NPC.Character.Inventory:FindFirstChild("KeycardRed") or (NPC.Character.Interact:FindFirstChild("Intel") and NPC.Character.Interact.Intel:FindFirstChild("KeypadCode")) then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Specials")
		elseif NPCName == "Guard" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Guards")
		elseif NPCName == "Staff" then
			NPC.Parent = workspace.Level.Actors.SeparatedNPCS:FindFirstChild("Workers")
		end
	end
end

local sortFunctions = {
	[3590667014] = LakehouseSort,
	[4518266946] = ScientistSort,
	[2215221144] = KillhouseSort,
	[3925577908] = GalaSort
}

local SortFunction = EasySortFunction

if sortFunctions[game.PlaceId] then
	SortFunction = sortFunctions[game.PlaceId]
end

game:GetService("RunService").RenderStepped:Connect(function()
	game.Players.LocalPlayer.MaximumSimulationRadius = 5000
	sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius", 2500)
	for _, v in pairs(workspace.Level.Actors:GetChildren()) do
		SortFunction(v)
	end
end)

-- NPC FUNCTIONS

local function NpcNoclip(Npc)

	if Npc.Character:FindFirstChild("Spot") then
		Npc.Character.Spot:Destroy()
	end
	for _, part in pairs(Npc:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
	--[[
	for index, Part in pairs(BodyParts) do
		local FoundPart = Npc.Character:FindFirstChild(Part)
		if FoundPart and FoundPart.CanCollide then
			FoundPart.CanCollide = false
		end
	end]]--
end

local function tpNpc(Npc, NpcPos)
	if Npc:FindFirstChild("Character") and Npc.Character:FindFirstChild("HumanoidRootPart") then
		NpcNoclip(Npc)
		for index, Part in pairs(BodyForces) do
			if Npc.Character.HumanoidRootPart:FindFirstChild(Part) then
				Npc.Character.HumanoidRootPart:FindFirstChild(Part):Destroy()
			end
		end
		--[[for index, Part in pairs(BodyParts) do
			if Npc.Character:FindFirstChild(Part) then
				Npc.Character:FindFirstChild(Part):Destroy()
			end
		end]]--
		if not Npc.Character.HumanoidRootPart:FindFirstChild("MyForceInstance") then
			local ForceInstance = Instance.new("BodyPosition", Npc.Character.HumanoidRootPart)
			ForceInstance.Name = "MyForceInstance"
			ForceInstance.P = 1000000
			ForceInstance.MaxForce = Vector3.new(2500000, 2500000, 2500000)
		end
		Npc.Character.HumanoidRootPart.MyForceInstance.Position = NpcPos
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

local function AddHighlightGroups()
	workspace:WaitForChild("Level")

	local NewFolder = Instance.new("Folder", workspace.Level.Actors)
	NewFolder.Name = "SeparatedNPCS"

	for groupName, _ in pairs(GroupsAndColors) do
		local NewGroup = Instance.new("Model", workspace.Level.Actors.SeparatedNPCS)
		NewGroup.Name = groupName
	end

	for name, color in pairs(GroupsAndColors) do
		AddHighlight(workspace.Level.Actors.SeparatedNPCS:FindFirstChild(name), color)
	end
end

local myCoroutine = coroutine.create(AddHighlightGroups)
coroutine.resume(myCoroutine)

local function CamESP()
	_G.CamsESP = not _G.CamsESP
	if _G.CamsESP then
		for _, v in pairs(workspace.Level.Glass:GetChildren()) do
			if v.Name == "ExteriorCam" then
				v.Parent = workspace.Level.Actors.SeparatedNPCS.Cams
			end
		end
		workspace.Level.Actors.SeparatedNPCS.Cams.Highlight.Enabled = true
		while _G.CamsESP do
			game.workspace.Level.Actors.SeparatedNPCS.Cams.Highlight:Clone()
			task.wait(1)
		end
	else
		workspace.Level.Actors.SeparatedNPCS.Cams.Highlight.Enabled = false
	end
end

local function NPCsESP()
	_G.NpcESP = not _G.NpcESP
	if _G.NpcESP then
		workspace.Level.Actors.SeparatedNPCS.Workers.Highlight.Enabled = true
		workspace.Level.Actors.SeparatedNPCS.Guards.Highlight.Enabled = true
		workspace.Level.Actors.SeparatedNPCS.Specials.Highlight.Enabled = true
		workspace.Level.Actors.SeparatedNPCS.Enemies.Highlight.Enabled = true
		workspace.Level.Actors.SeparatedNPCS.Allies.Highlight.Enabled = true
		for _, v in pairs(objectsHighlights) do v.Enabled = true end
	else
		workspace.Level.Actors.SeparatedNPCS.Workers.Highlight.Enabled = false
		workspace.Level.Actors.SeparatedNPCS.Guards.Highlight.Enabled = false
		workspace.Level.Actors.SeparatedNPCS.Specials.Highlight.Enabled = false
		workspace.Level.Actors.SeparatedNPCS.Enemies.Highlight.Enabled = false
		workspace.Level.Actors.SeparatedNPCS.Allies.Highlight.Enabled = false
		for _, v in pairs(objectsHighlights) do v.Enabled = false end
	end
	pcall(function() CamESP() end)
end

spawn(function()
	for _, v in pairs(game.workspace.Level.GroundItems:GetChildren()) do
		v.Parent = workspace.Level.Actors.SeparatedNPCS.Items
	end
end)

local function ItemESP()
	_G.ItemsESP = not _G.ItemsESP
	local SendFunction
	if _G.ItemsESP then
		workspace.Level.Actors.SeparatedNPCS.Items.Highlight.Enabled = true
		SendFunction = game.workspace.Level.GroundItems.ChildAdded:Connect(function(Item)
			while game.workspace.Level.GroundItems.Parent == nil do task.wait() end
			game.workspace.Level.Actors.SeparatedNPCS.Items.Highlight:Clone()
			Item.Parent = workspace.Level.Actors.SeparatedNPCS.Items
		end)
	else
		workspace.Level.Actors.SeparatedNPCS.Items.Highlight.Enabled = false
		pcall(function() SendFunction:Disconnect() end)
	end
end


local function NPCRayCast()
	local ray = nil
	local IntersectionPart = nil
	local whiteList = {workspace.Level.Actors.SeparatedNPCS}
	local mouse = game.Players.LocalPlayer:GetMouse()
	ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
	IntersectionPart = workspace:FindPartOnRayWithWhitelist(ray, whiteList)
	if IntersectionPart then 
		return IntersectionPart.Parent.Parent
	else
		return nil
	end
end

--[[
game.RunService.RenderStepped:Connect(function()
	local ray = nil
	local IntersectionPart = nil
	local whiteList = {workspace.Level.Actors.SeparatedNPCS}
	local mouse = game.Players.LocalPlayer:GetMouse()
	ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
	IntersectionPart = workspace:FindPartOnRayWithWhitelist(ray, whiteList)
	print(IntersectionPart.Name)
end)






local UserInputService = game:GetService("UserInputService")

local function NPCRayCast()
    local ray = nil
	local IntersectionPart = nil
	local whiteList = {workspace.Level.Actors.SeparatedNPCS}
	local mouse = game.Players.LocalPlayer:GetMouse()
	ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
	IntersectionPart = workspace:FindPartOnRayWithWhitelist(ray, whiteList)
	return IntersectionPart.Parent.Parent.Name
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        print(NpcRaycast)
    end
end)








]]--


----------------------------------- LOCAL PLAYER FUNCTIONS ------------------------------------

local WALKSPEED = nil
local JUMPPOWER = nil

if game:GetService("RunService"):IsStudio() == false then
	game.Players.LocalPlayer.MaximumSimulationRadius = 5000
	game.Players.LocalPlayer.SimulationRadius = 2500
end

local function GetPlayer()	
	local localPlayer = game.Players.LocalPlayer
	local foundPlayer = false
	for _, v in pairs(workspace.Level.Players:GetChildren()) do
		if v:WaitForChild("Interact"):WaitForChild("ObjectTip").Value == localPlayer.Name then
			_G.Player = v
			foundPlayer = true
		end
	end
	local waitFunc
	if not foundPlayer then
		waitFunc = game.Workspace.Level.Players.ChildAdded:Connect(function(child)
			if child:WaitForChild("Interact"):WaitForChild("ObjectTip").Value == localPlayer.Name then
				child:WaitForChild("Humanoid")
				child:WaitForChild("HumanoidRootPart")
				child:WaitForChild("Head")
				_G.Player = child
				foundPlayer = true
				waitFunc:Disconnect()
			end
		end)
	end
	while not foundPlayer do task.wait() end
end

local function ReturnPlayer()	
	game.workspace.Level.Players:WaitForChild("Player")
	local ServerCount = game.Players:GetChildren()
	local ModelPlayerCount = game.workspace.Level.Players:GetChildren()
	while #ServerCount ~= #ModelPlayerCount do
		task.wait()
	end
	for i,v in pairs(workspace.Level.Players:GetChildren()) do
		v:WaitForChild("Interact"):WaitForChild("ObjectTip")
		if v.Interact.ObjectTip.Value == game.Players.LocalPlayer.Name then
			return v
		end
	end
	task.wait(3)
end

local function tpObject(Object, Position)
	GetPlayer()
	if Object:FindFirstChild("Base") and Object.Base.Anchored == false then
		if not Object.Base:FindFirstChild("MyForceInstance") then
			local ForceInstance = Instance.new("BodyPosition")
			ForceInstance.Name = "MyForceInstance"
			ForceInstance.P = 1000000
			ForceInstance.Parent = Object.Base
			ForceInstance.MaxForce = Vector3.new(2500000, 2500000, 2500000)
		end
		Object.Base.MyForceInstance.Position = Position
	end
end


local function PlayerWalkspeed(args) -- loopwalk
	GetPlayer()
	pcall(function() WALKSPEED:Disconnect() end)
	if args then
		_G.Player:WaitForChild("Humanoid").WalkSpeed = args[1]
		WALKSPEED = _G.Player:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			_G.Player:WaitForChild("Humanoid").WalkSpeed = args[1]
		end)
	else
		_G.Player:WaitForChild("Humanoid").WalkSpeed = 16
	end
end

local function PlayerJumppower(args) -- loopjump
	GetPlayer()
	pcall(function() JUMPPOWER:Disconnect() end)
	if args then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").UseJumpPower = true
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = args[1]
		JUMPPOWER = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):GetPropertyChangedSignal("JumpPower"):Connect(function()
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = args[1]
		end)
	else
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end

local function PlayerNoclip() -- noclip
	GetPlayer()
	_G.noclips = not _G.noclips
	local temp
	temp = game:GetService("RunService").Heartbeat:connect(function()
		if _G.noclips then
			for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		else
			temp:Disconnect()
			for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v.Name == "LowerTorso" or v.Name == "UpperTorso" then
					v.CanCollide = true
				end
			end
		end
	end)
end

local UserInputService = game:GetService("UserInputService")

local function PlayerInifniteJump() -- infjump
	GetPlayer()
	_G.InfJump = not _G.InfJump

	local InfJumpFunc1 = nil
	local InfJumpFunc2 = nil

	local HoldingSpace = false

	if _G.InfJump then
		InfJumpFunc1 = game:GetService("UserInputService").InputEnded:Connect(function(UserInput)
			if UserInput.KeyCode == Enum.KeyCode.Space then
				HoldingSpace = false
			end
		end)

		InfJumpFunc2 = game:GetService("UserInputService").InputBegan:Connect(function(UserInput)
			if UserInput.KeyCode == Enum.KeyCode.Space and UserInputService:GetFocusedTextBox() == nil then
				HoldingSpace = true
				while HoldingSpace and task.wait() do
					game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
				end
			end
		end)
	else
		InfJumpFunc1:Disconnect()
		InfJumpFunc2:Disconnect()
	end
end

local function InfiniteAmmo() -- infammo
	GetPlayer()
	_G.InfAmmo = not _G.InfAmmo
	while _G.InfAmmo == true do
		local ammo = game.Players.LocalPlayer.Status.Ammo:GetChildren()
		for i,v in pairs(ammo) do
			if v.Value ~= 500 then v.Value = 500 end
		end
		task.wait(1)
	end
end

local function ResetCharacter() -- resetz
	GetPlayer()
	_G.Player.Humanoid.Health = -1
end

local function KillAura() -- killaura
	GetPlayer()
	_G.KillAura = not _G.KillAura
	local DeathGroups = {
		workspace.Level.Actors.SeparatedNPCS.Workers,
		workspace.Level.Actors.SeparatedNPCS.Guards,
		workspace.Level.Actors.SeparatedNPCS.Enemies,
		workspace.Level.Actors.SeparatedNPCS.Specials
	}
	local KillAuraFunction
	KillAuraFunction = game:GetService("RunService").RenderStepped:Connect(function()
		if _G.KillAura then
			for _, DeathGroup in pairs(DeathGroups) do
				for _, npc in pairs(DeathGroup:GetChildren()) do
					pcall(function()
						npc.Character.Humanoid.Health = -1
						npc.Character.Head.Neck:Destroy()
						npc.Character.HumanoidRootPart.MyForceInstance:Destroy()
					end)
				end
			end
		else
			KillAuraFunction:Disconnect()
		end
	end)
end

local function StopOperations() -- free
	GetPlayer()

	for _, v in pairs(workspace.Level.Actors.SeparatedNPCS.Allies:GetChildren()) do
		pcall(function() v.Character.HumanoidRootPart.MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.Actors.SeparatedNPCS.Enemies:GetChildren()) do
		pcall(function() v.Character.HumanoidRootPart.MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.Actors.SeparatedNPCS.Guards:GetChildren()) do
		pcall(function() v.Character.HumanoidRootPart.MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.Actors.SeparatedNPCS.Workers:GetChildren()) do
		pcall(function() v.Character.HumanoidRootPart.MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.Actors.SeparatedNPCS.Specials:GetChildren()) do
		pcall(function() v.Character.HumanoidRootPart.MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.GroundBags:GetChildren()) do
		pcall(function() v:FindFirstChildWhichIsA("BasePart").MyForceInstance:Destroy() end)
	end
	for _, v in pairs(workspace.Level.GroundItems:GetChildren()) do
		pcall(function() v:FindFirstChildWhichIsA("BasePart").MyForceInstance:Destroy() end)
	end

	_G.KillAura = false

	_G.HideCivs = false
	_G.HideWorkers = false
	_G.HideGuards = false
	_G.HideSpecial = false
	_G.HideAllies = false

	_G.ThrowCivs = false
	_G.ThrowWorkers = false
	_G.ThrowGuards = false
	_G.ThrowSpecial = false
	_G.ThrowAllies = false
end

local CommandGroups = {
	["w"] = workspace.Level.Actors.SeparatedNPCS.Workers,
	["g"] = workspace.Level.Actors.SeparatedNPCS.Guards,
	["a"] = workspace.Level.Actors.SeparatedNPCS.Allies,
	["e"] = workspace.Level.Actors.SeparatedNPCS.Enemies,
	["s"] = workspace.Level.Actors.SeparatedNPCS.Specials
}

local function killGroup(args) -- kill
	if args[1] == nil then
		killGroup({"w"})
		killGroup({"g"})
	end
	for npcIndex, npc in pairs(CommandGroups[args[1]]:GetChildren()) do
		pcall(function()
			npc.Character.Humanoid.Health = -1
			npc.Character.Head.Neck:Destroy()
			npc.Character.HumanoidRootPart.MyForceInstance:Destroy()
		end)
	end
end

local function moveObject(obj, objPos)
	local movePart = obj:FindFirstChildWhichIsA("BasePart")
	if not movePart:FindFirstChild("MyForceInstance") then
		local ForceInstance = Instance.new("BodyPosition", movePart)
		ForceInstance.Name = "MyForceInstance"
		ForceInstance.P = 1000000
		ForceInstance.MaxForce = Vector3.new(2500000, 2500000, 2500000)
	end
	movePart.MyForceInstance.Position = objPos
end

local function bringGroup(args) -- bring
	if args[1] ~= "bag" and args[1] ~= "item" then
		if args[1] == nil then
			bringGroup({"w"})
			bringGroup({"g"})
		end
		local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
		for npcIndex, npc in pairs(CommandGroups[args[1]]:GetChildren()) do
			if npc:FindFirstChild("Character") and npc.Character:FindFirstChild("HumanoidRootPart") then
				tpNpc(npc, HRP.Position)
			end
		end
	else
		local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
		if args[1] == "bag" then
			for _, v in pairs(workspace.Level.GroundBags:GetChildren()) do
				moveObject(v, HumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		elseif args[1] == "item" then
			for _, v in pairs(workspace.Level.GroundItems:GetChildren()) do
				moveObject(v, HumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		end
	end
end

local function loopBringItems() -- loopitem
	GetPlayer()
	_G.LoopItem = not _G.LoopItem
	local loopBringItemsFunction
	loopBringItemsFunction = game:GetService("RunService").RenderStepped:Connect(function()
		if _G.LoopItem then
			local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
			for _, v in pairs(workspace.Level.GroundItems:GetChildren()) do
				moveObject(v, HumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		else
			loopBringItemsFunction:Disconnect()
		end
	end)
end

local function loopBringBags() -- loopbag
	GetPlayer()
	_G.LoopBag = not _G.LoopBag
	local loopBringBagsFunction
	loopBringBagsFunction = game:GetService("RunService").RenderStepped:Connect(function()
		if _G.LoopBag then
			local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
			for _, v in pairs(workspace.Level.GroundBags:GetChildren()) do
				moveObject(v, HumanoidRootPart.Position + Vector3.new(0, -1, 0))
			end
		else
			loopBringBagsFunction:Disconnect()
		end
	end)
end

local function hideGroup(args) -- hide
	if args[1] == nil then
		hideGroup({"w"})
		hideGroup({"g"})
	end
	for npcIndex, npc in pairs(CommandGroups[args[1]]:GetChildren()) do
		if npc:FindFirstChild("Character") and npc.Character:FindFirstChild("HumanoidRootPart") then
			tpNpc(npc, groupMapping[game.PlaceId].Spot)
		end
	end
end

local function voidGroup(args) -- void
	if args[1] == nil then
		voidGroup({"w"})
		voidGroup({"g"})
	end
	for npcIndex, npc in pairs(CommandGroups[args[1]]:GetChildren()) do
		if npc:FindFirstChild("Character") and npc.Character:FindFirstChild("HumanoidRootPart") then
			tpNpc(npc, Vector3.new(0,-450,0))
		end
	end
end

local function killClosest() -- forcekill
	local NPC = NPCRayCast()
	pcall(function()
		NPC.Character.Humanoid.Health = -1
		NPC.Character.Head.Neck:Destroy()
		NPC.Character.HumanoidRootPart.MyForceInstance:Destroy()
	end)
end

local function bringClosest() -- forcebring
	local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
	local NPC = NPCRayCast()
	if NPC and NPC:FindFirstChild("Character"):FindFirstChild("Humanoid") then
		tpNpc(NPC, HRP.Position)
	end
end

local function hideClosest() -- forcehide
	local NPC = NPCRayCast()
	if NPC and NPC:FindFirstChild("Character"):FindFirstChild("Humanoid") then
		tpNpc(NPC, groupMapping[game.PlaceId].Spot)
	end
end

local function voidClosest() -- forcevoid
	local NPC = NPCRayCast()
	if NPC and NPC:FindFirstChild("Character") and NPC.Character:FindFirstChild("Humanoid") then
		tpNpc(NPC, Vector3.new(0,-2500000,0))
	end
end

local function startGame() -- startgame
	game:GetService("ReplicatedStorage").Lobby.Trig.StartGame:FireServer()
end

local function leaveLobby() -- leavelobby
	game:GetService("ReplicatedStorage").Lobby.Trig.LeaveLobby:FireServer()
end

local function StopLoud() -- stoploud
	_G.StopSpawn = not _G.StopSpawn
	local AntiSpawnFunction

	AntiSpawnFunction = game:GetService("RunService").RenderStepped:Connect(function()
		if _G.StopSpawn then
			for index, enemy in pairs(workspace.Level.Actors.SeparatedNPCS.Enemies:GetChildren()) do
				tpNpc(enemy, Vector3.new(2500000,2500000,2500000))
			end
		else
			AntiSpawnFunction:Disconnect()
		end
	end)
end

local function noShield() -- noshield
	_G.RemoveShields = not _G.RemoveShields
	local AntiShieldFunction

	if _G.RemoveShields then
		for index, enemy in pairs(workspace.Level.SeparatedNPCS.Enemies:GetChildren()) do
			if enemy:FindFirstChild("S97Shield"):FindFirstChild("BallisticShield") then
				enemy.S97Shield.BallisticShield:Destroy()
			end
		end
		AntiShieldFunction = game.workspace.Level.GroundItems.ChildAdded:Connect(function(Enemy)
			if Enemy:FindFirstChild("S97Shield"):FindFirstChild("BallisticShield") then
				Enemy.S97Shield.BallisticShield:Destroy()
			end
		end)
	else
		pcall(function() AntiShieldFunction:Disconnect() end)
	end
end

local function noFlash() -- noflash
	GetPlayer()
	for index, effect in pairs(workspace.Camera:GetChildren()) do
		if effect.Name == "Blur" then
			effect:Destroy()
		end
	end
	game.Players.LocalPlayer.PlayerGui:WaitForChild("Weapons"):WaitForChild("WeaponGui"):WaitForChild("Flashbang").Visible = false
end

local function destroyBoss() -- killboss
	GetPlayer()
	if game.PlaceId == 3590667014 then
		local Base = workspace.Level.Actors:WaitForChild("Helo"):WaitForChild("Base").Position
		localPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
	elseif game.PlaceId == 4661507759 then
		local Helo = workspace.Level.Actors:WaitForChild("Helo")
		local Base = Helo:WaitForChild("Base").Position
		while Helo:WaitForChild("ObjectHealth").Value ~= 17150 do
			game:GetService("Players").LocalPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
			task.wait(1)
		end
	elseif game.PlaceId == 5862433299 then
		local Base = workspace.Level.Actors:WaitForChild("Turret"):WaitForChild("Gun").Position
		game:GetService("Players").LocalPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(Base, Base, Base, 50000, 50000, 50000, 50000, 50000)
	end
end

local function Autofarm() -- autofarm
	local SupportedIDs = {
		[4518266946] = loadstring(game:HttpGet(("https://raw.githubusercontent.com/RawParmesann/test/main/scientist.lua"),true))()
	}

	game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ReadyGui")

	if SupportedIDs[game.PlaceId] then
		MainHolder["1"]:Destroy()
		SupportedIDs[game.PlaceId]()
	end
end

local function Teleport() -- teleport

end

local function difficultyRequest(args) -- diffrequest
	game:GetService("ReplicatedStorage").GameState.SetGameDifficulty:InvokeServer(tonumber(args[1]))
end

local function simulateShot(v, damage)
	pcall(function()
		local ohVector31 = v.HumanoidRootPart.Position -- game.Players.LocalPlayer.Character.HeadM
		local ohVector32 = v.HumanoidRootPart.Position -- 
		local ohVector33 = Vector3.new(0, 1, 0) -- HeadM LookVector
		local ohNumber4 = damage
		local ohNumber5 = 100
		local ohNumber6 = 100
		local ohNumber7 = 100
		local ohNumber8 = 100

		game:GetService("Players").LocalPlayer.PlayerGui.Weapons.BulletLocal.FireBullet:Fire(ohVector31, ohVector32, ohVector33, ohNumber4, ohNumber5, ohNumber6, ohNumber7, ohNumber8)
	end)
end

local function godMode(args) -- godMode
	GetPlayer()

	if args[1] ~= nil then
		simulateShot(game.workspace.Level.Players:FindFirstChild(args[1]), 0/0)
	else
		for _, v in pairs(game.workspace.Level.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer.Character then
				simulateShot(v, 0/0)
			end
		end
	end
end

local function killOthers() -- killothers
	for _, v in pairs(game.workspace.Level.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer.Character then
			simulateShot(v, 1250)
		end
	end
end

local LakeHouseDoor = nil
local WithdrawalDoor = nil

if game.PlaceId == 3590667014 then
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("Escape") and v.Escape:FindFirstChild("Interact") then
			LakeHouseDoor = v
		end
	end
end

if game.PlaceId == 2951213182 then
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("AccessDoorScript") and v:FindFirstChild("OpenTrig") then
			WithdrawalDoor = v
		end
	end
end

local function openDoors()
	_G.OpenDoors = not _G.OpenDoors
	local OpenDoorsFunction
	OpenDoorsFunction = game:GetService("RunService").RenderStepped:Connect(function()
		if _G.OpenDoors then
			for _, v in pairs(workspace.Level.Geometry.Doors:GetChildren()) do
				if v:FindFirstChild("Interact") and v.Interact:FindFirstChild("Opened") then
					v.Interact.Opened.Value = true
					--if door:FindFirstChild("Sensors") and door.Sensors.Interact:FindFirstChild("ReqEngineer") then
					--	door.Sensors.Interact.ReqEngineer:Destroy()
					--end
				end
				if LakeHouseDoor and LakeHouseDoor:FindFirstChild("Escape") then LakeHouseDoor.Escape.Interact.Active.Value = true end
				if WithdrawalDoor then WithdrawalDoor.OpenTrig.Interact.Active.Value = true end
			end
		else
			OpenDoorsFunction:Disconnect()
		end
	end)
end

local function speedUpBags()
	_G.SpeedUp = not _G.SpeedUp

	local SpeedUpFunc
	SpeedUpFunc = game.RunService.RenderStepped:Connect(function()
		pcall(function()
			if _G.SpeedUp then
				if game.PlaceId == 3590667014 then
					local Servers = {
						workspace.Level.Geometry:GetChildren()[1836],
						workspace.Level.Geometry:GetChildren()[1835],
						workspace.Level.Geometry:GetChildren()[1834],
						workspace.Level.Geometry:GetChildren()[1833],
						workspace.Level.Geometry:GetChildren()[1832],
						workspace.Level.Geometry:GetChildren()[1831],
					}
					for _, v in pairs(Servers) do
						v.ServerPickup.Interact.Value = true
						v.ServerPickup.PickupTime.Value = 0
					end
				elseif game.PlaceId == 2951213182 then
					for _, v in pairs(workspace.Level.GroundBags:GetChildren()) do
						if v.Name == "Cash" then
							v.PickupTime.Value = 0
						end
					end
				elseif game.PlaceId == 5862433299 then
					for _, v in pairs(workspace.Level.GroundBags:GetChildren()) do
						if v.Name == "Gold" then
							v.PickupTime.Value = 0
						end
					end
				end
			else
				SpeedUpFunc:Disconnect()
			end
		end)
	end)
end

local function metalDetectors() -- metaldetectors
	for i,v in pairs(game:GetService("Workspace").Level.Glass:GetChildren()) do
		if v.Name == "MetalDetectorPart1" or v.Name == "MetalDetectorPart2" or v.Name == "MetalDetectorPart3" then
			v:Destroy()
		end
	end
	for i,v in pairs(game:GetService("Workspace").Level.Triggers:GetChildren()) do
		if v.Name == "Detector" then
			v:Destroy()
		end
	end
end

local function allyImmunity() -- allyimmunity
	for i,v in pairs(workspace.Level.SeparatedNPCS.Enemies:GetChildren()) do
		if v:FindFirstChild("Character"):FindFirstChild("Interact") and (v.Character.Interact.ObjectName.Value == "Rose" or v.Character.Interact.ObjectName.Value == "Rivera" or v.Character.Interact.ObjectName.Value == "Jade") then
			v.Character.Humanoid.Team:Destroy()
		end
	end
end

local function npcInteract() -- npcinteract
	_G.NpcInteract = not _G.NpcInteract
	local NPCInteractFunction
	NPCInteractFunction = game:GetService("RunService").Heartbeat:Connect(function()
		if _G.NpcInteract then
			for groupIndex, group in pairs(workspace.Level.Actors.SeparatedNPCS:GetChildren()) do
				for npcIndex, npc in pairs(group:GetChildren()) do
					if npc:FindFirstChild("Character"):FindFirstChild("Interact"):FindFirstChild("Active") then
						npc.Character.Interact.Active.Value = true
					end
				end
			end
		else
			NPCInteractFunction:Disconnect()
		end
	end)
end

local function uiVisible() -- uivisible
	GetPlayer()
	local WeaponGUIHandler = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Weapons")
	WeaponGUIHandler.WeaponGui.MainPlayer.Visible = true
	WeaponGUIHandler.WeaponGui.Objectives.Visible = true
	WeaponGUIHandler.TeamGui.Team.Visible = true
	WeaponGUIHandler.TeamGui.Team.TeamTracker.TeammateTemplate.Visible = true
	WeaponGUIHandler.TeamGui.Team.TeamTracker.TeammateTemplate.Health.Visible = true
	WeaponGUIHandler.WeaponGui.CharModel.Visible = true
	WeaponGUIHandler.WeaponGui.Clock.TextTransparency = 0
end

local function breakArms(args) -- breakarms
	if args[1] == "1" then
		game:GetService("Players").LocalPlayer.PlayerGui.Animate.SetAnim:Fire("HipPosition", 1, tonumber(args[2]), 0.15)
	elseif args[1] == "2" then
		game:GetService("Players").LocalPlayer.PlayerGui.Animate.SetWeight:Fire(tonumber(args[2]), 0.15)
	end
end

local function breakShoulders(args) -- breakshoulders
	game:GetService("Players").LocalPlayer.PlayerGui.Animate.SetShoulders:Fire(tonumber(args[1]), 0.17)
end

local function breakBack(args) -- breakback
	game:GetService("Players").LocalPlayer.PlayerGui.Animate.SetLean:Fire(tonumber(args[1]))
end

local function disableCam() -- disablecam

end

local function expandHitbox() -- hitbox

end

local function noFog() -- nofog

end

local function Telekinesis() -- telekinesis

end

local function wallHack() -- wallhack

end

local function ChangeMusic(MusicType, Value, IsCustom, CustomSoundId)
	GetPlayer()

	local StealthMusic = game:GetService("Players").LocalPlayer.PlayerGui.SpectateGui.Music.Stealth
	local LoudMusic = game:GetService("Players").LocalPlayer.PlayerGui.SpectateGui.Music.Loud

	if MusicType == "Stealth" then
		while StealthMusic.Playing == false do task.wait() end

		if IsCustom == false then StealthMusic.SoundId = MusicTable[Value]
		else StealthMusic.SoundId = "rbxassetid://"..CustomSoundId end

	elseif MusicType == "Loud" then
		while LoudMusic.Playing == false do task.wait() end

		if IsCustom == false then LoudMusic.SoundId = MusicTable[Value]
		else LoudMusic.SoundId = "rbxassetid://"..CustomSoundId end
	end
end

local function CreateLobby(LobbyData)
	game:GetService("ReplicatedStorage").Lobby.Trig.CreateLobby:InvokeServer(LobbyData)
end

local function objectiveAssist()
	--financier
	if game.PlaceId == 2797881676 then

		local offset = 0

		for _, object in pairs(game.Workspace.Level.Geometry:GetChildren()) do
			if object.Name == "PowerBox" then
				object.Case.Interact.Time.Value = 5
				object.PrimaryPart = object.Case.BasePart
				object:SetPrimaryPartCFrame(CFrame.new(-3.205, 5.9, -30.888 + offset) * CFrame.Angles(0, math.rad(90), 0))
				offset += 2
			end
		end

	elseif game.PlaceId == 2625195454 then
		--deposit

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
	end
end

local function helpToggle()
	Library["2a"]["Visible"] = not Library["2a"]["Visible"]
end

local function hotkeysToggle()
	Library["40"]["Visible"] = not Library["40"]["Visible"]
end

local function lobbyToggle()
	Library["53"]["Visible"] = not Library["53"]["Visible"]
end

local function musicToggle()
	Library["a8"]["Visible"] = not Library["a8"]["Visible"]
end

local function teleportToggle()
	Library["ea"]["Visible"] = not Library["ea"]["Visible"] 
end

local function fuckMessage()
	print(GroupShortenings)
end

local args = {}

local functionCalls = {
	["help"] = helpToggle,
	["esp"] = NPCsESP,
	["itemesp"] = ItemESP,
	["camesp"] = CamESP,
	["hotkeys"] = hotkeysToggle,
	["lobby"] = lobbyToggle,
	["music"] = musicToggle,
	["teleport"] = teleportToggle,
	["loopwalk"] = PlayerWalkspeed,
	["loopjump"] = PlayerJumppower,
	["noclip"] = PlayerNoclip,
	["infjump"] = PlayerInifniteJump,
	["fuck"] = fuckMessage,
	["infammo"] = InfiniteAmmo,
	["reset"] = ResetCharacter,
	["killaura"] = KillAura,
	["free"] = StopOperations,
	["kill"] = killGroup,
	["bring"] = bringGroup,
	["hide"] = hideGroup,
	["void"] = voidGroup,
	["forcekill"] = killClosest,
	["forcebring"] = bringClosest,
	["forcehide"] = hideClosest,
	["forcevoid"] = voidClosest,
	["loopbag"] = loopBringBags,
	["loopitem"] = loopBringItems,
	["startgame"] = startGame,
	["leavelobby"] = leaveLobby,
	["loud"] = StopLoud,
	["noshield"] = noShield,
	["noflash"] = noFlash,
	["killboss"] = destroyBoss,
	["autofarm"] = Autofarm,
	["diffrequest"] = difficultyRequest,
	["godmode"] = godMode,
	["killothers"] = killOthers,
	["opendoors"] = openDoors,
	["metaldetectors"] = metalDetectors,
	["allyimmunity"] = allyImmunity,
	["npcinteract"] = npcInteract,
	["uivisible"] = uiVisible,
	["breakarms"] = breakArms,
	["breakshoulders"] = breakShoulders,
	["breakback"] = breakBack,
	["disablecam"] = disableCam,
	["hitbox"] = expandHitbox,
	["nofog"] = noFog,
	["speedup"] = speedUpBags,
	["objectiveassist"] = objectiveAssist,
	--["telekinesis"] = "telekinesis: Allows you to move npc",
	--["wallhack"] = "wallhack: Allows you to shoot through walls while aiming",
}

local function getCommand(text)
	local command, arguments = text:match("(%w+)%s*(.*)")
	args = {}
	if arguments then
		for arg in arguments:gmatch("(%w+)") do
			table.insert(args, arg)
		end
	end

	if functionCalls[command] then
		print(command, args[1], args[2])
		functionCalls[command](args)
	else
		local currentTime = os.date("*t")
		local hour = string.format("%02d", currentTime.hour)
		local minute = string.format("%02d", currentTime.min)
		local second = string.format("%02d", currentTime.sec)
		addMessage(hour..":"..minute..":"..second.." - [Error]: Command does not exist!")
	end

	if command then print("Command: "..command) end
	for i,v in pairs(args) do
		print("Argument: "..v, type(v))
	end
end

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

function Library:Hotkeys()
	local Hotkey = {}

	-- StarterGui.Entry_Point_2.Hotkeys
	Library["40"] = Instance.new("Frame", MainHolder["1"]);
	Library["40"]["BorderSizePixel"] = 0;
	Library["40"]["BackgroundColor3"] = Color3.fromRGB(34, 37, 45);
	Library["40"]["BackgroundTransparency"] = 0.05000000074505806;
	Library["40"]["Size"] = UDim2.new(0, 250, 0, 300);
	Library["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["40"]["Position"] = UDim2.new(0, 500, 0, 100);
	Library["40"]["Name"] = [[Hotkeys]];
	Library["40"]["Visible"] = false

	TurnOnDraggable(Library["40"])

	-- StarterGui.Entry_Point_2.Hotkeys.FileName
	Library["41"] = Instance.new("TextLabel", Library["40"]);
	Library["41"]["ZIndex"] = 2;
	Library["41"]["BorderSizePixel"] = 0;
	Library["41"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["41"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["41"]["TextSize"] = 12;
	Library["41"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["41"]["Size"] = UDim2.new(1, 0, 0, 25);
	Library["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["41"]["Text"] = [[root@kali:~hotkeys]];
	Library["41"]["Name"] = [[FileName]];

	-- StarterGui.Entry_Point_2.Hotkeys.FileName.UICorner
	Library["42"] = Instance.new("UICorner", Library["41"]);


	-- StarterGui.Entry_Point_2.Hotkeys.FileName.Frame
	Library["43"] = Instance.new("Frame", Library["41"]);
	Library["43"]["BorderSizePixel"] = 0;
	Library["43"]["BackgroundColor3"] = Color3.fromRGB(44, 49, 59);
	Library["43"]["Size"] = UDim2.new(1, 0, 0, 5);
	Library["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["43"]["Position"] = UDim2.new(0, 0, 0, 20);

	-- StarterGui.Entry_Point_2.Hotkeys.UICorner
	Library["44"] = Instance.new("UICorner", Library["40"]);


	-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame
	Library["45"] = Instance.new("ScrollingFrame", Library["40"]);
	Library["45"]["Active"] = true;
	Library["45"]["BorderSizePixel"] = 0;
	Library["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	Library["45"]["BackgroundTransparency"] = 1;
	Library["45"]["Size"] = UDim2.new(1, 0, 0, 275);
	Library["45"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	Library["45"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["45"]["ScrollBarThickness"] = 3;
	Library["45"]["Position"] = UDim2.new(0, 0, 0, 25);

	-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.UIListLayout
	Library["46"] = Instance.new("UIListLayout", Library["45"]);
	Library["46"]["Padding"] = UDim.new(0, 7);
	Library["46"]["SortOrder"] = Enum.SortOrder.Name;

	-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.hotkeys
	Library["47"] = Instance.new("TextLabel", Library["45"]);
	Library["47"]["BorderSizePixel"] = 0;
	Library["47"]["BackgroundColor3"] = Color3.fromRGB(28, 31, 37);
	Library["47"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	Library["47"]["TextSize"] = 14;
	Library["47"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	Library["47"]["Size"] = UDim2.new(0, 230, 0, 25);
	Library["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	Library["47"]["Text"] = [[Hotkeys]];
	Library["47"]["Name"] = [[hotkeys]];
	Library["47"]["BackgroundTransparency"] = 1;

	-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.hotkeys.UICorner
	Library["48"] = Instance.new("UICorner", Library["47"]);
	Library["48"]["CornerRadius"] = UDim.new(0, 2);

	-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.UIPadding
	Library["49"] = Instance.new("UIPadding", Library["45"]);
	Library["49"]["PaddingTop"] = UDim.new(0, 5);
	Library["49"]["PaddingLeft"] = UDim.new(0, 10);

	function Library:AddHotkey(letter, text)
		local listener = nil

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey
		Hotkey["4a"] = Instance.new("Frame", Library["45"]);
		Hotkey["4a"]["BorderSizePixel"] = 0;
		Hotkey["4a"]["BackgroundColor3"] = Color3.fromRGB(27, 29, 35);
		Hotkey["4a"]["Size"] = UDim2.new(1, -10, 0, 30);
		Hotkey["4a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Hotkey["4a"]["Name"] = [[veryhotkey]];

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.UICorner
		Hotkey["4b"] = Instance.new("UICorner", Hotkey["4a"]);
		Hotkey["4b"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.UIStroke
		Hotkey["4c"] = Instance.new("UIStroke", Hotkey["4a"]);
		Hotkey["4c"]["Color"] = Color3.fromRGB(30, 30, 30);

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextLabel
		Hotkey["4d"] = Instance.new("TextLabel", Hotkey["4a"]);
		Hotkey["4d"]["BorderSizePixel"] = 0;
		Hotkey["4d"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
		Hotkey["4d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Hotkey["4d"]["TextSize"] = 14;
		Hotkey["4d"]["TextColor3"] = Color3.fromRGB(179, 179, 179);
		Hotkey["4d"]["Size"] = UDim2.new(0, 20, 0, 20);
		Hotkey["4d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Hotkey["4d"]["Text"] = letter;
		Hotkey["4d"]["Position"] = UDim2.new(0, 10, 0, 5);
		Hotkey["4d"]["AutomaticSize"] = Enum.AutomaticSize.X

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextLabel.UICorner
		Hotkey["4e"] = Instance.new("UICorner", Hotkey["4d"]);
		Hotkey["4e"]["CornerRadius"] = UDim.new(0, 2);

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextLabel.UIStroke
		Hotkey["4f"] = Instance.new("UIStroke", Hotkey["4d"]);
		Hotkey["4f"]["Color"] = Color3.fromRGB(30, 30, 30);
		Hotkey["4f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextBox 
		local shit = Instance.new("TextBox", Hotkey["4a"]);
		shit["CursorPosition"] = -1;
		shit["PlaceholderColor3"] = Color3.fromRGB(179, 179, 179);
		shit["BorderSizePixel"] = 0;
		shit["TextSize"] = 11;
		shit["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
		shit["TextColor3"] = Color3.fromRGB(255, 255, 255);
		shit["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		shit["PlaceholderText"] = [[command]];
		shit["Size"] = UDim2.new(0, 60, 0, 20);
		shit["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		shit["Text"] = text;
		shit["Position"] = UDim2.new(0, 160, 0, 5);

		shit.FocusLost:Connect(function()
			AvalaibleHotkeys[shit.Parent.TextLabel.Text] = shit["Text"]
			writefile("hotkeyConfig.txt", HttpService:JSONEncode(AvalaibleHotkeys))
		end)

		pcall(function() listener:Disconnect() end)
		if shit["Text"] ~= "" then
			listener = game:GetService("UserInputService").InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode[letter] and UserInputService:GetFocusedTextBox() == nil then
					getCommand(shit["Text"])
				end
			end)
		end

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextBox.UIStroke
		Hotkey["51"] = Instance.new("UIStroke", shit);
		Hotkey["51"]["Color"] = Color3.fromRGB(30, 30, 30);
		Hotkey["51"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

		-- StarterGui.Entry_Point_2.Hotkeys.ScrollingFrame.veryhotkey.TextBox.UICorner
		Hotkey["52"] = Instance.new("UICorner", shit);
		Hotkey["52"]["CornerRadius"] = UDim.new(0, 2);

	end

	if isfile("hotkeyConfig.txt") then
		local test = readfile("hotkeyConfig.txt")
		for i, v in pairs(HttpService:JSONDecode(test)) do
			Library:AddHotkey(i,v)
			AvalaibleHotkeys[i] = v
		end
	else
		for i, v in pairs(AvalaibleHotkeys) do
			Library:AddHotkey(i,v)
		end
	end
end

Library:Hotkeys()

local function addFocusLostListener()
	listener = previousTextBox.FocusLost:Connect(function()
		frame.Visible = false
		if previousTextBox and previousTextBox.Text ~= "" then
			previousTextBox.TextEditable = false
			print(previousTextBox.Text)
			getCommand(previousTextBox.Text)
		end
	end)
end

local function addButtonListener()
	local userInputService = game:GetService("UserInputService")

	userInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Semicolon and (previousTextBox == nil or previousTextBox:IsFocused() == false) then
			frame.Visible = true

			if previousTextBox and previousTextBox.Text == "" then
				previousTextBox:CaptureFocus()
			else
				pcall(function() listener:Disconnect() end)
				local textBox = CreateTextBox()
				textBox:CaptureFocus()
				previousTextBox = textBox
				addFocusLostListener()
			end

			MainHolder["15"].CanvasPosition = Vector2.new(0, 10000000)

			previousTextBox:GetPropertyChangedSignal("Text"):Connect(function()
				previousTextBox.Text = previousTextBox.Text:gsub(";", "")
			end)
		end
	end)
end

addButtonListener()

local defaultColor = Color3.fromRGB(0, 191, 255)

local function addObjectHighlight(Object, Color)
	if not Object:FindFirstChild("Highlight") then		
		local NewHighlight = Instance.new("Highlight", Object)
		NewHighlight.OutlineColor = (Color3.new(255, 255, 255))
		NewHighlight.OutlineTransparency = 0.75
		NewHighlight.Adornee = Object
		NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		table.insert(objectsHighlights, NewHighlight)
		if Color == nil then
			NewHighlight.FillColor = defaultColor
		else
			NewHighlight.FillColor = Color
		end
		NewHighlight.Enabled = false
	end
end

local function blackSiteHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("Computer") then
			addObjectHighlight(v.Computer)
		end
	end
end

local function financierHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("Computer") then
			addObjectHighlight(v.Computer)
		end
		if v.Name == "PowerBox" then
			addObjectHighlight(v)
		end
	end
end

local function depositHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "ManagerComputer" then
			addObjectHighlight(v)
		end
		if v.Name == "AccComputers" then
			for _, computer in pairs(v:GetChildren()) do
				if computer:FindFirstChild("Interact") then
					addObjectHighlight(computer)
				end
			end
		end
		if v.Name == "Safe" then
			addObjectHighlight(v.SafeDoor)
		end
	end
end

local function lakehouseHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "PowerBox" or v.Name == "FileFolder" or v:FindFirstChild("DoorModel") then
			addObjectHighlight(v)
		end
	end
end

local function withdrawalHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("Computer") then
			addObjectHighlight(v.Computer)
		end
		if v.Name == "PowerBox" then
			addObjectHighlight(v, v.PowerDoor.Color.Color)
		end
	end
end

local function scientistHighlights()
	for _, v in pairs(workspace.Level.Geometry.Doors:GetChildren()) do
		if v:FindFirstChild("ServerUnlock") then
			addObjectHighlight(v)
		end
	end
end

local function scrsHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v:FindFirstChild("PowerBoxDoor") or v:FindFirstChild("SafeDoor") then
			addObjectHighlight(v)
		end
	end
end

local function conceptHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "ManagerComputer" or v.Name == "AssistantComputer" or v.Name == "PowerBox" or v:FindFirstChild("SafeDoor") then
			addObjectHighlight(v)
		end
		if v.Name == "AccountComputers" then
			for _, computer in pairs(v:GetChildren()) do
				if computer:FindFirstChild("Interact") then
					addObjectHighlight(computer)
				end
			end
		end
	end
end

local function auctionHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "Clipboard" or v.Name == "Computer" then
			addObjectHighlight(v)
		end
	end
end

local function galaHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "CaseArtifact" or v:FindFirstChild("Lid") or v:FindFirstChild("SafeDoor") or (v:FindFirstChild("Interact") and v.Interact.ObjectName.Value == "Keypad") then
			addObjectHighlight(v)
		end
	end
end

local function cacheHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "Keypad" or v.Name == "PowerBox" or v.Name == "CameraPanel" or v.Name == "DoorLockPanel" then
			addObjectHighlight(v)
		end
		if v.Name == "Servers" then
			addObjectHighlight(v.Computer)
		end
	end
end

local function setupHighlights()
	for _, v in pairs(workspace.Level.Geometry:GetChildren()) do
		if v.Name == "PowerBox" or v:FindFirstChild("SafeDoor") then
			addObjectHighlight(v)
		end
		if v:FindFirstChild("Interact") and v.Interact.ObjectName.Value == "Files" then
			addObjectHighlight(v)
		end
		if v:FindFirstChild("Desk") then
			addObjectHighlight(v.Desk.Computer)
		end
	end
end

local function lockupHighlights()

end

local function blackduskHighlights()

end

local function killhouseHighlights()

end

local function scoreHighlights()

end

local highlightMissions = {
	[3200010305] = blackSiteHighlights,
	[2797881676] = financierHighlights,
	[2625195454] = depositHighlights,
	[3590667014] = lakehouseHighlights,
	[2951213182] = withdrawalHighlights,
	[4518266946] = scientistHighlights,
	[4661507759] = scrsHighlights,
	[4768829954] = blackduskHighlights,
	[2215221144] = killhouseHighlights,
	[4134003540] = auctionHighlights,
	[3925577908] = galaHighlights,
	[4388762338] = cacheHighlights,
	[5071816792] = setupHighlights,
	[5188855685] = lockupHighlights,
	[5862433299] = scoreHighlights,
	[7799530284] = conceptHighlights,
}

highlightMissions[game.PlaceId]()
