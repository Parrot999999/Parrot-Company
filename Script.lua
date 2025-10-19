--가열교반기 서버 스크립트

--데이타메니저 모듈 블러오는 코드
local DataManagerModule = require(game.ServerScriptService.DataManager)

--가열교반기 비커 파트 변수
local Beaker = script.Parent.Parent.Beaker
local BottomBeaker = script.Parent.Parent.Beaker.BottomCylinder
local TopBeaker = script.Parent.Parent.Beaker.TopCylinder
local SpinBeaker = script.Parent.Parent.Beaker.SpinCylinder

--가열교반기 버튼 변수
local TempButton = script.Parent.TempButton.ClickDetector
local SpeedButton = script.Parent.SpeedButton.ClickDetector
local LiquidDestory = script.Parent.LiquidDestory.ClickDetector
local TempSwitch = script.Parent.TempSwitch
local SpeedSwitch = script.Parent.SpeedSwitch

--가열교반기의 현재 온도, 속도 값에 대한 변수
local TempValue = script.Parent.Parent.TempValue
local SpeedValue = script.Parent.Parent.SpeedValue

--이름, 시간 표시 파트 변수
local NameSIGN = script.Parent.NameSIGN.SurfaceGui.SIGN
local TimeSIGN = script.Parent.TimeSIGN.SurfaceGui.SIGN

--가열교반기 상호작용 오브젝트(ProximityPrompt) 변수 (가열교반기를 활성화 시키거나 화학물을 넣을 때 상호작용 하는 용도)
local Prox = script.Parent.Proximity.ProximityPrompt

--가열교반기 관련 리모트 변수
local ReactionFormulaRemote = game.ReplicatedStorage.Research.ReactionFormulaRemote
local ReactionFormulaCheck = game.ReplicatedStorage.Research.ReactionFormulaCheck
local ReactionFormulaStop = game.ReplicatedStorage.Research.ReactionFormulaStop

--가열교반기 소리 오브젝트 변수
local HeatingStirrerSound = script.Parent.LiquidDestory.HeatingStirrerSound
local ButtonClick = script.Parent.LiquidDestory.ButtonClick
local LiquidSound = script.Parent.LiquidDestory.LiquidSound

--임시로 쓰이는 랜덤 관련 변수들
local TimeTimeValue
local NaemNameValue
local OneValue
local TwoValue
local OneColor
local TwoColor
local TempTempValue
local SpeedSpeedValue

--화학물이 어느정도 찼는지 알려주는 변수
local On = false
local Bottom = false

--임시로 플레이어 이름을 적는 변수
local TemporaryPlr = script.Parent.Parent.TemporaryPlr

--조건이 성립 됐는지 알려주는 변수
local TempPerfect = false
local SpeedPerfect = false
local CollectNum = 0

--반복문을 멈추게 하는 변수
local StopStop = false


--조건이 성립 돼고 가열교반기가 작동 되는 과정을 보여 줄 때 다른 상호작용을 못하게 막아주는 변수
local ing = false

--에너지가 현재 어느정도 인지 값을 가져오는 리모트
local MoneyEnergy1 = game.ReplicatedStorage.Energy.MoneyEnergy1
local MoneyEnergy2 = game.ReplicatedStorage.Energy.MoneyEnergy2
local MoneyEnergy3 = game.ReplicatedStorage.Energy.MoneyEnergy3

--플레이어, 마켓플레이스서비스를 가져와 주는 코드
local Players = game:GetService("Players")
local gamepass = game:GetService("MarketplaceService")

--현재 연구직의 레벨, 직급을 가져와 주는 리모트
local ResearchData = game.ReplicatedStorage.State.ResearchData

--효과를 가져와 주는 리모트
local MoneyEffect = game.ReplicatedStorage.Effect.Money
local LevelEffect = game.ReplicatedStorage.Effect.LevelUp
local EnergyValue = 1
local programData = 1


--에너지 비율이 현재 어느 상태인지에 따라 수익이 변하게 만드는 코드
MoneyEnergy1.OnServerEvent:Connect(function(player)
	EnergyValue = 1
end)
MoneyEnergy2.OnServerEvent:Connect(function(player)
	EnergyValue = 0.7
end)
MoneyEnergy3.OnServerEvent:Connect(function(player)
	EnergyValue = 0.3
end)

