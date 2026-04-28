# Klyr

Klyr is an expense tracker app with a Flutter frontend and a Node.js/Express backend.

## Stack

- Flutter
- Node.js and Express
- Prisma with PostgreSQL
- Passport Google OAuth

## Setup

### Backend

```bash
cd backend
npm install
npx prisma migrate dev
npm start
```

Create a `.env` file in `backend` with the required database and auth values:

```env
DATABASE_URL=
SERVER_PORT=3000
GOOGLE_CLIENT_ID_WEBAPP=
GOOGLE_CLIENT_SECRET=
```

### Frontend

```bash
cd frontend/klyr
flutter pub get
flutter run
```

## Notes

Authentication is based on [Auth-Template](https://github.com/AyushMusale/Auth-Template).
