--�������ݱ� ���� ��ũ��Ʈ

--����Ÿ�޴��� ��� ������ �ڵ�
local DataManagerModule = require(game.ServerScriptService.DataManager)

--�������ݱ� ��Ŀ ��Ʈ ����
local Beaker = script.Parent.Parent.Beaker
local BottomBeaker = script.Parent.Parent.Beaker.BottomCylinder
local TopBeaker = script.Parent.Parent.Beaker.TopCylinder
local SpinBeaker = script.Parent.Parent.Beaker.SpinCylinder

--�������ݱ� ��ư ����
local TempButton = script.Parent.TempButton.ClickDetector
local SpeedButton = script.Parent.SpeedButton.ClickDetector
local LiquidDestory = script.Parent.LiquidDestory.ClickDetector
local TempSwitch = script.Parent.TempSwitch
local SpeedSwitch = script.Parent.SpeedSwitch

--�������ݱ��� ���� �µ�, �ӵ� ���� ���� ����
local TempValue = script.Parent.Parent.TempValue
local SpeedValue = script.Parent.Parent.SpeedValue

--�̸�, �ð� ǥ�� ��Ʈ ����
local NameSIGN = script.Parent.NameSIGN.SurfaceGui.SIGN
local TimeSIGN = script.Parent.TimeSIGN.SurfaceGui.SIGN

--�������ݱ� ��ȣ�ۿ� ������Ʈ(ProximityPrompt) ���� (�������ݱ⸦ Ȱ��ȭ ��Ű�ų� ȭ�й��� ���� �� ��ȣ�ۿ� �ϴ� �뵵)
local Prox = script.Parent.Proximity.ProximityPrompt

--�������ݱ� ���� ����Ʈ ����
local ReactionFormulaRemote = game.ReplicatedStorage.Research.ReactionFormulaRemote
local ReactionFormulaCheck = game.ReplicatedStorage.Research.ReactionFormulaCheck
local ReactionFormulaStop = game.ReplicatedStorage.Research.ReactionFormulaStop

--�������ݱ� �Ҹ� ������Ʈ ����
local HeatingStirrerSound = script.Parent.LiquidDestory.HeatingStirrerSound
local ButtonClick = script.Parent.LiquidDestory.ButtonClick
local LiquidSound = script.Parent.LiquidDestory.LiquidSound

--�ӽ÷� ���̴� ���� ���� ������
local TimeTimeValue
local NaemNameValue
local OneValue
local TwoValue
local OneColor
local TwoColor
local TempTempValue
local SpeedSpeedValue

--ȭ�й��� ������� á���� �˷��ִ� ����
local On = false
local Bottom = false

--�ӽ÷� �÷��̾� �̸��� ���� ����
local TemporaryPlr = script.Parent.Parent.TemporaryPlr

--������ ���� �ƴ��� �˷��ִ� ����
local TempPerfect = false
local SpeedPerfect = false
local CollectNum = 0

--�ݺ����� ���߰� �ϴ� ����
local StopStop = false


--������ ���� �Ű� �������ݱⰡ �۵� �Ǵ� ������ ���� �� �� �ٸ� ��ȣ�ۿ��� ���ϰ� �����ִ� ����
local ing = false

--�������� ���� ������� ���� ���� �������� ����Ʈ
local MoneyEnergy1 = game.ReplicatedStorage.Energy.MoneyEnergy1
local MoneyEnergy2 = game.ReplicatedStorage.Energy.MoneyEnergy2
local MoneyEnergy3 = game.ReplicatedStorage.Energy.MoneyEnergy3

--�÷��̾�, �����÷��̽����񽺸� ������ �ִ� �ڵ�
local Players = game:GetService("Players")
local gamepass = game:GetService("MarketplaceService")

--���� �������� ����, ������ ������ �ִ� ����Ʈ
local ResearchData = game.ReplicatedStorage.State.ResearchData

--ȿ���� ������ �ִ� ����Ʈ
local MoneyEffect = game.ReplicatedStorage.Effect.Money
local LevelEffect = game.ReplicatedStorage.Effect.LevelUp
local EnergyValue = 1
local programData = 1


