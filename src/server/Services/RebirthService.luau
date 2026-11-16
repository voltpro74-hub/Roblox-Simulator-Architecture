--!strict
--[[
	RebirthService
	Système de rebirth (reset monnaie + boost permanent).
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Remotes = require(Shared.Network.Remotes)
local EconomyConfig = require(Shared.Configs.Economy)
local DataService = require(script.Parent.DataService)

local RebirthService = {}

function RebirthService:Init()
	Remotes.Get("Rebirth").OnServerEvent:Connect(function(player)
		self:DoRebirth(player)
	end)
end

function RebirthService:Start()
end

function RebirthService:DoRebirth(player: Player)
	local data = DataService:Get(player)
	if not data then return end

	local required = EconomyConfig.RebirthRequirement * (data.Rebirths + 1)
	if data.Currency < required then
		return
	end

	DataService:Update(player, function(d)
		d.Currency = 0
		d.Rebirths += 1
		d.Multipliers.Click = (d.Multipliers.Click or 1) + EconomyConfig.RebirthMultiplierGain
	end)

	local newData = DataService:Get(player)
	Remotes.Get("RebirthCompleted"):FireClient(player, newData.Rebirths, newData.Multipliers.Click)
	Remotes.Get("CurrencyUpdated"):FireClient(player, 0)
end

return RebirthService
