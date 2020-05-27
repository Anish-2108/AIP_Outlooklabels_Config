#Login to Security and compliance via Powershell

$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

#Get Label Settings
(Get-LabelPolicy -Identity "Public_Policy").settings

#Get Label Information
Get-Label |FT -Property Displayname, Name, GUID

#Set Label Policies

Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookRecommendationEnabled="True"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{EnableContainerSupport="True"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookDefaultLabel="Public_Doc"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{PFileSupportedExtensions=""}

#Remove "Not now" for documents when you use mandatory labeling

Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{PostponeMandatoryBeforeSave="False"}

#Settings to block/Warn/Justiy Trusted Domains

Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookTrustedDomains="micorosoft.com"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookJustifyTrustDomains="micorosoft.com"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookBlockTrustedDomains="micorosoft.com"}


#Advance Outlook Settings to block/Warn/Justiy collaborations with untrusted domains

Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookJustifyUntrustedCollaborationLabel="6cb4c91a-3e9c-4231-850a-87d81d9a5dfc"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookWarnUntrustedCollaborationLabel="6febcefd-60c1-4bb4-9fc0-34c90288f525"}
Set-LabelPolicy -Identity Public_Policy -AdvancedSettings @{OutlookBlockUntrustedCollaborationLabel="2add1fea-a3c0-4e86-96d7-e5a5f0fc317c"}