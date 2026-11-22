# smartPack - Unified Mobile Application (CS 310 Step 2.2)

Term Project Step 2.2: UI Implementation & Wireframe Realization  
**Course:** CS 310 Mobile Application Development, Sabancı University  
**Group:** Group 7  

---

## 👥 Team Members & Contribution Prefixes

Every source file in `lib/` is explicitly prefixed with the author's initials so each member's contributions and individual git history are immediately identifiable:

| Member | Prefix | Subdirectory | Primary Responsibilities & Implemented Features |
| :--- | :---: | :---: | :--- |
| **Alara Bilik** (35672) [Lead] | `ab_` | `lib/ab_alara/` | Global Theme & Color Palette (`ab_theme.dart`), Packing Checklist with progress bar and categories (`ab_packing_checklist_page.dart`), Add Item Form (`ab_add_item_page.dart`), Places & Activities UI (`ab_places_activities_page.dart`). |
| **Seyma Sahin** (28033) | `ss_` | `lib/ss_seyma/` | Budget & Expense Management (`ss_budget_tab.dart`), Model-backed Card with working remove action (`ss_expense_card.dart`), Form with inline validation and confirmation `AlertDialog` (`ss_add_expense_dialog.dart`), Budget Summary Card (`ss_budget_summary_card.dart`), Expense Models (`ss_expense_model.dart`, `ss_trip_model.dart`), Lecture Validation Utilities (`ss_validator_utils.dart`). |
| **Baler Cekmece** (35448) | `bc_` | `lib/bc_baler/` | Navigation Shell & Bottom Nav (`bc_app_shell.dart`), My Trips Screen with active trip cards (`bc_my_trips_page.dart`), Past Journeys Archive Screen (`bc_archive_page.dart`), Plan New Trip Form with Date Pickers (`bc_new_trip_page.dart`), Trip Detail Hub Coordinator (`bc_trip_detail_hub_screen.dart`). |
| **Enes Ozcan** (35532) | `eo_` | `lib/eo_enes/` | Destination Search & Category Filtering (`eo_explore_screen.dart`), Unified PlaceCard Component (`eo_place_card.dart`), Place Model (`eo_place_model.dart`), Trip Overview & Weather Forecast Card (`eo_overview_screen.dart`, `eo_weather_card.dart`). |
| **Nehir Erdim** (35215) | `ne_` | `lib/ne_nehir/` | Authentication UI with Form Validation (`ne_main.dart`: `LoginScreen`, `SignUpScreen`), Local & Network Images Component with fallback errorBuilder (`ne_widgets.dart`: `DestinationImage`, `DestinationCard`), User Profile Screen (`ProfileScreen`), 4 Local City PNG Assets (`barcelona.png`, `paris.png`, `rome.png`, `tokyo.png`). |

---

## 🚀 How to Run the Project

1. Ensure Flutter 3.x+ is installed.
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run on an Android emulator or iOS simulator:
   ```bash
   flutter run
   ```
