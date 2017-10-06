#  buildflow-core

## What is buildflow?
Most of the tools available for iOS Developers are working either in web or on command line.
Designed to be part of a CI server or any other automation process.
In contrast to that, i wanted create some useful tools which:
- Are handy for every iOS App Developer (like me)
- Can work offline *(for most of the tasks)*
- Don't need any subscription fees to buy
- Have a nice interactive UI
- Works on every Mac

So the idea for buildflow was born.
See more at [rogerboesch.com/buildflow]( http://www.rogerboesch.com/buildflow)

Please help making this project reality by support it on kickstarter.com (Campaign starts soon)

## Why this project (why I created buildflow core)?
When I started working on buildflow, there was a need to access and push pack data from Apple's AppStore
to make it working. I have made before some similar things based on fastlane's spaceship and scripting.
But for this project, this was not enough. I need classes and API's (and not scripts) that I can integrate in any macOS
or even iOS App. Something similar like [fastlane spaceship](https://github.com/fastlane/fastlane/tree/master/spaceship#readme), but written entirely in Swift.
Most of the infos I needed to realize that, i have found by using Charles Proxy and inspecting fastlane also.

Im pretty sure, others have also think already on doing something similar and because I was also using a lot of information
from other open source projects, I made this now also open source. I hope many others will like and join to make it fast growing.
Of course you can use buildflow-core also for command line tools and/or server integrations.
It will base on Swift 4, so any platform supports this, can (in theory) use it.
As for now it will not work on Linux because it uses internally URLSession for the network access.
As far as I know, this is still not available on Linux, but can easily be replaced by any 3rd party library IBM and/or Vapor has.
So that's a "side" goal to do also, but not my primary one.


### Important
**The current state of the source was created as part of a PoC/MVP and it's still pretty hacky and not very sophisticated ;).
But it works!. The goal was to see, if it work's that way. I will refactor therefore many thinge internally without breaking the public functions.**

Technical things like:

- Using generic types
- Dynamic mapping
- ICodeable
- Make it more Swifty :)

But also some features are still missing (coming soon):

- Implement mac/ios specifier in `BFCorePortal.swift`
- Implement paging in `BFCorePortal.swift`
- Implement **all** methods in `BFCorePortal.swift`
- Support 2-factor authentication in `BFCoreConnect.swift`
- Unit tests on **all** public functions and properties (very important)
- More environment variables to influence buildflow-core from outside
- And last but not least the (animated) buildflow logo :)


## spaceship
Without spaceship (part of the fastlane tools) and the great work Felix Krause and the community around have already done,
this project would be much more complicated and would need a lot more time to realize. So a BIG THANK for that great work!

Besides the fact that spaceship is by concept a command line tool, I wanted also improve some things in buildflow-core:

- No dependencies on libraries and frameworks
- Better documentation
- Class model
- Make it more understandable for *non ruby geeks* ;)
- Easier to use, debug and extend

