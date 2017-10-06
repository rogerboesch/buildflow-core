#  BFCorePortal

## Purpose
Lists and descreibes all the calls implemented in *BFCorePortal*.
The list is almost complete, but some details might nmot be correct at that point.
Also i will describe the functions in more detail, step by step.


### Introduction
Lists all functions and properties implemented in *BFCorePortal*.

#### Public functions and properties

##### Apps
---
Property: `apps`
API: `account/[ios,mac]/identifiers/listAppIds.action`
Parameters: `teamId, pageNumber, pageSize: page_size, sort: 'name=asc'`
Uses JSON: *no*

Property: `apps.app`
API: `account/[ios,mac]/identifiers/getAppIdDetail.action`
Parameters: `teamId, appIdId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/identifiers/assignApplicationGroupToAppId.action`
Parameters: `teamId, appIdId, displayId, applicationGroups`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/assignOMCToAppId.action`
Parameters: `teamId: team_id, appIdId: app.app_id, omcIds`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/addAppId.action`
Parameters: *none*
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/deleteAppId.action`
Parameters: `teamId: team_id, appIdId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/updateAppIdName.action`
Parameters: `teamId: team_id, appIdId, name`
Uses JSON: *no*


##### Passbook
---
Function/Property: *not implemented*
API: `account/ios/identifiers/listPassTypeIds.action`
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc'`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/identifiers/addPassTypeId.action`
Parameters: `name, identifier, teamId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/identifiers/deletePassTypeId.action`
Parameters: `teamId, passTypeId`
Uses JSON: *no*


##### Website Push
---
Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/listWebsitePushIds.action `
Parameters:  `teamId, pageNumber, pageSize, sort: 'name=asc' `
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/addWebsitePushId.action `
Parameters: `name, identifier, teamId `
Uses JSON: *no*

API: `account/[ios,mac]/identifiers/deleteWebsitePushId.action `
Parameters: `teamId, websitePushId `
Function/Property: *not implemented*
Uses JSON: *no*


##### Merchant
---
Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/listOMCs.action `
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc' `
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/addOMC.action `
Parameters: `name: name, identifier: bundle_id, teamId: team_id `
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/identifiers/deleteOMC.action `
Parameters: `teamId: team_id, omcId: merchant_id `
Uses JSON: *no*


##### App Groups
---
Function/Property: *not implemented*
API: `account/ios/identifiers/listApplicationGroups.action`
Parameters: teamId, pageNumber, pageSize, sort: 'name=asc'`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/identifiers/addApplicationGroup.action`
Parameters: `name, identifier, teamId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/identifiers/deleteApplicationGroup.action`
Parameters: `teamId, applicationGroup`
Uses JSON: *no*


##### Team
---
Property: `teams.team`
API: `account/listTeams.action`
Parameters: `teamId: team_id`
Uses JSON: *no*

Function: `selectTeam(_ team: BFCoreTeam)`
API: *See BFCorePortal.selectTeam()*
Parameters: `team`

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/getTeamMembers`
Parameters: `teamId: team_id`
Uses JSON: *yes*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/getInvites`
Parameters: `teamId`
Uses JSON: *yes*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/setTeamMemberRoles`
Parameters: `teamId, role, teamMemberIds`
Uses JSON: *yes*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/removeTeamMembers`
Parameters: `teamId, teamMemberIds`
Uses JSON: *yes*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/sendInvites`
Parameters: `invites: [recipientEmail, recipientRole], teamId`
Uses JSON: *yes*


## Devices
---
Function/Property: *not implemented*
API: `account/[ios,mac]/device/listDevices.action`
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc', includeRemovedDevices: include_disabled
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/ios/device/listDevices.action`
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc', deviceClasses, includeRemovedDevices: include_disabled
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/device/addDevices.action`
Parameters: `teamId, deviceClasses, deviceNumbers: device_id, deviceNames, register: 'single'
Uses JSON: *no*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/#{platform_slug(mac)}/device/deleteDevice.action`
Parameters: `teamId, deviceId
Uses JSON: *no*

Function/Property: *not implemented*
API: `services-account/[protocol_version]/account/#{platform_slug(mac)}/device/enableDevice.action`
Parameters: `teamId, displayId, deviceNumber
Uses JSON: *no*


##### Certificates
---
Function/Property: *not implemented*
API: `account/[ios,mac]/certificate/listCertRequests.action`
Parameters: `teamId, types, pageNumber, pageSize, sort: 'certRequestStatusCode=asc'
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/certificate/submitCertificateRequest.action`
Parameters: `teamId, type, csrContent, appIdId
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/certificate/downloadCertificateContent.action`
Parameters: `teamId, certificateId, type
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/certificate/revokeCertificate.action`
Parameters: `teamId, certificateId, type
Uses JSON: *no*


##### Provisioning Profiles
---
Function/Property: *not implemented*
API: `account/[ios,mac]/profile/listProvisioningProfiles.action`
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc', includeInactiveProfiles: true, onlyCountLists: true`
Uses JSON: *no*

Function/Property: *not implemented*
API: `developerservices2.apple.com/services/[protocol_version]/[ios,mac]/listProvisioningProfiles.action`
Parameters: `teamId, includeInactiveProfiles: true, onlyCountLists: true`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/getProvisioningProfile.action`
Parameters: `teamId, provisioningProfileId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/createProvisioningProfile.action`
Parameters: `*none*
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/downloadProfileContent`
Parameters: `teamId, provisioningProfileId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/deleteProvisioningProfile.action`
Parameters: `teamId, provisioningProfileId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/regenProvisioningProfile.action`
Parameters: `*none*
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/[ios,mac]/profile/listProvisioningProfiles.action`
Parameters: `teamId,pageNumber,pageSize, sort: 'name=asc'`
Uses JSON: *no*


##### Keys
---
Function/Property: *not implemented*
API: `account/auth/key/list`
Parameters: `teamId, pageNumber, pageSize, sort: 'name=asc'`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/auth/key/get`
Parameters: `teamId, keyId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/auth/key/download`
Parameters: `teamId, keyId`
Uses JSON: *no*

Function/Property: *not implemented*
API: `account/auth/key/create`
Parameters: *none*
Uses JSON: *yes*

Function/Property: *not implemented*
API: `account/auth/key/revoke`
Parameters: `teamId, keyId`
Uses JSON: *no*
