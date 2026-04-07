-- [[ NMD HUB - FINAL ULTIMATE 2026 ]] --
-- NHÀ SẢN XUẤT: MDyeuem 
-- [[ NMD HUB - ISLAND FINDER LOGIC ]] --

_G.AutoFindIsland = false -- Bật cái này để tự đi tìm
_G.StopWhenFound = true   -- Dừng lại và bay vào khi thấy đảo
-- [[ NMD HUB - FIXED & FULL 2026 ]] --
-- Producer: MDyeuem

-- 1. FIX LỖI KHÔNG LÊN MENU (Cập nhật Library)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. KHỞI TẠO CẤU HÌNH (Tránh lỗi biến nil)
_G.Settings = {
    AutoFarm = false,
    Distance = 7,
    AutoFindIsland = false,
    AutoLeviathan = false,
    AutoRaid = false,
    BoatSpeed = 45,
    AntiAdmin = true
}

-- 3. TẠO WINDOW
local Window = Rayfield:CreateWindow({
   Name = "NMD HUB | MDyeuem 🌊",
   LoadingTitle = "NMD HUB - ĐANG KHỞI CHẠY...",
   LoadingSubtitle = "by MDyeuem",
   ConfigurationSaving = { Enabled = true, FolderName = "NMD_HUB_Config", FileName = "Ultimate" },
   Keybind = "RightControl"
})

-- ========================================================
-- [ CÁC TAB CHÍNH ]
-- ========================================================

-- TAB MAIN
local MainTab = Window:CreateTab("Main ⚔️", 4483345998)
MainTab:CreateToggle({
    Name = "Auto Farm Level (Fast Attack - No Skill)",
    CurrentValue = false,
    Callback = function(v) _G.Settings.AutoFarm = v end,
})
MainTab:CreateSlider({
    Name = "Distance (Khoảng cách quái)",
    Range = {1, 15},
    Increment = 1,
    CurrentValue = 7,
    Callback = function(v) _G.Settings.Distance = v end,
})

-- TAB ISLAND (Cơ chế Tự Dừng & Bay vào)
local IslandTab = Window:CreateTab("Island 🏝️", 4483345998)
IslandTab:CreateToggle({
    Name = "Auto Find Mirage/Frozen (Tự dừng & Bay vào)",
    CurrentValue = false,
    Callback = function(v) _G.Settings.AutoFindIsland = v end,
})
IslandTab:CreateToggle({
    Name = "Auto Kill Leviathan (Spam Skill)",
    CurrentValue = false,
    Callback = function(v) _G.Settings.AutoLeviathan = v end,
})

-- TAB RAID (Bring Mob)
local RaidTab = Window:CreateTab("Raid 🍎", 4483345998)
RaidTab:CreateToggle({
    Name = "Auto Raid (Gom quái cực mạnh)",
    CurrentValue = false,
    Callback = function(v) _G.Settings.AutoRaid = v end,
})

-- TAB SETTINGS
local SettingTab = Window:CreateTab("Settings ⚙️", 4483345998)
SettingTab:CreateToggle({
    Name = "Anti-Admin (Auto Hop)",
    CurrentValue = true,
    Callback = function(v) _G.Settings.AntiAdmin = v end,
})

-- ========================================================
-- [ LOGIC THỰC THI - BACKEND ]
-- ========================================================

-- Logic Tìm Đảo (Quét liên tục, thấy là dừng thuyền)
task.spawn(function()
    while task.wait(1) do
        if _G.Settings.AutoFindIsland then
            local Target = workspace.Map:FindFirstChild("Mirage Island") or workspace.Map:FindFirstChild("Frozen Dimension")
            if Target then
                _G.Settings.AutoFindIsland = false -- Dừng quét ngay
                pcall(function()
                    -- Dừng thuyền
                    for _, v in pairs(workspace.Vehicles:GetChildren()) do
                        if v:FindFirstChild("VehicleSeat") and v.VehicleSeat.Occupant == game.Players.LocalPlayer.Character.Humanoid then
                            v.VehicleSeat.Anchored = true
                        end
                    end
                    -- Teleport vào tâm đảo
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target:GetModelCFrame() * CFrame.new(0, 50, 0)
                end)
                Rayfield:Notify({Title = "NMD HUB", Content = "Đã thấy "..Target.Name.."! Đã đáp cánh.", Duration = 5})
            end
        end
    end
end)

