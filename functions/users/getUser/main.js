const { Request } = require("tedious");
const { createConnection } = require('../utils/createConnection')
const { buildCreateQuery } = require('../utils/queryBuilder')

function getUser(id) {
  console.log("Getting New User");
  const connection = createConnection();
  const query = buildGetQuery(1, id, 'users')
  const request = new Request(query,
    (err, rowCount) => {
      if (err) {
        console.error(err.message);
      } else {
        console.log(`${rowCount} row(s) returned`);
      }
    }
  );

  request.on("row", columns => {
    columns.forEach(column => {
      console.log("%s\t%s", column.metadata.colName, column.value);
    });
  });

  connection.execSql(request);
}