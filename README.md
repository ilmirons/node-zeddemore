Churchill
=========

A file-conf wrapper around Winston

### Motivation

I'm used to handle configuration of logging with text file, but could not find a way to do it with Winston: so I wrote this module.

### How does it works

At startup the module reads the specified file in the main directory of the project, reads it (synchromously, as this should happen only on startup and we want everything setup before running anything else) and instantiate winston loggers according to configuration. Loggers can then be retrieved with `churchill.get('<loggerName>')`


### Configuration Example


        {
	"levels": {
                "foo": 0,
                "bar": 1,
                "baz": 2,
                "foobar": 3
           },
           "colors: {
                "foo": "blue",
                "bar": "green",
                "baz": "yellow",
                "foobar": "red"
           },
	"loggers": {
                "myLogger": {
                     "transports": {
                          "File": {
                               "filename": "somefile.log",
                               "level": "foobar",
                               "label": "foo"
                          },
                          "console": {
                               "colorize": true
                          }
                      }],
	          "exitOnError": false
                     "handleExceptions": true
                 }
	}
        }

### Usage example

        var logMgr   = require('churchill')('logging.conf');
        var myLogger = logMgr.get('myLogger');
        
        myLogger.foo("Can you see the fnord?");

