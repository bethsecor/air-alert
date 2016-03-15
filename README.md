### Air Alert

This application is extremely important for people who are sensitive to air pollution or care about the environment and want to know ways to reduce their impact on air pollution. Rather than having to manually check the air quality, this app will notify someone by text when the air quality is a certain level. A user can customize the alerts they get, and can also add alerts to remind them when they need to change indoor air filters. They can also tweet the air quality for any location. They can also look up recent legislation signed that is related to air quality for a specified US state.

![air alert screencast](http://g.recordit.co/xRsLVuYdge.gif)

[http://air-alert.herokuapp.com/](http://air-alert.herokuapp.com/)

##### Alerts

Air quality alerts:

![text alerts](https://cloud.githubusercontent.com/assets/11467561/13793969/316598e4-eabf-11e5-99a3-d59fa1801c89.png)

##### Target Audience

* People who are sensitive to air pollution (outdoor and indoor).
* Caregivers of children and seniors who want to know when it is not a good idea for their loved one to go outside.
* The general population who cares about the environment and wants to know information on ways to protect their health and reduce air pollution.

##### API Integrations

* [Breezometer API](https://breezometer.com/api/)
* [Twilio](https://www.twilio.com/)
* [Sunlight Foundation Open States API](http://sunlightlabs.github.io/openstates-api/)
* [Twitter](https://dev.twitter.com/rest/public)

##### OAuth

* [Twitter](https://dev.twitter.com/oauth/overview/introduction)

##### Content Sources

* [US Environmental Protection Agency](https://www.epa.gov/learn-issues/learn-about-air)
* [Colorado Department of Public Health and Environment](http://www.colorado.gov/airquality/default.aspx)

##### Challenges

One challenge that arose with this project was working with the Breezometer API. When querying for a specific location, sometimes it would be unable to find the location at first, and then it would return air quality data on the second try a few seconds later. I had to rescue the app from those types of errors.

A call to the Breezometer API takes on average 1.5 seconds, so I decided to cache those calls every 15 minutes to improve the performance of the app.

Another challenge was that the Twilio Lookup API (to validate phone numbers) is not supported with Twilio test credentials, so I could not test that.
