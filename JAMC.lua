-- Just Another Menu Changer
-- Resumindo: ele adiciona mais 'tabs' pro Roblox Gui kkkkk

local CoreGui = game:FindFirstChildWhichIsA("CoreGui")

local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
local Main = RobloxGui:FindFirstChild("SettingsClippingShield")
local MainGui = Main:FindFirstChild("SettingsShield")

local Tabs = MainGui.MenuContainer.Page.HubBar.HubBarContainer
local Windows = MainGui.MenuContainer.Page.PageViewClipper.PageView.PageViewInnerFrame
local HubBar = MainGui.MenuContainer.Page.HubBar.HubBarContainer

local TabManager = {}
local lastopened = {}

function TabManager:CreateTab(Config)
	Config = Config or {}
	Config.Title = Config.Title or "AnotherTab"
	Config.Icon = "rbxassetid://"..Config.Title or "rbxasset://studio_svg_textures/Shared/Placeholder/Dark/Standard/Placeholder.png"
	
	local Page_TabButton = Instance.new("TextButton")
	local Page_TabSelection = Instance.new("ImageLabel")
	local Page_TabLabel = Instance.new("Frame")
	local Page_Layout = Instance.new("UIListLayout")
	local Page_Icon = Instance.new("ImageLabel")
	local Page_AspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	local Page_Title = Instance.new("TextLabel")
	local Page = Instance.new("Frame")
	local Page_UIPadding = Instance.new("UIPadding")
	local Page_RowListLayout = Instance.new("UIListLayout")
	
	Page_TabButton.Name = Config.Title:gsub(" ", "").."Tab"
	Page_TabButton.Parent = HubBar
	Page_TabButton.BackgroundTransparency = 1.000
	Page_TabButton.Size = UDim2.new(0.2, 0, 1, 0)
	Page_TabButton.ZIndex = 3
	Page_TabButton.Text = ""

	Page_TabSelection.Name = "TabSelection"
	Page_TabSelection.Parent = Page_TabButton
	Page_TabSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Page_TabSelection.BorderSizePixel = 0
	Page_TabSelection.Position = UDim2.new(0, 3, 1, -2)
	Page_TabSelection.Size = UDim2.new(1, -2, 0, 2)
	Page_TabSelection.ZIndex = 3

	Page_TabLabel.Name = "TabLabel"
	Page_TabLabel.Parent = Page_TabButton
	Page_TabLabel.BackgroundTransparency = 1.000
	Page_TabLabel.BorderSizePixel = 0
	Page_TabLabel.Size = UDim2.new(1, 0, 1, 0)
	Page_TabLabel.ZIndex = 3

	Page_Layout.Name = "Layout"
	Page_Layout.Parent = Page_TabLabel
	Page_Layout.FillDirection = Enum.FillDirection.Horizontal
	Page_Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Page_Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Page_Layout.VerticalAlignment = Enum.VerticalAlignment.Center
	Page_Layout.Padding = UDim.new(0, 10)

	Page_Icon.Name = "Icon"
	Page_Icon.Parent = Page_TabLabel
	Page_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Page_Icon.BackgroundTransparency = 1.000
	Page_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Page_Icon.BorderSizePixel = 0
	Page_Icon.Size = UDim2.new(0, 24, 0, 24)
	Page_Icon.Image = Config.Icon

	Page_AspectRatioConstraint.Name = "AspectRatioConstraint"
	Page_AspectRatioConstraint.Parent = Page_Icon

	Page_Title.Name = "Title"
	Page_Title.Parent = Page_TabLabel
	Page_Title.BackgroundTransparency = 1.000
	Page_Title.Position = UDim2.new(1.20000005, 5, 0, -2)
	Page_Title.ZIndex = 3
	Page_Title.Font = Enum.Font.BuilderSansMedium
	Page_Title.Text = Config.Title
	Page_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Page_Title.TextSize = 19.000
	Page_Title.TextXAlignment = Enum.TextXAlignment.Left
	
	Page.Name = Config.Title:gsub(" ", "")
	Page.Parent = Windows
	Page.BackgroundTransparency = 1.000
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.ZIndex = 5
	Page.Visible = false

	Page_UIPadding.Parent = Page
	Page_UIPadding.PaddingLeft = UDim.new(0, 12)
	Page_UIPadding.PaddingRight = UDim.new(0, 11)

	Page_RowListLayout.Name = "RowListLayout"
	Page_RowListLayout.Parent = Page
	Page_RowListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Page_RowListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	Page_TabButton.MouseButton1Click:Connect(function()
		for i, v in Windows:GetChildren() do
			if v:IsA("Frame") then
				v.Visible = false
			end
		end
		Page.Visible = true
		for i, v in HubBar:GetChildren() do
			if v:IsA("TextButton") then
				v:FindFirstChild("TabSelection").Visible = false
				v:FindFirstChild("TabLabel"):FindFirstChild("Title").TextTransparency = 0.5
				if v:FindFirstChild("TabLabel"):FindFirstChild("Icon") then
					if typeof(v:FindFirstChild("TabLabel"):FindFirstChild("Icon")) == "TextLabel" then
						v:FindFirstChild("TabLabel"):FindFirstChild("Icon").TextTransparency = 0.5
					elseif typeof(v:FindFirstChild("Icon")) == "ImageLabel" then
						v:FindFirstChild("TabLabel"):FindFirstChild("Icon").ImageTransparency = 0.5
					end
				end
			end
		end
		Page_TabSelection.Visible = true
		Page_Title.TextTransparency = 0
		Page_Icon.ImageTransparency = 0
	end)
	
	local TabFunc = {}
	
	function TabFunc:AddButton(ButtonConfig)
		ButtonConfig = ButtonConfig or {}
		ButtonConfig.Title = ButtonConfig.Title or "Button"
		ButtonConfig.Text = ButtonConfig.Text or "Normal Button"
		ButtonConfig.Callback = ButtonConfig.Callback or function() print("Button Pressed") end
		
		local items = {}
		for i, v in Page:GetChildren() do
			if typeof(v) ~= "UIListLayout" or typeof(v) ~= "UIPadding" then
				table.insert(items, v)
			end 
		end
		
		local order
		
		if #items == 0 then
			order = 1
		else
			order = #items + 1
		end

		local Button = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")
		local ButtonLabel = Instance.new("TextLabel")
		local ButtonUIPadding = Instance.new("UIPadding")
		local ButtonClickButton = Instance.new("ImageButton")
		local UICorner_2 = Instance.new("UICorner")
		local Border = Instance.new("UIStroke")
		local ButtonClickbuttonLabel = Instance.new("TextLabel")
		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		Button.Name = ButtonConfig.Title
		Button.Parent = Page
		Button.Active = false
		Button.BackgroundColor3 = Color3.fromRGB(35, 37, 39)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.LayoutOrder = order
		Button.Position = UDim2.new(0, 0, 0, 800)
		Button.Selectable = false
		Button.Size = UDim2.new(1, 0, 0, 50)
		Button.ZIndex = 2
		Button.AutoButtonColor = false
		Button.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
		Button.ImageColor3 = Color3.fromRGB(35, 37, 39)
		Button.ImageTransparency = 1.000
		Button.ScaleType = Enum.ScaleType.Slice
		Button.SliceCenter = Rect.new(10, 10, 10, 10)

		UICorner.Parent = Button

		ButtonLabel.Name = "Label"
		ButtonLabel.Parent = Button
		ButtonLabel.BackgroundTransparency = 1.000
		ButtonLabel.Position = UDim2.new(0, 10, 0, 0)
		ButtonLabel.Size = UDim2.new(0.400000006, -20, 1, 0)
		ButtonLabel.ZIndex = 2
		ButtonLabel.Font = Enum.Font.BuilderSansMedium
		ButtonLabel.Text = ButtonConfig.Title
		ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonLabel.TextSize = 17.000
		ButtonLabel.TextWrapped = true
		ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left

		ButtonUIPadding.Name = "UIPadding"
		ButtonUIPadding.Parent = ButtonLabel
		ButtonUIPadding.PaddingBottom = UDim.new(0, 10)
		ButtonUIPadding.PaddingTop = UDim.new(0, 10)

		ButtonClickButton.Name = "ClickButton"
		ButtonClickButton.Parent = Button
		ButtonClickButton.AnchorPoint = Vector2.new(0, 0.5)
		ButtonClickButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ButtonClickButton.BackgroundTransparency = 1.000
		ButtonClickButton.Position = UDim2.new(0.400000006, 10, 0.5, 0)
		ButtonClickButton.Size = UDim2.new(0.600000024, -10, 0, 35)
		ButtonClickButton.ZIndex = 2
		ButtonClickButton.AutoButtonColor = false

		UICorner_2.Parent = ButtonClickButton

		Border.Name = "Border"
		Border.Parent = ButtonClickButton
		Border.Color = Color3.fromRGB(255, 255, 255)
		Border.Transparency = 0.300

		ButtonClickbuttonLabel.Name = "ClickbuttonLabel"
		ButtonClickbuttonLabel.Parent = ButtonClickButton
		ButtonClickbuttonLabel.BackgroundTransparency = 1.000
		ButtonClickbuttonLabel.BorderSizePixel = 0
		ButtonClickbuttonLabel.Size = UDim2.new(1, 0, 1, 0)
		ButtonClickbuttonLabel.ZIndex = 2
		ButtonClickbuttonLabel.Font = Enum.Font.BuilderSans
		ButtonClickbuttonLabel.Text = ButtonConfig.Text
		ButtonClickbuttonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonClickbuttonLabel.TextSize = 17.000
		ButtonClickbuttonLabel.TextTransparency = 0.300
		ButtonClickbuttonLabel.TextWrapped = true

		UITextSizeConstraint.Parent = ButtonClickbuttonLabel
		UITextSizeConstraint.MaxTextSize = 17
		
		ButtonClickButton.MouseButton1Click:Connect(ButtonConfig.Callback)
		
		local Misc = {}
		function Misc:ChangeTitle(title)
			ButtonLabel.Text = title
		end
		return Misc
	end
	
	function TabFunc:Separator(Text)
		local items = {}
		for i, v in Page:GetChildren() do
			if typeof(v) ~= "UIListLayout" or typeof(v) ~= "UIPadding" then
				table.insert(items, v)
			end 
		end

		local order

		if #items == 0 then
			order = 1
		else
			order = #items + 1
		end
		
		local Separator = Instance.new("ImageButton")
		local SepCorno2 = Instance.new("UICorner")
		local SepOverrideLabel = Instance.new("TextLabel")
		local SepCorner = Instance.new("UICorner")

		Separator.Name = "Separator"
		Separator.Parent = Page
		Separator.Active = false
		Separator.BackgroundColor3 = Color3.fromRGB(35, 37, 39)
		Separator.BackgroundTransparency = 1.000
		Separator.BorderSizePixel = 0
		Separator.LayoutOrder = 10
		Separator.Selectable = false
		Separator.Size = UDim2.new(1, 0, 0, 50)
		Separator.ZIndex = 2
		Separator.AutoButtonColor = false
		Separator.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
		Separator.ImageColor3 = Color3.fromRGB(35, 37, 39)
		Separator.ImageTransparency = 1.000
		Separator.ScaleType = Enum.ScaleType.Slice
		Separator.SliceCenter = Rect.new(2, 2, 18, 18)

		SepCorno2.Parent = Separator

		SepOverrideLabel.Name = "SepOverrideLabel"
		SepOverrideLabel.Parent = Separator
		SepOverrideLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		SepOverrideLabel.BackgroundTransparency = 0.750
		SepOverrideLabel.Size = UDim2.new(1, 0, 1, 0)
		SepOverrideLabel.ZIndex = 2
		SepOverrideLabel.Font = Enum.Font.BuilderSans
		SepOverrideLabel.Text = Text
		SepOverrideLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		SepOverrideLabel.TextSize = 20.000

		SepCorner.Parent = SepOverrideLabel
	end
	return TabFunc
