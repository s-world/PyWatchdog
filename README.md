# PyWatchdogdog

## Description

PyWatchdog is a watchdog (monitoring) application. It tests if an application is
working fine and if not it starts/restarts the application.
Currently it can detect if a application is running by looking for a process
id and it can additionally test if it is reachable by calling a specific URL
and waiting for a HTTP status 200. There is also an optional timeout to test
if the application answers the request within a given time range.
If one of the conditions fails PyWatchdog will start/restart the application.

## Pre-Requirements

Most of PyWatchdog's requirements should already be met by a standard Linux
system. The only thing need to be installed should be the python psutil
module.

* Python 2.7 or higher
  (Python 3.x is not yet supported but will be coming soon)
* psutil > 0.4.1 (http://code.google.com/p/psutil/)
  if you are running a recent Debian/Ubuntu distro you can type
  "apt-get install python-psutil"


## Install

To install PyWatchdog start the install.sh script as root.

## Uninstall

To uninstall PyWatchdog start the uninstall.sh script as root.

## Configuration

Your configuration file must contain valid json. To test your json you can use
http://jsonlint.com/. If you don't want to use this webservice you can also
try to start PyWatchdog. You will get detailed error messages if the configuration
is wrong.

Here is an example config

    {
        "settings": {
            "mail_sender": "root",
            "mail_receiver": "your.mail@example.com"
        },
        "apps": {
            "appOne": {
                "ps_identfier": "app-two",
                "start_script": "/etc/init.d/app-two start"
                "url": "http://app-two.com",
                "timeout": 10
            },
        }
    }

The settings fields are mandatory.
* "mail_sender" should be a sender address that is accepted by your SMTP server
  as a valid sender address that does not need authentication to send mails.
* "mail_receiver" is the mail address that should get status mails if something
  went wrong.

The app part is necessary.
Inside the "apps" part you can define one or multiple applications to monitor.
The name of the application ("appOne" in the example above) must be unique
and should tell you something about the application because you will see this
name in mails if the application failed.
"ps_identifier" and "start_script" are mandatory, "url" and "timeout" are
optional.
* "ps_identifier" is a part of the command line arguments that uniquely
  identifies a process. For example a argument that the one you would hand over
  to a "pgrep -f" call (confluence for confluence applications). It is ok if an
  app consists of multiple processes. All processes will be terminated by
  PyWatchdog.
* "start_script" is the command (with full qualified path) that can start the
  application.
* "url" is the url to test for a successful 200 response.
* "timeout" is the timeout in seconds after which the site is handled as down.
  The default timeout is 30 seconds.

## Running

You can call PyWatchdog with an additional config parameter to specify an alternative config file

    pywatchdog --config PATH_TO_YOUR_CONFIG

We recommend running pywatchdog as a cronjob. For example

    */4 * * * * /usr/local/sbin/pywatchdog

to run it every 4 minutes.


To deactivate PyWatchdog create a directory called "wd.lock" under /tmp/

    deactivate - mkdir /tmp/wd.lock
    activate - rmdir /tmp/wd.lock


## Help and Bug Reporting

If you need support or want to report a bug please write a short mail to
info@s-world.info.