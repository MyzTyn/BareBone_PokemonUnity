BEGIN TRANSACTION;
CREATE VIEW pokemon_abilities_view as
select 
	p.id as pokemon_id,
	CAST(AVG(CASE WHEN a.slot = 1 THEN a.ability_id
    END) as int) as ability1
	,CAST(AVG(CASE WHEN a.slot = 2 THEN a.ability_id 
    END) as int) as ability2
	,CAST(AVG(CASE WHEN a.slot = 3 THEN a.ability_id 
    END) as int) as ability3
	from "pokemon" as p
	left join "pokemon_abilities" as a on p.id = a.pokemon_id
	group by p.id;
CREATE VIEW pokemon_stats_view as
select 
	p.id as pokemon_id
	,CAST(AVG(CASE WHEN i.stat_id = 1 THEN i.base_stat
    END) as int) as bhp
	,CAST(AVG(CASE WHEN i.stat_id = 2 THEN i.base_stat
    END) as int) as batk
	,CAST(AVG(CASE WHEN i.stat_id = 3 THEN i.base_stat
    END) as int) as bdef
	,CAST(AVG(CASE WHEN i.stat_id = 4 THEN i.base_stat
    END) as int) as bspa
	,CAST(AVG(CASE WHEN i.stat_id = 5 THEN i.base_stat
    END) as int) as bspd
	,CAST(AVG(CASE WHEN i.stat_id = 6 THEN i.base_stat
    END) as int) as bspe
	,CAST(AVG(CASE WHEN i.stat_id = 1 THEN i.effort
    END) as int) as ehp
	,CAST(AVG(CASE WHEN i.stat_id = 2 THEN i.effort
    END) as int) as eatk
	,CAST(AVG(CASE WHEN i.stat_id = 3 THEN i.effort
    END) as int) as edef
	,CAST(AVG(CASE WHEN i.stat_id = 4 THEN i.effort
    END) as int) as espa
	,CAST(AVG(CASE WHEN i.stat_id = 5 THEN i.effort
    END) as int) as espd
	,CAST(AVG(CASE WHEN i.stat_id = 6 THEN i.effort
    END) as int) as espe
	from "pokemon" as p
	left join "pokemon_stats" as i on p.id = i.pokemon_id
	group by p.id;
CREATE VIEW pokemon_egg_groups_view as
select 
	p.id as pokemon_id,
	MIN(e.egg_group_id) as egg_group1
	,CASE WHEN COUNT(e.species_id) = 2 THEN MAX(e.egg_group_id) --ELSE 0   
    END as egg_group2
	from "pokemon" as p
	left join "pokemon_egg_groups" as e on p.species_id = e.species_id
	group by p.id;
CREATE VIEW pokemon_types_view as
select 
	p.id as pokemon_id,
	CAST(AVG(CASE WHEN t.slot = 1 THEN t.type_id  
    END) as int) as type1
	,CAST(AVG(CASE WHEN t.slot = 2 THEN t.type_id --ELSE 0
    END) as int) as type2
	from "pokemon" as p
	left join "pokemon_types" as t on p.id = t.pokemon_id
	group by p.id;
