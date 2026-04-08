-- that all I can do and give you
-- maybe that look stupid but WHO CARE?
-- is it possible with accurate hitboxes?
-- -gh 5316479641 5316539421 5699795428 5316549755 5268602207 5268710380 5268720002 5268555719 82742704984803
-- Just A Baseplate
-- Credit to C00l_Ch4os

local uis = game:GetService("UserInputService")
local lp = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local mode = "q"
local lerpSpeed = 0.15

local function cf(p, r) 
    return CFrame.new(p) * CFrame.fromEulerAnglesXYZ(math.rad(r.X), math.rad(r.Y), math.rad(r.Z)) 
end

local function RunReanimate()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oldhacfard/The-script/refs/heads/main/Reanimate.luau"))()
    task.wait(1)

    local char = lp.Character
    local hum = char:WaitForChild("Humanoid")
    local tor = char:WaitForChild("Torso")
    local root = char:WaitForChild("HumanoidRootPart")
    
    hum.WalkSpeed = 18
    hum.JumpPower = 55
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local animate = char:FindFirstChild("Animate")
    if animate then animate.Disabled = true end
    for _, v in pairs(hum:GetPlayingAnimationTracks()) do v:Stop() end

    local parts = {
        Sword1 = nil, Sword2 = nil, Sword3 = nil, Sword4 = nil,
        Sword5 = nil, Sword6 = nil, Sword7 = nil, Sword8 = nil, Halo = nil
    }

    local textureIds = {	
        ["5316471565"] = "Sword1",	
        ["5278777022"] = "Sword2", 
        ["5316510551"] = "Sword3",
        ["5692006383"] = "Sword4",
        ["5268538095"] = "Sword5",
        ["5254572443"] = "Sword6",
        ["5268630057"] = "Sword7",
        ["5268638340"] = "Sword8",
        ["115262824887782"] = "Halo"
    }

    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Accessory") then
            local handle = v:FindFirstChild("Handle")
            if handle then
                local tex = ""
                if handle:IsA("MeshPart") then
                    tex = handle.TextureID
                else
                    local m = handle:FindFirstChildOfClass("SpecialMesh")
                    if m then tex = m.TextureId end
                end

                for id, name in pairs(textureIds) do
                    if tex:find(id) then
                        parts[name] = handle
                        handle:BreakJoints()
                        handle.CanCollide = false
                        handle.Massless = true
                    end
                end
            end
        end
    end

    local joints = {
        root = root:WaitForChild("RootJoint"),
        neck = tor:WaitForChild("Neck"),
        rs = tor:WaitForChild("Right Shoulder"),
        ls = tor:WaitForChild("Left Shoulder"),
        rh = tor:WaitForChild("Right Hip"),
        lh = tor:WaitForChild("Left Hip")
    }

    local currentCFs = {}
    for name, joint in pairs(joints) do currentCFs[name] = joint.Transform end
    
    local currentHatCFs = {}
    for name, _ in pairs(parts) do currentHatCFs[name] = CFrame.new() end

    rs.Stepped:Connect(function()
        local state = "idle"
        local vel = tor.Velocity.Magnitude
        local hState = hum:GetState()
        local moveDir = root.CFrame:VectorToObjectSpace(hum.MoveDirection)
        local rotCont = (tick() * 350) % 360

        if hState == Enum.HumanoidStateType.Freefall or hState == Enum.HumanoidStateType.Jumping then 
            state = "fall"
        elseif vel > 0.1 then
            if moveDir.Z < -0.1 then state = "walkW"
            elseif moveDir.Z > 0.1 then state = "walkS"
            elseif moveDir.X < -0.1 then state = "walkA"
            elseif moveDir.X > 0.1 then state = "walkD"
            end
        end

        local targets = {}
        local hatTargets = {}
        local ws = math.sin(tick() * 10)
        
        local cosM = (1 - math.cos(tick() * 1.5)) / 2
        local s5 = cosM * 25
        local s6 = cosM * 15
        local s7 = cosM * 40
        
        local s_ani = math.sin(tick() * 64) * 30
        local s1_ani = math.sin(tick() * 64) * 55
        local s2_ani = math.sin(tick() * 3) * 3
        local s3_ani = math.sin(tick() * 1.5) * 0.7
        local s4_ani = math.sin(tick() * 1) * 2.5
	
	if state == "idle" then
			targets.root = cf(
			    Vector3.new(0, 0, 0),
			    Vector3.new(8.63, 0, 0) -- Y was 0, so stays 0
			)
			
			targets.neck = cf(
			    Vector3.new(0, 0, 0),
			    Vector3.new(-18.41, 0, 0)
			)
			
			targets.ls = cf(
			    Vector3.new(-0.0000011, 0.0000005, -0.0000007),
			    Vector3.new(-34.21, 39.02, 126.87)
			)
			
			targets.rs = cf(
			    Vector3.new(0.0000002, -0.0000006, 0.0000010),
			    Vector3.new(-27.98, 47.61, 149.32)
			)
			
			targets.lh = cf(
			    Vector3.new(0, 0, 0),
			    Vector3.new(-1.64, 23.58, -7.91)
			)
			
			targets.rh = cf(
			    Vector3.new(0, 0, 0),
			    Vector3.new(2.11, 15.73, -10.44)
			)
            hatTargets.Halo = cf(Vector3.new(0, -1.5, 3.5), Vector3.new(25, 0, rotCont))
            hatTargets.Sword1 = cf(Vector3.new(-4+s3_ani, -4, 6+s3_ani), Vector3.new(100, -50-s6, 100))
            hatTargets.Sword2 = cf(Vector3.new(-10+s4_ani, -5, 7+s4_ani), Vector3.new(100, -70-s5, 100))
            hatTargets.Sword3 = cf(Vector3.new(4-s3_ani, -4, 6+s3_ani), Vector3.new(100, -30+s6, 100))
            hatTargets.Sword4 = cf(Vector3.new(10-s4_ani, -5, 7+s4_ani), Vector3.new(100, -10+s5, 100))
            hatTargets.Sword5 = cf(Vector3.new(-16+s3_ani, -3, 8+s4_ani), Vector3.new(100, -90-s7, 100))
            hatTargets.Sword6 = cf(Vector3.new(16+s3_ani, -4, 8+s4_ani), Vector3.new(100, 10+s7, 100))
            hatTargets.Sword7 = cf(Vector3.new(6-s3_ani, -10, 10), Vector3.new(100, -20+s6, 100))
            hatTargets.Sword8 = cf(Vector3.new(-6+s3_ani, -10, 10), Vector3.new(100, -70-s6, 100))

        elseif state == "walkW" then
            targets.root = cf(Vector3.new(0, 0, 0), Vector3.new(10, 0, 0))
            targets.neck = cf(Vector3.new(0, 0, 0), Vector3.new(10 + s_ani, s1_ani, s1_ani))
            targets.rs = cf(Vector3.new(0, 0, 0), Vector3.new(math.sin(tick() * 2.5) * -8, math.sin(tick() * 2.5) * -20, math.sin(tick() * 2.5) * -35))
            targets.ls = cf(Vector3.new(0, 0, 0), Vector3.new(-30, -20, -160 + -s2_ani))
            targets.rh = cf(Vector3.new(math.sin(tick() * 3) * 0.3, math.sin(tick() * 3) * 0.2, 0), Vector3.new(-2, 0, math.sin(tick() * 2.5) * 35))
            targets.lh = cf(Vector3.new(math.sin(tick() * 3) * 0.3, math.sin(tick() * 3) * 0.2, 0), Vector3.new(-2, 0, math.sin(tick() * 2.5) * 35))
            
            hatTargets.Halo = cf(Vector3.new(0, 1, 3), Vector3.new(0, 0, rotCont))
            hatTargets.Sword1 = cf(Vector3.new(-4+s3_ani, 4, 6+s3_ani), Vector3.new(100, -50-s6, 100))
            hatTargets.Sword2 = cf(Vector3.new(-10+s4_ani, 5, 7+s4_ani), Vector3.new(100, -70-s5, 100))
            hatTargets.Sword3 = cf(Vector3.new(4-s3_ani, 4, 6+s3_ani), Vector3.new(100, -30+s6, 100))
            hatTargets.Sword4 = cf(Vector3.new(10-s4_ani, 5, 7+s4_ani), Vector3.new(100, -10+s5, 100))
            hatTargets.Sword5 = cf(Vector3.new(-16+s3_ani, 3, 8+s4_ani), Vector3.new(100, -90-s7, 100))
            hatTargets.Sword6 = cf(Vector3.new(16+s3_ani, 4, 8+s4_ani), Vector3.new(100, 10+s7, 100))
            hatTargets.Sword7 = cf(Vector3.new(6-s3_ani, 3, 10), Vector3.new(100, -20+s6, 100))
            hatTargets.Sword8 = cf(Vector3.new(-6+s3_ani, 3, 10), Vector3.new(100, -70-s6, 100))

        elseif state == "walkS" then
            targets.root = cf(Vector3.new(0, 0, 0), Vector3.new(-10, 0, 0))
            targets.neck = cf(Vector3.new(0, 0, 0), Vector3.new(10 + s_ani, s1_ani, s1_ani))
            targets.rs = cf(Vector3.new(0, 0, 0), Vector3.new(math.sin(tick() * 2.5) * -5, math.sin(tick() * 2.5) * -5, math.sin(tick() * 2.5) * -10))
            targets.ls = cf(Vector3.new(0, 0, 0), Vector3.new(-30, -20, -160 + -s2_ani))
            targets.rh = cf(Vector3.new(-math.sin(tick() * 3) * 0.3, -math.sin(tick() * 3) * 0.2, 0), Vector3.new(-2, 0, -math.sin(tick() * 2.5) * 35))
            targets.lh = cf(Vector3.new(-math.sin(tick() * 3) * 0.3, -math.sin(tick() * 3) * 0.2, 0), Vector3.new(-2, 0, -math.sin(tick() * 2.5) * 35))
            
            hatTargets.Halo = cf(Vector3.new(0, 1, 3), Vector3.new(0, 0, rotCont))
            hatTargets.Sword1 = cf(Vector3.new(-4+s3_ani, 4, 6+s3_ani), Vector3.new(100, -50-s6, 100))
            hatTargets.Sword2 = cf(Vector3.new(-10+s4_ani, 5, 7+s4_ani), Vector3.new(100, -70-s5, 100))
            hatTargets.Sword3 = cf(Vector3.new(4-s3_ani, 4, 6+s3_ani), Vector3.new(100, -30+s6, 100))
            hatTargets.Sword4 = cf(Vector3.new(10-s4_ani, 5, 7+s4_ani), Vector3.new(100, -10+s5, 100))
            hatTargets.Sword5 = cf(Vector3.new(-16+s3_ani, 3, 8+s4_ani), Vector3.new(100, -90-s7, 100))
            hatTargets.Sword6 = cf(Vector3.new(16+s3_ani, 4, 8+s4_ani), Vector3.new(100, 10+s7, 100))
            hatTargets.Sword7 = cf(Vector3.new(6-s3_ani, 3, 10), Vector3.new(100, -20+s6, 100))
            hatTargets.Sword8 = cf(Vector3.new(-6+s3_ani, 3, 10), Vector3.new(100, -70-s6, 100))
        elseif state == "fall" then
            targets.root = cf(Vector3.new(0,0,0), Vector3.new(-10,0,0))
            targets.neck = cf(Vector3.new(0,0,0), Vector3.new(-20,0,0))
            targets.rs = cf(Vector3.new(0,0,0), Vector3.new(-50,0,0))
            targets.ls = cf(Vector3.new(0,0,0), Vector3.new(-50,0,0))
            targets.rh = cf(Vector3.new(0.5,0.5,0), Vector3.new(-10,0,-30))
            targets.lh = cf(Vector3.new(0,0,0), Vector3.new(-5,0,20))
            hatTargets.Halo = cf(Vector3.new(0, 1, 3), Vector3.new(0, 0, rotCont))
            hatTargets.Sword1 = cf(Vector3.new(-4+s3_ani, 4, 6+s3_ani), Vector3.new(100, -50-s6, 100))
            hatTargets.Sword2 = cf(Vector3.new(-10+s4_ani, 5, 7+s4_ani), Vector3.new(100, -70-s5, 100))
            hatTargets.Sword3 = cf(Vector3.new(4-s3_ani, 4, 6+s3_ani), Vector3.new(100, -30+s6, 100))
            hatTargets.Sword4 = cf(Vector3.new(10-s4_ani, 5, 7+s4_ani), Vector3.new(100, -10+s5, 100))
            hatTargets.Sword5 = cf(Vector3.new(-16+s3_ani, 3, 8+s4_ani), Vector3.new(100, -90-s7, 100))
            hatTargets.Sword6 = cf(Vector3.new(16+s3_ani, 4, 8+s4_ani), Vector3.new(100, 10+s7, 100))
            hatTargets.Sword7 = cf(Vector3.new(6-s3_ani, 3, 10), Vector3.new(100, -20+s6, 100))
            hatTargets.Sword8 = cf(Vector3.new(-6+s3_ani, 3, 10), Vector3.new(100, -70-s6, 100))
        end

        for name, joint in pairs(joints) do
            if targets[name] then
                currentCFs[name] = currentCFs[name]:Lerp(targets[name], lerpSpeed)
                joint.Transform = currentCFs[name]
            end
        end
        
        for name, _ in pairs(parts) do
            if hatTargets[name] then
                currentHatCFs[name] = currentHatCFs[name]:Lerp(hatTargets[name], lerpSpeed)
            end
        end
    end)

    rs.Heartbeat:Connect(function()
        for name, handle in pairs(parts) do
            if handle and handle.Parent then
                handle.CFrame = tor.CFrame * currentHatCFs[name]
                handle.Velocity = Vector3.new(0, 35, 0)
                handle.AssemblyLinearVelocity = Vector3.new(0, 35, 0)
            end
        end
    end)
end

RunReanimate()
