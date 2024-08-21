extends HBoxContainer

@onready var options: OptionButton = %Options

@export var buttons_to_disable: Array[Button]

func populate_options():
	for i in %Sorters.get_children():
		options.add_item(i.name)

func _ready() -> void:
	populate_options()
	owner.sort_started.connect(disable_buttons)
	owner.sorted.connect(enable_buttons)

func enable_buttons():
	for i in buttons_to_disable:
		i.disabled = false

func disable_buttons():
	for i in buttons_to_disable:
		i.disabled = true

func _on_shuffle_pressed() -> void:
	owner.shuffle_bars()


func _on_sort_pressed() -> void:
	owner.sort()


func _on_options_item_selected(index: int) -> void:
	owner.sorter = %Sorters.get_child(index)