/* Forms -> Pokemon -> Species Relationship  
CREATE VIEW pokemon_forms_view as
--select REPLACE('case Forms.' || UPPER(pokemon_forms.identifier) || ':
--	return Pokemons.' || UPPER (pokemon.identifier) || ';', '-', '_') as Switch,
pokemon_forms.id, pokemon_forms.identifier,
pokemon.id, pokemon.species_id, pokemon.identifier, pokemon.height, pokemon.weight, pokemon.base_experience, --pokemon."order"
pokemon_stats_view.bhp, pokemon_stats_view.batk, pokemon_stats_view.bdef, pokemon_stats_view.bspa, pokemon_stats_view.bspd, pokemon_stats_view.bspe, pokemon_stats_view.ehp, pokemon_stats_view.eatk, pokemon_stats_view.edef, pokemon_stats_view.espa, pokemon_stats_view.espd, pokemon_stats_view.espe,
pokemon_species.generation_id, pokemon_species.evolves_from_species_id, pokemon_species.evolution_chain_id, pokemon_species.color_id, pokemon_species.shape_id, pokemon_species.habitat_id, pokemon_species.gender_rate, pokemon_species.capture_rate, pokemon_species.base_happiness, pokemon_species.is_baby, pokemon_species.hatch_counter, pokemon_species.has_gender_differences, pokemon_species.growth_rate_id, pokemon_species.forms_switchable, pokemon_species."order"
from pokemon
left join pokemon_forms on pokemon_forms.pokemon_id = pokemon.id
left join pokemon_stats_view on pokemon_stats_view.pokemon_id = pokemon.id 
left join pokemon_species on pokemon_species.id = pokemon.species_id
left join pokemon_species_names on pokemon_species_names.pokemon_species_id = pokemon.species_id AND pokemon_species_names.local_language_id=9
where pokemon_species.id != pokemon.id AND
--pokemon_forms.identifier != pokemon.identifier 
pokemon_forms.id != pokemon.id
--pokemon_forms.id != pokemon_species.id
order by pokemon.species_id, pokemon_forms.id ASC;*/
CREATE VIEW pokemon_views as 
select pokemon.id, pokemon.species_id, pokemon.identifier, pokemon.height, pokemon.weight, pokemon.base_experience, --pokemon."order"
pokemon_abilities_view.ability1, pokemon_abilities_view.ability2, pokemon_abilities_view.ability3, 
pokemon_egg_groups_view.egg_group1, pokemon_egg_groups_view.egg_group2,
pokemon_stats_view.bhp, pokemon_stats_view.batk, pokemon_stats_view.bdef, pokemon_stats_view.bspa, pokemon_stats_view.bspd, pokemon_stats_view.bspe, pokemon_stats_view.ehp, pokemon_stats_view.eatk, pokemon_stats_view.edef, pokemon_stats_view.espa, pokemon_stats_view.espd, pokemon_stats_view.espe,
pokemon_types_view.type1, pokemon_types_view.type2,
pokemon_color_names.name as color,
pokemon_species.generation_id, pokemon_species.evolves_from_species_id, pokemon_species.evolution_chain_id, pokemon_species.color_id, pokemon_species.shape_id, pokemon_species.habitat_id, pokemon_species.gender_rate, pokemon_species.capture_rate, pokemon_species.base_happiness, pokemon_species.is_baby, pokemon_species.hatch_counter, pokemon_species.has_gender_differences, pokemon_species.growth_rate_id, pokemon_species.forms_switchable, pokemon_species."order",
evolution_chains.baby_trigger_item_id as incense,
pokemon_species_names.name,pokemon_species_names.genus,
pokemon_species_flavor_text.flavor_text
from pokemon
left join pokemon_abilities_view on pokemon.id = pokemon_abilities_view.pokemon_id 
left join pokemon_egg_groups_view on pokemon_egg_groups_view.pokemon_id = pokemon.id 
left join pokemon_stats_view on pokemon_stats_view.pokemon_id = pokemon.id 
left join pokemon_types_view on pokemon_types_view.pokemon_id = pokemon.id 
left join pokemon_species on pokemon_species.id = pokemon.species_id
--left join pokemon_evolution on pokemon_evolution.species_id = pokemon_species.id
left join evolution_chains on evolution_chains.id = pokemon_species.evolution_chain_id
left join pokemon_colors on pokemon_colors.id = pokemon_species.color_id
left join pokemon_color_names on pokemon_color_names.pokemon_color_id=pokemon_colors.id AND pokemon_color_names.local_language_id=9
left join pokemon_species_names on pokemon_species_names.pokemon_species_id = pokemon.species_id AND pokemon_species_names.local_language_id=9
left join pokemon_species_flavor_text on pokemon_species_flavor_text.species_id = pokemon.species_id AND pokemon_species_flavor_text.version_id=26 AND pokemon_species_flavor_text.language_id=9
order by pokemon.id ASC;
CREATE VIEW pokemon_evolution_view as 
select pokemon_species.id, pokemon_species.identifier, pokemon_species.generation_id, pokemon_species.evolves_from_species_id, pokemon_species.evolution_chain_id, pokemon_species."order",
pokemon_evolution.evolved_species_id, pokemon_evolution.evolution_trigger_id, pokemon_evolution.trigger_item_id, pokemon_evolution.minimum_level, pokemon_evolution.gender_id, pokemon_evolution.location_id, pokemon_evolution.held_item_id, pokemon_evolution.time_of_day, pokemon_evolution.known_move_id, pokemon_evolution.known_move_type_id, pokemon_evolution.minimum_happiness, pokemon_evolution.minimum_beauty, pokemon_evolution.minimum_affection, pokemon_evolution.relative_physical_stats, pokemon_evolution.party_species_id, pokemon_evolution.party_type_id, pokemon_evolution.trade_species_id, pokemon_evolution.needs_overworld_rain, pokemon_evolution.turn_upside_down
from pokemon_evolution
left join pokemon_species on pokemon_evolution.evolved_species_id = pokemon_species.id
--group by pokemon_species."order" --pokemon_species.id --pokemon_species.evolution_chain_id
order by pokemon_species.evolution_chain_id, pokemon_species.id, --ToDo: Foreign/Index key "pokemon_species.evolves_from_species_id"
--pokemon_species.evolves_from_species_id, --number order is bad, went 1, 10, 100, instead of 1,2,3
pokemon_species."order";
CREATE VIEW item_game_indices_view as 
select item_id, group_concat(DISTINCT generation_id) as generation_group, group_concat(DISTINCT game_index) as game_index_group
from item_game_indices 
group by item_id;
CREATE VIEW item_flag_map_view as 
select item_id, group_concat(DISTINCT item_flag_id) as item_flag_group
from item_flag_map 
group by item_id;
CREATE VIEW item_views as 
select items.id, items.identifier, items.category_id, items.cost, items.fling_power, items.fling_effect_id,
item_flag_map_view.item_flag_group,
item_game_indices_view.generation_group, item_game_indices_view.game_index_group,
item_prose.short_effect, item_prose.effect,
item_categories.pocket_id,
item_pockets.identifier as item_pocket_identifier,
item_names.name,
item_flavor_text.flavor_text
from items
left join (
	select item_id, group_concat(DISTINCT item_flag_id) as item_flag_group
	from item_flag_map 
	group by item_id
	) as item_flag_map_view on item_flag_map_view.item_id = items.id 
