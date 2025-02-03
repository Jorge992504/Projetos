import "dotenv/config.js";

import pgk from 'pg';

const { Pool } = pgk;

/**
 * @type {Client}
 */
let pool;

function getPool() {
    if (!pool) {
        pool = new Pool({
            user: process.env.PG_USER,      // substitua pelo seu usuário do PostgreSQL
            host: process.env.PG_HOST,        // ou o host do seu banco de dados
            database: process.env.PG_DATABASE,    // substitua pelo nome do seu banco de dados
            password: process.env.PG_PASSWORD,    // substitua pela sua senha do PostgreSQL
            port: process.env.PG_PORT,               // porta padrão do PostgreSQL
            max: 20,                  // número máximo de conexões no pool
            idleTimeoutMillis: 30000, // tempo que uma conexão pode ficar ociosa antes de ser fechada (em milissegundos)
            connectionTimeoutMillis: 2000, // tempo máximo para tentar estabelecer uma nova conexão (em milissegundos)
            keepAlive: true,
        });
    }
    return pool;
}

export default getPool();