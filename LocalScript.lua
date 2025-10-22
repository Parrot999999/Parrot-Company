--가열교반기 로컬 스크립트

--리모트 변수
local ReactionFormulaRemote = game.ReplicatedStorage.Research.ReactionFormulaRemote
local ReactionFormulaCheck = game.ReplicatedStorage.Research.ReactionFormulaCheck
local ReactionFormulaStop = game.ReplicatedStorage.Research.ReactionFormulaStop

--반복문을 멈추게 하는 변수
local Stop = false

--UI 관련 오브젝트를 적어둔 변수
local NameT = script.Parent.Frame.NameT
local ReactionFormulaT = script.Parent.Frame.ReactionFormulaT
local TimeT = script.Parent.Frame.TimeT
local Frame = script.Parent.Frame
local TempImage = script.Parent.Frame.TempImage
local SpeedImage = script.Parent.Frame.SpeedImage

--가열교환기를 작동하고 있는지 여부를 반환하는 bool 변수
local On = false


--가열교반기가 이미 돌아가고 있는지 아닌지를 확인한 다음 서버로 보내는 역할을 하는 코드
ReactionFormulaCheck.OnClientEvent:Connect(function()
	if On == false then
		ReactionFormulaCheck:FireServer("Off")
	elseif On == true then
		ReactionFormulaCheck:FireServer("On")
	end
end)

--만약 가열교반기가 종료 됐다면 Stop 변수를 true로 만들어 반복문을 멈추게 한 후 8초 기다려 On 변수를 false로 만드는 코드
ReactionFormulaStop.OnClientEvent:Connect(function()
	Stop = true
	task.wait(8)
	On = false
end)

--서버에서 받아운 랜덤 값을 Ui에 적용 시키는 코드
ReactionFormulaRemote.OnClientEvent:Connect(function(TimeV, NameV, ReactionFormulaV, TempV, SpeedV)
	On = true
	task.wait(0.3)
	local TimeVV
	NameT.Text = NameV.."(을)/를 만드는 방법"
	ReactionFormulaT.Text = ReactionFormulaV
	TimeVV = TimeV
	if TempV == 1 then
		TempImage.Rotation = 0
	end
	if TempV == 2 then
		TempImage.Rotation = 45
	end
	if TempV == 3 then
		TempImage.Rotation = 90
	end
	if TempV == 4 then
		TempImage.Rotation = 135
	end
	if TempV == 5 then
		TempImage.Rotation = 180
	end
	if TempV == 6 then
		TempImage.Rotation = 225
	end
	if TempV == 7 then
		TempImage.Rotation = 270
	end
	if TempV == 8 then
		TempImage.Rotation = 315
	end
	
	if SpeedV == 1 then
		SpeedImage.Rotation = 0
	end
	if SpeedV == 2 then
		SpeedImage.Rotation = 45
	end
	if SpeedV == 3 then
		SpeedImage.Rotation = 90
	end
	if SpeedV == 4 then
		SpeedImage.Rotation = 135
	end
	if SpeedV == 5 then
		SpeedImage.Rotation = 180
	end
	if SpeedV == 6 then
		SpeedImage.Rotation = 225
	end
	if SpeedV == 7 then
		SpeedImage.Rotation = 270
	end
	if SpeedV == 8 then
		SpeedImage.Rotation = 315
	end
	
	Frame.Visible = true
	
	--타이머
	repeat
		--만약 Stop 변수가 true가 되면 반복문을 멈춤
		if Stop == true then
			Stop = false
			Frame.Visible = false
			NameT.Text = ""
			ReactionFormulaT.Text = ""
			TimeT.Text = ""
			break 
		end
		TimeVV = TimeVV - 1
		task.wait(1)
		TimeT.Text = tostring(TimeVV).."초 남음"
	until TimeVV == 0
	
	--만약 시간이 초과됐다면 On을 false로 만들어 초기화
	if TimeVV == 0 then
		On = false
	end
	--값 초기화
	Frame.Visible = false
	NameT.Text = ""
	ReactionFormulaT.Text = ""
	TimeT.Text = ""
	

end)
