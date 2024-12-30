import { Client } from 'pg';

export default async function handler(req, res) {
  const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'mydb',
    password: 'newpassword',
    port: 5432,
  });

  await client.connect();
  const result = await client.query('SELECT NOW()');
  await client.end();

  res.status(200).json({ time: result.rows[0].now });
}
