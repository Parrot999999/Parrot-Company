--�������ݱ� ���� ��ũ��Ʈ

--����Ʈ ����
local ReactionFormulaRemote = game.ReplicatedStorage.Research.ReactionFormulaRemote
local ReactionFormulaCheck = game.ReplicatedStorage.Research.ReactionFormulaCheck
local ReactionFormulaStop = game.ReplicatedStorage.Research.ReactionFormulaStop

--�ݺ����� ���߰� �ϴ� ����
local Stop = false

--UI ���� ������Ʈ�� ����� ����
local NameT = script.Parent.Frame.NameT
local ReactionFormulaT = script.Parent.Frame.ReactionFormulaT
local TimeT = script.Parent.Frame.TimeT
local Frame = script.Parent.Frame
local TempImage = script.Parent.Frame.TempImage
local SpeedImage = script.Parent.Frame.SpeedImage

--�̹� �������ݱ⸦ ������ �ִ��� ���� bool ����
local On = false


--�������ݱⰡ �̹� ���ư��� �ִ��� �ƴ����� Ȯ���� ���� ������ ������ ������ �ϴ� �ڵ�
ReactionFormulaCheck.OnClientEvent:Connect(function()
	if On == false then
		ReactionFormulaCheck:FireServer("Off")
	elseif On == true then
		ReactionFormulaCheck:FireServer("On")
	end
end)

--���� �������ݱⰡ ���� �ƴٸ� Stop ������ true�� ����� �ݺ����� ���߰� �� �� 8�� ��ٷ� On ������ false�� ����� �ڵ�
ReactionFormulaStop.OnClientEvent:Connect(function()
	Stop = true
	task.wait(8)
	On = false
end)

--�������� �޾ƿ� ���� ���� Ui�� ���� ��Ű�� �ڵ�
ReactionFormulaRemote.OnClientEvent:Connect(function(TimeV, NameV, ReactionFormulaV, TempV, SpeedV)
	On = true
	task.wait(0.3)
	local TimeVV
	NameT.Text = NameV.."(��)/�� ����� ���"
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
	
	--Ÿ�̸�
	repeat
		--���� Stop ������ true�� �Ǹ� �ݺ����� ����
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
		TimeT.Text = tostring(TimeVV).."�� ����"
	until TimeVV == 0
	
	--���� �ð��� �ʰ��ƴٸ� On�� false�� ����� �ʱ�ȭ
	if TimeVV == 0 then
		On = false
	end
	--�� �ʱ�ȭ
	Frame.Visible = false
	NameT.Text = ""
	ReactionFormulaT.Text = ""
	TimeT.Text = ""
	
end)