# MERN POS Backend Scaffold

A starter backend for a POS system built with Node/Express and MongoDB (Mongoose).

## Quickstart

1. Copy `.env.example` to `.env` and fill values.
2. `npm install`
3. `npm run dev` (requires nodemon) or `npm start`
4. Optionally seed sample data: `node src/utils/seed.js --seed`

## Notes & Next Steps

- Payment gateway integrations (card/ewallet) are represented as payloads; integrate provider SDKs (Stripe, Midtrans, GCash API, etc.) as needed.
- Add validation (Joi or express-validator) and rate limiting for production.
- Add tests, logging, and production-friendly configuration.
