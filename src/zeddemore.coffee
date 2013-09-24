_  = require 'underscore'
w  = require 'winston'
fs = require 'fs'


module.exports = (configFile) =>

    config  = JSON.parse fs.readFileSync configFile
    
    module.exports.getConfig = => config

    initLogger = (logConf, loggerName) =>
        logger = w.loggers.add(loggerName, logConf.transports)
        logger.setLevels logConf.levels if 'levels' of logConf
        logger.exitOnError = logConf.exitOnError if 'exitOnError' of logConf

    w.addColors config.colors if 'colors' of config
    
    if _.isObject(config.loggers) and not _.isEmpty config.loggers
        _.each(config.loggers, initLogger)
    else
        throw new Error "No loggers found for configuration at #{configFile}"

    # wrapping for keeping cntxt
    module.exports.get = (loggerName) => w.loggers.get loggerName

    module.exports