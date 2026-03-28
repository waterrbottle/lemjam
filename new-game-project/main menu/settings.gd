extends Node2D
var glosnosci = ["wyciszona (silent)", "cicha (quiet)", "srednia (average)", "maksymalna (max)"]
var trudnosci = ["labubu (noob)", "normalna (normal)", "trudna (hard)", "IMPOSSIBLE"]
var g = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/VBoxContainer/vollab.text = "głośność (volume): " + glosnosci[g]
	$CanvasLayer/VBoxContainer/diflab.text = "trudność (difficulty): " + trudnosci[Global.difficulty]


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main menu/mainmenu.tscn")


func _on_v_1_pressed() -> void:
	g = 0
	AudioServer.set_bus_volume_linear(0,0) 


func _on_v_2_pressed() -> void:
	g = 1
	AudioServer.set_bus_volume_linear(0,0.3) 


func _on_v_3_pressed() -> void:
	g = 2
	AudioServer.set_bus_volume_linear(0,0.7) 



func _on_v_4_pressed() -> void:
	g = 3
	AudioServer.set_bus_volume_linear(0,1) 


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()


func _on_return_4_pressed() -> void:
	Global.difficulty = 0


func _on_return_pressed() -> void:
	Global.difficulty = 1


func _on_return_2_pressed() -> void:
	Global.difficulty = 2


func _on_return_3_pressed() -> void:
	Global.difficulty = 3
