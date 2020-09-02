## TrackmyCovid ![GitHub stars](https://img.shields.io/github/stars/iamabhishek229313/aws_covid_care?style=social)![GitHub forks](https://img.shields.io/github/forks/iamabhishek229313/aws_covid_care?style=social) 

![GitHub pull requests](https://img.shields.io/github/issues-pr/iamabhishek229313/aws_covid_care) ![GitHub last commit](https://img.shields.io/github/last-commit/iamabhishek229313/aws_covid_care)  ![GitHub issues](https://img.shields.io/github/issues-raw/iamabhishek229313/aws_covid_care) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/iamabhishek229313/aws_covid_care)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


# TrackmyCovid

Building this app for AWS Data-Exchange Hackathon.

## 📱 Screenshots
|                                                     Splash Screen                                                      |                                                   Login Page                                                   |
|:----------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------:|
| ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_splash_screen.png?raw=true) | ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_login.png?raw=true) |

|                                          Phone number verification                                           |                                                  Profile Screen                                                  |
|:------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------:|
| ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_otp.png?raw=true) | ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_profile.png?raw=true) |


|                                                    Messages and Feeds                                                     |                                                    In person chat                                                     |
|:-------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------:|
| ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_messagesandfeeds.png?raw=true) | ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_InChatScreen.png?raw=true) |

|                                              Tinder Right Swipe                                               |                                               Tinder Left Swipe                                               |
|:-------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------:|
| ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_nope.png?raw=true) | ![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_like.png?raw=true) |

 Matchings     |
:-------------------------:|
![](https://github.com/iamabhishek229313/tinder_clone/blob/master/screenshots/tinder_clone_main.png)

## ☄ Inspiration 

```
The safest way place to be in this pandemic would be at home but going out is always an inevitable thing whether its for groceries or for other necessities. Going out during this pandemic contributes a risk of getting infected with COVID19. But how much exactly is that risk of going out poses to your health in general? In hindsight of that question, this project aims to give every user a perspective on how much their exposure levels are to COVID 19 based on their daily activity of going out.

```

## ⚛ What it does

```
The app takes your home location and set's it as a safe zone where COVID exposure levels are 0 and the app classifies the data received from the AWS Data Exchange enigma corona tracker it classifies every place in the world as one of 3 zones. Zone 1 is a green zone where COVID cases are light to almost none for example countries with less COVID cases or in general an empty space, Zone 2 is an orange zone where you have orange level exposure where COVID cases are mediocre and finally, Zone 3 which is a red zone which is a heavy COVID population concentration and also includes public spaces. The app classifies which zone you are in and presents a risk-based analysis based on the time you spent outside and based on the zone that the app classifies you in. It tracks how long you spent outside on that zone and when you return back home the app gives you an analysis of all the places you been to and the associated zone and gives a risk estimate on contracting COVID19. It gives you a detailed analysis of your daily activity and your monthly exposure levels to COVID. This gives the user's a visual understanding of contracting COVID and the app also furthermore gives a risk analysis of wearing a mask vs without wearing mask for giving the user a perspective on how their exposure risk changes based on your precautions. Lastly, the app presents a set of precautions that must be taken based on your exposure levels in the time you spent outside. The app also contains a map that wasn't completed to its potential but was intended to give a zone view of your location's radius on different exposure levels at different places.

```

## ⚒ How we built it

```
We built this app using flutter as our frontend for presenting our data visualization and analysis and fast API as our backend to compute our data from AWS and the data generated by the user. We used the AWS data exchange data set enigma corona scraper for analysis on locations and classifying a location to a zone based on population, corona growth rate, and other aspects to classify a location into a zone. Once it classifies an algorithm computes your risk exposure levels based on the time you spent at a zone. We hosted this application on Amazon EC2 instance and our storage in S3 and arangoDB for storing all data from AWS and the user-generated data. Lastly, we used different API's for map generation and news collection. We used a python library geopy to translate coordinates into an address the database understands for zone classification.

```


## 📚 Technical Details
```
Used Amazon-EC2, Amazon-Web-Services
Arango-DB
AWS-Data-Exchnage-Egnima-Dataset
Boto-3
covid19.org
FastApi
Geopy
Matplotlib
newsapi.org
nigix
Numpy
Pandas
Scikit-Learn
Bloc-Pattern
Flutter SDK.
```
## ⚛ Future Releases
```
The next steps for TrackMyCovid are creating a map view of the world with green, orange, and red zones and creating more personalized reports based on COVID exposure and creating more accurate estimates. Furthermore, we plan on developing a map view to push notifications when you enter a new zone the app gives statistics on that zone and furthermore precautions for that exact zone.

```

## ⚒ Pull Request 
I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.


## © License 
```
MIT License

Copyright (c) 2018 Abhishek Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
