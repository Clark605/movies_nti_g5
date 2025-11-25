# Movies App

A Flutter application for browsing movies using The Movie Database (TMDB) API.

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio or VS code (for Android development)

### Installation

1. Clone the repository:
```sh
git clone https://github.com/Clark605/movies_nti_g5
cd movies_nti_g5
code .
```

2. Install dependencies:
```sh
flutter pub get
```

3. Run the app

## Project Structure
- `lib/core/` - Core functionality (theme, constants, network)
- `lib/features/` - Feature modules
- `assets/` - Images and icons

## API Configuration
This project uses TMDB API. The API key is configured in [`lib/core/constants/app_constants.dart`](lib/core/constants/app_constants.dart).
