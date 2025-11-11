:command! -nargs=? SlotMachine call SlotMachine(<f-args>)

function SlotMachine(...)
	let wt=10
	if a:0>=1
		let wt=a:1
	end
	let frame_wait=wt."m"
	let slot_width=3
	let slot_hight=9

	let slot_column_indexes=range(slot_width)
	for i in range(slot_width)
		let slot_column_indexes[i]=rand()%9
	endfor

	let slot_index_index=0
	let slot_num_list=range(1,slot_hight)

	while v:true
		let char = getchar(0)
		if char ==char2nr('s')
			if slot_index_index<2
			let slot_index_index=slot_index_index+1
			else
				break	
			endif
		endif

		for i in range(slot_index_index,slot_width-1)
			let slot_column_indexes[i]=(slot_column_indexes[i]+1)%slot_hight
		endfor

		%delete _

		for j in range(slot_hight+1)
		call setline(j+1, '')
		endfor
	
		for y in range(slot_hight)
		let temp=""
			for i in range(slot_width)
				let temp=temp.slot_num_list[(y+slot_column_indexes[i])%slot_hight]
				if i<slot_width-1
					let temp=temp." "
				endif
			endfor
			call setline(y+1,temp) 
		endfor

		redraw
	
		exe 'sleep '.frame_wait
	endwhile

	let temp=slot_column_indexes[0]
	let win_flag=1
	for i in range(1,slot_width-1)
		if temp!=slot_column_indexes[i]
			let win_flag=0
		endif	
	endfor

	if win_flag==1
		call setline(slot_hight+1,"Congratulations! You won!!")
	else
		call setline(slot_hight+1,"Too bad! It was a miss!!")
	endif
endfunction
