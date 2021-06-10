extends Node2D


func _ready():
	set_players()

func set_parties(ObjectPlayer):
	for y in range(7):
		var partyObj = load("res://Objects/Parties window/Party.tscn").instance()
		var PartyTipe = Ideologies.tipe_ide[y-1]
		partyObj.Ideology = PartyTipe
		partyObj.NameOfParty = Ideologies.parties[PartyTipe][rng(0.0, 2.0)]
		ObjectPlayer.parties.append(partyObj)

func rng(num1,num2):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(num1,num2)
	return int(my_random_number)


func set_players():
	for i in get_node("/root/PlayersObj").political_ideology_of_countries.keys():
		if get_node("/root/PlayersObj").playersObj[i].size() < 2:
			var obj = load("res://Objects/AI/AI.tscn").instance()
			obj.part_of = i
			add_child(obj)
			get_node("/root/PlayersObj").playersObj[i].append(obj)
			set_parties(obj)
		else:
			set_parties(get_node("/root/PlayersObj").playersObj[i][1])
			
	for i in get_node("/root/PlayersObj").playersObj:
		get_node("/root/PlayersObj").playersObj[i][1].set_Ruling_Party()
		
	for i in get_node("/root/PlayersObj").playersObj:
		get_node("/root/PlayersObj").playersObj[i][1].set_Ruling_Party()
		for y in get_node("/root/PlayersObj").playersObj:
			if y != i:
				get_node("/root/PlayersObj").playersObj[i][1].set_relations(get_node("/root/PlayersObj").playersObj[y][1])
