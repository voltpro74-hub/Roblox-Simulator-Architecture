--!strict

export type PlayerData = {
	Currency: number,
	Rebirths: number,
	Multipliers: {
		Click: number,
	},
	Pets: {[string]: boolean},
	EquippedPet: string?,
}

export type EggConfig = {
	Price: number,
	Pets: {[string]: number}, -- petId → weight
}

return nil
