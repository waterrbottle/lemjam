extends Node2D
var sabotaged = 0
var done = 0
var quest = ""
var names = {"reactor": "programowanie komputera pokladowego",
"screws": "odkrecanie srub"}
# Called when the node enters the scene tree for the first time.


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
	pass


func _on_reactor_pressed() -> void:
	setquest("reactor")


func _on_reactor_2_pressed() -> void:
	setquest("screws")
