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
- [ ] Localization
- [ ] Thumbnail images
- [x] Unit tests
- [ ] UI tests

## Architecture:
![app_architecture](/app_architecture.png)

## Room for improvement:

* We can promote a more user friendly app experience by queuing up state change events and handling them with a delay between each event to prevent jarring state changes while loading data in good network conditions. The tools Combine provides out of the box for controlling timing (debounce and throttle) do not help us accomplish this. This stackoverflow post details a potential way to reach our goals: https://stackoverflow.com/a/76590605
* Allow users to cancel requests
* Bump code coverage to 80%
