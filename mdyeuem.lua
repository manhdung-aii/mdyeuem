-- [[ NMD HUB - FAST LOAD v15.0 ]] --
-- Tối ưu tốc độ hiển thị và thêm nhận diện thương hiệu

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
--[[
    NMD HUB - ULTIMATE VERSION 2026
    Producer: MDyeuem
    Support: Sea 2 & Sea 3 (Full Meta)
    Features: Auto Farm, Sea Event, Island Quest, Security
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ SYSTEM VARIABLES ]] --
_G.Lang = "Vietnamese"
_G.FlySpeed = 30
_G.DistanceMob = 7
_G.BoatSpeed = 40
_G.SelectedBoat = "Grand Enforcer"
_G.AntiAdmin = true
_G.TimedServerHop = false
_G.AutoNextIsland = true

-- Skill Config
_G.UseSkillZ, _G.UseSkillX, _G.UseSkillC, _G.UseSkillV = true, true, true, true
_G.UseMelee, _G.UseSword, _G.UseFruit, _G.UseGun = true, true, true, false

-- Sea Event Config
_G.OnlyFruitSea = false
_G.OnlyGunSea = false
_G.AutoLevi = false
_G.AutoHarpoon = false

-- [[ NOTIFICATION START ]] --
local Window = Rayfield:CreateWindow({
   Name = "NMD HUB | MDyeuem 🌊",
   LoadingTitle = "NMD HUB - SIÊU PHẨM 2026",
   LoadingSubtitle = "by MDyeuem",
   ConfigurationSaving = { Enabled = true, FolderName = "NMD_HUB_Config", FileName = "Main" },
   Keybind = "RightControl"
})

Rayfield:Notify({
    Title = "NMD HUB",
    Content = "NMD HUB chúc các bạn chơi game vui vẻ! Nhà sản xuất: MDyeuem",
    Duration = 6.5,
    Image = 4483345998,
})

-- ==========================================
-- 1. TAB: MAIN (FARMING)
-- ==========================================
local MainTab = Window:CreateTab("Main ⚔️", 4483345998)

MainTab:CreateSection("--- Farm Bone & Cake Prince ---")
MainTab:CreateToggle({
    Name = "Auto Farm Bone & Soul Reaper",
    CurrentValue = false,
    Callback = function(v) _G.AutoBone = v end,
})

MainTab:CreateToggle({
    Name = "Auto Cake Prince / Dough King (500 Mobs)",
    CurrentValue = false,
    Callback = function(v) 
        _G.AutoDough = v 
        -- Logic: Tự kiểm tra Cúp Sô-cô-la để summon Dough King
    end,
})

-- ==========================================
-- 2. TAB: SKILLS (COMBO SETUP)
-- ==========================================
local SkillTab = Window:CreateTab("Skills ⚡", 4483345998)

SkillTab:CreateSection("--- Chọn Vũ Khí (Chỉ áp dụng Sea Event) ---")
SkillTab:CreateToggle({Name = "Dùng Melee", CurrentValue = true, Callback = function(v) _G.UseMelee = v end})
SkillTab:CreateToggle({Name = "Dùng Sword", CurrentValue = true, Callback = function(v) _G.UseSword = v end})
SkillTab:CreateToggle({Name = "Dùng Fruit", CurrentValue = true, Callback = function(v) _G.UseFruit = v end})
SkillTab:CreateToggle({Name = "Dùng Gun", CurrentValue = false, Callback = function(v) _G.UseGun = v end})

SkillTab:CreateSection("--- Tùy Chỉnh Phím Skill ---")
SkillTab:CreateToggle({Name = "Skill Z", CurrentValue = true, Callback = function(v) _G.UseSkillZ = v end})
SkillTab:CreateToggle({Name = "Skill X", CurrentValue = true, Callback = function(v) _G.UseSkillX = v end})
SkillTab:CreateToggle({Name = "Skill C", CurrentValue = true, Callback = function(v) _G.UseSkillC = v end})
SkillTab:CreateToggle({Name = "Skill V", CurrentValue = true, Callback = function(v) _G.UseSkillV = v end})

-- ==========================================
-- 3. TAB: QUEST & ITEMS (ELITE/CDK/BOSS)
-- ==========================================
local QuestTab = Window:CreateTab("Quest & Items 📜", 4483345998)

