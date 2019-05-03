extends Resource
class_name RBuilding

export(Texture) var building_texture = null

export(String) var name = "Building"
export(String) var description = "This is a Building"

export(Building.TYPE) var type = Building.TYPE.BUILDING

export(int) var cost = 15000
export(int) var build_time = 10

export(bool) var tick = true
export(bool) var revenue_per_housing = true

export(int) var revenue = 0
export(int) var upkeep = 0
export(int) var bonus = 0
export(int) var malus = 0

export(Array, String) var build_reqiurements = []
export(Array, String) var malus_requirements = []
export(Array, String) var bonus_requirements = []