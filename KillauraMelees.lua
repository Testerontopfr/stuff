local rs = game:GetService("RunService")
local cankillaura
local CombatStaminaToggle
local InfStaminaToggle
local stunnedtoggle
local parrytoggle
local jumptoggle 
local parryhittoggle

local Multiplication = 1
local remotename = "hit"


local db = false
local antiragdoll = false
local noblood = false


local player = game:GetService("Players").LocalPlayer
local character = nil
local CharacterClient = nil
local dashcoolfunc = nil
local punchcoolfunc = nil
local stompcoolfunc = nil
local antidashcool = false
local antistompcool = false
local antipunchcool = false
local stompfunc = nil
local punchfunc = nil
local jumpfunc = nil
local dashfunc = nil
local stunhooked = false
local antitouchdone = false
local antitouch 

local stunboolvalue = nil
local parryboolvalue = nil

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()







local Window = Rayfield:CreateWindow({
    Name = "Lidar hub | Melees and blood 0.01",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Melees and Blood",
    LoadingSubtitle = "Lidar Hub",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Montellos Hub M and B"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })




 local CombatTab = Window:CreateTab("Combat", "gavel") -- Title, Image
 local MovementSection = CombatTab:CreateSection("")
 local Label = CombatTab:CreateLabel("Combat Features", nil, Color3.fromRGB(248, 227, 227), false) -- Title, Icon, Color, IgnoreTheme


 local MovementTab = Window:CreateTab("Movement", "feather") -- Title, Image

 local MovementSection = MovementTab:CreateSection("")
 local Label = MovementTab:CreateLabel("Movement Features", nil, Color3.fromRGB(248, 227, 227), false) -- Title, Icon, Color, IgnoreTheme

 local Divider = MovementTab:CreateDivider()


 local InfoTab = Window:CreateTab("Info", "search") -- Title, Image
 local Section = InfoTab:CreateSection("Credits")

local Label = InfoTab:CreateLabel("UI Library used - Rayfield by Sirius's Team", nil, Color3.fromRGB(89, 98, 175), false) -- Title, Icon, Color, IgnoreTheme
local Label = InfoTab:CreateLabel("Lidar Hub - By Tester", nil, Color3.fromRGB(89, 98, 175), false) -- Title, Icon, Color, IgnoreTheme


--local Divider = InfoTab:CreateDivider()



local Section = InfoTab:CreateSection("Contact Information")
local Label = InfoTab:CreateLabel("testerontopfr on Discord", nil, Color3.fromRGB(88, 101, 242), false) -- Title, Icon, Color, IgnoreTheme
local Label = InfoTab:CreateLabel("Testerontopfr on Gitub", "github", Color3.fromRGB(73, 73, 73), false) -- Title, Icon, Color, IgnoreTheme


 local Divider = CombatTab:CreateDivider()

 local BlatantSection = CombatTab:CreateSection("Blatant")


 local KilAuaraToggle = CombatTab:CreateToggle({
    Name = "Kill Aura (Fists Only)",
    CurrentValue = false,
    Flag = "KillAuraToggle1", 
    Callback = function(Value)
        cankillaura = Value
    end,
 })

local DamageSlider = CombatTab:CreateSlider({
    Name = "Damage Multiplier",
    Range = {1, 10},
    Increment = 1,
    Suffix = "x Damage",
    CurrentValue = 1,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        Multiplication = Value
    end,
 })

 local Label = CombatTab:CreateLabel("Multiplies damage by the number selected (e.g. Damage x 3)", "corner-left-up", Color3.fromRGB(128, 107, 107), false) -- Title, Icon, Color, IgnoreTheme

 --local Divider = CombatTab:CreateDivider()
 local ParryStunToggle = CombatTab:CreateToggle({
    Name = "No Parry / Stun",
    CurrentValue = false,
    Flag = "ParryStunToggle1", 
    Callback = function(Value)
         stunnedtoggle = Value
         parrytoggle = Value
         parryhittoggle = Value
    end,
 })
 

 local AntiTouchToggle = CombatTab:CreateToggle({
    Name = "Anti Touch",
    CurrentValue = false,
    Flag = "ParryStunToggle1", 
    Callback = function(Value)
        antitouch = Value
        if antitouchdone == false then
            for i,v in pairs(game.Workspace:GetDescendants()) do
                if not v:IsDescendantOf(game.Workspace.Characters) and not v:IsDescendantOf(game.Workspace.Blood) then
                    if v:IsA("TouchTransmitter") then 
                        v.Parent.CanTouch = false
                    end
                end
            end
            antitouchdone = true
        end
    end,
 })
 
 local Label = CombatTab:CreateLabel("Disables all touch, e.g. Fire, Grenade Stick Etc.", "corner-left-up", Color3.fromRGB(128, 107, 107), false) -- Title, Icon, Color, IgnoreTheme


 local LegitSection = CombatTab:CreateSection("Legit + Cooldown Section")

 local CStaminaToggle = CombatTab:CreateToggle({
    Name = "Combat Stamina",
    CurrentValue = false,
    Flag = "CStaminaToggle1", 
    Callback = function(Value)
        CombatStaminaToggle = Value
    end,
 })


 local PunchCooldownToggle = CombatTab:CreateToggle({
    Name = "No Punch Cooldown",
    CurrentValue = false,
    Flag = "PunchCooldownToggle1", 
    Callback = function(Value)
         antipunchcool = Value
    end,
 })
 


 local StompCooldownToggle = CombatTab:CreateToggle({
    Name = "No Stomp Cooldown",
    CurrentValue = false,
    Flag = "StompCooldownToggle1", 
    Callback = function(Value)
        antistompcool = Value
    end,
 })
 


 local PerformanceSection = CombatTab:CreateSection("Performance")

 local NoBlood = CombatTab:CreateToggle({
    Name = "No Blood",
    CurrentValue = false,
    Flag = "NoBloodToggle1", 
    Callback = function(Value)
        noblood = Value
    end,
 })

 
 local StaminaToggle = MovementTab:CreateToggle({
    Name = "Stamina",
    CurrentValue = false,
    Flag = "StaminaToggle1", 
    Callback = function(Value)
        InfStaminaToggle = Value
    end,
 })


 local RagdollToggle = MovementTab:CreateToggle({
    Name = "No Ragdoll",
    CurrentValue = false,
    Flag = "RagdollToggle1", 
    Callback = function(Value)
        antiragdoll = Value
    end,
 })


 local CooldownSection = MovementTab:CreateSection("Cooldown Section")

 local DashCooldownToggle = MovementTab:CreateToggle({
    Name = "No Dash Cooldown",
    CurrentValue = false,
    Flag = "DashCooldownToggle1", 
    Callback = function(Value)
         antidashcool = Value
    end,
 })

 local JumpCooldownToggle = MovementTab:CreateToggle({
    Name = "No Jump Cooldown (In progress)",
    CurrentValue = false,
    Flag = "DashCooldownToggle1", 
    Callback = function(Value)
         jumptoggle = Value
    end,
 })


 local Section = MovementTab:CreateSection("Notes")
local Label = MovementTab:CreateLabel("Please note that the serverside anticheat will prevent you from moving too fast", nil, Color3.fromRGB(255, 0, 0), false) -- Title, Icon, Color, IgnoreTheme









------------------------------------------------------------------------------------------------



    game.Workspace.DescendantAdded:Connect(function(descendant)
        if antitouch == true then
            if descendant.ClassName == "TouchTransmitter" and not descendant:IsDescendantOf(game.Workspace.Characters) and not descendant:IsDescendantOf(game.Workspace.Blood) then
                descendant.Parent.CanTouch = false
            end
        end
    end)


local function killaura()
    rs.RenderStepped:Connect(function()
        for i,v in pairs(game.Players:GetChildren()) do
            
				if v ~= game.Players.LocalPlayer then

                 
                    if v.Character ~= nil then

                          if v.Name ~= "Skybe6009" or v.Name ~= "Rustsn2738" then
                            if v.Character:FindFirstChild('HumanoidRootPart') then 
                                if (v.Character.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 and v.Character.Humanoid.Health > 0 then
                                    if v.Character:FindFirstChild("IsParry").Value == false and cankillaura == true then
                                        wait(.1)
                                        local args = {
                                            [1] = v.Character:FindFirstChild("Torso"),
                                            [2] = v.Character:FindFirstChild("Torso").Position
                                        }
                                        if player.Character:FindFirstChild("Fists") then
                                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fists").WeaponServer.hit:FireServer(unpack(args))
                                        end    
                                    end
                                    if v.Character:FindFirstChild("IsParry").Value == false then
                                        wait(.3)
                                    end
                                end 
                            end

                        end
                        


                    end

				end
		end
    end)

end

local function loop()
    rs.RenderStepped:Connect(function()
        if InfStaminaToggle == true then
            game.Players.LocalPlayer.Character.CharacterClient.stamina.Value = 100
        end
        if CombatStaminaToggle == true then
             game.Players.LocalPlayer.Character.CombatStamina.Value = 100
        end
        if stunnedtoggle == true then
        --      game.Players.LocalPlayer.Character.IsStunned.Value = false
        end
        if parrytoggle == true then
       -- game.Players.LocalPlayer.Character.IsParry.Value = false
        end
        if parryhittoggle == true then
       -- game.Players.LocalPlayer.Character.ParryHit.Value = false
        end
    end)
    
    end
    


    local function DeleteBlood()
        rs.RenderStepped:Connect(function()
            for i,v in pairs(game.Workspace.Blood:GetChildren()) do 
                if v ~= nil and noblood == true then
                  v:Destroy()
                end
            end
    end)
    end


local function nodelayloop()
    rs.RenderStepped:Connect(function()
        if player.Character ~= nil then character = player.Character
            --Cooldown area
            if character:FindFirstChild("CharacterClient") then
                CharacterClient = character.CharacterClient
                local senv = getsenv(CharacterClient)
                dashcoolfunc = senv.makecool
                punchcoolfunc = senv.punchcool
                stompcoolfunc = senv.stompcool
                dashfunc = senv.dash
                punchfunc = senv.punch
                stompfunc = senv.stomp
                jumpfunc = senv.Jumping
    
                 if antidashcool == true then 
                    debug.setupvalue(dashfunc, 5, true)
                 end
                 if antipunchcool == true then 
                    debug.setupvalue(punchfunc, 3, false)
                 end
                 if antistompcool == true then 
                    debug.setupvalue(stompfunc, 3, false)
                    debug.setupvalue(stompcoolfunc, 1, false)
                 end

    
            else CharacterClient = nil
                
            end


            if jumptoggle == true then 
                character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            end
            --Cooldown area ended

            if character:FindFirstChild("IsStunned") and character:FindFirstChild("IsParry")then
              stunboolvalue = character.IsStunned
              parryboolvalue = character.IsParry
                if stunhooked == false then
                    stunhooked = true
                    for i, connection in pairs(getconnections(stunboolvalue.Changed)) do 
                        local olhook = hookfunction(connection.Function, function(...) 
                            if stunnedtoggle == true then
                                stunboolvalue.Value = false
                                return
                            end 
                            

                            
                        end)
                    end


                    for i, connection in pairs(getconnections(parryboolvalue.Changed)) do 
                        local olhook = hookfunction(connection.Function, function(...) 
                            if parrytoggle == true then
                                parryboolvalue.Value = false
                                return
                            end 
                            

                            
                        end)
                    end



                end
            end    

        end
    
    
    
    
    
        -- hookfunction
    
        --[[if dashcoolfunc ~= nil then 
            local oldhook = hookfunction(dashcoolfunc, function(...)
                if antidashcool == true then 
                        return 
                end
                return oldhook(...)
            end)
        end
    
        if punchcoolfunc ~= nil then 
            local oldhook = hookfunction(punchcoolfunc, function(...)
                if antipunchcool == true then 
                    return  
            end
            return oldhook(...)
            end)
        end]]
    
        --[[if stompcoolfunc ~= nil then 
            local oldhook = hookfunction(stompcoolfunc, function(...)
                if antistompcool then 
                    return 
                end
                return oldhook(...)
            end)
        end]]
    
    
    end)
    
    
    
end



coroutine.wrap(nodelayloop)()
coroutine.wrap(loop)()

coroutine.wrap(killaura)()
coroutine.wrap(DeleteBlood)()


player.CharacterAdded:Connect(function(character)
    stunhooked = false
end)



local oldnamecall 

oldnamecall = hookmetamethod(game, "__namecall", function(self,...)
        if checkcaller() then return oldnamecall(self,...) end
        local method = getnamecallmethod()

            if self.Name == remotename and method == "FireServer" and db == false then
                    db = true

                        for i = 1, Multiplication do
                            self:FireServer(...)
                            print("Doing".. Multiplication)
                        end
                    db = false
                    return nil
            end

            if self.Name == "ragdoll" and method == "FireServer" and antiragdoll == true then
                return nil
            end


        return oldnamecall(self,...)
end)



Rayfield:LoadConfiguration()

Rayfield:Notify({
    Title = "Disclaimer",
    Content = "Successfully Loaded Hub",
    Duration = 6.5,
    Image = "check",
 })


 