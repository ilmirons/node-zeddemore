// Generated by CoffeeScript 1.6.3
(function() {
  var fs, w, _,
    _this = this;

  _ = require('underscore');

  w = require('winston');

  fs = require('fs');

  module.exports = function(configFile) {
    var config, initLogger;
    config = JSON.parse(fs.readFileSync(configFile));
    module.exports.getConfig = function() {
      return config;
    };
    initLogger = function(logConf, loggerName) {
      var logger;
      logger = w.loggers.add(loggerName, logConf.transports);
      if ('levels' in logConf) {
        logger.setLevels(logConf.levels);
      }
      if ('exitOnError' in logConf) {
        return logger.exitOnError = logConf.exitOnError;
      }
    };
    if ('colors' in config) {
      w.addColors(config.colors);
    }
    if (_.isObject(config.loggers) && !_.isEmpty(config.loggers)) {
      _.each(config.loggers, initLogger);
    } else {
      throw new Error("No loggers found for configuration at " + configFile);
    }
    module.exports.get = function(loggerName) {
      return w.loggers.get(loggerName);
    };
    return module.exports;
  };

}).call(this);