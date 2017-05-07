class KF_AI {
    class Units {
        class EAST {
            //"sl", "all other units", minimum 2 units
            infantry[] = {"O_Soldier_SL_F","O_medic_F","O_engineer_F","O_soldier_TL_F","O_Soldier_AT_F","O_soldier_AA_F","O_soldier_AR_F","O_soldier_LAT_F","O_soldier_GL_F","O_soldier_M_F","O_Soldier_F"};
            //"crew", "pilot", should be 2 units
            crew[] = {"O_crew_F","O_Helipilot_F"};
            wheeled[] = {"O_MRAP_02_F"};
            armored[] = {"O_APC_Wheeled_02_rcws_F", "O_MBT_02_cannon_F"};
            air[] = {"O_Heli_Light_02_F"};
            naval[] = {"O_Boat_Transport_01_F"};
        };
        class WEST {
            infantry[] = {"B_Soldier_SL_F","B_medic_F","B_engineer_F","B_soldier_TL_F","B_soldier_AT_F","B_soldier_AA_F","B_soldier_AR_F","B_soldier_LAT_F","B_soldier_GL_F","B_soldier_M_F","B_Soldier_F"};
            crew[] = {"B_crew_F","B_Helipilot_F"};
            wheeled[] = {"B_MRAP_01_F"};
            armored[] = {"B_APC_Wheeled_01_cannon_F", "B_MBT_01_TUSK_F"};
            air[] = {"B_Heli_Transport_01_F"};
            naval[] = {"B_Boat_Transport_01_F"};
        };
        class GUER {
            infantry[] = {"I_Soldier_SL_F","I_medic_F","I_engineer_F","I_soldier_TL_F","I_Soldier_AT_F","I_soldier_AA_F","I_soldier_AR_F","I_soldier_LAT_F","I_soldier_GL_F","I_soldier_M_F","I_Soldier_F"};
            crew[] = {"I_crew_F","I_Helipilot_F"};
            wheeled[] = {"I_MRAP_03_F"};
            armored[] = {"I_APC_Wheeled_03_cannon_F", "I_MBT_03_cannon_F"};
            air[] = {"I_Heli_light_03_F"};
            naval[] = {"I_Boat_Transport_01_F"};
        };
    };
    class Behaviour {
        class NORMAL {
            class Infantry {
                //"aimingAccuracy", "aimingShake", "aimingSpeed", "endurance", "spotDistance", "spotTime", "courage", "reloadSpeed", "commanding", "general"
                skill[] = {{0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.6, 0.8}, {0.6, 0.8}, {0.6, 0.8}, {0.6, 0.8}, {0.6, 0.8}, {0.6, 0.8}, {0.6, 0.8}};
            };
            class Vehicles {
                skill[] = {{0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}};
            };
        };
        class NORMAL_LOWER {
            class Infantry {
                skill[] = {{0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}, {0.5, 0.7}};
            };
            class Vehicles {
                skill[] = {{0.2, 0.4}, {0.2, 0.4}, {0.2, 0.4}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}};
            };
        };
        class EASY {
            class Infantry {
                skill[] = {{0.2, 0.4}, {0.2, 0.4}, {0.2, 0.4}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}, {0.4, 0.6}};
            };
            class Vehicles {
                skill[] = {{0.1, 0.3}, {0.1, 0.3}, {0.1, 0.3}, {0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}, {0.3, 0.5}};
            };
        };
    };
};
