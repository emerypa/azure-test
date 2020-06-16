const { Request } = require("tedious");
const { createConnection } = require('../utils/createConnection')
const { buildCreateQuery } = require('../utils/queryBuilder')

const getUser = async function (context, req) {
  context.log("Getting New User");
  let user = {
    id: 2
  }
  const connection = createConnection();
  const query = buildGetQuery(1, req.id, 'users')
  const request = new Request(query,
    (err, rowCount) => {
      if (err) {
        context.error(err.message);
      } else {
        context.log(`${rowCount} row(s) returned`);
      }
    }
  );

  connection.execSql(request);
  return user;
}

module.exports = async function (context, req) {
  context.log('JavaScript HTTP trigger function processed a request.');

  if (req.query.name || (req.body && req.body.name)) {
      const user = await getUser(req.body.id)
      context.res = {
          status: 200,
          body: `Hello ${(req.query.name || req.body.name)} id is ${user.id} }`
      };
  }
  else {
      context.res = {
          status: 400,
          body: "Please pass a name on the query string or in the request body"
      };
  }
};