const { Request } = require("tedious");
const { createConnection } = require('../utils/createConnection')
const { buildCreateQuery } = require('../utils/queryBuilder')

function createUser() {
  console.log("Creating New User");
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
}