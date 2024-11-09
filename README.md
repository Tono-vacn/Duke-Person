# Duke Person

This is a simple app to display personal information of People at Duke, fetched from given API.

This app includes one main page to display the list of people and a detail page to display the detailed information of a person, and also the team view to show the class groups.

- SwiftUI for UI Development
- SwiftData for DataManagement
- Delegation for web communication
- Global DataManager for Data Storage/Management

## Installation

1. Clone the repository
2. Run the project in xcode

## Features

- Finished in Sprint1

   - The app will display a list of people at Duke.
   - Click on a person to view their detailed information.
   - Click on the back button to go back to the list.
   - Click on the search icon to search for a person by their name.
   - Click the download icon to fetch data from remote API.

- Finished in Sprint2:
  
   - sort function with 6 options
   - search in description
   - W/R to sandbox
   - Detail Page is added alreay in HW2

- Finished in Sprint3:

   - add the login component to the app.
   - adjust the hardcoded authentication to the one provided by login component.
   - add the download progress indicator using delegate pattern.
   - add AddEditView to add or edit a person.
   - add the delete function to delete a person.
   - add upload method to upload the data to the server.
   - adjust project structure

   Extra For Sprint3

    - Add the Image Picker to select the image from the photo library as avatar.
    - Add global toast to show the message.
    - Customized progress indicator style.

- Finished in Sprint4:
    
    - switch persistence from fileurl to SwiftData
    - redesigned project structure
    - add teams view

  - Extra for Sprint4
    - implemented DAO singleton to handle data access
    - split data model and view model completely

  - Fix for Sprint4:
    - fixed email validation issue
    - fixed lName, fName capitalization issue
    - fixed DUID, NetID valid input issue

- Sprint5:
  
  - Add backcard for person detail view
  - Add the ability to flip the card
  - Add dynamic vector animation in backcard
  - Add Attributed Text in backcard
  - Add An Image (Raster graphic) in backcard
  - Add Animation to an Image in backcard
- Extra for Sprint5:
  - a dot clock in the backcard
  - a dynamic vector animation of an opening flower in the backcard
