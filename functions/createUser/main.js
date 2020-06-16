const { Request } = require("tedious");
const { createConnection } = require('../utils/createConnection')
const { buildCreateQuery } = require('../utils/queryBuilder')

const createUser = async function(context, req) {
  context.log("Creating New User");
  const connection = createConnection();
  const user = {
    id: '123',
    firstName: 'Test',
    lastName: 'Name'
  }
  const query = buildCreateQuery(user, 'users')
  const request = new Request(query,
    (err, rowCount) => {
      if (err) {
        console.error(err.message);
      } else {
        console.log(`${rowCount} row(s) returned`);
      }
    }
  );
  connection.execSql(request);
  return "Created a new user"
}


module.exports = async function (context, req) {
  context.log('JavaScript HTTP trigger function processed a request.');

  if (req.query.name || (req.body && req.body.name)) {
      context.res = {
          // status: 200, /* Defaults to 200 */
          body: "Hello " + (req.query.name || req.body.name)
      };
  }
  else {
      context.res = {
          status: 400,
          body: "Please pass a name on the query string or in the request body"
      };
  }
};