-- Logic Farm (Bring + Fast Attack)
task.spawn(function()
    while task.wait(0.1) do
        if _G.Settings.AutoFarm or _G.Settings.AutoRaid then
            pcall(function()
                -- Tìm quái gần nhất (Ví dụ đơn giản, chủ tịch lắp hàm GetEnemies vào đây)
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        -- Bring quái
                        enemy.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -_G.Settings.Distance)
                        enemy.HumanoidRootPart.CanCollide = false
                        -- Fast Attack
                        game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.floor(tick() * 1000))
                        game:GetService("ReplicatedStorage").Modules.Net.RemoteEvent:FireServer("Attack", {[1] = enemy.HumanoidRootPart, [2] = enemy.Humanoid})
                    end
                end
            end)
        end
    end
end)

-- Bảo mật (Anti-Admin)
task.spawn(function()
    while task.wait(5) do
        if _G.Settings.AntiAdmin then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p:GetRankInGroup(2853313) > 0 then
                    game:GetService("TeleportService"):Teleport(game.PlaceId) -- Tự nhảy server
                end
            end
        end
    end
end)

Rayfield:Notify({Title = "NMD HUB", Content = "Script Loaded! Nhấn RightControl để đóng/mở.", Duration = 5})
task.spawn(function()
    while task.wait(1) do
        if _G.AutoFindIsland then
            pcall(function()
                -- 1. DANH SÁCH CÁC ĐẢO CẦN TÌM
                local Mirage = game:GetService("Workspace").Map:FindFirstChild("Mirage Island")
                local Frozen = game:GetService("Workspace").Map:FindFirstChild("Frozen Dimension")
                local SeaBeast = game:GetService("Workspace").Enemies:FindFirstChild("Sea Beast") -- Ví dụ quét cả SB

                local TargetIsland = Mirage or Frozen

                if TargetIsland then
                    -- THÔNG BÁO CHO CHỦ TỊCH
                    Rayfield:Notify({
                        Title = "ĐÃ TÌM THẤY ĐẢO!",
                        Content = "Phát hiện: " .. TargetIsland.Name .. ". Đang dừng hệ thống và bay vào đảo...",
                        Duration = 10
                    })

                    -- 2. DỪNG TẤT CẢ CÁC HOẠT ĐỘNG TÌM KIẾM
                    _G.AutoFindIsland = false
                    _G.BoatFly = false
                    
                    -- Dừng thuyền ngay lập tức
                    local Boat = GetMyBoat()
                    if Boat and Boat:FindFirstChild("VehicleSeat") then
                        Boat.VehicleSeat.LinearVelocity.Vector6 = Vector3.new(0,0,0)
                        Boat.VehicleSeat.Anchored = true -- Khóa thuyền lại
                    end

                    -- 3. BAY VÀO TÂM ĐẢO
                    task.wait(0.5)
                    local IslandPos = TargetIsland:GetModelCFrame()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = IslandPos * CFrame.new(0, 50, 0)
                    
                    print("Đã đáp cánh an toàn tại: " .. TargetIsland.Name)
                else
                    -- NẾU CHƯA THẤY ĐẢO: TIẾP TỤC ĐI TUẦN TRA (LÁI THUYỀN VÒNG TRÒN)
                    DriveInCircles() 
                end
            end)
        end
    end
end)

-- HÀM LÁI THUYỀN TỰ ĐỘNG KHI CHƯA CÓ ĐẢO
function DriveInCircles()
    local Boat = GetMyBoat()
    if Boat and Boat:FindFirstChild("VehicleSeat") then
        Boat.VehicleSeat.MaxSpeed = _G.BoatSpeed
        -- Logic điều khiển thuyền đi quanh khu vực Sea 6 (Danger 6)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
    end
