extends Control

var code = []
var codegood = []
var running = false
var time = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in $Control/reactorbuttons.get_children():
		n.connect("pressed", bp.bind(n))

func start():
	time = 4
	code=[]
	codegood=[]
	%minigamedone.play("RESET")
	running = true
	for i in range(6):
		codegood.append(randi_range(0,9))
	
	$Label.text = ""
	$Label2.text = ""
	for i in codegood:
		$Label.text = $Label.text + str(i)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = time
	$Label2.text = ""
	
	for i in code:
		$Label2.text = $Label2.text + str(i)
	if running == true:
		time -= delta
		if code.size() > 5:
			var copy = codegood.duplicate()
			copy.reverse()
			print(copy)
			if code == codegood:
				%winmessage.text = "zadanie wykonane!"
				%winmessage.modulate = Color(0.0, 1.0, 0.017, 1.0)
			
				get_tree().current_scene.done += 1
				%minigamedone.play("new_animation")
				running = false
				get_tree().current_scene.donegames[4] = 0
			
			elif code == copy:
				get_tree().current_scene.donegames[4] = 1
				%winmessage.modulate = Color(0.783, 0.0, 1.0, 1.0)
				%winmessage.text = "zadanie zsabotowane"
				get_tree().current_scene.sabotaged += 1
				%minigamedone.play("new_animation")
				running=false
			else:
				%winmessage.modulate = Color(1.0, 0.0, 0.0, 1.0)
				%winmessage.text = "zadanie nieudane"
				%minigamedone.play("new_animation")
				running = false
		if time < 0:
			%winmessage.modulate = Color(1.0, 0.0, 0.0, 1.0)
			%winmessage.text = "zadanie nieudane"
			%minigamedone.play("new_animation")
			running = false
		

func bp(node):
	
	if running == true:
		$KeypadNumerki.play()
		$KeypadNumerki.pitch_scale = node.get_index()/ 2.0
		code.append(node.get_index()+1)


func _on_b_0_pressed() -> void:
	if running == true:
		$KeypadNumerki.play()
		code.append(0)
