/* Shahanshahi data model
 * Browser-side adapter for the PostgreSQL dump.
 * This file contains no credentials and is safe to ship with GitHub Pages.
 */
(function (global) {
  'use strict';

  const Schema = Object.freeze({
    character_status: ['active', 'imprisoned', 'exiled', 'dead'],
    game_event_kind: ['historical', 'transition', 'social'],
    province_status: ['core', 'subject', 'neighbor', 'influence'],
    tables: {
      game_state: ['id','current_year','treasury','food','water','population','stability','legitimacy','prestige','corruption','army','updated_at','game_over','transition_unlocked','current_ruler','historical_pressure'],
      game_provinces: ['id','game_id','name','status','terrain','food_output','water_access','population','owner_name','note'],
      game_characters: ['id','game_id','name','role','loyalty','influence','ambition','status','historical','note','age','wealth','popularity','fame','health','family_note'],
      game_character_relations: ['id','game_id','from_character_id','to_character_id','relation','relation_kind'],
      game_events: ['id','game_id','event_year','title','kind','confidence','event_text','resolved'],
      game_groups: ['id','game_id','name','satisfaction','influence','need'],
      game_relations: ['id','game_id','power_name','relation','trust','pressure','note'],
      game_wars: ['id','game_id','name','enemy','started_year','status','enemy_strength','player_strength','player_morale','enemy_morale','supply','terrain','historical','result'],
      game_challenges: ['id','gameid','era','kind','title','description','status','difficulty','reward','createdyear','resolvedyear'],
      game_history_memory: ['id','game_id','memory_year','actor','memory_type','description','weight'],
      game_logs: ['id','game_id','message','created_at']
    }
  });

  const Seed = {
    game_state: {
      id: 'default', current_year: -700, treasury: 860, food: 640, water: 71,
      population: 420000, stability: 72, legitimacy: 64, prestige: 39,
      corruption: 18, army: 24000, game_over: false,
      transition_unlocked: false, current_ruler: 'شاه محلی ماد', historical_pressure: 0
    },
    characters: [
      {id:'deioces', name:'دیاکو', historical:true, loyalty:78, influence:72, ambition:69},
      {id:'cyaxares', name:'هووخشتره', historical:true, loyalty:91, influence:94, ambition:83},
      {id:'astyages', name:'آستیاگ', historical:true, loyalty:76, influence:90, ambition:72},
      {id:'harpagus', name:'هارپاگ', historical:true, loyalty:62, influence:84, ambition:88},
      {id:'court-magus', name:'مغ دربار', historical:false, loyalty:69, influence:57, ambition:51},
      {id:'treasurer', name:'رئیس خزانه', historical:false, loyalty:68, influence:55, ambition:64},
      {id:'pass-commander', name:'فرمانده گذرگاه', historical:false, loyalty:73, influence:63, ambition:71}
    ],
    relations: [
      {from:'harpagus',to:'cyaxares',value:35,kind:'ally'},
      {from:'harpagus',to:'astyages',value:-20,kind:'rival'},
      {from:'deioces',to:'harpagus',value:10,kind:'court'},
      {from:'treasurer',to:'harpagus',value:-10,kind:'rival'}
    ]
  };

  const DataStore = {
    schema: Schema,
    seed: Seed,
    clone(value) {
      return JSON.parse(JSON.stringify(value));
    },
    empty(table) {
      return [];
    },
    fromGameState(game) {
      return {
        id: 'default',
        current_year: game.year,
        treasury: game.cash,
        food: game.food,
        water: game.water,
        population: game.pop,
        stability: game.stab,
        legitimacy: game.legit,
        army: game.armies.reduce((n, a) => n + a.n, 0),
        game_over: !!game.over,
        transition_unlocked: !!game.transition,
        current_ruler: game.ruler || 'شاه محلی ماد'
      };
    }
  };

  global.ShahanshahiData = DataStore;
})(window);
