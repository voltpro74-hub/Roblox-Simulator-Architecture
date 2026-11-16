--!strict
--[[
	UIController
	Gère l'affichage de la monnaie, boutons, etc.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = require(Shared.Network.Remotes)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local UIController = {}

function UIController:Init()
	-- Écouter les updates de monnaie
	Remotes.Get("CurrencyUpdated").OnClientEvent:Connect(function(amount)
		self:UpdateCurrencyDisplay(amount)
	end)

	Remotes.Get("DataLoaded").OnClientEvent:Connect(function(data)
		self:UpdateCurrencyDisplay(data.Currency)
		-- Initialiser d'autres UI ici
	end)
end

function UIController:Start()
	-- Créer / récupérer le ScreenGui principal ici si besoin
end

function UIController:UpdateCurrencyDisplay(amount: number)
	-- Exemple : mettre à jour un TextLabel
	-- local label = playerGui.Main.CurrencyLabel
	-- label.Text = tostring(amount)
	print("[UI] Currency:", amount)
end

return UIController
