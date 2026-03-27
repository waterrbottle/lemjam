extends Control
var values = []
var done =[0,0,0]
var timer = 3
var running = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func start():
	timer= 3
	running = true
	
	$VBoxContainer/HSlider.value=5
	$VBoxContainer/HSlider2.value=5
	$VBoxContainer/HSlider3.value=5
	%minigamedone.play("RESET")
	values = [randi_range(1,4),randi_range(1,4),randi_range(1,4),randi_range(6,10),randi_range(6,10),randi_range(6,10)]
	%vis1e.position.x = -0 + values[0]/ 10.0* 240
	%vis2e.position.x = -0 + values[1] /10.0* 240
	%vis3e.position.x = -0 + values[2] / 10.0* 240
	%vis1.position.x = -0 + values[3]/ 10.0* 240
	%vis2.position.x = -0 + values[4] /10.0* 240
	%vis3.position.x = -0 + values[5] / 10.0* 240
	done=[0,0,0]
	running = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	$ProgressBar.value = timer

	if running == true:
		timer -= delta
		if timer < 0:
			running=false
			%winmessage.modulate = Color(1.0, 0.0, 0.0, 1.0)
			%winmessage.text = "zadanie nieudane"
			%minigamedone.play("new_animation")
		
		
func good():
	running=false
	%winmessage.text = "zadanie wykonane!"
	%winmessage.modulate = Color(0.0, 1.0, 0.017, 1.0)
	get_tree().current_scene.done += 1
	%minigamedone.play("new_animation")
	get_tree().current_scene.donegames[3] = 0
func sabo():
	get_tree().current_scene.donegames[3] = 1
	running=false
	%winmessage.modulate = Color(0.783, 0.0, 1.0, 1.0)
	%winmessage.text = "zadanie zsabotowane"
	get_tree().current_scene.sabotaged += 1
	%minigamedone.play("new_animation")

func _on_h_slider_3_value_changed(value: float) -> void:
	print(value)
	print(values)
	if value == values[2] * 1.0:
		done[2] = 2
	if value == values[5] * 1.0:
		done[2] = 1
	
	if done == [1,1,1]:
		good()
	if done == [2,2,2]:
		sabo()

func _on_h_slider_2_value_changed(value: float) -> void:
	if value == values[1] * 1.0:
		done[1] = 2
	if value == values[4] * 1.0:
		done[1] = 1
	
	if done == [1,1,1]:
		good()
	if done == [2,2,2]:
		sabo()

func _on_h_slider_value_changed(value: float) -> void:
	if value == values[0] * 1.0:
		done[0] = 2
	if value == values[3] * 1.0:
		done[0] = 1
	if done == [1,1,1]:
		good()
	if done == [2,2,2]:
		sabo()
