# DurPhys

## An iOS mobile application designed for first year physics students at Durham University

Based off the [Android sister app](https://github.com/Bacoknight/DurPhys) created by [Kay Tukendorf](https://github.com/Bacoknight).

This app is designed to work with iPhone 5S and above. iPads are not actively supported but the app should still be mostly functional on them.

### Current Progress:
- [x] Set up of underlying app structure.
- [x] Design of main menu.
- [x] Navigation Drawer
- [x] Design Teaching Formats pages.
- [x] Scrape the physics staff page for Important Contacts (may want to add preferred email once username and passwords are setup).
- [x] App login using https://timetable.dur.ac.uk to verify credentials.
- [x] Setup keychain for storing user credentials
  
### Still to do:
- [ ] JS Injection of aforementioned credientials into PSP, Email and DUO pages.
- [ ] Scrape appropriate module information for use in Course Information.
- [ ] Set up mapbox (or similarly appropriate API).

### Dependancies:

Thanks to the following people for their libraries which have been implemented in this project:
* [Marcos Griselli](https://github.com/marcosgriselli) for his [Swipeable Tab Bar Controller.](https://github.com/marcosgriselli/SwipeableTabBarController)
* [Mapbox](https://www.mapbox.com/) for their [Mapbox SDK for iOS.](https://www.mapbox.com/install/ios/)
* [Scinfu](https://github.com/scinfu) for [SwiftSoup.](https://github.com/scinfu/SwiftSoup)
* [Evgenyu](https://github.com/evgenyneu) for [Keychain-Swift.](https://github.com/evgenyneu/keychain-swift)