--������ ������ ���� ��� ���������� ���� ������ ���ϰ� ����� �ڵ�
MoneyEnergy1.OnServerEvent:Connect(function(player)
	EnergyValue = 1
end)
MoneyEnergy2.OnServerEvent:Connect(function(player)
	EnergyValue = 0.7
end)
MoneyEnergy3.OnServerEvent:Connect(function(player)
	EnergyValue = 0.3
end)

--�� ��� �ڵ�
function Moneydef(player, MoneyValue, M)

	--������ ���� �����͸� ������ �ִ� ����
	local level = DataManagerModule:GetData(player).ResearchLevel
	
	--���� ���� ���� �� ��������Ʈ �׿����� �����͸� ������ �ִ� ����
	local DataP = DataManagerModule:GetData(player).ProgResearchLevel
	
	--ȯ���� �� �� �ߴ��� �����͸� ������ �ִ� ���� (ȯ�� �ý����� ���� ������� ����)
	local Reset = DataManagerModule:GetData(player).reset
	
	--������ ���� ������ ��ŭ ���ؾ� �ϴ�����  �������� ����
	local Ratio = DataManagerModule:GetData(player).ResearchLevelRatio
	
	--���� ������ ���� ���� �� ��������Ʈ�� ��ƾ� �ϴ��� �˷��ִ� �����͸� ������ �ִ� ����
	local limit = DataManagerModule:GetData(player).ResearchLevelLimit
	
	--����� ��� ���� ���� �˷��ִ� �����͸� ������ �ִ� ���� (��� �ý����� ���� ������� ����)
	local Department = DataManagerModule:GetData(player).ResearchDepartment
	
	--������ ������� ���� �˷��ִ� �����͸� ������ �ִ� ����
	local Rank = DataManagerModule:GetData(player).ResearchRank
	
	--��޿� ���� ������ ��ŭ ���ؾ� �ϴ����� �������� ���� (��� �ý����� ���� ������� ����)
	local DepartmentValue = DataManagerModule:GetData(player).ResearchDepartmentValue
	
	--���޿� ���� ������ ��ŭ ���ؾ� �ϴ����� �������� ����
	local RankValue = DataManagerModule:GetData(player).ResearchRankValue
	
	--���� ���� ���� �� ������ ��ƾ� �ϴ��� �˷��ִ� �����͸� ������ �ִ� ����
	local RankLimit = DataManagerModule:GetData(player).ResearchRankLimit
	
	--���� ��� ���� ��������� ������ �Ǿ� �ϴ��� �˷��ִ� �����͸� ������ �ִ� ���� (��� �ý����� ���� ������� ����)
	local DepartmentLimit = DataManagerModule:GetData(player).ResearchDepartmentLimit


	--���� �ӽ� ���
	local MoneyMemo
	
	--�������忡�� ���� ������� ������ ������
	local MoneyValue = player.leaderstats.Money
	
	--�����н��� ������ ������ 2��, �����н��� ������ ������ �״��
	if not gamepass:UserOwnsGamePassAsync(player.UserId, 107025607) then
		--�����н� ���� �� �� ��� ��� (ȯ�� ���� ���� * ( ��� ���� ���� * ( ���� ���� ���� * ( ���� ���� ���� * ( �⺻ ���� * �������ݱ⿡�� ������ ���ʽ�) ) ) ) ) 
		MoneyMemo = EnergyValue * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData))))))
		MoneyValue.Value += EnergyValue * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData)))))) --���� ���� ���� ���� ������
		DataManagerModule:UpdateData(player, "ProgResearchLevel", DataP + (1 * programData))
	elseif gamepass:UserOwnsGamePassAsync(player.UserId, 107025607) then
		--�����н� ���� �� �� ��� ��� (2 * (ȯ�� ���� ���� * ( ��� ���� ���� * ( ���� ���� ���� * ( ���� ���� ���� * ( �⺻ ���� * �������ݱ⿡�� ������ ���ʽ�) ) ) )  )
		MoneyMemo =  EnergyValue * (2 * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData)))))))
		MoneyValue.Value += EnergyValue * (2 * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData))))))) --���� ���� ���� ���� ������
		DataManagerModule:UpdateData(player, "ProgResearchLevel", DataP + (2 * programData))
	end
	
	--��������Ʈ�� ���� Ư�� ��������Ʈ�� �����ؾ� �ϴ� ������ ���ų� ������ ��������Ʈ�� 0���� ����� ������ �ø��� �ڵ�
	if DataManagerModule:GetData(player).ProgResearchLevel >= limit then
		DataManagerModule:UpdateData(player, "ResearchLevel", level + 1)
		DataManagerModule:UpdateData(player, "ResearchLevelRatio", Ratio + 0.1)
		DataManagerModule:UpdateData(player, "ResearchLevelLimit", limit + 15 )
		DataManagerModule:UpdateData(player, "ProgResearchLevel", 0)
		local LevelMemo = DataManagerModule:GetData(player).ResearchLevel
		LevelEffect:FireClient(player, LevelMemo)
	end
	--������ ���� Ư�� ������ �����ؾ� �ϴ� ������ ���ų� ������ ������ �ø��� �ڵ�
	if DataManagerModule:GetData(player).ResearchLevel >= RankLimit then
		DataManagerModule:UpdateData(player, "ResearchRank", Rank + 1)
		DataManagerModule:UpdateData(player, "ResearchRankValue", RankValue + 0.5)
		DataManagerModule:UpdateData(player, "ResearchRankLimit", RankLimit + 5)
		local RankMemo = DataManagerModule:GetData(player).ResearchRank
	end
	--������ ���� Ư�� ���޿� �����ؾ� �ϴ� ������ ���ų� ������ ����� �ø��� �ڵ� (����� �Ⱦ�)
	if DataManagerModule:GetData(player).ResearchRank >= DepartmentLimit then
		DataManagerModule:UpdateData(player, "ResearchRank", 1)
		DataManagerModule:UpdateData(player, "ResearchRankValue", 1)
		DataManagerModule:UpdateData(player, "ResearchDepartment", Department + 1)
		DataManagerModule:UpdateData(player, "ResearchDepartmentValue", DepartmentValue + 2)
		local DepartmentMemo = DataManagerModule:GetData(player).ResearchDepartment
	end
	--����â�� ǥ���ϱ� ���� ������ ������Ʈ �� �����͸� �ٽ� �������� ����
	local DataPR = DataManagerModule:GetData(player).ProgResearchLevel
	local levelR = DataManagerModule:GetData(player).ResearchLevel
	local limitSS = DataManagerModule:GetData(player).ResearchLevelLimit
	local DepartmentS = DataManagerModule:GetData(player).ResearchDepartment
	local RankS = DataManagerModule:GetData(player).ResearchRank
	local RankLimitS = DataManagerModule:GetData(player).ResearchRankLimit
	
	--��������Ʈ / ��������Ʈ ������
	local limitS = "/"..limitSS
	
	--����â�� ������ ǥ���ϱ� ���� �������� ���÷� ����Ʈ�� ����
	ResearchData:FireClient(player, levelR, DataPR, limitS, DepartmentS, RankS, RankLimitS)
	
	--���࿡ ������ 0�� �ʰ��ϸ� ���� ���� ȿ���� ǥ�� ����
	if MoneyMemo > 0 then
		MoneyEffect:FireClient(player, MoneyMemo)
	end
