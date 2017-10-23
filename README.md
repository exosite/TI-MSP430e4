# TI-MSP432e4 Development Kit Application
This repository holds the Exosite assets and code that setup the development kit experience on Exosite's Murano platform. This code can be cloned and deployed on its own or added to your Murano account through [Exosite Exchange](https://www.exosite.io/business/exchange/catalog#/?_k=dnrhld).

## Repository Contents

* Specification of the SimpleLink development kit represented as a Murano Product.
* A modified [Freeboard](https://freeboard.io) application put into a Murano Application configuration.

The source code for the application running on your SimpleLink device can be found here: {Link}

## Requirements

* TI SimpleLink development kit {link to the dev kit on TI's site}
* [MuranoCLI](https://github.com/exosite/muranocli)
* An account on [exosite.io](https://exosite.io)

## Steps to setup with Exosite's Exchange.

* Go to the [Exchange tab](https://www.exosite.io/business/exchange/catalog#/?_k=dnrhld) of your Exosite account.
* Click on the TI SimpleLink Dashboard Exchange card, and add this application to your Business.
* Create a new Murano Application Solution and choose this application in the drop-down menu.

## Steps to setup outside of Exosite Exchange.

* Clone this repository ```git clone https://github.com/exosite/TI-SimpleLink``` using git. 
* Initialize the repository in order to prepare it for deployment to Murano with the [MuranoCLI tool](https://github.com/exosite/muranocli)```murano init```
* Create a new blank Murano Solution Application. 
* Push this code to your Murano Application Soution with ```murano syncup```

## Where can I get help?

* [Exosite's community forum](https://community.exosite.com)
* [TI's engineer to engineer forum](https://e2e.ti.com/)

If you have questions or just plain need help, take a look at our [community forum](https://community.exosite.com)