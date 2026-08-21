/client/proc/spawn_floor_cluwne()
	set category = "Fun"
	set name = "Unleash Floor Cluwne"
	set desc = "Pick a specific target or just let it select randomly and spawn the floor cluwne mob on the station. Be warned: spawning more than one may cause issues!"
	var/target

	if(!check_rights(R_FUN))
		return

	var/turf/T = get_turf(usr)
	target = input("Any specific target in mind? Please note only live, non cluwned, human targets are valid.", "Target", target) as null|anything in GLOB.player_list
	if(target && ishuman(target))
		var/mob/living/carbon/human/H = target
		var/mob/living/simple_animal/hostile/floor_cluwne/FC = new /mob/living/simple_animal/hostile/floor_cluwne(T)
		FC.force_target(H)
		if(alert("Delete self after target is dead, or keep looking for targets?",,"Delete","More targets")=="Delete")
			FC.delete_after_target_killed = TRUE
	else
		new /mob/living/simple_animal/hostile/floor_cluwne(T)
	log_admin("[key_name(usr)] spawned floor cluwne.")
	message_admins("[key_name(usr)] spawned floor cluwne.")

/client/proc/hallucinate()
	set category = "Fun"
	set name = "Debug some hallucination"
	set desc = "Pick a specific target or just let it select randomly and spawn the floor cluwne mob on the station. Be warned: spawning more than one may cause issues!"

	var/list/halluc = list()
	for(var/hallucination in subtypesof(/datum/hallucination))
		halluc += hallucination
	var/mob/living/target = src.mob
	var/list/sel_hal = list(tgui_input_list(target, "select a hallucination", "asdqwe", halluc, /datum/hallucination), target)

	target._cause_hallucination(sel_hal)
