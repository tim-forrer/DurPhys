# DurPhys App Structure
I've tried to organise this app as clearly as possible, but what's clear for one person may not be clear for others.

So I've decided to try and include documentation for all aspects of this app so that others who come to work on this app might be able to more quickly understand what's going on.

To that end, this document quickly details how the app is setup, and where you should expect to find certain files or functions.

## Folders:
#### Custom:
This contains any custom table/collection view cells, buttons, classes or structs. Basically anything I've customised that is **not** a view controller. The exception to this is Utils.swift which is a file I've used to store all my extensions to default classes and structs (UIStoryboard, Dictionary etc.) and any global variables.

#### Storyboards:
Fairly self expanatory, contains all the storyboard files.

#### ViewControllers:
Contains all my custom view controller files.

## Files:
#### AppDelegate.swift:
Standard iOS file required for apps.

#### Assets.xcassets:
Contains all the images used in the app.

#### Info.plist:
Another standard file required for apps.
