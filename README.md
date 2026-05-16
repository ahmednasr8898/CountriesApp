# Countries App

A modern iOS application built with **SwiftUI** that allows users to explore countries around the world, search by country name, and view detailed country information including capital city and currency.

The app also supports detecting the user’s current country using location services.

---

## Features

### Selected Countries

* Automatically adds the user’s current country to the Selected Countries list using GPS location
* Defaults to **Egypt** if location permission is denied
* Display selected country flag and name
* Prevent adding duplicate countries
* Maximum limit of 5 selected countries
* Remove countries from selected countries list

### Search Functionality

* Fetch countries from REST Countries API
* Search countries by name
* Quickly add countries to the Selected Countries list

### Country Details

* View detailed information about a selected country:
  * Country name
  * Capital city
  * Currency 

### Location Support

* Detect user current country using CoreLocation
* Reverse geocoding support

### Offline Mode

* Persist selected countries locally
* Cache country flags for offline usage 

---

## Screenshots

| Selected Countries                                                                                                                              | Search Countries                                                                                                                              | Country Details                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| <img width="250" height="500" alt="Countries List" src="https://github.com/user-attachments/assets/a71a654f-3fee-4cb4-a470-1b7a2d7d8ac2" /> | <img width="250" height="500" alt="Search Countries" src="https://github.com/user-attachments/assets/0dde600a-5ebd-4b36-ab3d-f23ce5ef9429" /> | <img width="250" height="500" alt="Country Details" src="https://github.com/user-attachments/assets/ecbef6e3-0844-4a51-9ebf-b8c87ac15aa1" /> |

---

### Architecture & Code Quality

* MVVM Architecture
* Async/Await networking
* Service Layer abstraction
* Reusable SwiftUI components
* Unit Testing support
* Clean and scalable project structure

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture.

### Layers

#### Views

Responsible for:

* Building UI using SwiftUI
* Displaying app state
* Handling user interactions

#### ViewModels

Responsible for:

* Presentation logic
* State management
* Communicating with services

#### Services

Responsible for:

* API networking
* Location handling
* Storage
* Image caching

#### Data

Responsible for:

* Models
* Api requests

---

## Technologies

* SwiftUI
* Swift Concurrency (`async/await`)
* CoreLocation
* UserDefaults
* URLSession
* XCTest
* MVVM Architecture

---

## API

Countries data is fetched from:

[https://restcountries.com/](https://restcountries.com/)

### Endpoint

```bash
https://restcountries.com/v3.1/all?fields=name,capital,currencies,flags
```

---

## Project Structure

```bash
CountriesApp
│
├── Services
│   ├── Network
│   ├── Storage
│   ├── Location
│   └── ImageCaching
│
├── Data Layer
│   ├── Models
│   ├── Requests
│
├── Screens
│   ├── Countries (View + ViewModel)
│   ├── CountryDetails (View + ViewModel)
│
└── Tests
```
## Unit Testing 
The project includes unit tests for: 
* ViewModels

## Author

Ahmed Nasr
