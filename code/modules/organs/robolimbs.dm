var/list/all_robolimbs = list()
var/list/robolimb_data = list()
var/list/chargen_robolimbs = list()
var/datum/robolimb/basic_robolimb
var/const/standard_monitor_styles = "blank=ipc_blank;\
	pink=ipc_pink;\
	green=ipc_green,\
	red=ipc_red;\
	blue=ipc_blue;\
	shower=ipc_shower;\
	orange=ipc_orange;\
	nature=ipc_nature;\
	eight=ipc_eight;\
	goggles=ipc_goggles;\
	heart=ipc_heart;\
	monoeye=ipc_monoeye;\
	breakout=ipc_breakout;\
	yellow=ipc_yellow;\
	static=ipc_static;\
	purple=ipc_purple;\
	scroll=ipc_scroll;\
	console=ipc_console;\
	glider=ipc_gol_glider;\
	rainbow=ipc_rainbow;\
	smiley=ipc_smiley;\
	database=ipc_database"

/proc/populate_robolimb_list()
	basic_robolimb = new()
	for(var/limb_type in typesof(/datum/robolimb))
		var/datum/robolimb/R = new limb_type()
		all_robolimbs[R.company] = R
		if(!R.unavailable_at_chargen)
			chargen_robolimbs[R.company] = R //List only main brands and solo parts.

/datum/robolimb
	var/company = "Unbranded"                            // Shown when selecting the limb.
	var/desc = "A generic unbranded robotic prosthesis." // Seen when examining a limb.
	var/icon = 'icons/mob/human_races/robotic.dmi'       // Icon base to draw from.
	var/unavailable_at_chargen = 0                          // If set, not available at chargen.
	var/unavailable_to_build							 // If set, can't be constructed.
	var/lifelike										 // If set, appears organic.
	var/skin_tone										 // If set, applies skin tone rather than part color
	var/blood_color = "#030303"
	var/list/species_cannot_use = list(SPECIES_TESHARI)
	var/list/monitor_styles			 		 			 //If empty, the model of limbs offers a head compatible with monitors.
	var/parts = BP_ALL						 			 //Defines what parts said brand can replace on a body.
	var/health_hud_intensity = 1						 // Intensity modifier for the health GUI indicator.
	var/suggested_species = "Human"						 //If it should make the torso a species
	var/speech_bubble_appearance = "synthetic"			 // What icon_state to use for speech bubbles when talking.  Check talk.dmi for all the icons.
	var/robo_brute_mod = 1								 // Multiplier for incoming brute damage.
	var/robo_burn_mod = 1								 // As above for burn.

/datum/robolimb/unbranded_monitor
	company = "Unbranded Monitor"
	desc = "A generic unbranded interpretation of a popular prosthetic head model. It looks rudimentary and cheaply constructed."
	icon = 'icons/mob/human_races/cyberlimbs/unbranded/unbranded_monitor.dmi'
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles
	unavailable_to_build = 1

/datum/robolimb/nanotrasen
	company = "NanoTrasen"
	desc = "A simple but efficient robotic limb, created by NanoTrasen."
	icon = 'icons/mob/human_races/cyberlimbs/nanotrasen/nanotrasen_main.dmi'

/datum/robolimb/bishop
	company = "Bishop"
	desc = "This limb has a white polymer casing with blue holo-displays."
	icon = 'icons/mob/human_races/cyberlimbs/bishop/bishop_main.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1
	robo_brute_mod = 1.05
	robo_burn_mod = 1.05

/datum/robolimb/bishop_alt1
	company = "Bishop - Glyph"
	desc = "This limb has a white polymer casing with blue holo-displays."
	icon = 'icons/mob/human_races/cyberlimbs/bishop/bishop_alt1.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1
	parts = list(BP_HEAD)
	robo_brute_mod = 1.05
	robo_burn_mod = 1.05

/datum/robolimb/bishop_alt2
	company = "Bishop - Rook"
	desc = "This limb has a solid plastic casing with blue lights along it."
	icon = 'icons/mob/human_races/cyberlimbs/bishop/bishop_alt2.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/bishop_alt3
	company = "Bishop - Rook(Red)"
	desc = "This limb has a solid plastic casing with blue lights along it."
	icon = 'icons/mob/human_races/cyberlimbs/bishop/bishop_alt3.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/bishop_monitor
	company = "Bishop Monitor"
	desc = "Bishop Cybernetics' unique spin on a popular prosthetic head model. The themes conflict in an intriguing way."
	icon = 'icons/mob/human_races/cyberlimbs/bishop/bishop_monitor.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles

