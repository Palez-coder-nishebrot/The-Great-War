extends TextureButton

var status: bool = false
var tipe
var parent_object: Object
func set_tipe_children():
	var children = get_children()
	for i in children:
		if i.get_class() != 'Label':
			if tipe != 'Main':
				i.tipe = tipe
			i.status = true
			i.parent_object = parent_object
func _ready():
	$Label.text = name


func _on_TextureButton_pressed():
	if status == true:
		parent_object.get_node('Panel_Focus').open($Label.text, tipe, self)