end

local PlaceTab = TabManager:CreateTab({
	Title = "Place",
	Icon = "10734886004",
})

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end
everyClipboard = missing("function", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))

local PlaceId = PlaceTab:AddButton({
	Title = "Place Id",
	Text = "Copy Place Id",
	Callback = function()
		if everyClipboard then
			everyClipboard(game.PlaceId)
		else
			warn("No function to copy to clipboard.")
		end
	end,
})
PlaceId:ChangeTitle("Place Id: ["..game.PlaceId.."]")

local GameId = PlaceTab:AddButton({
	Title = "Game Id",
	Text = "Copy Game Id",
	Callback = function()
		if everyClipboard then
			everyClipboard(game.GameId)
		else
			warn("No function to copy to clipboard.")
		end
	end,
})
GameId:ChangeTitle("Game Id: ["..game.GameId.."]")

local JobId = PlaceTab:AddButton({
	Title = "Job Id",
	Text = "Copy Job Id",
	Callback = function()
		if everyClipboard then
			everyClipboard(game.JobId)
		else
			warn("No function to copy to clipboard.")
		end
	end,
})
JobId:ChangeTitle("Job Id: ["..game.JobId.."]")

PlaceTab:Separator("Utils")

local CopyInstance = PlaceTab:AddButton({
	Title = "Syn Save Instance",
	Text = "Save Instance",
	Callback = function()
		local Params = {
			RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
			SSI = "saveinstance",
		}
		local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
		local Options = {
			__DEBUG_MODE = true,
		}
		synsaveinstance(Options)
	end,
})

