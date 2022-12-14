/obj/effect/decal/cleanable/crayon
	name = "rune"
	desc = "A rune drawn in crayon."
	icon = 'icons/obj/rune.dmi'
	plane = DIRTY_PLANE
	anchored = 1

	New(location,main = "#FFFFFF",shade = "#000000",var/type = "rune")
		..()
		loc = location

		name = type
		desc = "A [type] drawn in crayon."


		switch(type)
			if("rune")
				type = "rune[rand(1,6)]"
			if("graffiti")
				//type = pick("amyjon","face","matt","revolution","engie","guy","end","dwarf","uboa") Old graffiti
				type = pick("graffiti1", "graffiti2", "graffiti3", "graffiti4", "graffiti5", "graffiti6",)

		var/icon/mainOverlay = new/icon('icons/effects/crayondecal.dmi',"[type]",2.1)
		var/icon/shadeOverlay = new/icon('icons/effects/crayondecal.dmi',"[type]s",2.1)

		mainOverlay.Blend(main,ICON_ADD)
		shadeOverlay.Blend(shade,ICON_ADD)

		overlays += mainOverlay
		overlays += shadeOverlay

		add_hiddenprint(usr)

/obj/effect/decal/cleanable/graffiti
	name = "graffiti"
	desc = "Looks like graffiti from a while ago."
	icon = 'icons/effects/crayondecal.dmi'
	icon_state = "graffiti1"
	layer = 2.1
	anchored = 1

/obj/effect/decal/cleanable/graffiti/New()
	..()
	icon_state = pick("graffiti1","graffiti2","graffiti3","graffiti4","graffiti5","graffiti6")
	color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))