left join (
	select item_id, group_concat(DISTINCT generation_id) as generation_group, group_concat(DISTINCT game_index) as game_index_group
	from item_game_indices 
	group by item_id
	) as item_game_indices_view on item_game_indices_view.item_id = items.id
left join item_categories on item_categories.id = items.category_id
left join item_pockets on item_pockets.id = item_categories.pocket_id
left join item_prose on item_prose.item_id=items.id AND item_prose.local_language_id=9
left join item_fling_effect_prose on item_fling_effect_prose.item_fling_effect_id = items.fling_effect_id AND item_fling_effect_prose.local_language_id=9
left join item_names on item_names.item_id = items.id AND item_names.local_language_id=9
left join item_flavor_text on item_flavor_text.item_id = items.id AND item_flavor_text.version_group_id=18 AND item_flavor_text.language_id=9
order by items.id ASC;
CREATE VIEW move_flag_map_view as 
select move_id, group_concat(DISTINCT move_flag_id) as move_flag_group
from move_flag_map 
group by move_id;
CREATE VIEW move_views as 
select moves.id, moves.identifier, moves.generation_id, moves.type_id, moves.power, moves.pp, moves.accuracy, moves.priority, moves.target_id, moves.damage_class_id, moves.effect_id, moves.effect_chance, moves.contest_type_id, moves.contest_effect_id, moves.contest_type_id, moves.contest_effect_id, moves.super_contest_effect_id,
contest_effects.appeal, contest_effects.jam, super_contest_effects.appeal as super_appeal,
move_meta.meta_category_id, move_meta.meta_ailment_id, move_meta.min_hits, move_meta.max_hits, move_meta.min_turns, move_meta.max_turns, move_meta.drain, move_meta.healing, move_meta.crit_rate, move_meta.ailment_chance, move_meta.flinch_chance, move_meta.stat_chance,
--move_flags.identifier as move_flag,
move_flag_map_view.move_flag_group,
move_effect_prose.short_effect, move_effect_prose.effect,
--move_flag_prose.name as flag_name, move_flag_prose.description as flag_description,
move_targets.identifier as target_identifier,
move_target_prose.name as target_name, move_target_prose.description as target_description,
move_names.name,
move_flavor_text.flavor_text
from moves
left join move_flag_map_view on move_flag_map_view.move_id = moves.id 
--left join move_flags on move_flags.id = moves.id 
left join move_meta on move_meta.move_id = moves.id
left join contest_effects on moves.contest_effect_id = contest_effects.id
left join super_contest_effects on super_contest_effects.id = moves.super_contest_effect_id
left join move_targets on move_targets.id = moves.target_id
left join move_target_prose on move_target_prose.move_target_id=move_targets.id AND move_target_prose.local_language_id=9
left join move_effect_prose on move_effect_prose.move_effect_id = moves.effect_id AND move_effect_prose.local_language_id=9
left join move_names on move_names.move_id = moves.id AND move_names.local_language_id=9
left join move_flavor_text on move_flavor_text.move_id = moves.id AND move_flavor_text.version_group_id=18 AND move_flavor_text.language_id=9
order by moves.id ASC;
CREATE VIEW berry_flavors_view as
select 
	b.id as berry_id
	,CAST(AVG(CASE WHEN i.contest_type_id = 1 THEN i.flavor
    END) as int) as cool
	,CAST(AVG(CASE WHEN i.contest_type_id = 2 THEN i.flavor
    END) as int) as beauty
	,CAST(AVG(CASE WHEN i.contest_type_id = 3 THEN i.flavor
    END) as int) as cute
	,CAST(AVG(CASE WHEN i.contest_type_id = 4 THEN i.flavor
    END) as int) as smart
	,CAST(AVG(CASE WHEN i.contest_type_id = 5 THEN i.flavor
    END) as int) as tough
	from "berries" as b
	left join "berry_flavors" as i on b.id = i.berry_id
	group by b.id;
