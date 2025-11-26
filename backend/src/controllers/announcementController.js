import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Path to the JSON file (Go up 2 levels from controllers/src to backend root)
const filePath = path.join(__dirname, '../../announcement.json');

// Get the current announcement
export const getAnnouncement = (req, res) => {
  try {
    if (!fs.existsSync(filePath)) {
      return res.json({ message: '' });
    }
    const data = fs.readFileSync(filePath, 'utf8');
    res.json(JSON.parse(data));
  } catch (error) {
    console.error("Error reading announcement:", error);
    res.status(500).json({ message: 'Error reading announcement' });
  }
};

// Update the announcement
export const updateAnnouncement = (req, res) => {
  try {
    const { message } = req.body;
    fs.writeFileSync(filePath, JSON.stringify({ message }));
    res.json({ success: true, message });
  } catch (error) {
    console.error("Error saving announcement:", error);
    res.status(500).json({ message: 'Error saving announcement' });
  }
};