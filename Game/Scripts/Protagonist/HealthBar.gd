extends CanvasLayer

@onready var health1 = $Health_1
@onready var health2 = $Health_2
@onready var health3 = $Health_3

@onready var mainWorld = $VBoxContainer/MainWorld
@onready var sideWorld = $VBoxContainer/SideWorld

var currHealth = 3


func _ready():
	SignalBus.DamageTaken.connect(loseHealth)
	SignalBus.changeWorld.connect(changeRealm)
	
	health1.show()
	health2.show()
	health3.show()
	
	mainWorld.show()
	sideWorld.hide()

func changeRealm(newRealm):
	match  newRealm:
		"Default":
			sideWorld.hide()
			mainWorld.show()
		"Alt1":
			mainWorld.hide()
			sideWorld.show()

func loseHealth():
	currHealth -= 1
	match currHealth:
		2:
			health3.hide()
		1:
			health2.hide()
		0:
			health1.hide()
