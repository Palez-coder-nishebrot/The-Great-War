extends Node2D

func _ready():
	$"Восстановление железных дорог".tipe = 'Main'
	$"Восстановление железных дорог".status = true
	$"Восстановление железных дорог".parent_object = self
	$"Восстановление железных дорог/Индустрилизация".tipe = 'Industrialization'
	$"Восстановление железных дорог/Упор на сельск хозяйство".tipe = 'Agriculture'

