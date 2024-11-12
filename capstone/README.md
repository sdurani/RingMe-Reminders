# RingMe Reminders

**RingMe Reminders** is a fun, interactive reminder app inspired by Apple's Reminders app, with a unique twist: your favorite celebrity or video game character calls you to help you get your work done! Designed to make task management more engaging, RingMe Reminders is built with Swift and Core Data for the iOS frontend and Python for the backend. By integrating generative AI using OpenAI's API, RingMe Reminders ensures that each reminder is personalized and motivating.

When reminders are triggered, a chosen character or celebrity "voices" a notification, encouraging users to complete tasks. This creates an entertaining experience for people who need that extra push—whether they're students juggling assingments and extracurriculars or anyone who finds typical task lists a bit dull. As someone with ADHD, creating an app that helps neurodivergent individuals in staying organized is deeply meaningful to me.

## Goals

- **Provide interactive, character-driven reminders** to make mundane tasks feel exciting and special.
- **Deliver a streamlined and easy-to-navigate interface** that stays minimalistic, making it accessible and efficient to use.
- **Create a supportive tool for neurodivergent users** to help simplify their daily routines.

## Features

- **Minimalistic Interface**: Features a clean, intuitive layout that’s easy to navigate and free of distracting elements.
- **Today View**: Displays all reminders due today, with an option to mark tasks as complete.
- **Scheduled View**: Shows upcoming tasks organized by their scheduled dates.
- **Completed View**: A log of finished tasks, allowing users to review past reminders.
- **Character Notifications**: Each notification is voiced by the character selected by the user providing a fun and personalized reminder experience.
- **Community Character Library** (in development): Users will eventually be able to contribute to a community character database.

## Tech Stack

### Frontend

- **Swift**: Main language used for iOS app development.
- **Core Data**: Manages storage for user-created reminders and lists.
  
### Backend

- **Python & Flask**: The backend framework handling API requests and responses.
- **OpenAI API**: Generates character-based messages to enhance user interaction.

## Database Schema

- **Reminders**: Stores task information including title, due date, notes, and completion status.
- **Lists**: Organizes reminders into user-defined categories.

## Setup and Run Instructions

1. **Clone the repository** and navigate to the project directory.

### iOS Frontend

1. Open the project in Xcode.
2. Run the app in the Xcode simulator.

### Python Backend

1. In VSCode, open a terminal and then navigate to the `python-backend` directory:
   ```sh
   cd python-backend
2. Install the required Python packages:
   ```sh
   pipenv install
   pip install openai
3. Obtain your OpenAI secret key from your OpenAI account.
4. Open the `openai_connector.py` file and insert your OpenAI secret key by editing the `client = OpenAI()` line to:
    ```sh
    client = OpenAI(api_key=" << paste key here >> "))
5. Back in the terminal, set up Python environment and run Flask:
    ```sh
    pipenv shell
    flask run

## Features In Development
- **Expanded Character Options**: The default character is currently Nicki Minaj, but more characters are being added. Users will have the option to select from a range of characters or celebrities.
- **Character Database**: A dedicated database will store available characters, with future functionality allowing users to contribute custom character information and add more character options.
- **Voice Cloning**: Integration with Eleven Labs' API will enable characters to deliver reminders in their own voices, making the experience even more immersive.
- **User Accounts**: Features for user login and authorization.

