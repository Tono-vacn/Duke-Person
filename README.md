# Duke Person

This is a simple app to display personal information of People at Duke, fetched from given API.

This app includes one main page to display the list of people and a detail page to display the detailed information of a person.

## Installation

1. Clone the repository
2. Run the project in xcode

## Features

- Finished in HW2

   - The app will display a list of people at Duke.
   - Click on a person to view their detailed information.
   - Click on the back button to go back to the list.
   - Click on the search icon to search for a person by their name.
   - Click the download icon to fetch data from remote API.

- Finished in HW3:
  
   - sort function with 6 options
   - search in description
   - W/R to sandbox
   - Detail Page is added alreay in HW2

- Finished in HW4:

   - add the login component to the app.
   - adjust the hardcoded authentication to the one provided by login component.
   - add the download progress indicator using delegate pattern.
   - add AddEditView to add or edit a person.
   - add the delete function to delete a person.
   - add upload method to upload the data to the server.
   - adjust project structure

   Extra For HW4

    - Add the Image Picker to select the image from the photo library as avatar.
    - Add global toast to show the message.
    - Customized progress indicator style.

- HW5:
  
  - switch persistence from fileurl to SwiftData
  - redesigned project structure
  - add teams view

- Extra for HW5
  - implemented DAO singleton to handle data access
  - split data model and view model completely

- Fix for HW5:
  - fixed email validation issue
  - fixed lName, fName capitalization issue
  - fixed DUID, NetID valid input issue