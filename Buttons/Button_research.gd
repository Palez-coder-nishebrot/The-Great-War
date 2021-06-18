extends TextureButton

var _text: String
var status: bool = false
var tipe
func _on_Button_pressed():
	if status == true:
		set_tipe_children()
		var object = load("res://Objects/researh/ProcessOfResearch.tscn").instance()
		add_child(object)
		object.call(tipe, $Label.text, PlayersObj.PlayerObject.part_of, self)
	else:
		print('Исследование недоступно')
	
func set_tipe_children():
	var children = get_children()
	for i in children:
		if i.get_class() != 'Label':
			i.tipe = tipe
func _ready():
	$Label.text = name
