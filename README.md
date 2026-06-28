# Klyr - Expense Tracker App

A full-stack expense tracking application with support for personal and shared group expenses. Track spending, split bills with friends, and manage settlements seamlessly.

## Features

### Core Features
- **Personal Expense Tracking** — Log and categorize individual expenses
- **Group Expenses** — Create groups and split expenses among members
- **Smart Splitting** — Support for equal splits, custom amounts, and percentage-based splits
- **Expense Categories** — 11 built-in categories (Food, Rent, Transport, Utilities, Entertainment, Shopping, Health, Education, Travel, Subscriptions, Other)
- **Multi-Currency Support** — Track expenses in different currencies (default: INR)
- **Settlement Tracking** — Keep records of who owes whom and settled amounts
- **User Profiles** — Personalized user profiles with authentication

### Authentication
- **Google OAuth 2.0** — Secure sign-in via Google accounts
- **JWT-based Sessions** — Token-based authentication for API requests
- **Refresh Tokens** — Automatic session refresh capability
- **Password Hashing** — Bcrypt for secure password handling

## Tech Stack

### Backend
- **Runtime**: Node.js with ES Modules
- **Framework**: Express.js 5.2+
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: Passport.js with Google OAuth 2.0
- **Security**: JWT, Bcrypt
- **Validation**: Zod schema validation
- **Caching**: Redis (Upstash) / ioRedis
- **Email**: Resend

### Frontend
- **Framework**: Flutter (Dart 3.7+)
- **State Management**: BLoC pattern with flutter_bloc
- **HTTP Client**: Dio
- **Routing**: GoRouter
- **Storage**: Flutter Secure Storage, SharedPreferences
- **UI Enhancements**: Shimmer for loading states

### Deployment Ready Components
- PostgreSQL adapter for Prisma
- Edge runtime support
- Multi-environment configuration

## Project Structure

```
klyr/
├── backend/                          # Node.js/Express backend
│   ├── src/
│   │   ├── modules/
│   │   │   ├── auth/                 # Authentication (Google OAuth, JWT)
│   │   │   ├── profile/              # User profile management
│   │   │   ├── personal expense/     # Personal expense logic
│   │   │   ├── group/                # Group creation and management
│   │   │   ├── group expense/        # Group expense splitting
│   │   │   └── home/                 # Dashboard/home endpoints
│   │   ├── configure/                # Database and app configuration
│   │   ├── middleware/               # Auth middleware
│   │   └── routes/                   # Route definitions
│   ├── prisma/
│   │   └── schema.prisma             # Database schema
│   ├── package.json
│   └── server.js                     # Entry point
│
└── frontend/
    └── klyr/                         # Flutter mobile app
        ├── lib/
        │   ├── data/
        │   │   ├── model/            # Data models
        │   │   └── repo/             # Repository layer (API calls)
        │   ├── domain/
        │   │   └── usecase/          # Business logic
        │   └── presentation/         # UI layer with BLoC
        └── pubspec.yaml
```

## Database Schema

### Core Models

**User**
- Stores user information and Google OAuth details
- Linked to sessions, profiles, expenses, and groups

**Profile**
- User personal information (name, email, phone)
- One-to-one relationship with User

**Expenses**
- Personal and group expenses
- Supports multiple currencies and split types
- Links to participants and groups

**Group**
- Manages shared groups for expense splitting
- Tracks members and settlements

**Expense_Participants**
- Tracks who owes what in each expense
- Supports settlement status

**Settlement**
- Records payments between group members
- Tracks amount and timestamp

**Group_Members**
- Manages membership in groups

## Getting Started

### Prerequisites
- Node.js 18+ and npm
- Flutter SDK 3.7+
- PostgreSQL 12+
- Google OAuth credentials
- (Optional) Redis/Upstash account

### Backend Setup

1. **Clone and install dependencies**
   ```bash
   cd backend
   npm install
   ```

2. **Configure environment variables**
   Create `.env` in the `backend` directory:
   ```env
   # Database
   DATABASE_URL=postgresql://user:password@localhost:5432/klyr

   # Server
   SERVER_PORT=3000

   # Google OAuth (get from Google Cloud Console)
   GOOGLE_CLIENT_ID_WEBAPP=your_client_id.apps.googleusercontent.com
   GOOGLE_CLIENT_SECRET=your_client_secret

   # JWT Secrets (generate random strings)
   JWT_ACCESS_SECRET=your_access_secret_key
   JWT_REFRESH_SECRET=your_refresh_secret_key

   # Optional: Redis/Caching
   REDIS_URL=redis://localhost:6379

   # Optional: Email Service
   RESEND_API_KEY=your_resend_key
   ```

3. **Setup database**
   ```bash
   npx prisma migrate dev
   # This creates tables and applies migrations
   ```

4. **Start the server**
   ```bash
   npm start
   ```
   Server runs on `http://localhost:3000`

