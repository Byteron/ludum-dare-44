extends Resource
class_name RBuilding

export(Texture) var building_texture = null

export(String) var alias = ""
export(String) var description = ""

export(Structure.TYPE) var type = null

export(int) var cost = 0
export(int) var build_time = 0

export(bool) var tick = true

export(int) var revenue = 0
export(int) var upkeep = 0
export(int) var bonus = 0
export(int) var malus = 0