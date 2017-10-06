#  BFCoreConnect

## Purpose
Lists and descreibes all the calls implemented in *BFCoreConnect*.
The list is almost complete, but some details might nmot be correct at that point.
Also i will describe the functions in more detail, step by step.

### Introduction
Lists all functions and properties implemented in *BFCoreConnect*.

#### Public functions and properties

Function: `login(user, pwd)`
API: `https://idmsa.apple.com/appleauth/auth/signin`


#### Internal functions
*Don't use them directly*

Function: `getSessionKey()`
API: `https://olympus.itunes.apple.com/v1/app/config?hostname=itunesconnect.apple.com`

Function: `getOlympusSession()`
API: `https://olympus.itunes.apple.com/v1/session`

Function: `selectTeam(id: String)`
API: `http://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/v1/session/webSession`

Function: `getUserDetails()`
API: `http://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/user/detail`