/datum/robolimb/cybersolutions
	company = "Cyber Solutions"
	desc = "This limb is grey and rough, with little in the way of aesthetic."
	icon = 'icons/mob/human_races/cyberlimbs/cybersolutions/cybersolutions_main.dmi'
	unavailable_to_build = 1
	robo_brute_mod = 1.15
	robo_burn_mod = 1.15

/datum/robolimb/cybersolutions_alt2
	company = "Cyber Solutions - Array"
	desc = "This limb is simple and functional; array of sensors on a featureless case."
	icon = 'icons/mob/human_races/cyberlimbs/cybersolutions/cybersolutions_alt2.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	robo_brute_mod = 1.15
	robo_burn_mod = 1.15

/datum/robolimb/cybersolutions_alt1
	company = "Cyber Solutions - Wight"
	desc = "This limb has cheap plastic panels mounted on grey metal."
	icon = 'icons/mob/human_races/cyberlimbs/cybersolutions/cybersolutions_alt1.dmi'
	unavailable_to_build = 1
	robo_brute_mod = 1.15
	robo_burn_mod = 1.15

/datum/robolimb/grayson
	company = "Grayson"
	desc = "This limb has a sturdy and heavy build to it."
	icon = 'icons/mob/human_races/cyberlimbs/grayson/grayson_main.dmi'
	unavailable_to_build = 1
	monitor_styles = "blank=grayson_off;\
		green=grayson_green;\
		rgb=grayson_rgb"
	robo_brute_mod = 0.95
	robo_burn_mod = 0.95
	unavailable_at_chargen = 1

/datum/robolimb/grayson_alt1
	company = "Grayson - Reinforced"
	desc = "This limb has a sturdy and heavy build to it."
	icon = 'icons/mob/human_races/cyberlimbs/grayson/grayson_alt1.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = "blank=grayson_alt_off;\
		green=grayson_alt_green;\
		scroll=grayson_alt_scroll;\
		rgb=grayson_alt_rgb;\
		rainbow=grayson_alt_rainbow"
	robo_brute_mod = 0.9
	robo_burn_mod = 0.9
	unavailable_at_chargen = 1

/datum/robolimb/grayson_monitor
	company = "Grayson Monitor"
	desc = "This limb has a sturdy and heavy build to it, and uses plastics in the place of glass for the monitor."
	icon = 'icons/mob/human_races/cyberlimbs/grayson/grayson_monitor.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles
	robo_brute_mod = 0.95
	robo_burn_mod = 0.95
	unavailable_at_chargen = 1

/datum/robolimb/hephaestus
	company = "Hephaestus"
	desc = "This limb has a militaristic black and green casing with gold stripes."
	icon = 'icons/mob/human_races/cyberlimbs/hephaestus/hephaestus_main.dmi'
	unavailable_to_build = 1
	robo_brute_mod = 0.9
	robo_burn_mod = 0.9
	unavailable_at_chargen = 1

/datum/robolimb/hephaestus_alt1
	company = "Hephaestus - Frontier"
	desc = "A rugged prosthetic head featuring the standard Hephaestus theme, a visor and an external display."
	icon = 'icons/mob/human_races/cyberlimbs/hephaestus/hephaestus_alt1.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = "blank=hephaestus_alt_off;\
		pink=hephaestus_alt_pink;\
		orange=hephaestus_alt_orange;\
		goggles=hephaestus_alt_goggles;\
		scroll=hephaestus_alt_scroll;\
		rgb=hephaestus_alt_rgb;\
		rainbow=hephaestus_alt_rainbow"
	robo_brute_mod = 0.9
	robo_burn_mod = 0.9
	unavailable_at_chargen = 1

/datum/robolimb/hephaestus_alt2
	company = "Hephaestus - Athena"
	desc = "This rather thick limb has a militaristic green plating."
	icon = 'icons/mob/human_races/cyberlimbs/hephaestus/hephaestus_alt2.dmi'
	unavailable_to_build = 1
	robo_brute_mod = 0.9
	robo_burn_mod = 0.9
	unavailable_at_chargen = 1

/datum/robolimb/hephaestus_alt2/alt
	company = "Hephaestus - Athena (aftermarket chrome)"
	desc = "A limb coated in suprachrome plating"
	icon = 'icons/mob/human_races/cyberlimbs/hephaestus/hephaestus_alt3.dmi'

