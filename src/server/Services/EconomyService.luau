--!strict
--[[
	EconomyService
	Gère la monnaie, les multipliers et les actions de click.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Remotes = require(Shared.Network.Remotes)
local EconomyConfig = require(Shared.Configs.Economy)
local DataService = require(script.Parent.DataService)

local EconomyService = {}

function EconomyService:Init()
	Remotes.Get("Click").OnServerEvent:Connect(function(player)
		self:ProcessClick(player)
	end)
end

function EconomyService:Start()
end

function EconomyService:ProcessClick(player: Player)
	local data = DataService:Get(player)
	if not data then return end

	local gain = EconomyConfig.BaseClick * (data.Multipliers.Click or 1)
	data.Currency += gain

	-- Notifier le client
	Remotes.Get("CurrencyUpdated"):FireClient(player, data.Currency)
end

function EconomyService:AddCurrency(player: Player, amount: number)
	DataService:Update(player, function(data)
		data.Currency += amount
	end)
	local data = DataService:Get(player)
	Remotes.Get("CurrencyUpdated"):FireClient(player, data.Currency)
end

return EconomyService
