#define SLASH 1
#define STAB 2
#define BASH 3

/obj/item/weapon/material/sword
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	slot_flags = SLOT_BELT
	force_divisor = 0.7 // 42 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.5 // 10 when thrown with weight 20 (steel)
	sharp = 1
	edge = 1
	var/atk_mode = SLASH
	block_chance = 35
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	drawsound = 'sound/items/unholster_sword01.ogg'
	sharpness = 25
	var/stat = "swords"
	cooldownw = DEFAULT_ATTACK_COOLDOWN //how long till you can attack again


/obj/item/weapon/material/sword/handle_shield(mob/living/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	//Ok this if looks like a bit of a mess, and it is. Basically you need to have the sword in your active hand, and pass the default parry check
	//and also pass the prob which is your melee skill * the swords block chance. Complicated, I know, but hopefully it'll balance out.
	var/mob/living/carbon/human/H_user = user
	if(default_parry_check(user, attacker, damage_source) && prob(min(block_chance * (H_user.getStatCoeff("swords")),92)) && (user.get_active_hand() == src))//You gotta be holding onto that sheesh bro.
		user.visible_message("<span class='danger'><big>\The [user] parries [attack_text] with \the [src]!</big></span>")
		var/mob/living/carbon/human/H = user
		H.adaptStat("swords", 1)
		playsound(user.loc, pick('sound/weapons/blade_parry1.ogg', 'sound/weapons/blade_parry2.ogg', 'sound/weapons/blade_parry3.ogg'), 50, 1)
		health -= 0.5
		if(prob(15))
			user.visible_message("<span class='danger'><big>\The [src] flies out of \the [user]'s hand!</big></span>")
			user.drop_from_inventory(src)
			throw_at(get_edge_target_turf(src, pick(alldirs)), rand(1,3), throw_speed)//Throw that sheesh away

		return 1
	return 0

/obj/item/weapon/material/sword/attack_self(mob/user)
	..()
	if(atk_mode == SLASH)
		atk_mode = STAB
		user << "<span class='notice'>You will now stab.</span>"
		edge = 0
		sharp = 1
		attack_verb = list("stabbed")
		hitsound = "stab_sound"
		return

	else if(atk_mode == STAB)
		atk_mode = BASH
		user << "<span class='notice'>You will now bash.</span>"
		edge = 0
		sharp = 0
		attack_verb = list("bashed", "smacked")
		hitsound = "swing_hit"
		return


	else if(atk_mode == BASH)
		atk_mode = SLASH
		user << "<span class='notice'>You will now slash.</span>"
		attack_verb = list("slashed", "diced")
		hitsound = "slash_sound"
		edge = 1
		sharp = 1
		return
/obj/item/weapon/material/sword/katana
	name = "katana"
	desc = "Woefully underpowered in D20. This one looks pretty sharp."
	icon_state = "katana"
	item_state = "katana"
	block_chance = 30
	slot_flags = SLOT_BELT | SLOT_BACK
	value = 40

/obj/item/weapon/material/sword/smallsword
	name = "small sword"
	desc = "A common european sword, with about one meter in lenght."
	icon_state = "smallsword"
	item_state = "smallsword"
	throw_speed = 2
	throw_range = 4
	force_divisor = 0.6 // 36 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.8 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 25
	cooldownw = 6
	value = 35

obj/item/weapon/material/sword/smallsword/iron
	default_material = "iron"

obj/item/weapon/material/sword/smallsword/copper
	default_material = "copper"

obj/item/weapon/material/sword/smallsword/bronze
	default_material = "bronze"

/obj/item/weapon/material/sword/spadroon
	name = "spadroon"
	desc = "A medium sword with a straight blade. Common among the military."
	icon_state = "spadroon"
	item_state = "longsword2"
	throw_speed = 3
	throw_range = 3
	force_divisor = 0.8 // 48 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.5 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 40
	cooldownw = 10
	value = 50

obj/item/weapon/material/sword/spadroon/iron
	default_material = "iron"

obj/item/weapon/material/sword/spadroon/copper
	default_material = "copper"

obj/item/weapon/material/sword/spadroon/bronze
	default_material = "bronze"

/obj/item/weapon/material/sword/vangar
	name = "Vangar's sword"
	desc = "A special, customized sword with 'Vangar' engraved on the hilt."
	icon_state = "vangar"
	item_state = "longsword2"
	throw_speed = 4
	throw_range = 4
	force_divisor = 0.75 // 45 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.6 // 12 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 35
	cooldownw = 7

/obj/item/weapon/material/sword/cutlass
	name = "cutlass"
	desc = "A medium-sized, curved sword, preferred by pirates."
	icon_state = "cutlass"
	item_state = "cutlass"
	throw_speed = 2
	throw_range = 4
	force_divisor = 0.7 // 42 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.6 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 28
	cooldownw = 8
	value = 40

obj/item/weapon/material/sword/cutlass/iron
	default_material = "iron"

/obj/item/weapon/material/sword/sabre
	name = "sabre"
	desc = "A small, slightly curved sword, favored by cavalry and light infantry units."
	icon_state = "sabre"
	item_state = "sabre"
	throw_speed = 2
	throw_range = 4
	force_divisor = 0.75 // 45 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.6 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 32
	cooldownw = 9
	value = 50

obj/item/weapon/material/sword/sabre/iron
	default_material = "iron"

/obj/item/weapon/material/sword/longsword
	name = "longsword"
	desc = "A large sword, with a long blade. Commonly used in the medieval era, it's rarely used now."
	icon_state = "longsword"
	item_state = "longsword"
	throw_speed = 2
	throw_range = 2
	force_divisor = 1 // 60 when wielded with hardness 60 (steel)
	thrown_force_divisor = 0.6 // 12 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 47
	cooldownw = 13
	value = 60

obj/item/weapon/material/sword/longsword/iron
	default_material = "iron"

obj/item/weapon/material/sword/longsword/bronze
	default_material = "bronze"

obj/item/weapon/material/sword/longsword/diamond
	default_material = "diamond"

/obj/item/weapon/material/sword/rapier
	name = "rapier"
	desc = "A light sword with a thin, stright blade. Commonly used by officers and nobility."
	icon_state = "rapier"
	item_state = "longsword2"
	throw_speed = 4
	throw_range = 4
	force_divisor = 0.65 // 40 when wielded with hardness 60 (steel)
	thrown_force_divisor = 0.8 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 30
	cooldownw = 5
	value = 60

obj/item/weapon/material/sword/rapier/iron
	default_material = "iron"



/obj/item/weapon/material/sword/gladius
	name = "gladius"
	desc = "A relatively small sword, used by Roman soldiers."
	icon_state = "gladius"
	item_state = "gladius"
	default_material = "iron"
	throw_speed = 2
	throw_range = 6
	force_divisor = 0.6 // 36 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.8 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 25
	cooldownw = 6
	value = 35

/obj/item/weapon/material/sword/xiphos
	name = "xiphos"
	desc = "A small sword, used by Hellenic soldiers."
	icon_state = "xiphos"
	item_state = "gladius"
	default_material = "iron"
	throw_speed = 2
	throw_range = 4
	force_divisor = 0.75 // 36 when wielded with hardnes 60 (steel)
	thrown_force_divisor = 0.7 // 10 when thrown with weight 20 (steel)
	slot_flags = SLOT_BELT | SLOT_BACK
	block_chance = 28
	cooldownw = 7
	value = 40