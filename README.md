# FetchRewards-Interview

[![Build Status](https://app.bitrise.io/app/0548c39f-ab19-4912-a213-9baa647312b7/status.svg?token=xmeiF9x02Ak3ZpcaA5FO5Q&branch=master)](https://app.bitrise.io/app/0548c39f-ab19-4912-a213-9baa647312b7)

## TODO

- [x] Integrate Bitrise for CI
- [x] Create Codable models
- [x] Setup Coordinator
- [x] Keep dependency injection in mind
- [x] Implement networking layer
- [x] Implement repository layer
- [x] Refresh functionality
- [x] Localization
- [ ] Thumbnail images
- [x] Unit tests
- [ ] UI tests

## Architecture
![app_architecture](/app_architecture.png)

## Room for improvement

* We can promote a more user friendly app experience by queuing up state change events and handling them with a delay between each event to prevent jarring state changes while loading data in good network conditions. The tools Combine provides out of the box for controlling timing (debounce and throttle) do not help us accomplish this. This stackoverflow post details a potential way to reach our goals: https://stackoverflow.com/a/76590605
* Allow users to cancel requests
* Bump code coverage to 80%
* For the thumbnail images we can download the data per usual in our repository and utilize an NSCache object to cache the images
* Break the UI up into reusable components
* The names of the properties in the model can be refactored so they're a bit nicer on the client side. From the API I would prefer if the model returned an array of "ingredients" instead of having separate properties for each name and value.

## Assumptions
* We needed to handle more than just the happy path. A good application is not only defined by how well it performs when everything is going well, but also how well it performs when handling error states. Also consider what avenues for recovery from are available to the user. Following this line of thought I handled the loading UI state as well as offline and generic error states. 
* We need to support the latest two version of iOS (15 and up)


## Tidbits

* I have a personal preference to explicitly declare types as I find it easier to read code when the types are readily visible.
* I focused more on the architecture than the UI. I wanted to make sure everything was decoupled and readily testable as I learned that's one of the most important things that can instill confidence when releasing changes.
* At the time of submission we're sitting at 60% code coverage
* Pull to refresh is implemented
* The loading screen is reusable
* There is a state on the meal list screen for an empty data set
* There is a state on the meal list screen for displaying an alert in the case of some error (bad json, offline, unable to reach server, the list goes on...)

