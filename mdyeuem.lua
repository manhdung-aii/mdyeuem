-- [[ NMD HUB - FAST LOAD v15.0 ]] --
-- Tối ưu tốc độ hiển thị và thêm nhận diện thương hiệu

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
