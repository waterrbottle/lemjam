extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _ready() -> void:
	Global.donegames = [-1,-1,-1,-1,-1]
func _on_start_pressed() -> void:
	$clickaudio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://starts/start_gaem.tscn")

func _on_authors_pressed() -> void:
	$clickaudio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("uid://b1e6tuit4euh4")


func _on_exit_pressed() -> void:
	$clickaudio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("uid://cxidk5igsb26v")
	
