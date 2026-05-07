EventHub

<div align="center">

🎟️ EventHub

Smart Event Management Mobile Application

A modern mobile platform that simplifies event management by connecting organizers, sponsors, speakers, and attendees in one unified system.

</div>

⸻

📌 About The Project

EventHub is an innovative graduation project designed to modernize and simplify event management through a smart digital platform.

The application connects all event participants — including organizers, sponsors, speakers, and attendees — within one integrated mobile system.

The platform allows users to:

* Discover and explore events
* Book tickets online
* View event locations using Google Maps
* Receive notifications and reminders
* Save favorite events
* Access QR-based digital tickets

The project also helps organizers manage events more efficiently by reducing manual coordination and improving communication between all parties involved.

⸻

✨ Features

👤 Authentication

* Login & Register
* Forgot Password
* OTP Verification
* Reset Password
* Persistent Login using SharedPreferences

⸻

🎟️ Event Booking

* Browse upcoming events
* View event details
* Book tickets instantly
* QR Code tickets
* Download ticket support

⸻

❤️ Favorites

* Save favorite events
* Remove favorites anytime

⸻

🔔 Notifications

* Real-time event reminders
* Booking confirmation notifications
* Event updates

⸻

🗺️ Maps Integration

* Google Maps support
* Event location display
* Interactive map view

⸻

🌙 Additional Features

* Localization (English / Arabic)
* Responsive UI
* Clean and modern design

⸻

🛠️ Tech Stack

Technology	Usage
Dart	Programming Language
Flutter	Mobile Application
Laravel API	Backend API
Provider	State Management
Dio	API Requests
Google Maps API	Maps & Locations
SharedPreferences	Local Storage

⸻

📱 Application Screens

🔹 Splash & Onboarding
<img width="1600" height="1200" alt="Shot00" src="https://github.com/user-attachments/assets/80d5be21-ad25-451d-a6d8-dc154a3856ce" />


⸻

🔹 Authentication Screens
<img width="1600" height="1200" alt="Shot01" src="https://github.com/user-attachments/assets/61fb7372-880d-4311-a0fd-c6cd87d22662" />
<img width="1600" height="1200" alt="Shot3" src="https://github.com/user-attachments/assets/e91c9d34-4101-489d-8e85-596c40cc575d" />



⸻

🔹 Home, Notifications & Event Details
<img width="1600" height="1200" alt="Shot005" src="https://github.com/user-attachments/assets/bc2da925-4046-444f-aed7-0ed714c68052" />


⸻

🔹 Tickets & QR Booking
<img width="1600" height="1200" alt="Shot4" src="https://github.com/user-attachments/assets/be50c7d3-fdd1-4ef3-ad79-082ceccad9f8" />


⸻

🔹 Favorites & Profile
<img width="874" height="1200" alt="Shot003" src="https://github.com/user-attachments/assets/339acff9-64e3-48e5-8f21-67a5fb01c421" />
<img width="1080" height="1350" alt="IMG_4367" src="https://github.com/user-attachments/assets/d911353d-96a3-45ec-be13-0389e3764e4b" />



⸻

🚀 Getting Started

Prerequisites

* Flutter SDK
* Android Studio or VS Code
* Emulator or Physical Device

⸻

Installation

# Clone repository
git clone https://github.com/Ahmed-Nasser-66/eventhub.git
# Open project
cd eventhub
# Install dependencies
flutter pub get
# Run application
flutter run

⸻

🔗 Backend API

The application uses a Laravel REST API backend for:

* Authentication
* Events Management
* Booking System
* Notifications
* User Data

⸻

📂 Project Structure

