extends Sorter


func sort():
	var swapped = false

	while !owner.is_sorted():
		var c = %Bars.get_child_count() - (1 if !swapped else 0)
		var c_range = range(1, c)

		if swapped:
			c_range.reverse()

		for i in c_range:

			var bar = %Bars.get_child(i)
			var next_bar = %Bars.get_child(i + (-1 if swapped else 1))
			if swapped:
				if bar.custom_minimum_size.y < next_bar.custom_minimum_size.y:
					await owner.swap_bars(i, i - 1)
			else:
				if bar.custom_minimum_size.y > next_bar.custom_minimum_size.y:
					await owner.swap_bars(i, i + 1)

		swapped = !swapped
