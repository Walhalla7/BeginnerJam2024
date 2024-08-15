extends CanvasLayer

@onready var health1 = $Health_1
@onready var health2 = $Health_2
@onready var health3 = $Health_3

@onready var mainWorld = $VBoxContainer/MainWorld
@onready var sideWorld = $VBoxContainer/SideWorld

var currHealth = 3

var isRealmCooldown = false

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _process(delta):
	if isRealmCooldown:
		$VBoxContainer/TimeLeft.text = str(round_to_dec($RealmTimer.time_left, 1))

func _ready():
	SignalBus.DamageTaken.connect(loseHealth)
	SignalBus.changeWorld.connect(changeRealm)
	$VBoxContainer/TimeLeft.hide()
	
	health1.show()
	health2.show()
	health3.show()
	
	mainWorld.show()
	sideWorld.hide()

func changeRealm(newRealm):
	$RealmTimer.start()
	isRealmCooldown = true
	$VBoxContainer/TimeLeft.show()
	$VBoxContainer.modulate = Color("#6d6d6d")
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


func _on_realm_timer_timeout():
	isRealmCooldown = false
	$VBoxContainer.modulate = Color("#ffffff")
	$VBoxContainer/TimeLeft.hide()