QuestTab:CreateSection("--- Elite Hunter ---")
QuestTab:CreateButton({Name = "Auto Farm Elite Hunter (Đánh)", Callback = function() _G.AutoElite = true end})
QuestTab:CreateButton({Name = "Hop Server Elite (Tìm)", Callback = function() HopServer() end})

QuestTab:CreateSection("--- CDK Quest (Alucard Fragment) ---")
QuestTab:CreateDropdown({
    Name = "Chọn Nhánh Nhiệm Vụ Trước",
    Options = {"Tushita Branch", "Yama Branch"},
    CurrentOption = "Tushita Branch",
    Callback = function(v) _G.CDKBranch = v end,
})
QuestTab:CreateButton({Name = "Auto Lấy Yama", Callback = function() end})
QuestTab:CreateButton({Name = "Auto Lấy Tushita", Callback = function() end})

QuestTab:CreateSection("--- Raid Boss Summon ---")
QuestTab:CreateToggle({Name = "Auto Summon & Farm Rip Indra", CurrentValue = false, Callback = function(v) end})
QuestTab:CreateButton({Name = "Auto Summon Darkbeard (Râu Đen)", Callback = function() end})
QuestTab:CreateToggle({Name = "Auto Order Boss (Sea 2)", CurrentValue = false, Callback = function(v) end})
QuestTab:CreateButton({Name = "Auto Up Tộc V2/V3", Callback = function() end})

-- ==========================================
-- 4. TAB: ISLAND (MIRAGE/KITSUNE/FROZEN)
-- ==========================================
local IslandTab = Window:CreateTab("Island 🏝️", 4483345998)

IslandTab:CreateSection("--- Mirage Island (Đảo Bí Ẩn) ---")
IslandTab:CreateToggle({Name = "Auto Look Moon + Bật Tộc", CurrentValue = false, Callback = function(v) end})
IslandTab:CreateToggle({Name = "Auto Find Gear", CurrentValue = false, Callback = function(v) end})
IslandTab:CreateToggle({Name = "Auto Nhặt Rương Đảo", CurrentValue = false, Callback = function(v) end})
IslandTab:CreateButton({Name = "Tìm Người Bán Fruit Bí Ẩn", Callback = function() end})

IslandTab:CreateSection("--- Kitsune Island ---")
IslandTab:CreateToggle({Name = "Auto Nhặt Lửa Kitsune", CurrentValue = false, Callback = function(v) end})
IslandTab:CreateSlider({Name = "Chọn Lượng Lửa Để Đổi", Range = {1, 50}, Increment = 1, CurrentValue = 20, Callback = function(v) _G.AzureAmt = v end})
IslandTab:CreateToggle({Name = "Auto Trade Azure Ember", CurrentValue = false, Callback = function(v) end})

-- ==========================================
-- 5. TAB: SEA EVENT (LEVIATHAN/BOAT)
-- ==========================================
local SeaTab = Window:CreateTab("Sea Events 🌊", 4483345998)

SeaTab:CreateSection("--- Leviathan (Frozen Dimension) ---")
SeaTab:CreateToggle({Name = "Auto Kill Leviathan (Bám sát + Skill)", CurrentValue = false, Callback = function(v) _G.AutoLevi = v end})
SeaTab:CreateToggle({Name = "Auto Harpoon Kéo Levi về Tiki/Hydra", CurrentValue = false, Callback = function(v) _G.AutoHarpoon = v end})

SeaTab:CreateSection("--- Boat Control ---")
SeaTab:CreateDropdown({Name = "Chọn Thuyền", Options = {"Grand Enforcer", "Beast Hunter", "Sloop"}, CurrentOption = "Grand Enforcer", Callback = function(v) _G.SelectedBoat = v end})
SeaTab:CreateToggle({Name = "Boat Fly (Thuyền Bay)", CurrentValue = false, Callback = function(v) end})
SeaTab:CreateToggle({Name = "Hijack Mode (Lái Thuyền Người Khác)", CurrentValue = false, Callback = function(v) end})
SeaTab:CreateSlider({Name = "Tốc độ thuyền (Recommend 40)", Range = {1, 100}, Increment = 1, CurrentValue = 40, Callback = function(v) _G.BoatSpeed = v end})

SeaTab:CreateSection("--- Chế Độ Ưu Tiên ---")
SeaTab:CreateToggle({Name = "Only Fruit Mode", CurrentValue = false, Callback = function(v) _G.OnlyFruitSea = v end})
SeaTab:CreateToggle({Name = "Only Gun Mode", CurrentValue = false, Callback = function(v) _G.OnlyGunSea = v end})

