extends Node

onready var artillery = $"Artillery/Артеллерия 1914 года"
onready var grenades = $"Grenades/Граната"
onready var FireSupport = $"FireSupport/Окопный гранотомет Алексеева"
func _ready():
	$"Artillery/Артеллерия 1914 года".status = true
	$"Artillery/Артеллерия 1914 года".tipe = 'artillery'
	$"Artillery/Артеллерия 1914 года".parent = self
	
	$"Grenades/Граната".status = true
	$"Grenades/Граната".tipe = 'grenades'
	$"Grenades/Граната".parent = self
	
	$"FireSupport/Окопный гранотомет".status = true
	$"FireSupport/Окопный гранотомет".tipe = 'FireSupport'
	$"FireSupport/Окопный гранотомет".parent = self
	
