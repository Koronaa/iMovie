# iMovie

Movie browser app written in Swift 5.

### Supports

iOS 14.1+


### Pods Used

YTS-Mobile uses number of open source dependencies for its magic 

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [BRYXBanner](https://github.com/bryx-inc/BRYXBanner)
* [SkeletonView](https://github.com/Juanpe/SkeletonView)
* [Kingfisher](https://github.com/onevcat/Kingfisher)


### Installation Guide:

Do a `pod install` and you'll be good to go.


### Q&A:

###### Describe how you would design the implementation of a user login to the app including what kind of backend APIs you would require if any.

- There'll be a sign-up flow (Which can integrate auth services such as Firebase) and end of the sign-up flow app asks user to enter card details / sign in with services such as paypal,  (User can skip this as well) and instead of storing all the card info on the device itself we can send the info by a payload encryption enabled webservice to the backend and get a token which is tied with the payment info as well as the unique id of that perticular user. 
- Use of Local Authentication API before navigating user to the payment related functioanalities would be an added advantage

###### If the API to purchase the movie tickets responds asynchronously, what are possible options to get the movie tickets to the app and what would be your choice among them?

- After user logs in 
- Once user navigates to that perticular view

Getting the movie info right after user logs into the app would give better UX

###### Describe how you would achieve maintenance and security aspects of the app.

Security: 
- Relevant services will include payload encryption
- Code will be obfuscated before building for PROD

Maintanability:

- By adding unit testing 
- By adding best practises such as SOLID
- By configuring CI/CD pipeline 

###### What are the approaches we can implement to get marketing information about movie tickets (discounts, etc.) to the app users? 

- Promotions via Push Notifications
- Social media integrations (For features such as inviting friends for movies, sharing purchased movie info)