-- ==========================================
-- 6. TAB: RAID & FRUIT
-- ==========================================
local RaidTab = Window:CreateTab("Raid & Fruit 🍎", 4483345998)

RaidTab:CreateToggle({Name = "Auto Raid (Bring Mob + Fast Attack)", CurrentValue = false, Callback = function(v) _G.AutoRaid = v end})
RaidTab:CreateToggle({Name = "Auto Thức Tỉnh Chiêu (Awaken - Nút Riêng)", CurrentValue = false, Callback = function(v) _G.AutoAwaken = v end})
RaidTab:CreateToggle({Name = "Auto Nhặt Trái Ác Quỷ", CurrentValue = false, Callback = function(v) end})

-- ==========================================
-- 7. TAB: SERVER STATUS (RADAR)
-- ==========================================
local StatusTab = Window:CreateTab("Status 📊", 4483345998)
local CakeLabel = StatusTab:CreateLabel("Cake Prince: Đang quét...", 4483345998)
local DoughLabel = StatusTab:CreateLabel("Dough King: Đang quét...", 4483345998)
local EliteLabel = StatusTab:CreateLabel("Elite Hunter: Đang quét...", 4483345998)

-- ==========================================
-- 8. TAB: TELEPORT
-- ==========================================
local TeleTab = Window:CreateTab("Teleport 📍", 4483345998)
TeleTab:CreateDropdown({Name = "Chọn Đảo Sea 3", Options = {"Mansion", "Tiki", "Hydra", "Castle"}, Callback = function(v) end})
TeleTab:CreateDropdown({Name = "Chọn Đảo Sea 2", Options = {"Cafe", "Dark Arena", "Kingdom"}, Callback = function(v) end})

-- ==========================================
-- 9. TAB: SETTINGS (SECURITY/LANG)
-- ==========================================
local SettingTab = Window:CreateTab("Settings ⚙️", 4483345998)

SettingTab:CreateDropdown({Name = "Ngôn Ngữ / Language", Options = {"Tiếng Việt", "English"}, CurrentOption = "Tiếng Việt", Callback = function(v) _G.Lang = v end})
SettingTab:CreateToggle({Name = "Anti-Admin (Auto Hop - Mặc Định Bật)", CurrentValue = true, Callback = function(v) _G.AntiAdmin = v end})
SettingTab:CreateToggle({Name = "Đổi Server Mỗi 30 Phút", CurrentValue = false, Callback = function(v) _G.TimedServerHop = v end})
SettingTab:CreateSlider({Name = "Tốc Độ Bay (An Toàn < 30)", Range = {1, 100}, Increment = 1, CurrentValue = 30, Callback = function(v) _G.FlySpeed = v end})
SettingTab:CreateSlider({Name = "Khoảng Cách Farm (1-36)", Range = {1, 36}, Increment = 1, CurrentValue = 7, Callback = function(v) _G.DistanceMob = v end})
SettingTab:CreateButton({Name = "Giảm Lag & Xóa Sương Mù", Callback = function() end})

-- ==========================================
-- CORE LOGIC (BACKEND)
-- ==========================================

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

-- Anti-Admin & Auto Hop
task.spawn(function()
    while task.wait(5) do
        if _G.AntiAdmin then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player:GetRankInGroup(2853313) > 0 or player.Name:lower():find("admin") then
                    HopServer()
                end
            end
        end
    end
end)

-- Sea Event Skill Logic ( Leviathan / SB Focus )
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoHuntSea or _G.AutoLevi then
            local Monster = GetSeaMonster() -- Hàm quét quái biển
            if Monster then
                local VIM = game:GetService("VirtualInputManager")
                -- Đổi vũ khí & Xả chiêu dựa trên cấu hình Tab Skill
                HandleSkillCombat(Monster) 
            end
        end
    end
end)

-- Server Status Loop
task.spawn(function()
    while task.wait(5) do
        -- Update màu nhãn Status (Xanh: Có, Đỏ: Không)
        updateStatusLabels()
    end
end)

-- Anti-Idle
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
-- == HỆ THỐNG CÀI ĐẶT ==
_G.Settings = {
    AutoFarm = false,
    AutoChest = false,
    AutoDoughKing = false,
    AutoRipIndra = false,
    AutoV4 = false,
    AutoKitsune = false,
    Skills = {["Z"] = true, ["X"] = true, ["C"] = true, ["V"] = true}
}

