using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using PokemonUnity;

public class DatabaseReaderEditor : EditorWindow
{
    
    int Pokemon = 0;
    //int EncounterData = 0;
    int Natures = 0;
    int PokemonForms = 0;
    int PokemonEvolutions = 0;
    int Items = 0;
    int Berries = 0;
    int Trainers = 0;
    int Regions = 0;
    int Locations = 0;
    int Moves = 0;
    //int PokeDex = 0;
    //int Badge = 0;
    //int Machine = 0;
    //Add menu item named "PokemonUnity" to the Window Menu
    [MenuItem ("Pokemon Unity/Read Database")]
    public static void ShowWindow () {
        //Show Existing Window instance. If one doesn't exist, make one.
        EditorWindow.GetWindow(typeof(DatabaseReaderEditor));
    }
    private void OnGUI()
    {
        //Like the Title 
        GUILayout.Label("Database Load", EditorStyles.boldLabel);

        DatabaseData();
        if (GUILayout.Button("Load the Database"))
        {
            LoadDatabase();
        }
    }

    private void DatabaseData()
    {
        
        //GUI of Pokemon Load
        EditorGUILayout.LabelField("Pokemon Load:", Pokemon.ToString());
        //GUI of EncounterData
        //EditorGUILayout.LabelField("EncounterData Load :", EncounterData.ToString());
        //GUI of Natures Load
        EditorGUILayout.LabelField("Natures Load:", Natures.ToString());
        //GUI of Pokemon Forms Load
        EditorGUILayout.LabelField("Forms Load:", PokemonForms.ToString());
        //GUI of Pokemon Evolutions Load
        EditorGUILayout.LabelField("Evolutions Load:", PokemonEvolutions.ToString());
        //GUI of Items load
        EditorGUILayout.LabelField("Items Load:", Items.ToString());
        //GUI of Berries load
        EditorGUILayout.LabelField("Berries Load:", Berries.ToString());
        //GUI of Trainers load
        EditorGUILayout.LabelField("Trainers Load:", Trainers.ToString());
        //GUI of Regions load
        EditorGUILayout.LabelField("Regions Load:", Regions.ToString());
        //GUI of Locations load
        EditorGUILayout.LabelField("Locations", Locations.ToString());
        //GUI of Moves load
        EditorGUILayout.LabelField("Moves Load:", Moves.ToString());
        //GUI of PokeDex load
        //PokeDex = EditorGUILayout.IntField("PokeDex Load:", PokeDex);
        //EditorGUILayout.LabelField("PokeDex Load:", PokeDex.ToString());
        //GUI of Machine load
        //Machine = EditorGUILayout.IntField("Machines Load:", Machine);
        //EditorGUILayout.LabelField("Machines Load:", Machine.ToString());
    }

    private void LoadDatabase()
    {
        //Count the Pokemon
        Pokemon = Game.PokemonData.Count;
        //Count the EncounterData
        //EncounterData = Game.EncounterData.Count;
        //Count the Natures
        Natures = Game.NatureData.Count;
        //Count the Forms
        PokemonForms = Game.PokemonFormsData.Count;
        //Count the Evolutions
        PokemonEvolutions = Game.PokemonEvolutionsData.Count;
        //Count the Items
        Items = Game.PokemonItemsData.Count;
        //Count the Berries
        Berries = Game.BerryData.Count;
        //Count the Trainers
        Trainers = Game.TrainerMetaData.Count;
        //Count the Regions
        Regions = Game.RegionData.Count;
        //Count the Locations
        Locations = Game.LocationData.Count;
        //Count the Moves
        Moves = Game.MoveData.Count;
        //Count the PokeDex
        //PokeDex = Game.PokedexData.Count;
        //Count the Badge
        //Badge = Game.BadgeData.Count;
        //Count the Machine
        //Machine = Game.MachineData.Count;
    }
}