--돈 계산 코드
function Moneydef(player, MoneyValue, M)

	--연구직 레벨 데이터를 가져와 주는 변수
	local level = DataManagerModule:GetData(player).ResearchLevel
	
	--다음 레벨 까지 몇 레벨포인트 쌓였는지 데이터를 가져와 주는 변수
	local DataP = DataManagerModule:GetData(player).ProgResearchLevel
	
	--환생을 몇 번 했는지 데이터를 가져와 주는 변수 (환생 시스템은 현재 사용하지 않음)
	local Reset = DataManagerModule:GetData(player).reset
	
	--레벨에 따라 수익을 얼만큼 곱해야 하는지를  가져오는 변수
	local Ratio = DataManagerModule:GetData(player).ResearchLevelRatio
	
	--다음 연구직 레벨 까지 몇 레벨포인트를 모아야 하는지 알려주는 데이터를 가져와 주는 변수
	local limit = DataManagerModule:GetData(player).ResearchLevelLimit
	
	--계급이 어느 정도 인지 알려주는 데이터를 가져와 주는 변수 (계급 시스템은 현재 사용하지 않음)
	local Department = DataManagerModule:GetData(player).ResearchDepartment
	
	--직급이 어느정도 인지 알려주는 데이터를 가져와 주는 변수
	local Rank = DataManagerModule:GetData(player).ResearchRank
	
	--계급에 따라 수익을 얼만큼 곱해야 하는지를 가져오는 변수 (계급 시스템은 현재 사용하지 않음)
	local DepartmentValue = DataManagerModule:GetData(player).ResearchDepartmentValue
	
	--직급에 따라 수익을 얼만큼 곱해야 하는지를 가져오는 변수
	local RankValue = DataManagerModule:GetData(player).ResearchRankValue
	
	--다음 직급 까지 몇 레벨을 모아야 하는지 알려주는 데이터를 가져와 주는 변수
	local RankLimit = DataManagerModule:GetData(player).ResearchRankLimit
	
	--다음 계급 까지 어느정도의 직급이 되야 하는지 알려주는 데이터를 가져와 주는 변수 (계급 시스템은 현재 사용하지 않음)
	local DepartmentLimit = DataManagerModule:GetData(player).ResearchDepartmentLimit


	--수익 임시 기록
	local MoneyMemo
	
	--리더보드에서 돈이 어느정도 인지를 가져옴
	local MoneyValue = player.leaderstats.Money
	
	--게임패스가 있으면 수익이 2배, 게임패스가 없으면 수익이 그대로
	if not gamepass:UserOwnsGamePassAsync(player.UserId, 107025607) then
		--게임패스 없을 때 돈 계산 방법 (환생 수익 배율 * ( 계급 수익 배율 * ( 직급 수익 배율 * ( 레벨 수익 배율 * ( 기본 수익 * 가열교반기에서 나오는 보너스) ) ) ) ) 
		MoneyMemo = EnergyValue * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData))))))
		MoneyValue.Value += EnergyValue * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData)))))) --얻은 돈을 기존 돈에 더해줌
		DataManagerModule:UpdateData(player, "ProgResearchLevel", DataP + (1 * programData))
	elseif gamepass:UserOwnsGamePassAsync(player.UserId, 107025607) then
		--게임패스 있을 때 돈 계산 방법 (2 * (환생 수익 배율 * ( 계급 수익 배율 * ( 직급 수익 배율 * ( 레벨 수익 배율 * ( 기본 수익 * 가열교반기에서 나오는 보너스) ) ) )  )
		MoneyMemo =  EnergyValue * (2 * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData)))))))
		MoneyValue.Value += EnergyValue * (2 * (Reset * (DepartmentValue * (RankValue * (Ratio * ((M * programData))))))) --얻은 돈을 기존 돈에 더해줌
		DataManagerModule:UpdateData(player, "ProgResearchLevel", DataP + (2 * programData))
	end
	
	--레벨포인트가 다음 특정 레벨포인트에 도달해야 하는 기준을 같거나 넘으면 레벨포인트를 0으로 만들고 레벨을 올리는 코드
	if DataManagerModule:GetData(player).ProgResearchLevel >= limit then
		DataManagerModule:UpdateData(player, "ResearchLevel", level + 1)
		DataManagerModule:UpdateData(player, "ResearchLevelRatio", Ratio + 0.1)
		DataManagerModule:UpdateData(player, "ResearchLevelLimit", limit + 15 )
		DataManagerModule:UpdateData(player, "ProgResearchLevel", 0)
		local LevelMemo = DataManagerModule:GetData(player).ResearchLevel
		LevelEffect:FireClient(player, LevelMemo)
	end
	--레벨이 다음 특정 레벨에 도달해야 하는 기준을 같거나 넘으면 직급을 올리는 코드
	if DataManagerModule:GetData(player).ResearchLevel >= RankLimit then
		DataManagerModule:UpdateData(player, "ResearchRank", Rank + 1)
		DataManagerModule:UpdateData(player, "ResearchRankValue", RankValue + 0.5)
		DataManagerModule:UpdateData(player, "ResearchRankLimit", RankLimit + 5)
		local RankMemo = DataManagerModule:GetData(player).ResearchRank
	end
	--직급이 다음 특정 직급에 도달해야 하는 기준을 같거나 넘으면 계급을 올리는 코드 (현재는 안씀)
	if DataManagerModule:GetData(player).ResearchRank >= DepartmentLimit then
		DataManagerModule:UpdateData(player, "ResearchRank", 1)
		DataManagerModule:UpdateData(player, "ResearchRankValue", 1)
		DataManagerModule:UpdateData(player, "ResearchDepartment", Department + 1)
		DataManagerModule:UpdateData(player, "ResearchDepartmentValue", DepartmentValue + 2)
		local DepartmentMemo = DataManagerModule:GetData(player).ResearchDepartment
	end
	--상태창에 표시하기 위해 위에서 업데이트 된 데이터를 다시 가져오는 변수
	local DataPR = DataManagerModule:GetData(player).ProgResearchLevel
	local levelR = DataManagerModule:GetData(player).ResearchLevel
	local limitSS = DataManagerModule:GetData(player).ResearchLevelLimit
	local DepartmentS = DataManagerModule:GetData(player).ResearchDepartment
	local RankS = DataManagerModule:GetData(player).ResearchRank
	local RankLimitS = DataManagerModule:GetData(player).ResearchRankLimit
	
	--레벨포인트 / 레벨포인트 기준점
	local limitS = "/"..limitSS
	
	--상태창에 정보를 표시하기 위해 서버에서 로컬로 리모트를 보냄
	ResearchData:FireClient(player, levelR, DataPR, limitS, DepartmentS, RankS, RankLimitS)
	
	--만약에 수익이 0을 초과하면 돈을 얻은 효과를 표시 해줌
	if MoneyMemo > 0 then
		MoneyEffect:FireClient(player, MoneyMemo)
	end
