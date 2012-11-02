/* ------------------------------------------------------------------------- */
PROCESS show_graveyard()

private

	int i;
	int count;
	
	int max_x;

end

begin

	file = load_fpg( "fpg/graveyard.fpg" );

	// cuento la cantidad de muertos
	for ( count=0; count < GRAVEYARD_COUNT; count++ )
	
		if ( data.graveyard[count].age == 0 )
		
			// say("lugar " + count + " vacio");
			break;
			
		end
		
	end
	
	max_x = ( count * 200) - 100;
	
	/*
	say( "count " + count );
	say("muertos: " + count);
	say("max_x: " + max_x);
	*/
	
	start_scroll(0, file, 9, 0, 0, 1);
	
	ctype = c_scroll;
	scroll.camera = id;
	
	for (i=0; i<count; i++)
		// say( "creo tumba " + i );
		tomb( i, count );
	end
	
	loop
		
		if ( jkeys_state[_JKEY_LEFT] and x > 0 )
			x -= 4;
		end
	
		if ( jkeys_state[_JKEY_RIGHT] and x < max_x )
			x += 4;
		end
		
		if ( jkeys_state[_JKEY_MENU] )
			break;
		end
	
		frame;
		
	end
	
	open_main_menu = true;
	
onexit

	unload_fpg(file);
	
end

/* ------------------------------------------------------------------------- */
process tomb(index, total)

private

	string name;
	string age;
	
	string dates;
	
	int fnt_id;

end

begin

	file = father.file;
	graph = map_clone(father.file, 10);
	
	name = data.graveyard[index].name;
	age = s_to_string(data.graveyard[index].death_time - data.graveyard[index].first_time);
	dates = ftime("%m/%d/%y", data.graveyard[index].first_time) + "-" + ftime("%m/%d/%y", data.graveyard[index].death_time);
	
	fnt_id = load_fnt( "fnt/nueva-std-bold-18-gray.fnt" );
	
	map_put(0, graph, write_in_map(fnt_id, name, 4 ), 83, 60);
	map_put(0, graph, write_in_map(fnt_id, "Age: " + age, 4 ), 83, 80);
	map_put(0, graph, write_in_map(fnt_id, dates, 4 ), 83, 100);
	
	x = 100 + (total*200) - ( (index+1) * 200);
	y = rand (80, 170);

	// say( "creo tumba [" + index + "]: " + name + ", " +x + "," + y );
	
	ctype = c_scroll;
	
	loop
	
		frame;
		
	end
onexit

	unload_map(0, graph);

end
