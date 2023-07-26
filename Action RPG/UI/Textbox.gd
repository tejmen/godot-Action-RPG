extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
onready var audio = $AudioStreamPlayer2D
enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	hide_textbox()

# warning-ignore:unused_argument
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				end_symbol.text = "v"
				change_state(State.FINISHED)
		State.FINISHED:
			end_symbol.text = "v"
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	var next_text: String = text_queue.pop_front()
	change_state(State.READING)
	show_textbox()
	for i in next_text:
		label.text = label.text + i
		if i != " ":
			audio.play()
		yield(get_tree().create_timer(CHAR_READ_RATE), "timeout")
	change_state(State.FINISHED)
	

func change_state(next_state):
	current_state = next_state
