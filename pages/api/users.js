import { Pool } from 'pg';

// Configure PostgreSQL connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

export default async function handler(req, res) {
  try {
    // Query the current time from the database
    const result = await pool.query('SELECT NOW()');
    res.status(200).json({ message: 'Connected to PostgreSQL!', time: result.rows[0].now });
  } catch (error) {
    console.error('Error connecting to PostgreSQL:', error);
    res.status(500).json({ error: 'Database connection failed' });
  }
}
