extends Label

var splashes : Array = [
	"W pogoni za nowym domem elity zdecydowały się przejąć Eden.", 
	"Jedyne, co wiadomo o Eden to to, 
	że jest w stanie utrzymać na swojej powierzchni masę żyjących istot.", 
	"Statek “Niezwyciężony” uzyskał swoją nazwę,
	bo nigdy nie poległ w walkach międzyplanetarnych.", 
	"Mieszkańcy planety Eden są zamknięci w sobie,
	nigdy nie interesowały ich intrygi innych odległych cywilizacji.", 
	"Niezwyciężony wyposażony jest w innowacyjne tarcze,
	które chronią go przed własnymi bombami atomowymi.",
	"Horpach, Ballmin oraz Lauda to trzej dzielni reprezentanci,
	którzy podjęli się misji kolonizacji Eden.",
	"Model robotów R0G4RTH-19-XX to najnowszy wynalazek firmy DSM-7."
]

func _ready() -> void:
	pivot_offset = size / 2
	
	text = splashes.pick_random()

func _process(delta: float) -> void:

	var pulse = 1.0 + abs(sin(Time.get_ticks_msec() * 0.003)) * 0.03
	scale = Vector2(pulse, pulse)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_SPACE:
			text = splashes.pick_random()
			pivot_offset = size / 2
