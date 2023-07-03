# FetchRewards-Interview

## TODO

- [x] Integrate Bitrise for CI
- [x] Create Codable models
- [x] Setup Coordinator
- [x] Keep dependency injection in mind
- [x] Implement networking layer
- [x] Implement repository layer
- [x] Refresh functionality
- [ ] Localization

## Architecture:
![app_architecture](/app_architecture.png)

## Room for improvement:

* We can promote a more user friendly app experience by queuing up state change events and handling them with a delay between each event to prevent jarring state changes while loading data in good network conditions. The tools Combine provides out of the box for controlling timing (debounce and throttle) do not help us accomplish this. This stackoverflow post details a potential way to reach our goals: https://stackoverflow.com/a/76590605
