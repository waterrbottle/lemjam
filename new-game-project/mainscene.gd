extends Node2D
var sabotaged = 0
var done = 0
var quest = ""
# Called when the node enters the scene tree for the first time.


func setquest(questval: String):
	quest=questval
	for n in %allquests.get_children():
		n.hide()
		if n.name == questval:
			n.show()
			print("o")
			n.start()
	$quests.show()
	$quests/CanvasLayer/allquests/reactor/AnimationPlayer2.play("elo")
	
func _ready() -> void:
	$quests.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reactor_pressed() -> void:
	setquest("reactor")