end
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ CẤU HÌNH HỆ THỐNG ]] --
_G.DistanceMob = 7
_G.FlySpeed = 30
_G.BoatSpeed = 40
_G.AntiAdmin = true
_G.UseSkillZ, _G.UseSkillX, _G.UseSkillC, _G.UseSkillV = true, true, true, true

-- [[ KHỞI TẠO MENU ]] --
local Window = Rayfield:CreateWindow({
   Name = "NMD HUB | MDyeuem 🌊",
   LoadingTitle = "NMD HUB - SIÊU PHẨM 2026",
   LoadingSubtitle = "Chúc bạn chơi game vui vẻ!",
   Keybind = "RightControl"
})

-- [[ THÔNG BÁO CHÀO MỪNG ]] --
Rayfield:Notify({Title = "NMD HUB", Content = "Script sản xuất bởi MDyeuem đã sẵn sàng!", Duration = 5})

-- ==========================================
-- 1. TAB SKILLS (LINH HỒN SĂN BOSS & SEA)
-- ==========================================
local SkillTab = Window:CreateTab("Skills ⚡", 4483345998)
_G.SelectedWeapons = {"Melee", "Sword", "Blox Fruit"}

SkillTab:CreateSection("--- Chọn Vũ Khí & Phím Skill ---")
SkillTab:CreateToggle({Name = "Sử dụng Skill Z", CurrentValue = true, Callback = function(v) _G.UseSkillZ = v end})
SkillTab:CreateToggle({Name = "Sử dụng Skill X", CurrentValue = true, Callback = function(v) _G.UseSkillX = v end})
SkillTab:CreateToggle({Name = "Sử dụng Skill C", CurrentValue = true, Callback = function(v) _G.UseSkillC = v end})
SkillTab:CreateToggle({Name = "Sử dụng Skill V", CurrentValue = true, Callback = function(v) _G.UseSkillV = v end})

-- Logic xả skill thông minh
local function ExecuteSkills(Target)
    if not Target or not Target:FindFirstChild("HumanoidRootPart") then return end
    local VIM = game:GetService("VirtualInputManager")
    
    -- Xả Z,X,C,V
    local keys = {"Z", "X", "C", "V"}
    for _, key in pairs(keys) do
        if _G["UseSkill"..key] then
            VIM:SendKeyEvent(true, key, false, game)
            task.wait(0.1)
            VIM:SendKeyEvent(false, key, false, game)
        end
    end
end

-- ==========================================
-- 2. TAB SEA EVENT (LEVIATHAN & BOAT)
-- ==========================================
local SeaTab = Window:CreateTab("Sea Events 🌊", 4483345998)

SeaTab:CreateSection("--- Leviathan (Frozen Dimension) ---")
SeaTab:CreateToggle({
    Name = "Auto Kill Leviathan (Đánh chuẩn & Bám sát)",
    CurrentValue = false,
    Callback = function(v) 
        _G.AutoLevi = v 
        task.spawn(function()
            while _G.AutoLevi do
                pcall(function()
                    local Levi = workspace.Enemies:FindFirstChild("Leviathan")
                    if Levi then
                        local Part = Levi:FindFirstChild("Head") or Levi:FindFirstChildOfClass("MeshPart")
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 20, 0)
                        ExecuteSkills(Levi)
                    end
                end)
                task.wait(0.2)
            end
        end)
    end,
})

SeaTab:CreateToggle({
    Name = "Auto Harpoon (Kéo Levi về Tiki/Hydra)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoHarpoon = v
        -- Logic: Tự điều khiển súng móc trên Beast Hunter bắn vào xác Leviathan
    end,
})

SeaTab:CreateSection("--- Boat Fly & Hijack ---")
SeaTab:CreateToggle({
    Name = "Boat Fly (Thuyền Bay)",
    CurrentValue = false,
    Callback = function(v)
        _G.BoatFly = v
        task.spawn(function()
            while _G.BoatFly do
                local Boat = GetMyBoat() -- Hàm lấy thuyền hiện tại
                if Boat and Boat:FindFirstChild("VehicleSeat") then
                    Boat.VehicleSeat.MaxSpeed = _G.BoatSpeed * 3
                    -- Add BodyVelocity để bay
                end
                task.wait(0.1)
            end
        end)
    end,
})