end

--�������ݱ� Ȱ��ȭ ��ų �� �÷��̾��� �̸��� ���� �ð��� �ܺη� ǥ���ϰ� Ŭ���̾�Ʈ�� UI�� �������ݱ� ������ ������ ������ �������� Ŭ���̾�Ʈ�� ������ ������ ����Ʈ�� �ִ� �Լ�
function Chemicals(plr, TimeTimeValue, ChemicalsName, Plus, TempTempValue, SpeedSpeedValue)
	NameSIGN.Text = plr.Name
	TimeSIGN.Text = tostring(TimeTimeValue)
	ReactionFormulaRemote:FireClient(plr, TimeTimeValue, ChemicalsName, Plus, TempTempValue, SpeedSpeedValue)
end


Prox.Triggered:Connect(function(plr)
	--On�� false �� �� �������ݱ� ���� 
	if On == false then
		ButtonClick:Play()
		TemporaryPlr.Value = plr.Name --������ ���� ���ǹ��� �ʿ��ϱ� ������ �ӽ� �÷��̾� �̸� �߰�
		ReactionFormulaCheck:FireClient(plr)
	end
	if On == true then
		--On�� true �� �� ȭ�й��� ������ ����� �̺�Ʈ
		if plr.Name == NameSIGN.Text then
			if CollectNum  ~= 2 then
			--�÷��̾ ��� �ִ� ȭ�й��� ���ǿ� �ִ� ȭ�й����� ����
			local plrcharacterOne = plr.Character:FindFirstChild(OneValue)
			local plrcharacterTwo = plr.Character:FindFirstChild(TwoValue)
			if plrcharacterOne then
				plrcharacterOne:Destroy()
				
				--ȭ�й��� �� ��°�� ä�� ��
				if Bottom == true then
					TopBeaker.Color = OneColor
					TopBeaker.Transparency = 0.5
					CollectNum = CollectNum + 1
					if CollectNum == 2 then
						LiquidSound:Play()
						if TempPerfect == true then
							if SpeedPerfect == true then
								ReactionFormulaStop:FireClient(plr)
								BottomBeaker.Transparency = 1
								TopBeaker.Transparency = 1
								SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
								SpinBeaker.Transparency = 0.5
								StopStop = true
							end
						end
					end
				end
				
				--ȭ�й��� ù ��°�� ä�� ��
				if Bottom == false then
					LiquidSound:Play()
					Bottom = true
					BottomBeaker.Color = OneColor
					BottomBeaker.Transparency = 0.5
					CollectNum = CollectNum + 1
					if CollectNum == 2 then
						if TempPerfect == true then
							if SpeedPerfect == true then
								ReactionFormulaStop:FireClient(plr)
								BottomBeaker.Transparency = 1
								TopBeaker.Transparency = 1
								SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
								SpinBeaker.Transparency = 0.5
								StopStop = true
							end
						end
					end
				end
			end
			
			if plrcharacterTwo then
				plrcharacterTwo:Destroy()
				
				--ȭ�й��� �� ��°�� ä�� ��
				if Bottom == true then
					LiquidSound:Play()
					TopBeaker.Color = TwoColor
					TopBeaker.Transparency = 0.5
					CollectNum = CollectNum + 1
					if CollectNum == 2 then
						if TempPerfect == true then
							if SpeedPerfect == true then
								ReactionFormulaStop:FireClient(plr)
								BottomBeaker.Transparency = 1
								TopBeaker.Transparency = 1
								SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
								SpinBeaker.Transparency = 0.5
								StopStop = true
								
							end
						end
					end
				end
				
				--ȭ�й��� ù ��°�� ä�� ��
				if Bottom == false then
					LiquidSound:Play()
					Bottom = true
					BottomBeaker.Color = TwoColor
					BottomBeaker.Transparency = 0.5
					CollectNum = CollectNum + 1
					if CollectNum == 2 then
						if TempPerfect == true then
							if SpeedPerfect == true then
								ReactionFormulaStop:FireClient(plr)
								BottomBeaker.Transparency = 1
								TopBeaker.Transparency = 1
								SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
								SpinBeaker.Transparency = 0.5
								StopStop = true
							end
						end
					end
				end
			end
			end
		end
	end
end)


