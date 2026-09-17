
# SharedLiving
SharedLiving is designed to support people living in a shared household. 
Its main goal is to bring common shared-living activities that are usually spread across different applications into one certain app. Rather than requiring users to utilize numerous apps for different tasks like budgeting, chore and grocery list management, SharedLiving allows users to do all this and more within the same program.
Shared Living currently has options for house expenses and household chores, while features for housemates and groceries are rudimentary and placements for advancements.

## Core Features
### 1. Shared Expenses
Users can enter title, amount, category, payer, and the split between housemates to add a household expense.
Expenses are validated before being saved. When expenses are invalid, for example, if the share/portion value is not valid, an error message related to the domain is displayed.

### 2. Household Chores
Users can set a due date on a chore when assigning it to a housemate and mark it as completed.
This area validates assignments to prevent users from assigning chores to housemates with no title or due dates in the past. It also prevents a user from marking a chore as completed more than once.

### 3. Grocery
Housemates can use this area to make notes about shared household items they need
By using this section, housemates can see what items the household is lacking, whether it be something to clean the house with, or something to eat.
The application provides a way to add items and share them with others.  The purpose of the application is to manage the shared household grocery shopping.  The developers plan to enhance the application to provide additional features and functions.

### 4. Housemates
The housemates section displays members of the shared household and separates the current user's profile from the other household members.

## Architecture
SharedLiving follows an MVVM-based layered architecture with a dedicated UseCase layer.
The main structure:
- Views -- responsible for displaying information and collecting user input
- ViewModels -- manage presentation state and communicate with Use Cases.
- UseCases -- contain the main business rules of the application.
- Domain Models & Repository Protocols -- define household entities, domain errors, and repository protocols.
- Repository Implementations -- handle data storage and retrieval without exposing storage details to the domain layer.
- Local JSON Storage

## Persistence
Shared expenses and household chores are stored locally using JSON files.
`PSERepo` will manage persistent expense data, on the other hand, `PChoreRepo` manages persistent chore data.

The repositories load existing data when the application starts and save updated data whenever expenses or chores are changed. This allows the data to remain available after the app is closed and reopened.

## Error Handling
The project uses domain-specific error types to provide meaningful feedback to the user.
Examples include:
- Invalid shared expense amount
- Missing expense shares
- Invalid sharing portions
- Empty chore title
- Invalid chore due date
- Attempting to complete an already completed chore

These errors are converted into messages and displayed on the UI.

## Testing
This project includes unit tests for the core expense and chore UseCases.
The tests cover both successful workflows and important failure states:
- Recording a valid expense
- Rejecting an invalid expense amount
- Rejecting invalid expense portions
- Assigning a valid chore
- Rejecting an empty chore title
- Rejecting a past due date
- Completing an incomplete chore
- Rejecting a chore that has already been completed

## Current Limitations
This version covers mostly expenses and chores.
The grocery feature contains a form to input grocery data, but storage and more features will be added in future versions.
The housemate feature contains a summary of members of the household, and could be expanded to include details about members and other household data, which may be edited.

## How to Run
1. Open the project in Xcode.
2. Select an iOS Simulator or compatible iOS device.
3. Build and run the project.
4. Use the Home screen to access Expenses, Chores, Grocery, and Housemates.
5. Unit tests can be run through the Xcode Test Navigator.

## Repository
GitHub Repository: https://github.com/Trodean/SharedLiving
