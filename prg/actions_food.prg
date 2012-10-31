/* ------------------------------------------------------------------------- */
function action_food()

private

	int seleccion;

	int confirmed;

	int button_sel[2];
	int button_act[2];

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


	fpg_food = load_fpg( "fpg/food.fpg" );
	
	// pongo el fondo para los botones
	put(fpg_system, 125, 160, 120);

	file = fpg_food;
	graph = food[seleccion].graph;

	x = 160;
	y = 120;
	size = 200;

	// creo los botones
	gui_button(30, 120, fpg_system, 100, &button_sel[0], &button_act[0]);
	gui_button(290, 120, fpg_system, 110, &button_sel[1], &button_act[1]);
	
	gui_button(160, 120, fpg_food, 120, &button_sel[2], &button_act[2]);

	while ( jkeys_state[_JKEY_SELECT] or mouse.left )
		frame;
	end

	loop

		global_key_lock();

		// seleccion de la comida
		if ( !confirmed )

			if ( (!global_key_lock AND jkeys_state[_JKEY_LEFT]) OR button_act[0] )

				global_key_lock = true;
				seleccion--;
				if ( seleccion < 0 ) seleccion = 3; end

			elseif ( (!global_key_lock AND jkeys_state[_JKEY_RIGHT]) OR button_act[1] )

				global_key_lock = true;
				seleccion = (seleccion+1) %4;

			end

			// confirmacion de la comida
			if ( (!global_key_lock AND jkeys_state[_JKEY_SELECT]) OR button_act[2] )

				global_key_lock = true;
				confirmed = true;

			end

		else

			size -= 6;
			alpha -= 4;

			if ( size < 0 )

				stats.food += food[seleccion].hambre;
				stats.health += food[seleccion].salud;

				say( "hambre:" + food[seleccion].hambre );
				say( "salud:" + food[seleccion].salud );

				// si le gusta o no
				if ( rand(0, 100) <= food[seleccion].sabor )
					stats.fun += 10;
					say( "gusta!" );
				else
					stats.fun -= 30;
					say( "no gusta!" );
				end

				break;

			end

		end

		graph = food[seleccion].graph;

		frame;

	end
	
onexit

	unload_fpg( fpg_food );

end
