const { Connection } = require("tedious");

// Create connection to database
const createConnection = () => {
  const config = {
    authentication: {
      options: {
        userName: process.env.sql_admin_user
        password: process.env.sql_admin_pass
        type: "default"
      },
      server: process.env_sql_server_address
      options: {
        database: process.env.sql_database_name
        encrypt: true
      }
    }
  }
  const connection = new Connection(config);
  return connection;
}

