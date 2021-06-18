extends Node

onready var cavalry = $"Карабин"

func _ready():
	$"Карабин".status = true
	$"Карабин".tipe = 'cavalry'
	$"Карабин".parent = self
	