--��Ŀ�� �ִ� ȭ�й����� ������ ��ư �ڵ�
LiquidDestory.MouseClick:Connect(function(plr)
	if ing == false then
		if plr.Name == NameSIGN.Text then
		ButtonClick:Play()
		Bottom = false
		BottomBeaker.Transparency = 1
		TopBeaker.Transparency = 1
		CollectNum = 0
		end
	end
end)

--�µ� ��ư�� Ŭ���ϸ� �µ��� �ö󰡴� �ڵ�
TempButton.MouseClick:Connect(function(player)
	if On == true then
		if player.Name == NameSIGN.Text then
			ButtonClick:Play()
			TempValue.Value = TempValue.Value + 1
			
			--���� TempValue ������ 8�� �ʰ��ϸ� �ٽ� 1�� ����
			if TempValue.Value > 8 then
				TempValue.Value = 1
			end
	
			TempSwitch.CFrame = TempSwitch.CFrame * CFrame.Angles(math.rad(-45),0,0)
			--���� TempValue ������ �������� ������ �µ� ������ �������� ����� �̺�Ʈ
			if TempValue.Value == TempTempValue then
				TempPerfect = true
				if CollectNum == 2 then
					if TempPerfect == true then
						if SpeedPerfect == true then
							ReactionFormulaStop:FireClient(player)
							BottomBeaker.Transparency = 1
							TopBeaker.Transparency = 1
							SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
							SpinBeaker.Transparency = 0.5
							StopStop = true
						end
					end
				end
				--���� TempPerfect�� true�̰� SpeedPerfect�� false�� ���¿��� �µ� ��ư�� Ŭ�� �ߴٸ� TempPerfect�� false�� ���� �������ݱ� ������ ���� �� �ϳ��� TempPerfect ���� ���� �������� ����
			elseif TempValue.Value ~= TempTempValue then
				TempPerfect = false
			end
		end
	end
end)

