--가열교반기 서버 스크립트

--데이터메니저 모듈 블러오는 코드
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

--가열교반기 소리 변수
local HeatingStirrerSound = script.Parent.LiquidDestory.HeatingStirrerSound
local ButtonClick = script.Parent.LiquidDestory.ButtonClick
local LiquidSound = script면, 실행되는 코드
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
					--만약 위의 조건들이 성립되지 않는다면, 1초를 기다림
					task.wait(1)
				end
		elseif n == "On" then
			TemporaryPlr.Value = "" --만약 다른 가열교반기를 돌리고 있었다면 임시 플레이어 이름을 지움
		end
	end
end)


