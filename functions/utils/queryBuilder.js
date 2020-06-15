const buildGetQuery = (count, id, tableName) => {
  let query = ''
  query = `SELECT ${count}
           FROM ${tableName}
           WHERE id = ${id}`
  return query
}

const buildCreateQuery = (user, tableName) => {
  let query = ''
  query = `INSERT ${user}
           FROM ${tableName}`
  return query
}

exports.buildGetQuery = buildGetQuery