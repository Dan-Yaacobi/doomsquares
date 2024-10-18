class_name HowToPlay extends Control

@onready var boost_text: Label = $BoostText

@onready var back_button: Button = $BackButton


@onready var button: Button = $Button
@onready var button2: Button = $Button2
@onready var button3: Button = $Button3
@onready var button4: Button = $Button4
@onready var button5: Button = $Button5
@onready var button6: Button = $Button6

const START_MENU = "res://Start Menu/StartMenu.tscn"
var texts: Array[String] = ["Increase enemy size","Bullets can explode into smaller bullets","Increase bullet size"
,"Bullets will pierce through enemies","Reduces enemy spawn rate","Increase amount of bullets fired"]

func _ready() -> void:
	button.connect("pressed",func():text_appear(texts[0]))
	button2.connect("pressed",func():text_appear(texts[1]))
	button3.connect("pressed",func():text_appear(texts[2]))
	button4.connect("pressed",func():text_appear(texts[3]))
	button5.connect("pressed",func():text_appear(texts[4]))
	button6.connect("pressed",func():text_appear(texts[5]))
	back_button.pressed.connect(back_to_menu)
	
	var new_sb = StyleBoxFlat.new()
	new_sb.bg_color = Color.from_string("ff191987",Color.DARK_RED)
	boost_text.add_theme_stylebox_override("normal", new_sb)
	
func text_appear(_text: String) -> void:
	boost_text.text = _text

func back_to_menu() -> void:
	get_tree().change_scene_to_file(START_MENU)
	pass
	
