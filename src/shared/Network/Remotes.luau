--!strict
--[[
	Remotes
	Création centralisée de tous les RemoteEvents / RemoteFunctions.
	Tous les remotes vivent dans ReplicatedStorage.Remotes
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemotesFolder = ReplicatedStorage:WaitForChild("Remotes")

local REMOTE_NAMES = {
	-- Client → Server
	"Click",
	"OpenEgg",
	"EquipPet",
	"Rebirth",

	-- Server → Client
	"DataLoaded",
	"CurrencyUpdated",
	"PetEquipped",
	"EggOpened",
	"RebirthCompleted",
}

local cache = {}

local Remotes = {}

function Remotes.Init()
	for _, name in REMOTE_NAMES do
		local existing = RemotesFolder:FindFirstChild(name)
		if existing then
			cache[name] = existing
		else
			local remote = Instance.new("RemoteEvent")
			remote.Name = name
			remote.Parent = RemotesFolder
			cache[name] = remote
		end
	end
end

function Remotes.Get(name: string): RemoteEvent
	return cache[name] or RemotesFolder:WaitForChild(name)
end

return Remotes