/datum/robolimb/hephaestus_monitor
	company = "Hephaestus Monitor"
	desc = "Hephaestus' unique spin on a popular prosthetic head model. It looks rugged and sturdy."
	icon = 'icons/mob/human_races/cyberlimbs/hephaestus/hephaestus_monitor.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles
	robo_brute_mod = 0.95
	robo_burn_mod = 0.95
	unavailable_at_chargen = 1

/datum/robolimb/morpheus
	company = "Morpheus"
	desc = "This limb is simple and functional; no effort has been made to make it look human."
	icon = 'icons/mob/human_races/cyberlimbs/morpheus/morpheus_main.dmi'
	unavailable_to_build = 1
	monitor_styles = standard_monitor_styles

/datum/robolimb/morpheus_alt1
	company = "Morpheus - Zenith"
	desc = "This limb is simple and functional; no effort has been made to make it look human."
	icon = 'icons/mob/human_races/cyberlimbs/morpheus/morpheus_alt1.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)

/datum/robolimb/morpheus_alt2
	company = "Morpheus - Skeleton Crew"
	desc = "This limb is simple and functional; it's basically just a case for a brain."
	icon = 'icons/mob/human_races/cyberlimbs/morpheus/morpheus_alt2.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)

/datum/robolimb/veymed
	company = "Vey-Med"
	desc = "This high quality limb is nearly indistinguishable from an organic one."
	icon = 'icons/mob/human_races/cyberlimbs/veymed/veymed_main.dmi'
	unavailable_to_build = 1
	lifelike = 1
	skin_tone = 1
	blood_color = "#CCCCCC"
	speech_bubble_appearance = "normal"
	robo_brute_mod = 1.1
	robo_burn_mod = 1.1
	unavailable_at_chargen = 1

/datum/robolimb/veymed_alt1
	company = "Vey-Med - Reinforced"
	desc = "This high quality limb is nearly indistinguishable from an organic one, save for some visible cybernetic reinforcement in key areas."
	icon = 'icons/mob/human_races/cyberlimbs/veymed/veymed_alt1.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1
	lifelike = 1
	skin_tone = 1
	blood_color = "#CCCCCC"
	speech_bubble_appearance = "normal"
	robo_brute_mod = 1.05
	robo_burn_mod = 1.05

/datum/robolimb/veymed_alt2
	company = "Vey-Med - Cyberwalker"
	desc = "This limb features bleeding edge cooling technology that allows for the continuous operation of high intensity cyberware implants with minimal impact on user health."
	icon = 'icons/mob/human_races/cyberlimbs/veymed/veymed_alt2.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1
	skin_tone = 1
	blood_color = "#8A0303"
	speech_bubble_appearance = "normal"

/datum/robolimb/wardtakahashi
	company = "Ward-Takahashi"
	desc = "This limb features sleek black and white polymers."
	icon = 'icons/mob/human_races/cyberlimbs/wardtakahashi/wardtakahashi_main.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/wardtakahashi_alt1
	company = "Ward-Takahashi - Shroud"
	desc = "This limb features sleek black and white polymers. This one looks more like a helmet of some sort."
	icon = 'icons/mob/human_races/cyberlimbs/wardtakahashi/wardtakahashi_alt1.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	unavailable_at_chargen = 1

/datum/robolimb/wardtakahashi_alt2
	company = "Ward-Takahashi - Spirit"
	desc = "This limb has white and purple features, with a heavier casing."
	icon = 'icons/mob/human_races/cyberlimbs/wardtakahashi/wardtakahashi_alt2.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/wardtakahashi_monitor
	company = "Ward-Takahashi Monitor"
	desc = "Ward-Takahashi's unique spin on a popular prosthetic head model. It looks sleek and modern."
	icon = 'icons/mob/human_races/cyberlimbs/wardtakahashi/wardtakahashi_monitor.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles
	unavailable_at_chargen = 1

/datum/robolimb/xion
	company = "Xion"
	desc = "This limb has a minimalist black and red casing."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_main.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/xion_alt1
	company = "Xion - Breach"
	desc = "This limb has a minimalist black and red casing. Looks a bit menacing."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_alt1.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	unavailable_at_chargen = 1

/datum/robolimb/xion_alt2
	company = "Xion - Hull"
	desc = "This limb has a thick orange casing with steel plating."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_alt2.dmi'
	unavailable_to_build = 1
	monitor_styles = "blank=xion_off;\
		green=xion_green;\
		rgb=xion_rgb"
	unavailable_at_chargen = 1

/datum/robolimb/xion_alt3
	company = "Xion - Whiteout"
	desc = "This limb has a minimalist black and white casing."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_alt3.dmi'
	unavailable_to_build = 1
	unavailable_at_chargen = 1

