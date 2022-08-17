const winston = require('winston');


module.exports = function() {
  winston.handleExceptions(
    new winston.transports.File({ filename: 'uncaughtExceptions.log' }));
  
  process.on('unhandledRejection', (ex) => {
    console.log(ex)
  });
  process.on('uncaughtException', (ex) => {
    console.log(ex)
 });

  winston.add(winston.transports.File, { filename: 'logfile.log' });
 
}