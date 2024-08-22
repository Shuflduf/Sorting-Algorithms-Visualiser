extends HBoxContainer

@onready var options: OptionButton = %Options
@export var buttons_to_disable: Array[Control]

var time = 0.0:
	set(value):
		time = value
		$Timer.text = str(value).pad_decimals(2).pad_zeros(2)
var counting = false

func populate_options():
	for i in %Sorters.get_children():
		options.add_item(i.name)

func _process(delta: float) -> void:
	if counting:
		time += delta

func _ready() -> void:
	populate_options()
	_on_options_item_selected(0)
	%BarsSlide.value = owner.count
	%SpeedSlide.value = owner.speed
	owner.sort_started.connect(disable_buttons)
	owner.sorted.connect(enable_buttons)

func enable_buttons():
	counting = false
	for i in buttons_to_disable:
		if i is Button:
			i.disabled = false
		elif i is Slider or i is SpinBox:
			i.editable = true

func disable_buttons():
	time = 0
	counting = true
	for i in buttons_to_disable:
		if i is Button:
			i.disabled = true
		elif i is Slider or i is SpinBox:
			i.editable = false

func _on_shuffle_pressed() -> void:
	owner.shuffle_bars()


func _on_sort_pressed() -> void:
	owner.sort()


func _on_options_item_selected(index: int) -> void:
	owner.sorter = %Sorters.get_child(index)


func _on_bars_slide_value_changed(value: float) -> void:
	owner.count = value
	owner.populate_bars()
	$Bars/BarsNum.value = value


func _on_bars_num_value_changed(value: float) -> void:
	%BarsSlide.value = value


func _on_speed_slide_value_changed(value: float) -> void:
	owner.speed = value
	$Speed/SpeedNum.value = value


func _on_speed_num_value_changed(value: float) -> void:
	%SpeedSlide.value = value


func _on_reset_pressed() -> void:
	get_tree().root.add_child(load(owner.scene_file_path).instantiate())
	owner.queue_free()
