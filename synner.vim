let output = []
let row = 1
let current_name = ""
let syn_contents = ""

while row <= line('$')
	let line = getline(row)
	let col = 1

	while col <= strlen(line)
		let syn_name = synIDattr(synID(row, col, 1), "name")

		if syn_name == ""
			let syn_name = "NONE"
		endif

		if current_name != syn_name
			if syn_contents != ""
				call add(output, current_name . " " . syn_contents)
			endif

			let syn_contents = ""
			let current_name = syn_name
		endif

		let syn_contents = syn_contents . line[col - 1]

		let col = col + 1
	endwhile

	if syn_contents != "" | call add(output, current_name . " " . syn_contents) | endif
	let syn_contents = ""
	let current_name = ""

	call add(output, "NewLine")

	let row = row + 1
endwhile

echo join(output, "\n") . "\n"
