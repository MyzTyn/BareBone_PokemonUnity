using UnityEngine;
using UnityEditor;
using PokemonUnity;
using PokemonUnity.Monster;
public class PokemonUnityTool : EditorWindow {
    //Scrolls
    Vector2 scrollPos;
    //Bool
    bool Main_Menu = true;
    bool Pokemon_Stat_Viewer = false;
    bool Convert_From_Int_To_Byte = true;
    bool PokemonCreator = false;
    bool ReadDatabase = false;
    //Pokemon
    Pokemon pokemon = null;
    Pokemons pokemons;
    string Male = "♂";
    string Female = "♀";
    string HealthWithMax = null;
    //Pokemon Stats Viewer
    byte ByteLevel; //For Pokemon Level
    int IntLevel; //For changing the values.
    private string Name;
    private string gender;
    private int PokemonLevel;
    private Natures nature;
    private PokemonUnity.Types type1;
    private PokemonUnity.Types type2;
    private string Types;
    private int HP;
    private int MaxHP;
    private int ATK;
    private int DEF;
    private int SPA;
    private int SPD;
    private int SPE;
    private Moves move1;
    private Moves move2;
    private Moves move3;
    private Moves move4;
    private int IV1;
    private int IV2;
    private int IV3;
    private int IV4;
    private int IV5;
    private int IV6;
    //Database
    private string Pokemon = null;
    private string EncounterData = null;
    private string Natures = null;
    private string PokemonForms = null;
    private string PokemonEvolutions = null;
    private string Items = null;
    private string Berries = null;
    private string Trainers = null;
    private string Regions = null;
    private string Locations = null;
    private string Move = null;
    private string PokeDex = null;
    private string Type = null;
    private string Badge;
    private string Machine;
    [MenuItem("Pokemon Unity/Pokemon Unity Tool")]
    private static void ShowWindow() {
        var window = GetWindow<PokemonUnityTool>();
        window.titleContent = new GUIContent("PKTool");
        window.Show();
    }