/datum/robolimb/xion_alt4
	company = "Xion - Breach - Whiteout"
	desc = "This limb has a minimalist black and white casing. Looks a bit menacing."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_alt4.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	unavailable_at_chargen = 1

/datum/robolimb/xion_monitor
	company = "Xion Monitor"
	desc = "Xion Mfg.'s unique spin on a popular prosthetic head model. It looks and minimalist and utilitarian."
	icon = 'icons/mob/human_races/cyberlimbs/xion/xion_monitor.dmi'
	unavailable_to_build = 1
	parts = list(BP_HEAD)
	monitor_styles = standard_monitor_styles
	unavailable_at_chargen = 1

/datum/robolimb/zenghu
	company = "Zeng-Hu"
	desc = "This limb has a rubbery fleshtone covering with visible seams."
	icon = 'icons/mob/human_races/cyberlimbs/zenghu/zenghu_main.dmi'
	unavailable_to_build = 1
	skin_tone = 1
	unavailable_at_chargen = 1
	robo_burn_mod = 1.1
	robo_brute_mod = 1.05

/obj/item/weapon/disk/limb
	name = "Limb Blueprints"
	desc = "A disk containing the blueprints for prosthetics."
	icon = 'icons/obj/cloning.dmi'
	icon_state = "datadisk2"
	var/company = ""

/obj/item/weapon/disk/limb/New(var/newloc)
	..()
	if(company)
		name = "[company] [initial(name)]"

/obj/item/weapon/disk/limb/bishop
	company = "Bishop"

/obj/item/weapon/disk/limb/bishop/rook
	company = "Bishop - Rook"

/obj/item/weapon/disk/limb/bishop/rook_red
	company = "Bishop - Rook(Red)"

/obj/item/weapon/disk/limb/cybersolutions
	company = "Cyber Solutions"

/obj/item/weapon/disk/limb/cybersolutions/array
	company = "Cyber Solutions - Array"

/obj/item/weapon/disk/limb/cybersolutions/wight
	company = "Cyber Solutions - Wight"

/obj/item/weapon/disk/limb/grayson
	company = "Grayson"

/obj/item/weapon/disk/limb/grayson/reinforced
	company = "Grayson - Reinforced"

/obj/item/weapon/disk/limb/grayson/monitor
	company = "Grayson - Monitor"

/obj/item/weapon/disk/limb/hephaestus
	company = "Hephaestus"

/obj/item/weapon/disk/limb/hephaestus/athena
	company = "Hephaestus - Athena"

/obj/item/weapon/disk/limb/hephaestus/athena/alt
	company = "Hephaestus - Athena (aftermarket chrome)"

/obj/item/weapon/disk/limb/hephaestus/frontier
	company = "Hephaestus - Frontier"

/obj/item/weapon/disk/limb/hephaestus/monitor
	company = "Hephaestus Monitor"

/obj/item/weapon/disk/limb/morpheus
	company = "Morpheus"

/obj/item/weapon/disk/limb/morpheus/zenith
	company = "Morpheus - Zenith"

/obj/item/weapon/disk/limb/morpheus/skeletoncrew
	company = "Morpheus - Skeleton Crew"

/obj/item/weapon/disk/limb/veymed
	company = "Vey-Med"

/obj/item/weapon/disk/limb/veymed/reinforced
	company = "Vey-Med - Reinforced"

/obj/item/weapon/disk/limb/veymed/cyberwalker
	company = "Vey-Med - Cyberwalker"

/obj/item/weapon/disk/limb/wardtakahashi
	company = "Ward-Takahashi"

/obj/item/weapon/disk/limb/wardtakahashi/shroud
	company = "Ward-Takahashi - Shroud"

/obj/item/weapon/disk/limb/wardtakahashi/spirit
	company = "Ward-Takahashi - Spirit"

/obj/item/weapon/disk/limb/wardtakahashi/monitor
	company = "Ward-Takahashi Monitor"

/obj/item/weapon/disk/limb/xion
	company = "Xion"

/obj/item/weapon/disk/limb/xion/breach
	company = "Xion - Breach"

/obj/item/weapon/disk/limb/xion/breach_whiteout
	company = "Xion - Breach - Whiteout"

/obj/item/weapon/disk/limb/xion/hull
	company = "Xion - Hull"

/obj/item/weapon/disk/limb/xion/whiteout
	company = "Xion - Whiteout"

/obj/item/weapon/disk/limb/zenghu
	company = "Zeng-Hu"

/obj/item/weapon/disk/limb/nanotrasen
	company = "NanoTrasen"