CREATE VIEW berry_views as
select 
	b.id, b.item_id, b.firmness_id, b.natural_gift_power, b.natural_gift_type_id, b.size, b.max_harvest, b.growth_time, b.soil_dryness, b.smoothness
	,i.cool, i.beauty, i.cute, i.smart, i.tough
	from "berries" as b
	left join berry_flavors_view as i on b.id = i.berry_id;
CREATE VIEW contest_combos_view as 
select first_move_id, group_concat(DISTINCT second_move_id) as second_move_group
	from contest_combos 
	group by first_move_id;
CREATE VIEW encounter_condition_value_map_view as
select encounter_id, group_concat(DISTINCT encounter_condition_value_id) as encounter_condition_value_group
from encounter_condition_value_map 
group by encounter_id;
CREATE VIEW location_area_encounter_rates_view as
select location_area_id, group_concat(DISTINCT version_id) as version_group, encounter_method_id, rate
	from location_area_encounter_rates 
	group by location_area_id, encounter_method_id, rate;
CREATE VIEW location_areas_view as
select 
	l.id, l.location_id, l.identifier,
	location_area_encounter_rates_view.location_area_id, location_area_encounter_rates_view.version_group, location_area_encounter_rates_view.encounter_method_id, location_area_encounter_rates_view.rate
	from "location_areas" as l
	left join (
		select location_area_id, group_concat(DISTINCT version_id) as version_group, encounter_method_id, rate
		from location_area_encounter_rates 
		group by location_area_id, encounter_method_id, rate
	) location_area_encounter_rates_view on l.id = location_area_encounter_rates_view.location_area_id;
CREATE VIEW location_views as
select 
	l.id, l.region_id, l.identifier,
	g.generation_id,
	n.name, n.subtitle
	from "locations" as l
	left join location_game_indices as g on l.id = g.location_id
	left join location_names as n on l.id = n.location_id AND n.local_language_id=9;
CREATE VIEW encounter_views as
select 
	--e.id, e.version_id, e.location_area_id, e.encounter_slot_id, e.pokemon_id, e.min_level, e.max_level,
	e.location_area_id, group_concat(DISTINCT e.pokemon_id) as pokemon_group, MIN(e.min_level) as min_level, MAX(e.max_level) as max_level, group_concat(DISTINCT e.encounter_slot_id) as encounter_slot_group, group_concat(DISTINCT e.version_id) as version_group,
	s.encounter_method_id, s.slot, s.rarity, --group_concat(DISTINCT s.version_group_id) as encounter_slot_version_group,
	--i.encounter_condition_value_group,
	group_concat(DISTINCT i.encounter_condition_value_id) as encounter_condition_value_group,
	a.location_id,
	l.region_id,
	g.generation_id
	--group_concat(DISTINCT g.generation_id) as generation_group
	--,n.name, n.subtitle
	from "encounters" as e
	left join encounter_slots as s on s.id = e.encounter_slot_id
	--left join encounter_condition_value_map_view as i on e.id = i.encounter_id;
	--left join (
	--	select encounter_id, group_concat(DISTINCT encounter_condition_value_id) as encounter_condition_value_group
	--	from encounter_condition_value_map 
	--	group by encounter_id
	--) as i on e.id = i.encounter_id
	left join encounter_condition_value_map as i on e.id = i.encounter_id
	--left join (
	--	select location_area_id, group_concat(DISTINCT version_id) as version_group, encounter_method_id, rate
	--	from location_area_encounter_rates 
	--	group by location_area_id, encounter_method_id, rate
	--) as r on e.location_area_id = r.location_area_id
	left join location_areas as a on a.id=e.location_area_id
	left join locations as l on l.id=a.location_id
	left join location_game_indices as g on l.id = g.location_id
	left join location_names as n on l.id = n.location_id AND n.local_language_id=9
	--where i.encounter_condition_value_group IS NOT NULL
	--where i.encounter_condition_value_id IS NOT NULL
	group by e.location_area_id, s.encounter_method_id, s.slot, e.pokemon_id;
