# Kora



https://github.com/user-attachments/assets/c1f239b7-96f5-4a3e-92f0-6af4fc14fa98



Designed for performance and simplicity, Kora delivers a seamless sports experience—whether you're checking scores, planning your next watch party, or just exploring the world of leagues and teams.

An iOS application developed using Swift and UIKit that allows users to explore sports leagues, view event details, team information, and manage their favorite leagues. The app is built with modern design principles and follows the MVP architecture pattern.
 
## Features
 
- **Home Screen**  
  Displays a list of available sports (e.g., Football, Basketball, Tennis, etc.).
 
- **Leagues Screen**  
  Shows a list of leagues based on the selected sport. Each league includes its logo and name.
 
- **League Details**  
  Displays upcoming and latest events, as well as participating teams within a league.
 
- **Teams Section**  
  Shows team name, logo, and allows navigation to detailed team information.
 
- **Favorites**  
  Users can mark leagues as favorites. Favorites are stored locally using Core Data and persist between app launches.
 
- **Onboarding Screen**  
  A one-time introduction screen that guides users through the core functionality of the app.
 
- **Dark Mode Support**  
  Colors and images are adapted to the system appearance using Asset Catalogs.
 
- **Shimmer Effect**  
  Placeholder loading animations to enhance user experience during data fetching.
 
- **Reachability**  
  Alerts users when there is no internet connection.
 
- **Unit Testing**  
  Test coverage is applied to critical networking and business logic components using XCTest and mock services.
 
## Technologies Used
 
- **Language**: Swift  
- **Architecture**: MVP (Model–View–Presenter)  
- **Networking**: Alamofire  
- **Persistence**: Core Data  
- **UI/UX**: UIKit, Storyboard, Asset Catalogs (Light & Dark mode)  
- **Testing**: XCTest with Mock Services

