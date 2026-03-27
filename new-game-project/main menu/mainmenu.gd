extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	$clickaudio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("uid://bm5jusu50mxim")

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