### Frontend Setup

1. **Install dependencies**
   ```bash
   cd frontend/klyr
   flutter pub get
   ```

2. **Configure API endpoint**
   Update the API base URL in your repository configuration (typically in `lib/data/repo/`):
   ```dart
   const String API_BASE_URL = 'http://localhost:3003/klyr/api';
   ```

3. **Run the app**
   ```bash
   # For Android
   flutter run -d android

   # For iOS
   flutter run -d ios

   # For Web (if supported)
   flutter run -d chrome
   ```

## API Endpoints

### Authentication
- `POST /klyr/api/auth/login` — Login with Google OAuth
- `POST /klyr/api/auth/refresh` — Refresh access token
- `POST /klyr/api/auth/logout` — Logout

### Profile
- `GET /klyr/api/profile` — Get user profile
- `POST /klyr/api/profile` — Create/update profile
- `GET /klyr/api/profile/:id` — Get profile by ID

### Personal Expenses
- `GET /klyr/api/expense/personal` — List personal expenses
- `POST /klyr/api/expense/personal` — Create personal expense
- `GET /klyr/api/expense/personal/:id` — Get expense details
- `PUT /klyr/api/expense/personal/:id` — Update expense
- `DELETE /klyr/api/expense/personal/:id` — Delete expense

### Groups
- `GET /klyr/api/expense/group` — List user's groups
- `POST /klyr/api/expense/group` — Create new group
- `GET /klyr/api/expense/group/:id` — Get group details
- `POST /klyr/api/expense/group/:id/members` — Add group member

### Group Expenses
- `GET /klyr/api/expense/group/:id` — List group expenses
- `POST /klyr/api/expense/group/:id` — Create group expense

### Dashboard
- `GET /klyr/api/home` — Get home dashboard data

## Authentication Flow

1. User initiates Google OAuth login
2. Backend validates OAuth token from Google
3. Creates/retrieves user record
4. Issues JWT access token + refresh token
5. Client stores tokens securely (Flutter Secure Storage)
6. All subsequent API requests include `Authorization: Bearer <token>`
7. Tokens refresh automatically when expired

## Expense Splitting

### Split Types
- **EQUAL** — Split amount equally among all participants
- **CUSTOM** — Each participant specifies their share amount

### Example
Group expense of ₹300 split equally among 3 people:
- Each person's share: ₹100
- Paid by: Ayush
- Owed by: Ravi, Priya

## Running Both Servers Locally

### Terminal 1 - Backend
```bash
cd backend
npm start
```

### Terminal 2 - Frontend
```bash
cd frontend/klyr
flutter run
```

The app will connect to your local backend at `http://localhost:3003/klyr/api`.

## Development Workflow

### Adding Features
1. Update Prisma schema if needed: `backend/prisma/schema.prisma`
2. Create/migrate database: `npx prisma migrate dev --name feature_name`
3. Create controller in `backend/src/modules/feature/`
4. Create validator using Zod
5. Add routes in `backend/src/routes/`
6. Implement Flutter BLoC and UI in `frontend/klyr/lib/`
7. Test API with Postman/Insomnia

### Database Migrations
```bash
# Create new migration after schema changes
npx prisma migrate dev --name description

# View Prisma Studio
npx prisma studio

# Reset database (⚠️ deletes all data)
npx prisma migrate reset
```

## Deployment

### Backend Deployment (Vercel, Railway, Heroku)
1. Set environment variables on deployment platform
2. Ensure PostgreSQL database is accessible
3. Run migrations: `npx prisma migrate deploy`
4. Deploy Node.js app

### Frontend Deployment
1. Build APK/IPA: `flutter build apk` / `flutter build ios`
2. Upload to app stores or host on web: `flutter build web`

## Security Considerations

- ✅ JWT for stateless authentication
- ✅ Google OAuth for secure sign-in
- ✅ Bcrypt password hashing
- ✅ Secure token storage in Flutter
- ✅ Request validation with Zod
- ⚠️ Implement rate limiting
- ⚠️ Add API request signing for enhanced security

## Known Limitations & TODOs

- [ ] Add automated tests (unit & integration)
- [ ] Implement expense notifications
- [ ] Add expense history/analytics
- [ ] Export expense reports (CSV/PDF)
- [ ] Push notifications for settlements
- [ ] Transaction history with filters
- [ ] User-to-user payment requests
- [ ] Receipt image upload
- [ ] Recurring expenses
- [ ] Budget tracking

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add feature description'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

## License

This project is licensed under the ISC License - see the LICENSE file for details.

## Support & Contact

For issues, questions, or feature requests, please open an issue on [GitHub Issues](https://github.com/AyushMusale/Klyr/issues).

---

**Built by Ayush Musale**

[GitHub](https://github.com/AyushMusale) | [Repository](https://github.com/AyushMusale/Klyr)
