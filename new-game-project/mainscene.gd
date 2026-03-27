extends Node2D
var sabotaged = 0
var done = 0
var quest = ""
var names = {"reactor": "przekazywanie komunikatu",
"screws": "uszczelnianie silnika", "cables":"wpinanie przewodów", "slider": "ustawienie trajektorii predkosci i konta lota",
"codes": "wprowadzanie kodu bezpieczenstwa"}
# Called when the node enters the scene tree for the first time.
var donegames = [-1,-1,-1,-1,-1]

func setquest(questval: String):
	quest=questval
	for n in %allquests.get_children():
		if n is not AnimationPlayer:
			if n.name != "always_shown":
				n.hide()
		if n.name == questval:
			n.show()
			print("o")
			n.start()
	$quests.show()
	%gamefade.play("elo")
	%gamename.text = names[questval]
	
func _ready() -> void:
	$quests.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if donegames == [0,0,0,0,0]:
		$Panel.show()
	if donegames == [1,1,1,1,1]: 
		$Panel.show()
	
	for n in $buttons.get_children():
		if donegames[n.get_index()] == -1:
			n.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if donegames[n.get_index()] == 0:
			n.modulate = Color(0.0, 1.0, 0.05, 1.0)
		if donegames[n.get_index()] == 1:
			n.modulate = Color(0.833, 0.0, 1.0, 1.0)


func _on_reactor_pressed() -> void:
	setquest("reactor")


func _on_reactor_2_pressed() -> void:
	setquest("screws")


func _on_cables_pressed() -> void:
	setquest("cables")


func _on_sliders_pressed() -> void:
	setquest("slider")


func _on_codes_pressed() -> void:
	setquest("codes")


func _on_wingame_pressed() -> void:
	if donegames == [0,0,0,0,0]:
		pass
	if donegames == [1,1,1,1,1]: 
		pass
