--!strict
--[[
	DataService
	Gère la sauvegarde et le chargement des données joueur via DataStore.
	Recommandation : remplacer par ProfileService / ProfileStore en production.
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local DataSchema = require(game:GetService("ServerStorage").Modules.DataSchema)
local Remotes = require(Shared.Network.Remotes)

local DataService = {}
DataService.__index = DataService

local DATASTORE_NAME = "PlayerData_v1"
local dataStore = DataStoreService:GetDataStore(DATASTORE_NAME)

local playerData = {} -- [Player] = data table

function DataService:Init()
	Players.PlayerAdded:Connect(function(player)
		self:Load(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:Save(player)
		playerData[player] = nil
	end)

	game:BindToClose(function()
		for _, player in Players:GetPlayers() do
			self:Save(player)
		end
	end)
end

function DataService:Start()
	-- Rien de spécial ici pour l'instant
end

function DataService:Load(player: Player)
	local key = "Player_" .. player.UserId
	local success, data = pcall(function()
		return dataStore:GetAsync(key)
	end)

	if success and data then
		-- Migration éventuelle via DataSchema
		data = DataSchema.Migrate(data)
	else
		data = DataSchema.GetDefault()
	end

	playerData[player] = data

	-- Envoyer les données au client
	Remotes.Get("DataLoaded"):FireClient(player, data)
end

function DataService:Save(player: Player)
	local data = playerData[player]
	if not data then return end

	local key = "Player_" .. player.UserId
	local success, err = pcall(function()
		dataStore:SetAsync(key, data)
	end)

	if not success then
		warn("[DataService] Failed to save data for", player.Name, err)
	end
end

function DataService:Get(player: Player)
	return playerData[player]
end

function DataService:Update(player: Player, updater: (data: any) -> ())
	local data = playerData[player]
	if not data then return end
	updater(data)
end

return DataService
