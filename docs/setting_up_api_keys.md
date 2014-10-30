# Setting up your API Keys
We have a lot of development keys that you need to set.

Currently we use:
* GitHub (for authentication)
* Google Calendar (for setting up our meetings)

## GitHub
Please go to [https://github.com/settings/applications/new](https://github.com/settings/applications/new)
and setup your application like this.

![GitHub Application Setup](http://f.cl.ly/items/1O1x100I2q1m1t3N4641/Screen%20Shot%202014-10-27%20at%203.09.04%20PM.png)

Then copy the `Client ID` and the `Client Secret` and paste them into `config/secrets.yml` next to `github_client_id` and `github_client_secret` respectively.
![config/secrets.yml](http://cl.ly/image/2u0j0V1w3K2M/Screen%20Shot%202014-10-27%20at%203.46.00%20PM.png)

## Google Calendar