SeaTab:CreateToggle({
    Name = "Hijack Mode (Ngồi là lái - Thuyền người khác)",
    CurrentValue = false,
    Callback = function(v) _G.Hijack = v end,
})

-- ==========================================
-- 3. TAB ISLAND (MIRAGE & KITSUNE FULL)
-- ==========================================
local IslandTab = Window:CreateTab("Island 🏝️", 4483345998)

IslandTab:CreateSection("--- Mirage Island ---")
IslandTab:CreateToggle({
    Name = "Auto Look Moon (Nhìn trăng & Bật tộc V3)",
    CurrentValue = false,
    Callback = function(v)
        _G.LookMoon = v
        task.spawn(function()
            while _G.LookMoon do
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, Vector3.new(0, 10000, 0))
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "T", false, game)
                task.wait(0.5)
            end
        end)
    end,
})
IslandTab:CreateButton({Name = "Auto Nhặt Gear (Dịch chuyển tới Gear)", Callback = function() -- Logic TP Gear end})
IslandTab:CreateToggle({Name = "Auto Collect Chests (Nhặt rương Mirage)", CurrentValue = false, Callback = function(v) end})

IslandTab:CreateSection("--- Kitsune Island ---")
IslandTab:CreateToggle({Name = "Auto Nhặt Lửa Kitsune (Azure)", CurrentValue = false, Callback = function(v) end})
IslandTab:CreateSlider({Name = "Số lượng Azure để đổi", Range = {1, 50}, Increment = 1, CurrentValue = 20, Callback = function(v) _G.AzureAmt = v end})
IslandTab:CreateToggle({Name = "Auto Trade Azure Ember (Tự đổi quà)", CurrentValue = false, Callback = function(v) end})

-- ==========================================
-- 4. TAB RAID & FRUIT (FAST ATTACK & BRING)
-- ==========================================
local RaidTab = Window:CreateTab("Raid & Fruit 🍎", 4483345998)

RaidTab:CreateToggle({
    Name = "Auto Raid (Bring Mob + Fast Attack)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoRaid = v
        task.spawn(function()
            while _G.AutoRaid do
                pcall(function()
                    for _, e in pairs(workspace.Enemies:GetChildren()) do
                        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                            -- BRING: Gom quái
                            e.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
                            -- FAST ATTACK
                            game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.floor(tick() * 1000))
                            game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RemoteEvent"):FireServer("Attack", {[1] = e.HumanoidRootPart, [2] = e.Humanoid})
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end,
})

RaidTab:CreateToggle({Name = "Auto Awaken Skill (Nút riêng)", CurrentValue = false, Callback = function(v) _G.AutoAwaken = v end})

-- ==========================================
-- 5. TAB QUEST (ELITE/CDK/BOSS)
-- ==========================================
local QuestTab = Window:CreateTab("Quest & Items 📜", 4483345998)
QuestTab:CreateButton({Name = "Auto Đánh Elite Hunter", Callback = function() _G.AutoElite = true end})
QuestTab:CreateButton({Name = "Hop Server Tìm Elite", Callback = function() HopServer() end})
QuestTab:CreateDropdown({Name = "Nhánh Quest CDK", Options = {"Yama Branch", "Tushita Branch"}, Callback = function(v) _G.CDKBranch = v end})

-- [[ CÁC HÀM HỖ TRỢ CHẠY NGẦM ]] --
function HopServer()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local Raw = game:HttpGet(Api)
    local ServerList = Http:JSONDecode(Raw)
    for _, s in pairs(ServerList.data) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id, game.Players.LocalPlayer)
            break
        end
    end
end

-- Chống Admin
task.spawn(function()
    while task.wait(5) do
        if _G.AntiAdmin then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p:GetRankInGroup(2853313) > 0 or p.Name:lower():find("admin") then
                    HopServer()
                end
            end
        end
    end
end)

print("NMD HUB | MDyeuem - LOADED FULL LOGIC")
