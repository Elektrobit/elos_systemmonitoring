# System Monitoring

Plugins for elos to monitor memory and cpu load of applications including
automatic event handling for overloaded applications.

## Introduction

The plugins should extend the functionality of elos. They should be able to
check memory and cpu usage of different processes/applications in a defined
interval and should automatically perform actions based on user settings.

The plugin who checks the load of applications and creates events is called
**nightwatch** and the event handling is done by **punisher**.

## Configuration

The nightwatch plugin can be configured to set applications for
monitoring, thresholds and test intervals.
The structure of the config file looks as follows:

```yaml
systemmonitoring:
# Overwrites default values if set here
    testinterval: ... # default is 600 needed in miliseconds (optional)
    memthreshold1: ... # default is 1.0 (optional)
    memthreshold2: ... # default is 1.5 (optional)
    memthreshold3: ... # default is 2.0 (optional)
    cputhreshold1: ... # default is 1.0 (optional)
    cputhreshold2: ... # default is 1.5 (optional)
    cputhreshold3: ... # default is 2.0 (optional)
    monitoring:
        monitoringname1:
            testinterval: ... # default is 600 needed in miliseconds (optional)
            memthreshold1: ... # default is 1.0 (optional)
            memthreshold2: ... # default is 1.5 (optional)
            memthreshold3: ... # default is 2.0 (optional)
            cputhreshold1: ... # default is 1.0 (optional)
            cputhreshold2: ... # default is 1.5 (optional)
            cputhreshold3: ... # default is 2.0 (optional)
            applications:
                appname1:
                    maxmemusage: ... # needed in KB
                    maxcpuload: ... # needed in %
                    memthreshold1: ... # default is 1.0 (optional)
                    memthreshold2: ... # default is 1.5 (optional)
                    memthreshold3: ... # default is 2.0 (optional)
                    cputhreshold1: ... # default is 1.0 (optional)
                    cputhreshold2: ... # default is 1.5 (optional)
                    cputhreshold3: ... # default is 2.0 (optional)
                appname2:
                    ...

        monitoringname2:
            ...
```

The plugins use the message code 3024, to use it add to the elos event message codes
usr/local/include/elos/event/event_message_codes.h:

```c
ELOS_MSG_CODE_RESOURCE_OVERLOAD = 3024,
```

To run the nightwatch plugin with elos add in the elosd configuration
under root/elos/Scanner/Plugins:

```json
"Nightwatch": {
    "File": "scanner_nightwatch.so",
    "Run": "always"
}
```

To run the punisher plugin with elos add in the elosd configuration
under root/elos/ClientInputs/Plugins:

```json
"Punisher": {
    "File": "client_punisher.so",
    "Run": "always"
}
```

## Building all the plugins

### Using cmake and make

Make sure to build [elos](https://elektrobit.github.io/elos/doc/userManual.html#elosd-installation-setup) before building the plugin.

Install dependencies:

- libelos
- libelosplugin
- [safu](https://github.com/Elektrobit/safu)
- [samconf](https://github.com/Elektrobit/samconf)
- yaml-cpp
- libgtest

```bash
cmake -B build .
make -C build install
```

## Building one plugin

The plugins can be build individually.
To do this change to the respective folder and follow the instructions.
