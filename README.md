# E-commerce Mini App

A small e-commerce application built with Flutter that demonstrates a complete user flow from browsing products to adding them to a cart. The app uses the Fake Store API to display dynamic data.

## Features

-   **Splash Screen**: Displays the app logo with a fade-in animation and navigates to the Login Screen after a delay.
-   **Login Screen**: A simulated login screen with email and password fields, including input validation.
-   **Dashboard (Category Display)**: Shows product categories in a grid view. Tapping a category filters the products.
-   **Product List Screen**: Displays a list of products in a grid with images, titles, and prices.
-   **Product Details Screen**: Shows detailed information about a selected product, including a larger image, description, price, and an "Add to Cart" button.
-   **Cart Screen**:
    -   Lists all products added to the cart.
    -   Allows users to adjust the quantity of each item (+/-).
    -   Allows users to remove items from the cart.
    -   Displays the total bill amount.
    -   Includes a placeholder "Checkout" button.
-   **Local State Management**: Manages the cart and favorite items locally on the device.
-   **Global Theming**: Uses a centralized color scheme for a consistent look and feel across the app.

## Tech Stack

-   **Framework**: Flutter
-   **Language**: Dart
-   **API Integration**: `http` package for making requests to the Fake Store API.
-   **Animations**: Lottie for the splash screen animation.
-   **Local Storage**: `shared_preferences` for persisting cart and favorite items.

## API Used

This application uses the [Fake Store API](https://fakestoreapi.com/), a free online REST API that provides dummy data for e-commerce or shopping websites.

-   **Get all categories**: `https://fakestoreapi.com/products/categories`
-   **Get all products**: `https://fakestoreapi.com/products`
-   **Get products by category**: `https://fakestoreapi.com/products/category/{category}`

## Future Improvements

-   **Real Authentication**: Implement a proper authentication system with a backend service (e.g., Firebase Authentication, or a custom backend).
-   **User Profiles**: Add a user profile screen where users can view and edit their information.
-   **Order History**: Implement a feature to view past orders.
-   **Search Functionality**: Implement a real search functionality to search for products by name or description.
-   **State Management Refactor**: Migrate to a more robust state management solution like Bloc or Riverpod for better scalability.
-   **Checkout Flow**: Implement a complete checkout process, including shipping information and payment integration.
-   **Error Handling**: Improve error handling and display user-friendly messages for network errors or API failures.
-   **Unit and Widget Testing**: Add more comprehensive tests to ensure code quality and prevent regressions.

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd "E-commerce Mini App"
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the application:**
    ```bash
    flutter run
    ```