--�ӵ� ��ư�� Ŭ���ϸ� �ӵ��� �ö󰡴� �ڵ�
SpeedButton.MouseClick:Connect(function(player)
	if On == true then
		if player.Name == NameSIGN.Text then
			ButtonClick:Play()
			SpeedValue.Value = SpeedValue.Value + 1
			
			--���� SpeedValue ������ 8�� �ʰ��ϸ� �ٽ� 1�� ����
			if SpeedValue.Value > 8 then
				SpeedValue.Value = 1
			end
			
			SpeedSwitch.CFrame = SpeedSwitch.CFrame * CFrame.Angles(math.rad(-45),0,0)
			--���� TempValue ������ �������� ������ �µ� ������ �������� ����� �̺�Ʈ
			if SpeedValue.Value == SpeedSpeedValue then
				SpeedPerfect = true
				if CollectNum == 2 then
					if TempPerfect == true then
						if SpeedPerfect == true then
							ReactionFormulaStop:FireClient(player)
							BottomBeaker.Transparency = 1
							TopBeaker.Transparency = 1
							SpinBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
							SpinBeaker.Transparency = 0.5
							StopStop = true
						end
					end
				end
				--���� SpeedPerfect�� true�̰� TempPerfect�� false�� ���¿��� �ӵ� ��ư�� Ŭ�� �ߴٸ� SpeedPerfect�� false�� ���� �������ݱ� ������ ���� �� �ϳ��� TempPerfect ���� ���� �������� ����
			elseif SpeedValue.Value ~= SpeedSpeedValue then
				SpeedPerfect = false
			end
		end
	end
end)


