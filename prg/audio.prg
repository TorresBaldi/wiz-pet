/* ------------------------------------------------------------------------- */
PROCESS audio_manager()

private

	int i;

end

begin

	signal_action( s_kill, s_ign );

	loop
	
		frame;
		
	end
	
onexit

	audio_manager();

end
