# coding-challenge

## What we are looking for

- Coding style / readability
- Understanding of the chosen language
- Understanding of the chosen platform / framework
- Solution design
- Code maintainablity, including testing
- Use of version control (preferably git)
- Any other techniques which would contribute to supportability of your code

## The Challenges

## List Display
In this assignment you will be using JSON feed to read lotteries Jurisdictions/Companies and display them in a table like shown below.

Use the following as an example, but don't be constrained by our design or implementation choice.  The example below was taken from our IOS app, use the appropriate design idiom of your chosen plaform.

![Sample List](images/ios.png)

## Requirements (IOS)

- Swift 3.x with Xcode 8
- Screen uses MVVM pattern for unit testability and object oriented design
- Demonstrated Unit tests, testing ViewModel
- Isolate/Override network API invocation for Unit Tests

### Bonus Points

- Example of reactive programming (eg. View-ViewModel binding)
- You are free to use 3rd party libraries for Networking or Reactive (e.g. RxSwift)

## API endpoint details

## Jurisdictions List

GET Request:
`https://api.thelott.com/svc/sales/vmax/web/data/lotto/companies`

Sample Response:

```
{
"Companies": [
{
"CompanyId": "GoldenCasket",
"CompanyDisplayName": "Golden Casket",
"CompanyDescription": "QLD Residents",
"CompanyLogoUrl": "http://media.tatts.com/TattsServices/Lotto/Companies/GoldenCasket_v1.png"
},
{
"CompanyId": "NSWLotteries",
"CompanyDisplayName": "NSW Lotteries",
"CompanyDescription": "NSW, ACT Residents",
"CompanyLogoUrl": "http://media.tatts.com/TattsServices/Lotto/Companies/NSWLotteries_v1.png"
},
{
"CompanyId": "NTLotteries",
"CompanyDisplayName": "NT Lotteries",
"CompanyDescription": "NT, International Residents",
"CompanyLogoUrl": "http://media.tatts.com/TattsServices/Lotto/Companies/Tatts_v1.png"
},
{
"CompanyId": "SALotteries",
"CompanyDisplayName": "SA Lotteries",
"CompanyDescription": "SA Residents",
"CompanyLogoUrl": "http://media.tatts.com/TattsServices/Lotto/Companies/SALotteries_v1.png"
},
{
"CompanyId": "Tattersalls",
"CompanyDisplayName": "Tattersall's",
"CompanyDescription": "VIC, TAS Residents",
"CompanyLogoUrl": "http://media.tatts.com/TattsServices/Lotto/Companies/Tatts_v1.png"
}
],
"ErrorInfo": null,
"Success": true
}
```