local ExecIY = PlaceTab:AddButton({
	Title = "Infinite Yield FE",
	Text = "Execute",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Noob-With-Z/reposts2/refs/heads/main/InfiniteYield.lua"))()
	end,
})

do
	for i, v in HubBar:GetChildren() do
		if v:IsA("TextButton") then
			local TabLabel = v:FindFirstChild("TabLabel")
			v.MouseButton1Click:Connect(function()
				for i, v in Windows:GetChildren() do
					if v:IsA("Frame") then
						v.Visible = false
					end
				end
				for i, v in HubBar:GetChildren() do
					if v:IsA("TextButton") then
						v:FindFirstChild("TabSelection").Visible = false
						TabLabel:FindFirstChild("Title").TextTransparency = 0.5
						if typeof(TabLabel:FindFirstChild("Icon")) == "TextLabel" then
							TabLabel:FindFirstChild("Icon").TextTransparency = 0.5
						elseif typeof(TabLabel:FindFirstChild("Icon")) == "ImageLabel" then
							TabLabel:FindFirstChild("Icon").ImageTransparency = 0.5
						end
					end
				end
				v:FindFirstChild("TabSelection").Visible = true
				TabLabel:FindFirstChild("Title").TextTransparency = 0
				if typeof(TabLabel:FindFirstChild("Icon")) == "TextLabel" then
					TabLabel:FindFirstChild("Icon").TextTransparency = 0
				elseif typeof(TabLabel:FindFirstChild("Icon")) == "ImageLabel" then
					TabLabel:FindFirstChild("Icon").ImageTransparency = 0
				end
				if v.Name == "GameSettingsTab" then
					if Windows:FindFirstChild("Page") then
						Windows:FindFirstChild("Page").Visible = true
					end
				elseif v.Name == "CapturesTab" then
					if Windows:FindFirstChild("Captures") then
						Windows:FindFirstChild("Captures").Visible = true
					end
				elseif v.Name == "ReportAbuseTab" then
					if Windows:FindFirstChild("ReportAbuseMenuNewContainerPage") then
						Windows:FindFirstChild("ReportAbuseMenuNewContainerPage").Visible = true
					end
				elseif v.Name == "HelpTab" then
					if Windows:FindFirstChild("Help") then
						Windows:FindFirstChild("Help").Visible = true
					end
				elseif v.Name == "PlayersTab" then
					if Windows:FindFirstChild("Players") then
						Windows:FindFirstChild("Players").Visible = true
					end
				end
			end)
		end
	end
end
