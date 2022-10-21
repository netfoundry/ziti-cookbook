# Simple Sidecar Solution
## _The fastest way to secure your API with OpenZiti_

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://netfoundry.io/)

![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)

## Meal Prep Time!

Here are all the ingredients you'll need to cook this meal. And don't worry, we'll explain the last 2. They're free!

- Cook Time: 1 hour
- Ingredients
  - This Repo!
  - AWS Account and CLI Access
  - Terraform >=1.0.1
  - GNU Make
  - Any Dockerized API (sample flask API included)
  - NetFoundry Teams Account (Free Tier!)
  - Ziti Desktop Edge 
---
## Prep Your Kitchen
In order to do this demo, you will need an AWS account and permissions to create resources in that account via Terraform. You will also need a version of Terraform >=1.0.1. We suggest the latest version, as of the time of this tutorial we are using 1.3.2 https://www.terraform.io/downloads. You'll also need to ensure you have Make.

Let's run 3 quick commands to ensure we have everything we need installed:
```
> aws --version
aws-cli/2.7.31 Python/3.10.6 Darwin/21.6.0 source/x86_64 prompt/off
> aws sts get-caller-identity
{
    "UserId": "AIDAXXXXXXXXXXXX",
    "Account": "012345678910",
    "Arn": "arn:aws:iam::012345678910:user/ziti.chef"
}

> Terraform --version
Terraform v1.3.2

> make --version
GNU Make 3.81
```

Once you're sure you have proper permissions in AWS and you have a compatible version of Terraform and Make installed, go ahead and clone this repo.

You will also need a "Hello World" API that can be deployed to AWS Fargate. We suggest that you start with the default image included in [variable.tf](terraform/variables.tf), but once that's working, feel free to replace it with whatever flavor of API you like!

---

## Create a NetFoundry Teams (Free Tier) Account
In order to start this recipe, you'll need to create a Teams account at [NetFoundry Teams](https://netfoundry.io/pricing/)

---
## Create Your First Identity

Once you've created an account at NetFoundry.io, you'll need to create a [Ziti Endpoint](###Endpoints). To do this, navigate to **Endpoints** in the navigation pannel to the left and click '+' to create a new endpoint. Let's name this endpoint "dark_api_endpoint" and assign it the [Attribute](###Attributes) "demo_attribute". This will be the [Ziti Identity](###Identities) for the API you deploy to AWS during this recipe. Select **DOWNLOAD KEY** and save the one-time use JWT token to the folder **identity_token_goes_here**

-----

## NetFoundry Terminology
### Endpoints

Endpoints are light-weight agents that are installed on your devices or in an APP as a SDK. Endpoints are enrolled to the NetFoundry network using the registration process via one-time use secure JWT. 

See more [here](https://support.netfoundry.io/hc/en-us/sections/360002445391-Endpoints) to learn more about endpoints in NetFoundry and how to create & install endpoints.

### Identities

Attributes are applied to Endpoints, Services, and Edge Routers. These are tags that are used for identifying a group or a single endpoint / service / edge router. Attributes are used while creating APPWANs. The @ symbol is used to tag Individual endpoints / services / edge routers and # symbol is used to tag a group of endpoints / services / edge routers.

[Learn more](https://support.netfoundry.io/hc/en-us/articles/360045933651-Role-Attributes) on how attributes simplify policy management in NetFoundry.


### NetFoundry Teams (Free Tier)

NetFoundry has created a Teams tier that is free up to 10 nodes. All examples that include this in their ingredients can be done with less than 10 nodes and can be done for free!