/* IGNORE THIS; JUST TESTING QUERY RESULTS
CREATE VIEW encounter_slot_views as 
select 
	--e.id, e.version_id, e.location_area_id, e.encounter_slot_id, e.pokemon_id, e.min_level, e.max_level,
	e.location_area_id, group_concat(DISTINCT e.pokemon_id) as pokemon_group, MIN(e.min_level) as min_level, MAX(e.max_level) as max_level, --group_concat(DISTINCT e.encounter_slot_id) as encounter_slot_group, group_concat(DISTINCT e.version_id) as version_group,
	s.encounter_method_id, s.slot, s.rarity, group_concat(DISTINCT s.version_group_id) as encounter_slot_version_group,
	--i.encounter_condition_value_group,
	group_concat(DISTINCT i.encounter_condition_value_id) as encounter_condition_value_group,
	a.location_id,
	l.region_id,
	g.generation_id
	--group_concat(DISTINCT g.generation_id) as generation_group
	--,n.name, n.subtitle
	from "encounters" as e
	left join encounter_slots as s on s.id = e.encounter_slot_id
	--left join encounter_condition_value_map_view as i on e.id = i.encounter_id;
	--left join (
	--	select encounter_id, group_concat(DISTINCT encounter_condition_value_id) as encounter_condition_value_group
	--	from encounter_condition_value_map 
	--	group by encounter_id
	--) as i on e.id = i.encounter_id
	left join encounter_condition_value_map as i on e.id = i.encounter_id
	--left join (
	--	select location_area_id, group_concat(DISTINCT version_id) as version_group, encounter_method_id, rate
	--	from location_area_encounter_rates 
	--	group by location_area_id, encounter_method_id, rate
	--) as r on e.location_area_id = r.location_area_id
	left join location_areas as a on a.id=e.location_area_id
	left join locations as l on l.id=a.location_id
	left join location_game_indices as g on l.id = g.location_id
	left join location_names as n on l.id = n.location_id AND n.local_language_id=9
	--where i.encounter_condition_value_group IS NOT NULL
	--where i.encounter_condition_value_id IS NOT NULL
	group by e.location_area_id, s.encounter_method_id, s.slot, s.rarity;--e.pokemon_id;*/
--CREATE VIEW encounter_slot_views as 
select encounter_method_group, slot_group, rarity_group, group_concat(DISTINCT encounter_slot_version_group) as version_group, group_concat(id_group) as id_group FROM (SELECT
	--s.id, s.encounter_method_id, s.slot, s.rarity, group_concat(DISTINCT s.version_group_id) as encounter_slot_version_group
	group_concat(s.id) as id_group, s.encounter_method_id as encounter_method_group, group_concat(DISTINCT s.slot) as slot_group, group_concat(s.rarity) as rarity_group, group_concat(DISTINCT s.version_group_id) as encounter_slot_version_group
	from ( --encounter_slots as s --on s.id = e.encounter_slot_id
		select id, version_group_id, rarity, encounter_method_id,
		case when (slot is not null) AND version_group_id = 15 then slot + 1 else slot end as slot
		from encounter_slots
	) as s group by s.version_group_id, s.encounter_method_id--s.slot, rarity
	--order by s.encounter_method_id, s.id
) group by encounter_method_group, slot_group, rarity_group 
order by encounter_method_group
COMMIT;