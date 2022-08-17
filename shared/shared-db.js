const mysql = require('mysql');

const pool = mysql.createPool({
  supportBigNumbers: true,
  bigNumberStrings: true,
  connectionLimit: 50,
  connectTimeout: 60 * 60 * 1000,
  acquireTimeout: 60 * 60 * 1000,
  waitForConnections: true,
  port: 3306,
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE
});
console.log(process.env)
function executeQuerySelect(sql, params = [], callback = null) {

  pool.getConnection(function (err, connection) {
    if (err) {
      console.log(err);
      if (callback) return callback(err, results);
      return;
    }
    let query = connection.query(sql, params, function (err, results) {
      //connection.release();
      if (err) {
        console.log(err);
        if (callback) return callback(err, results);
        return;
      }
      
      return callback(err, results);
    });
    // console.log(query.sql);
    connection.release();
  });
};

function executeQueryInsert(sql, params = [], callback = null) {
  pool.getConnection(function (err, connection) {
    if (err) {
      console.log(err);
      if (callback) return callback(err, results);
      return;
    }
    let query = connection.query(sql, [params], function (err, results) {
      connection.release();
      if (err) {
        console.log(err);
        if (callback) return callback(err, results);
        return;
      }
    //   console.log(query.sql);
      return callback(err, results);
    });
  });
};

function executeQueryUpdate(sql, params, callback = null) {
  pool.getConnection(function (err, connection) {
    if (err) {
      console.log(err);
      if (callback) return callback(err, results);
      return;
    }
    let query = connection.query(sql, params, function (err, results) {
      connection.release();
      if (err) {
        console.log(err);
        if (callback) return callback(err, results);
        return;
      }
    //   console.log(query.sql);
      return callback(err, results);
    });
  });
};
exports.executeQuerySelect = executeQuerySelect;
exports.executeQueryInsert = executeQueryInsert;
exports.executeQueryUpdate = executeQueryUpdate;