import "mod_draw";
/* ------------------------------------------------------------------------- */
process botones() 

private

	int key_lock;

end

begin

	loop
	
		if ( key_lock == false )
		
			if ( key(_a) )
			
				say("Comida!");
				key_lock = true;
				
				stats.hambre += 20;
				
			elseif ( key(_s) )
			
				say("Medicina!");
				key_lock = true;
				
				stats.salud += 20;
			
			elseif ( key(_d) )
			
				say("Juegos!");
				key_lock = true;
				
				stats.diversion += 20;
			
			elseif ( key(_f) )
			
				say("Ducha!");
				key_lock = true;
				
				stats.higiene += 20;
			
			elseif ( key(_g) )
			
				say("Dormir!");
				key_lock = true;
				
				stats.energia += 20;
			
			end
		
		else
		
			if ( !key (_a) and !key(_s) and !key(_d) and !key(_f) and !key(_g) )
			
				key_lock = false;
				
			end
		
		end
	
		frame;
		
	end

end

/* ------------------------------------------------------------------------- */
function int draw_bar( int value )

private

	int width = 100;
	int height = 9;
	
	int width_value;
	
	int map_id;

end

begin

	map_id = map_new( width, height, SCREEN_D);
	
	drawing_map ( 0, map_id );
	
	width_value = (width * value) / 100;
	
	draw_line ( 1, 0, width - 2, 0 );
	draw_line ( 1, height-1, width - 2, height-1 );
	
	draw_line ( 0, 1, 0, height - 2 );
	draw_line ( width-1, 1, width-1, height - 2 );
	
	if ( value > 0 )
		draw_box ( 1, 1, 1+width_value, height-2 );
	end
	
	return map_id;

end
