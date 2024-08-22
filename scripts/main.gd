extends Control

signal sort_started
signal sorted

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@export_range(2, 200, 1) var count = 10
@export_range(0, 2, 0.01) var speed = 0.5
@export var bar_scene: PackedScene
@export var sorter: Sorter

var max_size: int


func get_max_size() -> int:
	var temp_bar: Panel = bar_scene.instantiate()
	temp_bar.size_flags_vertical = Control.SIZE_FILL
	%Bars.add_child(temp_bar)
	await get_tree().process_frame
	var m = temp_bar.size.y
	temp_bar.queue_free()
	print(m)
	return m


func _ready() -> void:
	max_size = await get_max_size()
	populate_bars()

	await get_tree().process_frame

func populate_bars():
	for i in %Bars.get_children():
		i.queue_free()

	for i in count:
		var height = float(i + 1) / float(count)
		var new_bar: Panel = bar_scene.instantiate()
		%Bars.add_child(new_bar)
		new_bar.custom_minimum_size.y = height * max_size

func sort():
	sort_started.emit()
	sorter.sort()

func swap_bars(first: int, second: int, fast = false):
	var first_bar = %Bars.get_child(first)
	var second_bar = %Bars.get_child(second)
	var p = (1 / (float(first_bar.custom_minimum_size.y) / float(count))) + 0.1
	audio.play()
	audio.pitch_scale = p
	first_bar.modulate = Color.RED
	second_bar.modulate = Color.RED

	if fast or speed <= 0.01:
		await get_tree().process_frame
	else:

		var first_pos = first_bar.position.x
		var second_pos = second_bar.position.x

		var tween = get_tree().create_tween()
		tween.parallel().tween_property(first_bar, "position:x", second_pos, speed)
		tween.parallel().tween_property(second_bar, "position:x", first_pos, speed)
		await tween.finished

	first_bar.modulate = Color.WHITE
	second_bar.modulate = Color.WHITE

	%Bars.move_child(first_bar, second)
	%Bars.move_child(second_bar, first)
	return

func shuffle_bars():
	randomize()
	for i in count * 10:
		%Bars.move_child(%Bars.get_child(randi_range(0, count - 1)), randi_range(0, count - 1))


func is_sorted() -> bool:
	var smallest = 0
	for i in %Bars.get_children():
		if smallest > i.custom_minimum_size.y:
			return false
		else:
			smallest = i.custom_minimum_size.y
	whooooOOOOOOOO()
	return true

func whooooOOOOOOOO():
	sorted.emit()
	for i in %Bars.get_children():
		i.modulate = Color.GREEN
		var p = (float(i.custom_minimum_size.y) / float(count))
		audio.play()
		audio.pitch_scale = p
		await get_tree().process_frame
	for i in %Bars.get_children():
		i.modulate = Color.WHITE
