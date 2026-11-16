--!strict
--[[
	DataSchema
	Définit la structure par défaut des données joueur + migrations.
]]

local DataSchema = {}

local CURRENT_VERSION = 1

function DataSchema.GetDefault()
	return {
		Version = CURRENT_VERSION,
		Currency = 0,
		Rebirths = 0,
		Multipliers = {
			Click = 1,
		},
		Pets = {},
		EquippedPet = nil,
	}
end

function DataSchema.Migrate(data)
	if not data.Version or data.Version < 1 then
		-- Migration depuis une version très ancienne
		data = DataSchema.GetDefault()
	end

	-- Exemple de migration future :
	-- if data.Version < 2 then
	--     data.NewField = true
	--     data.Version = 2
	-- end

	data.Version = CURRENT_VERSION
	return data
end

return DataSchema