--�������ݱ⸦ ������ ������ �����ϴ� 
ReactionFormulaCheck.OnServerEvent:Connect(function(plr, n)
	if plr.Name == TemporaryPlr.Value then
		--���� �̹� �ٸ� �������ݱ⸦ ������ ���� �� �� �������ݱ�� �� ������ ���� ���ǹ�
		if n == "Off" then
			On = true
			TemporaryPlr.Value = "" --�ӽ� �÷��̾� �̸� ����
			Prox.ActionText = "Put"
			TimeTimeValue = math.random(30,50)
			NaemNameValue = math.random(1,17)
			TempTempValue = math.random(1,8)
			SpeedSpeedValue = math.random(1,8)
			if NaemNameValue == 1 then
				OneValue = "CO"
				TwoValue = "2H��"
				Chemicals(plr, TimeTimeValue, "��ź��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 2 then
				OneValue = "2H��"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 3 then
				OneValue = "N��"
				TwoValue = "3H��"
				Chemicals(plr, TimeTimeValue, "�ϸ�Ͼ�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 4 then
				OneValue = "H��"
				TwoValue = "Cl��"
				Chemicals(plr, TimeTimeValue, "��ȭ����", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 5 then
				OneValue = "H��"
				TwoValue = "F��"
				Chemicals(plr, TimeTimeValue, "��ȭ����", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 6 then
				OneValue = "2Na"
				TwoValue = "Cl��"
				Chemicals(plr, TimeTimeValue, "��ȭ��Ʈ��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 7 then
				OneValue = "2Mg"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "��ȭ���׳׽�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 8 then
				OneValue = "4Al"
				TwoValue = "3O��"
				Chemicals(plr, TimeTimeValue, "��ȭ�˷�̴�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 9 then
				OneValue = "Si"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "�̻�ȭ�Լ�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 10 then
				OneValue = "P��"
				TwoValue = "6Cl��"
				Chemicals(plr, TimeTimeValue, "�￰ȭ��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 11 then
				OneValue = "S"
				TwoValue = "3F��"
				Chemicals(plr, TimeTimeValue, "����ȭȲ", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 12 then
				OneValue = "B"
				TwoValue = "3F��"
				Chemicals(plr, TimeTimeValue, "���ȭ�ؼ�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 13 then
				OneValue = "2K"
				TwoValue = "Cl��"
				Chemicals(plr, TimeTimeValue, "��ȭĮ��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 14 then
				OneValue = "2Ca"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "��ȭĮ��", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 15 then
				OneValue = "2Zn"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "��ȭ�ƿ�", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 16 then
				OneValue = "2Cu"
				TwoValue = "O��"
				Chemicals(plr, TimeTimeValue, "��ȭ����(II)", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 17 then
				OneValue = "Mn"
				TwoValue = "2O��"
				Chemicals(plr, TimeTimeValue, "��ȭ����(IV)", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			
			--���࿡ ó������ ���� ���̶� ���� ���̶� ���� �� TempPerfect Ȥ�� SpeedPerfect�� true�� ����
				if TempValue.Value == TempTempValue then
					TempPerfect = true
				end
				if SpeedValue.Value == SpeedSpeedValue then
					SpeedPerfect = true
				end
				
				--Ÿ�̸�
				for i = TimeTimeValue, 0, -1 do
					TimeSIGN.Text = tostring(i)
					
					--���࿡ ������ ���� �ż� StopStop�� true�� �Ÿ� �ݺ����� �ߴ� ��Ŵ
					if StopStop == true then
						--�۵� ���� �� ���� �ڵ�
						StopStop = false
						ing = true
						Prox.Enabled = false
						HeatingStirrerSound:Play()
						task.wait(1.5)
						BottomBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
						TopBeaker.Color = OneColor:Lerp(TwoColor, 0.5)
						SpinBeaker.Transparency = 1
						BottomBeaker.Transparency = 0.5
						TopBeaker.Transparency = 0.5
						task.wait(1.5)
						local MoneyValue = plr.leaderstats.Money
						Moneydef(plr, MoneyValue, 500)
						game.ReplicatedStorage.Tutorial.ResearchRemote:FireClient(plr, "Heating")
						
						--��ü �� �ʱ�ȭ
						BottomBeaker.Transparency = 1
						TopBeaker.Transparency = 1
						NameSIGN.Text = ""
						TimeSIGN.Text = ""
						Bottom = false
						TempPerfect = false
						SpeedPerfect = false
						CollectNum = 0
						OneValue = ""
						TwoValue = ""
						Prox.Enabled = true
						Prox.ActionText = "Start"
						ing = false
						On = false
						break
					end
					--���࿡ �ð��� �ʰ� ���� �� �Ͼ�� �ڵ�
					if i == 0 then
						--�ʱ�ȭ
						Prox.Enabled = true
						Prox.ActionText = "Start"
						BottomBeaker.Transparency = 1
						TopBeaker.Transparency = 1
						NameSIGN.Text = ""
						TimeSIGN.Text = ""
						Bottom = false
						TempPerfect = false
						SpeedPerfect = false
						CollectNum = 0
						OneValue = ""
						TwoValue = ""
						NameSIGN.Text = ""
						TimeSIGN.Text = ""
						ing = false
						On = false
						break
					end
					task.wait(1)
				end
		elseif n == "On" then
			TemporaryPlr.Value = "" --���� �ٸ� �������ݱ⸦ ������ �־��ٸ� �ӽ� �÷��̾� �̸��� �����
		end
	end
end)