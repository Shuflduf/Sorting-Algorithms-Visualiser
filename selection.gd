extends Sorter


func sort():
	var checked = 0
	while !owner.sorted():

		var smallest: Panel = null

		for i in %Bars.get_child_count() - checked:
			var bar = %Bars.get_child(i + checked)
			if smallest == null or bar.custom_minimum_size.y < smallest.custom_minimum_size.y:
				smallest = bar

		await owner.swap_bars(checked, smallest.get_index())

		checked += 1
