/* ------------------------------------------------------------------------- */
function action_die()

private

	int counter;

end

begin

	action_alert( ALE_RIP );
	
	// say("die!");
	
	data.game_started = false;
	data.status = STA_DEAD;
	
	// actualizo las opciones del menu principal
	menu_avaliable[MENU_CONTINUE] = FALSE;
	menu_avaliable[MENU_GRAVEYARD] = TRUE;
	
	// agrego al cementerio
	add_to_graveyard();
	
end

function add_to_graveyard()

private

	int i;
	int space_found;
	int done;

end

begin

	// busco el primer lugar vacio
	for ( i=0; i<=50; i++ )
		if ( data.graveyard[i].first_time == 0 )
			break;
		end
	end
	
	// creo un lugar si el cementerio esta lleno
	if ( i>50 )
		for ( i=0; i<50; i++ )
		
			data.graveyard[i].name = data.graveyard[i+1].name;
			data.graveyard[i].first_time = data.graveyard[i+1].first_time;
			data.graveyard[i].death_time = data.graveyard[i+1].death_time;
		
		end
	end
	
	// agrego datos de la mascota al cementerio
	data.graveyard[i].name= data.name;
	data.graveyard[i].first_time = data.first_time;
	data.graveyard[i].death_time = time();
	

end
