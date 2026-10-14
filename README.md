<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/assets/logo-dark.png">
  <img src=".github/assets/logo.png" alt="Bio Medika" width="440">
</picture>

<br>
<br>

**Web dashboard for drug warehouse staff to manage the medicine catalog and process orders from pharmacies.** Staff sign in with an administrator account, maintain medicines and categories in English and Arabic, set daily discounts and move each order placed from the Bio Medika mobile app through shipping, delivery and payment. New orders arrive as push notifications while the dashboard is open.

[![Flutter Web](https://img.shields.io/badge/Flutter-Web-02569B?logo=flutter&logoColor=white)](https://flutter.dev/multi-platform/web)
[![Dart](https://img.shields.io/badge/Dart-3.2%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/State-GetX-8A2BE2)](https://pub.dev/packages/get)
[![Firebase Cloud Messaging](https://img.shields.io/badge/Firebase-Cloud%20Messaging-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/docs/cloud-messaging)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

</div>

## Overview

Bio Medika connects pharmacies with a drug warehouse. This repository holds the warehouse dashboard. Pharmacists browse the catalog and place orders from the [Bio Medika mobile app](https://github.com/aymansalkhatib/bio-medika-mobile), and the warehouse team manages that catalog and those orders here. Both apps work against the same Bio Medika REST API, a Laravel backend that is not part of this repository.

## Features

- **Administrator sign-in.** Staff sign in from the home page with an administrator account provided by the backend. There is no public sign-up. After sign-in the browser registers its Firebase Cloud Messaging token with the API, so the dashboard can receive order notifications. The Orders, Medications and Categories pages are protected by route middleware and send signed-out visitors back to the home page.
- **Medication management.** Create, edit and delete medicines. The form takes the commercial name, scientific name, manufacturer and description in both English and Arabic, together with the category (from a searchable dropdown), price, expiry date, quantity in stock, the daily-offer discount and an image uploaded from the computer. A new medicine cannot be saved without an image.
- **Category management.** Create, edit and delete categories, each with an English name, an Arabic name and an image. Deleting a category asks for confirmation first, and the category list can be searched.
- **Order processing.** All orders appear in one table with the pharmacist's name, pharmacy, phone number, city, landmark, total price, order date, payment status, order status and number of medicines. Opening an order lists every medicine with its quantity, discount, price and final price. Staff mark an order as shipped, delivered, cancelled or paid, the table updates in place, and the pharmacist sees the change in the mobile app.
- **Search, filters and sorting.**
  - Medicines are searched by English or Arabic commercial or scientific name. Arabic search treats the hamza and madda forms of the letter alef as a plain alef, so common spelling variants still match.
  - Orders are searched by pharmacist or pharmacy name.
  - Both lists accept date queries: `2024-01-01><2024-03-31` matches dates inside the range, `2024-01-01>` matches dates after the given day and `2024-01-01<` matches dates before it. Medicines are matched on their expiry date and orders on their order date.
  - Medicines sort by expiry date, price, daily-offer discount or quantity. Orders filter by status (pending, shipped, delivered or cancelled) or payment (paid or unpaid) and sort by number of medicines, price or date.
- **Live notifications.** Push messages that arrive while the dashboard is open appear as a banner with the title and text in the current language. When the Orders page is open, a new order is added to the table as it arrives.
- **English and Arabic.** The language is switched from the account menu. Arabic switches the layout to right-to-left, and the choice is remembered in the browser.
- **Desktop layout.** The dashboard is designed for desktop browsers and scales with the window through `flutter_screenutil`. In windows smaller than 1000 by 650 pixels, the pages show an animation in place of the content.

## Tech stack

| Area               | Technology                                     | Used for                                                                 |
| ------------------ | ---------------------------------------------- | ------------------------------------------------------------------------ |
| Framework          | Flutter Web, Dart 3.2+                         | User interface and application logic in the browser                      |
| App architecture   | GetX                                           | State management, routing, route middleware, dependency injection and translations |
| Networking         | `http`                                         | JSON requests and multipart image uploads to the REST API with bearer-token authentication |
| Local storage      | `hive`, `hive_flutter`                         | The administrator session and the selected language                      |
| Push notifications | `firebase_core`, `firebase_messaging`          | Order notifications in the browser                                       |
| Layout             | `flutter_screenutil`, `auto_size_text`         | Sizing pages and text relative to the browser window                     |
| Forms and media    | `dropdown_search`, `image_picker`, `cached_network_image`, `flutter_svg` | Category selection, image uploads, cached images and vector icons |
| User interface     | `awesome_dialog`, `shimmer`, `lottie`, `flutter_spinkit` | Dialogs, loading placeholders and animations                   |
| Connectivity       | `connectivity`                                 | Detecting when the browser is offline                                    |

## Project structure

```text
lib/
├── controllers/         # GetX controllers for sign-in, medicines, categories, orders, locale and notifications
├── core/
│   ├── bindings/        # Initial dependency bindings
│   ├── constant/        # Colors, themes, routes, asset paths and UI text
│   ├── data/            # Remote data sources for each API resource
│   ├── enum/            # Sort options and order states
│   ├── helpers/         # Date-query parsing, input formatting and response handling
│   ├── localization/    # English and Arabic translations
│   ├── middleware/      # Route guard for signed-in pages
│   ├── navigation/      # Route table and navigation service
│   ├── services/        # API endpoints, HTTP client and Hive storage service
│   ├── ui/              # Shared widgets and dialogs
│   └── utils/           # Connectivity checker, validation and loaders
├── models/              # Data models
├── views/               # Home, medication, category and order pages and their widgets
├── firebase_options.dart
└── main.dart
```

## Getting started

### Requirements

- Flutter SDK with Dart 3.2 or later and web support enabled
- Google Chrome or another supported browser
- A running instance of the Bio Medika REST API and an administrator account on it

### Installation

1. Clone the repository and install the dependencies.

   ```sh
   git clone https://github.com/aymansalkhatib/bio-medika-web.git
   cd bio-medika-web
   flutter pub get
   ```

2. Point the dashboard at your API server in `lib/core/services/app_link.dart`. Set `ipConfig` to the API host. The port, 8000 by default, is part of `server` and `prefixPathImage` in the same file.

   ```dart
   static const String ipConfig = '127.0.0.1';
   ```

3. Run the dashboard in Chrome.

   ```sh
   flutter run -d chrome
   ```

`lib/firebase_options.dart` holds the Firebase configuration of the original project. To receive notifications through your own Firebase project, generate a new one, for example with `flutterfire configure`.

## License

Released under the [MIT License](LICENSE).
