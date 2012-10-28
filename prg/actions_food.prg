/* ------------------------------------------------------------------------- */
function action_food()

private

	int seleccion;
	
	int key_lock;
	
	int confirmed;
	
	struct food[3]
	
		int hambre;
		int salud;
		int graph;
		int sabor;	// mientras mas sabor tiene hay mas probabilidad de que le guste
	
	end

end

begin

	// inicializo las comidas
	food[0].hambre = 30;
	food[0].salud = 0;
	food[0].graph = 10;
	food[0].sabor = 80;

	food[1].hambre = 40;
	food[1].salud = 2;
	food[1].graph = 20;
	food[1].sabor = 20;

	food[2].hambre = 20;
	food[2].salud = -10;
	food[2].graph = 30;
	food[2].sabor = 100;

	food[3].hambre = 30;
	food[3].salud = -1;
	food[3].graph = 40;
	food[3].sabor = 50;
	

	file = load_fpg( "fpg/food.fpg" );
	
	graph = food[seleccion].graph;
	
	x = 160; 
	y = 120;
	size = 200;
	
	while ( jkeys_state[_JKEY_SELECT] or mouse.left )
		frame;
	end

	loop
	
		// seleccion de la comida
		if ( !confirmed )
			
			if ( !global_key_lock AND jkeys_state[_JKEY_LEFT] )
				global_key_lock = true;
				seleccion--;
				if ( seleccion < 0 ) seleccion = 3; end
			elseif ( !global_key_lock AND jkeys_state[_JKEY_RIGHT] )
				global_key_lock = true;
				seleccion = (seleccion+1) %4;
			end
			
			// confirmacion de la comida
			if ( !global_key_lock AND jkeys_state[_JKEY_SELECT] )
				confirmed = true;
			end
			
		else
		
			size -= 6;
			alpha -= 4;
			
			if ( size < 0 )
			
				stats.hambre += food[seleccion].hambre;
				stats.salud += food[seleccion].salud;
				
				say( "hambre:" + food[seleccion].hambre );
				say( "salud:" + food[seleccion].salud );
				
				// si le gusta o no
				if ( rand(0, 100) <= food[seleccion].sabor )
					stats.diversion += 10;
					say( "gusta!" );
				else
					stats.diversion -= 30;
					say( "no gusta!" );
				end
				
				break;
			
			end
		
		end
		
		graph = food[seleccion].graph;
		
		frame;
		
	end
	
end