    private void OnGUI() {
        if (Main_Menu)
        {
            //Debug.Log("Main Menu True");
            //Title
            GUILayout.Label ("Choose The Tool Below", EditorStyles.boldLabel);
            //Button for Stats Viewer
            EditorGUILayout.Space();
            if (GUILayout.Button("Pokemon Stats Viewer"))
            {
                Main_Menu = false;
                PokemonCreator = true;
                Convert_From_Int_To_Byte = true;
            }
            //Button for Read Database
            EditorGUILayout.Space();
            if (GUILayout.Button("Read The Database"))
            {
                Main_Menu = false;
                ReadDatabase = true;
            }
        }
        if (PokemonCreator)
        {
            //Debug.Log("The Pokemon Stats Viewer True");
            Pokemon_Stats_Viewer();
        }
        if (Pokemon_Stat_Viewer)
        {
            //Debug.Log("Stats True");
            Stats_ViewerDisplay();
        }
        if (ReadDatabase)
        {
            //Debug.Log("Read Database True");
            Read_DataBase();
        }
    }
    void Pokemon_Stats_Viewer()
    {
        //Debug.Log("Pokemon Stats Viewer has Opened");
        //scrollPos = EditorGUILayout.BeginScrollView(scrollPos, position.width.ToString(), position.height.ToString());
        //Titles
        GUILayout.Label ("Pokemon Stats Viewer", EditorStyles.boldLabel);
        EditorGUILayout.Space();
        //Pokemon Picker
        pokemons = (Pokemons)EditorGUILayout.EnumPopup("Pokemon :", pokemons);
        IntLevel = EditorGUILayout.IntField ("Level :", IntLevel);
        if (GUILayout.Button("Generate Pokemon"))
        {
            if (Convert_From_Int_To_Byte)
            {
                ByteLevel = System.Convert.ToByte(IntLevel);
                //Debug.Log(Level);
                Create_Pokemon();
                //Debug.Log(Name);
                Convert_From_Int_To_Byte = false;
                PokemonCreator = false;
                Pokemon_Stat_Viewer = true;
            }
        }
        //EditorGUILayout.EndScrollView();
        if (GUILayout.Button("Main Menu"))
        {
            Main_Menu = true;
            PokemonCreator = false;
        }
    }
    void Create_Pokemon()
    {
        pokemon = new Pokemon(pokemons, level: ByteLevel, isEgg: false);
        pokemon.Heal(); //To heal
        pkmn = pokemon; //Send to pkmn
    }
    void Stats_ViewerDisplay()
    {
        GUIStyle BoldLabel = EditorStyles.boldLabel;
        //UI Cleaner
        UIPokemon();
        //Scrolls
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos, position.width.ToString(), position.height.ToString());
        //Titles
        GUILayout.Label("Pokemon Stats Viewer", BoldLabel);
        //Space
        EditorGUILayout.Space();
        //Name
        GUILayout.Label("Name", BoldLabel);
        EditorGUILayout.LabelField("Name :", Name);
        //Space
        EditorGUILayout.Space();
        //Gender
        GUILayout.Label("Gender", BoldLabel);
        EditorGUILayout.LabelField("Gender :", gender);
        //Space
        EditorGUILayout.Space();
        //Type
        EditorGUILayout.LabelField("Type", BoldLabel);
        EditorGUILayout.LabelField("Type :", Types);
        //Space
        EditorGUILayout.Space();
        //Stats
        GUILayout.Label("Stats", BoldLabel);
        //Level
        EditorGUILayout.LabelField("Level :", PokemonLevel.ToString());
        //Health
        EditorGUILayout.LabelField("Health :", HealthWithMax);
        //Attack
        EditorGUILayout.LabelField("ATK :", ATK.ToString());
        //Defense
        EditorGUILayout.LabelField("DEF :", DEF.ToString());
        //Special Attack
        EditorGUILayout.LabelField("SPA :", SPA.ToString());
        //Special Defense 
        EditorGUILayout.LabelField("SPD :", SPD.ToString());
        //Speed
        EditorGUILayout.LabelField("SPE :", SPE.ToString());
        //Space
        EditorGUILayout.Space();
        //Move
        GUILayout.Label("Moves", BoldLabel);
        EditorGUILayout.LabelField(move1.ToString(), move2.ToString());
        EditorGUILayout.LabelField(move3.ToString(), move4.ToString());
        //Space
        EditorGUILayout.Space();
        //IV
        GUILayout.Label("IV Stats", BoldLabel);
        EditorGUILayout.LabelField ("IV 1:", IV1.ToString());
        EditorGUILayout.LabelField ("IV 2:", IV2.ToString());
        EditorGUILayout.LabelField ("IV 3:", IV3.ToString());
        EditorGUILayout.LabelField ("IV 4:", IV4.ToString());
        EditorGUILayout.LabelField ("IV 5:", IV5.ToString());
        EditorGUILayout.LabelField ("IV 6:", IV6.ToString());
        //End of Pokemon Viewer
        EditorGUILayout.EndScrollView();
        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("Main Menu"))
        {
            Pokemon_Stat_Viewer = false;
            Main_Menu = true;
        }
        if (GUILayout.Button("Generate"))
        {
            Create_Pokemon();
        }
        EditorGUILayout.EndHorizontal();
        void UIPokemon() //This for Clean UI
        {
            if (type2 == PokemonUnity.Types.NONE)
            {
                Types = type1.ToString();
            }
            else
            {
                Types = string.Concat(type1.ToString() + "    " + type2.ToString());
            }
            HealthWithMax = string.Concat(HP,"/",MaxHP); //So it will show as CurrentHP/MaxHealth
        }
    }
    void GUI_Read_Database()
    {
        scrollPos = EditorGUILayout.BeginScrollView(scrollPos, position.width.ToString(), position.height.ToString());
        GUILayout.Label ("Database", EditorStyles.boldLabel);
        EditorGUILayout.Space();
        EditorGUILayout.LabelField ("Pokemon ", Pokemon);
        EditorGUILayout.LabelField ("EncounterData ", EncounterData);
        EditorGUILayout.LabelField ("Natures ", Natures);
        EditorGUILayout.LabelField ("Forms ", PokemonForms);
        EditorGUILayout.LabelField ("Evolutions ", PokemonEvolutions);
        EditorGUILayout.LabelField ("Items ", Items);
        EditorGUILayout.LabelField ("Berries ", Berries);
        EditorGUILayout.LabelField ("Trainers ", Trainers);
        EditorGUILayout.LabelField ("Regions ", Regions);
        EditorGUILayout.LabelField ("Locations ", Locations);
        EditorGUILayout.LabelField ("Moves ", Move);
        //EditorGUILayout.LabelField ("PokeDex ", PokeDex);
        EditorGUILayout.LabelField ("Types ", Type);
        EditorGUILayout.EndScrollView();
        if (GUILayout.Button("Main Menu"))
        {
            ReadDatabase = false;
            Main_Menu = true;
        }
    }
    Pokemon pkmn
    {
        set
        {
            if (value != null)
            {
                //Name
                Name = string.Format("{0}{1}", value.Name[0], value.Name.Substring(1).ToLowerInvariant());
                //gender
                gender = value.Gender == true ? Male : (value.Gender == false ? Female : null);
                //Nature
                nature = value.Nature;
                //Type
                type1 = value.Type1;
                type2 = value.Type2;
                //Level
                PokemonLevel = value.Level;
                //Stats
                HP = value.HP;
                MaxHP = value.TotalHP;
                ATK = value.ATK;
                DEF = value.DEF;
                SPA = value.SPA;
                SPD = value.SPD;
                SPE = value.SPE;
                //Move
                move1 = value.moves[0].MoveId;
                move2 = value.moves[1].MoveId;
                move3 = value.moves[2].MoveId;
                move4 = value.moves[3].MoveId;
                //IV
                IV1 = value.IV[0];
                IV2 = value.IV[1];
                IV3 = value.IV[2];
                IV4 = value.IV[3];
                IV5 = value.IV[4];
                IV6 = value.IV[5];
            }
            else
            {
                //Name
                Name = null;
                //Gender
                gender = null;
                //Nature
                nature = 0;
                //Type
                type1 = PokemonUnity.Types.NONE;
                type2 = PokemonUnity.Types.NONE;
                //Level
                PokemonLevel = 0;
                //Stats
                HP = 0;
                MaxHP = 0;
                ATK = 0;
                DEF = 0;
                SPA = 0;
                SPD = 0;
                SPE = 0;
                //Moves
                move1 = Moves.NONE;
                move2 = Moves.NONE;
                move3 = Moves.NONE;
                move4 = Moves.NONE;
                //IV
                IV1 = 0;
                IV2 = 0;
                IV3 = 0;
                IV4 = 0;
                IV5 = 0;
                IV6 = 0;
            }
        }
    }
    void Read_DataBase()
    {
        //Count the Pokemon
        Pokemon = Game.PokemonData.Count.ToString();
        //Count the EncounterData
        //EncounterData = Game.EncounterData.Count.ToString();
        //Count the Type
        Type = Game.TypeData.Count.ToString();
        //Count the Natures
        Natures = Game.NatureData.Count.ToString();
        //Count the Forms
        PokemonForms = Game.PokemonFormsData.Count.ToString();
        //Count the Evolutions
        PokemonEvolutions = Game.PokemonEvolutionsData.Count.ToString();
        //Count the Items
        Items = Game.PokemonItemsData.Count.ToString();
        //Count the Berries
        Berries = Game.BerryData.Count.ToString();
        //Count the Trainers
        Trainers = Game.TrainerMetaData.Count.ToString();
        //Count the Regions
        Regions = Game.RegionData.Count.ToString();
        //Count the Locations
        Locations = Game.LocationData.Count.ToString();
        //Count the Moves
        Move = Game.MoveData.Count.ToString();
        //Count the PokeDex
        //PokeDex = Game.PokedexData.Count.ToString();
        //Count the Badge
        //Badge = Game.BadgeData.Count.ToString();
        //Count the Machine
        //Machine = Game.MachineData.Count.ToString();
        GUI_Read_Database();
    }
}
