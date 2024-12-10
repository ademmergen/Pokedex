## Application Video
![ScreenRecording2024-12-05at20 21 30-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/80cedbac-dc17-4b87-a1ba-ecf352bd2b67)

A Pokémon application built using Swift and UIKit, showcasing a list of Pokémon and detailed information about each. The app is designed with a clean architecture and utilizes modern development practices for an intuitive and interactive user experience.

## Features  

### Pokémon List  
- **Displays a list of Pokémon in a `UITableView`:**  
  Shows Pokémon with their respective names and images in an organized table layout.  

- **Implements pagination to load Pokémon data incrementally:**  
  Fetches data in batches of 20 Pokémon to optimize performance and user experience.  

- **Includes a `UISearchBar` to filter Pokémon by name:**  
  Users can search and filter Pokémon in real time by typing their names.  

- **Smooth user experience with a loading indicator during data fetching:**  
  Displays an `ActivityIndicator` while waiting for data to load, enhancing usability.  

### Pokémon Detail  
- **Shows detailed Pokémon stats such as height, weight, and abilities:**  
  Displays individual stats like height, weight, and a list of abilities.  

- **Expanding sections for stats, abilities, and other attributes:**  
  Users can tap on sections to expand and view detailed information, such as individual stats.  

- **Displays Pokémon images using `Kingfisher`:**  
  Efficiently loads and caches Pokémon images for faster rendering.  

- **Supports dynamic table cells for versatile layouts and interactions:**  
  Provides adjustable cell heights and interactive content.  

---

## Technical Details  

### Architecture  
- **ViewModel:**  
  Implements the MVVM design pattern to separate UI logic from business logic.  

- **Custom Cells:**  
  Designed `UITableViewCell` subclasses to handle different types of data, like stats and abilities.  

- **Expandable Sections:**  
  Dynamically adjusts the cell height based on user interactions (e.g., expanding or collapsing sections).  

### Dependencies  
- **Kingfisher:**  
  Handles asynchronous image loading and caching for improved performance and UX.  

### API Integration  
- **Fetches Pokémon data from the PokéAPI:**  
  - Pokémon List Endpoint:  
    `https://pokeapi.co/api/v2/pokemon?offset=0&limit=20`  
  - Pokémon Detail Endpoint:  
    `https://pokeapi.co/api/v2/pokemon/{id}`  

- **Reusable API handling:**  
  Uses a dedicated service layer for managing API requests and data parsing.  

### UI Components  
- **UITableView:**  
  Displays Pokémon lists and details in a scrollable, structured format.  

- **UISearchBar:**  
  Provides real-time search capabilities for filtering Pokémon by name.  

- **Activity Indicator:**  
  Indicates loading states during pagination and search operations.  