-- == TẠO WINDOW (TỐI ƯU TỐC ĐỘ) ==
local Window = Rayfield:CreateWindow({
   Name = "🔥 NMD HUB | FAST VERSION",
   LoadingTitle = "NMD HUB", -- Dòng chữ bạn yêu cầu
   LoadingSubtitle = "Đang khởi động siêu tốc...",
   ConfigurationSaving = { Enabled = false }, -- Tắt cái này để load nhanh hơn
   Discord = { Enabled = false }
})

-- Thông báo hiện ngay lập tức
Rayfield:Notify({
   Title = "NMD HUB",
   Content = "Menu đã sẵn sàng!",
   Duration = 2,
   Image = 4483345998,
})

-- ==========================================
-- TAB CHÍNH (Gộp lại cho nhanh)
-- ==========================================
local MainTab = Window:CreateTab("Main ⚔️", 4483345998)

MainTab:CreateSection("--- NMD HUB FULL TÍNH NĂNG ---")

MainTab:CreateToggle({
   Name = "Auto Farm Level (Tất cả Sea)",
   CurrentValue = false,
   Flag = "F1",
   Callback = function(v) _G.Settings.AutoFarm = v end,
})

MainTab:CreateToggle({
   Name = "Auto Nhặt Rương (Fast)",
   CurrentValue = false,
   Flag = "F2",
   Callback = function(v) 
      _G.Settings.AutoChest = v 
      task.spawn(function()
         while _G.Settings.AutoChest do
            pcall(function()
               for _, x in pairs(game.Workspace:GetChildren()) do
                  if x.Name:find("Chest") then
                     firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, x, 0)
                     firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, x, 1)
                  end
               end
            end)
            task.wait()
         end
      end)
   end,
})

-- ==========================================
-- TAB BOSS & RACE V4
-- ==========================================
local BossTab = Window:CreateTab("Boss & V4 👑", 4483345998)

BossTab:CreateToggle({Name = "Auto Dough King", CurrentValue = false, Flag = "B1", Callback = function(v) _G.Settings.AutoDoughKing = v end})
BossTab:CreateToggle({Name = "Auto Rip Indra", CurrentValue = false, Flag = "B2", Callback = function(v) _G.Settings.AutoRipIndra = v end})
BossTab:CreateToggle({Name = "Auto Race V4 Full", CurrentValue = false, Flag = "B3", Callback = function(v) _G.Settings.AutoV4 = v end})

-- ==========================================
-- TAB KITSUNE & SEA
-- ==========================================
local EventTab = Window:CreateTab("Events 🦊", 4483345998)

EventTab:CreateToggle({Name = "Auto Kitsune Island", CurrentValue = false, Flag = "E1", Callback = function(v) _G.Settings.AutoKitsune = v end})
EventTab:CreateToggle({
   Name = "Auto Nhặt Đuôi Lửa (Azure Ember)",
   CurrentValue = false,
   Flag = "E2",
   Callback = function(v)
      _G.AutoEmber = v
      task.spawn(function()
         while _G.AutoEmber do
            for _, e in pairs(game.Workspace:GetChildren()) do
               if e.Name == "Azure Ember" then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = e.CFrame
               end
            end
            task.wait()
         end
      end)
   end,
})

-- ==========================================
-- TAB CÀI ĐẶT SKILL
-- ==========================================
local SkillTab = Window:CreateTab("Skills 💥", 4483345998)

for s, _ in pairs(_G.Settings.Skills) do
    SkillTab:CreateToggle({
        Name = "Dùng Skill " .. s,
        CurrentValue = true,
        Flag = "S"..s,
        Callback = function(v) _G.Settings.Skills[s] = v end,
    })
end

-- Logic Auto Click & Skill ngầm (Chạy cực nhẹ)
task.spawn(function()
    while task.wait(0.1) do
        if _G.Settings.AutoFarm or _G.Settings.AutoDoughKing or _G.Settings.AutoRipIndra then
            pcall(function()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                for s, active in pairs(_G.Settings.Skills) do
                    if active then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, s, false, game)
                        task.wait(0.01)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, s, false, game)
                    end
                end
            end)
        end
    end
end)

print("NMD HUB: Đã hiện Menu siêu tốc!")
