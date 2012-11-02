/* ------------------------------------------------------------------------- */
PROCESS show_graveyard()

private

	int i;
	int count;
	
	int max_x = 50;

end

begin

	file = load_fpg( "fpg/graveyard.fpg" );

	for ( count=0; count<=50; count++ )
	
		if ( data.graveyard[count].age == 0 )
			say(count + "vacio");
			break;
		end
		
	end
	
	say("muertos: " + count);
	
	max_x += (count-1) * 200;
	
	start_scroll(0, file, 9, 0, 0, 1);
	
	ctype = c_scroll;
	scroll.camera = id;
	
	for (i=1; i<=count; i++)
		if ( i>50 ) break; end // limite

		tomb(i-1);
	
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
process tomb(i)

private

	string name;

end

begin

	file = father.file;
	graph = map_clone(father.file, 10);
	
	name = data.graveyard[i].name;
	
	map_put(0, graph, write_in_map(fnt_nueva_18, name, 4 ), 80, 40);
	
	map_put(0, graph, write_in_map(fnt_nueva_18, "Age: " + data.graveyard[i].age, 4 ), 80, 60);
	
	x = 100 + (i * 200);
	y = rand (80, 170);

	say ( "creo tomb " + name + ":" +x + "," + y );
	
	ctype = c_scroll;
	
	loop
	
		frame;
		
	end
onexit

	unload_map(0, graph);

end
