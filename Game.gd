extends Node

@onready var world = $World
@onready var mainMenu = $MainMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_gui_input(event):
	if mainMenu.playGame:
		mainMenu.visible = 0
		world.visible = 1
		world.process_mode = Node.PROCESS_MODE_INHERIT
	pass # Replace with function body.
