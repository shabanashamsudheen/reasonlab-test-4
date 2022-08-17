const express = require('express');
const app = express();
var bodyParser = require('body-parser');
const winston = require('winston');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
require('dotenv').config();
require('./shared/logging');

//Route Mappings
const apiController= require('./controller/controller');
app.use('/api', apiController);

const port = process.env.PORT || 2023;
app.listen(port, () => winston.info(`Listening on port ${port}...`));
