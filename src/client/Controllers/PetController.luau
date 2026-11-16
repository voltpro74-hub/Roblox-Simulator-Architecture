--!strict
--[[
	PetController
	Gère l'affichage et l'équipement des pets côté client.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = require(Shared.Network.Remotes)

local PetController = {}

function PetController:Init()
	Remotes.Get("PetEquipped").OnClientEvent:Connect(function(petId)
		print("[Pet] Equipped:", petId)
		-- Spawner le modèle du pet ici
	end)

	Remotes.Get("EggOpened").OnClientEvent:Connect(function(eggName, petId)
		print("[Pet] Opened", eggName, "→ got", petId)
		-- Animation d'ouverture d'œuf
	end)
end

function PetController:Start()
end

return PetController