lib/
├── core/
│   ├── api/
│   │   ├── auth_api_service.dart
│   │   ├── dio_config.dart
│   │   ├── events_service.dart
│   │   └── notification_service.dart
│   │
│   ├── constants/
│   │   ├── app_assets.dart
│   │   └── app_keys.dart
│   │
│   ├── services/
│   │   ├── location_service.dart
│   │   └── storage_service.dart
│   │
│   └── theme/
│       └── app_color.dart
│
├── features/
│
│   ├── splash/
│   │   └── presentation/
│   │       └── splash_screen.dart
│   │
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── onboarding_screen.dart
│   │       └── welcome_screen.dart
│   │
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── login/
│   │   │   │   └── login.dart
│   │   │   │
│   │   │   ├── signup/
│   │   │   │   └── signup.dart
│   │   │   │
│   │   │   ├── forgot_password/
│   │   │   │   └── forgot_password.dart
│   │   │   │
│   │   │   ├── verification_otp/
│   │   │   │   └── varification_otp.dart
│   │   │   │
│   │   │   └── reset_password/
│   │   │       └── rest_password.dart
│   │   │
│   │   └── widgets/
│   │       ├── custom_back_button.dart
│   │       ├── custom_button_auth.dart
│   │       ├── custom_logo_auth.dart
│   │       └── text_form_field.dart
│   │
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── home_page.dart
│   │   │   │
│   │   │   ├── tabs/
│   │   │   │   ├── home_tab.dart
│   │   │   │   ├── favorite_tab.dart
│   │   │   │   └── nearby_events_screen.dart
│   │   │   │
│   │   │   ├── location/
│   │   │   │   └── location_screen.dart
│   │   │   │
│   │   │   ├── notification/
│   │   │   │   └── notification_screen.dart
│   │   │   │
│   │   │   └── event/
│   │   │       ├── event_details_screen.dart
│   │   │       └── event_booking_screen.dart
│   │   │
│   │   └── widgets/
│   │       ├── event/
│   │       │   ├── nearby_event_card.dart
│   │       │   ├── upcoming_event_card.dart
│   │       │   ├── category.dart
│   │       │   ├── filter_button.dart
│   │       │   ├── search_bar_widget.dart
│   │       │   ├── event_skeleton.dart
│   │       │   └── event_details_skeleton.dart
│   │       │
│   │       └── notification/
│   │           ├── notification_card.dart
│   │           └── notification_skeleton.dart
│   │
│   ├── ticket/
│   │   ├── presentation/
│   │   │   ├── tabs/
│   │   │   │   ├── ticket_tab.dart
│   │   │   │   └── ticket_details_screen.dart
│   │   │
│   │   └── widgets/
│   │       └── ticket_card.dart
│   │
│   ├── profile/
│   │   ├── profile_tab.dart
│   │   │
│   │   └── presentation/
│   │       ├── tabs/
│   │       │   ├── edit_profile.dart
│   │       │   ├── privacy_screen.dart
│   │       │   └── support_screen.dart
│   │       │
│   │       └── widgets/
│   │           ├── change_language.dart
│   │           ├── change_notification.dart
│   │           ├── profile_header.dart
│   │           └── profile_option_item.dart
│
├── models/
│   ├── event_details_model.dart
│   ├── event_model.dart
│   ├── notification_model.dart
│   ├── speaker_model.dart
│   ├── sponsor_model.dart
│   └── ticket_model.dart
│
├── providers/
│   ├── app_language_provider.dart
│   ├── event_provider.dart
│   ├── favorite_provider.dart
│   ├── map_provider.dart
│   ├── notification_provider.dart
│   ├── ticket_provider.dart
│   └── user_provider.dart
│
├── l10n/
│   ├── app_ar.arb
│   ├── app_en.arb
│   ├── app_localizations.dart
│   ├── app_localizations_ar.dart
│   └── app_localizations_en.dart
└── main.dart

⸻

👨‍💻 Team Members

Name	Role
Ahmed Nasser	Flutter Developer
Eslam Ahmed	Flutter Developer
Leen	UI/UX Designer

⸻

🎓 Project Type

Graduation Project — Management Information Systems

⸻

🔗 GitHub Accounts

* Ahmed Nasser GitHub￼
* Eslam Ahmed GitHub￼

⸻

❤️ Conclusion

EventHub demonstrates how modern mobile technologies can improve event management by creating a smart, connected, and user-friendly experience for organizers and attendees alike.

⸻

<div align="center">

Made with ❤️ using Flutter & Laravel API

</div>