end

--가열교반기 활성화 시킬 때 플레이어의 이름과 남은 시간을 외부로 표시하고 클라이언트의 UI에 가열교반기 돌리는 조건이 나오게 서버에서 클라이언트로 조건을 보내는 리모트가 있는 함수
function Chemicals(plr, TimeTimeValue, ChemicalsName, Plus, TempTempValue, SpeedSpeedValue)
	NameSIGN.Text = plr.Name
	TimeSIGN.Text = tostring(TimeTimeValue)
	ReactionFormulaRemote:FireClient(plr, TimeTimeValue, ChemicalsName, Plus, TempTempValue, SpeedSpeedValue)
end


Prox.Triggered:Connect(function(plr)
	--On이 false 일 때 가열교반기 실행 
	if On == false then
		ButtonClick:Play()
		TemporaryPlr.Value = plr.Name --앞으로 나올 조건문에 필요하기 때문에 임시 플레이어 이름 추가
		ReactionFormulaCheck:FireClient(plr)
	end
	if On == true then
		--On이 true 일 때 화학물을 넣으면 생기는 이벤트
		if plr.Name == NameSIGN.Text then
			if CollectNum  ~= 2 then
			--플레이어가 들고 있는 화학물이 조건에 있는 화학물인지 구분
			local plrcharacterOne = plr.Character:FindFirstChild(OneValue)
			local plrcharacterTwo = plr.Character:FindFirstChild(TwoValue)
			if plrcharacterOne then
				plrcharacterOne:Destroy()
				
				--화학물을 두 번째로 채울 때
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
				
				--화학물을 첫 번째로 채울 때
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
				
				--화학물을 두 번째로 채울 때
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
				
				--화학물을 첫 번째로 채울 때
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


--비커에 있던 화학물들을 버리는 버튼 코드
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

--온도 버튼을 클릭하면 온도가 올라가는 코드
TempButton.MouseClick:Connect(function(player)
	if On == true then
		if player.Name == NameSIGN.Text then
			ButtonClick:Play()
			TempValue.Value = TempValue.Value + 1
			
			--만약 TempValue 변수가 8을 초과하면 다시 1로 만듬
			if TempValue.Value > 8 then
				TempValue.Value = 1
			end
	
			TempSwitch.CFrame = TempSwitch.CFrame * CFrame.Angles(math.rad(-45),0,0)
			--만약 TempValue 변수가 랜덤으로 지정한 온도 변수랑 같아지면 생기는 이벤트
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
				--만약 TempPerfect가 true이고 SpeedPerfect가 false인 상태에서 온도 버튼을 클릭 했다면 TempPerfect를 false로 만들어서 가열교반기 돌리는 조건 중 하나인 TempPerfect 변수 값을 거짓으로 만듬
			elseif TempValue.Value ~= TempTempValue then
				TempPerfect = false
			end
		end
	end
end)

--속도 버튼을 클릭하면 속도가 올라가는 코드
SpeedButton.MouseClick:Connect(function(player)
	if On == true then
		if player.Name == NameSIGN.Text then
			ButtonClick:Play()
			SpeedValue.Value = SpeedValue.Value + 1
			
			--만약 SpeedValue 변수가 8을 초과하면 다시 1로 만듬
			if SpeedValue.Value > 8 then
				SpeedValue.Value = 1
			end
			
			SpeedSwitch.CFrame = SpeedSwitch.CFrame * CFrame.Angles(math.rad(-45),0,0)
			--만약 TempValue 변수가 랜덤으로 지정한 온도 변수랑 같아지면 생기는 이벤트
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
				--만약 SpeedPerfect가 true이고 TempPerfect가 false인 상태에서 속도 버튼을 클릭 했다면 SpeedPerfect를 false로 만들어서 가열교반기 돌리는 조건 중 하나인 TempPerfect 변수 값을 거짓으로 만듬
			elseif SpeedValue.Value ~= SpeedSpeedValue then
				SpeedPerfect = false
			end
		end
	end
end)


--가열교반기를 돌리는 조건을 생성하는 
ReactionFormulaCheck.OnServerEvent:Connect(function(plr, n)
	if plr.Name == TemporaryPlr.Value then
		--만약 이미 다른 가열교반기를 돌리고 있을 시 이 가열교반기는 못 돌리게 막는 조건문
		if n == "Off" then
			On = true
			TemporaryPlr.Value = "" --임시 플레이어 이름 제거
			Prox.ActionText = "Put"
			TimeTimeValue = math.random(30,50)
			NaemNameValue = math.random(1,17)
			TempTempValue = math.random(1,8)
			SpeedSpeedValue = math.random(1,8)
			if NaemNameValue == 1 then
				OneValue = "CO"
				TwoValue = "2H₂"
				Chemicals(plr, TimeTimeValue, "메탄울", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 2 then
				OneValue = "2H₂"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "물", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 3 then
				OneValue = "N₂"
				TwoValue = "3H₂"
				Chemicals(plr, TimeTimeValue, "암모니아", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 4 then
				OneValue = "H₂"
				TwoValue = "Cl₂"
				Chemicals(plr, TimeTimeValue, "염화수소", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 5 then
				OneValue = "H₂"
				TwoValue = "F₂"
				Chemicals(plr, TimeTimeValue, "불화수소", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 6 then
				OneValue = "2Na"
				TwoValue = "Cl₂"
				Chemicals(plr, TimeTimeValue, "염화나트륨", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 7 then
				OneValue = "2Mg"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "산화마그네슘", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 8 then
				OneValue = "4Al"
				TwoValue = "3O₂"
				Chemicals(plr, TimeTimeValue, "산화알루미늄", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 9 then
				OneValue = "Si"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "이산화규소", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 10 then
				OneValue = "P₄"
				TwoValue = "6Cl₂"
				Chemicals(plr, TimeTimeValue, "삼염화인", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 11 then
				OneValue = "S"
				TwoValue = "3F₂"
				Chemicals(plr, TimeTimeValue, "육불화황", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 12 then
				OneValue = "B"
				TwoValue = "3F₂"
				Chemicals(plr, TimeTimeValue, "삼불화붕소", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 13 then
				OneValue = "2K"
				TwoValue = "Cl₂"
				Chemicals(plr, TimeTimeValue, "염화칼륨", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 14 then
				OneValue = "2Ca"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "산화칼슘", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 15 then
				OneValue = "2Zn"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "산화아연", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 16 then
				OneValue = "2Cu"
				TwoValue = "O₂"
				Chemicals(plr, TimeTimeValue, "산화구리(II)", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			if NaemNameValue == 17 then
				OneValue = "Mn"
				TwoValue = "2O₂"
				Chemicals(plr, TimeTimeValue, "산화망간(IV)", OneValue.." + "..TwoValue, TempTempValue, SpeedSpeedValue)
				OneColor = Color3.fromRGB(213, 213, 213)
				TwoColor = Color3.fromRGB(255, 255, 255)
			end
			
			--만약에 처음부터 랜덤 값이랑 기존 값이랑 같을 때 TempPerfect 혹은 SpeedPerfect를 true로 만듬
				if TempValue.Value == TempTempValue then
					TempPerfect = true
				end
				if SpeedValue.Value == SpeedSpeedValue then
					SpeedPerfect = true
				end
				
				--타이머
				for i = TimeTimeValue, 0, -1 do
					TimeSIGN.Text = tostring(i)
					
					--만약에 조건이 성립 돼서 StopStop이 true가 돼면 반복문을 중단 시킴
					if StopStop == true then
						--작동 과정 및 보상 코드
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
						
						--전체 값 초기화
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
					--만약에 시간이 초과 됐을 때 일어나는 코드
					if i == 0 then
						--초기화
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
			TemporaryPlr.Value = "" --만약 다른 가열교반기를 돌리고 있었다면 임시 플레이어 이름을 지우기
		end
	end
end)