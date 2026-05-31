import express from "express";
import {
  verifyEmailController,
  requestOTPController,
} from "./auth.controller.js";
import passport from "passport";
import { googleTokens } from "./auth.controller.js";
import { refreshUserController } from "./auth.middleware.js";

const auth_router = express.Router();
//klyr/api/auth

auth_router.post("/get-otp", requestOTPController);
auth_router.post("/verify", verifyEmailController);
auth_router.post("/refersh", refreshUserController);
auth_router.get(
  "/google",
  passport.authenticate("google", {
    scope: ["profile", "email"],
  }),
);
auth_router.get(
  "/google/callback",
  passport.authenticate("google", { session: false }),
  googleTokens,
);

export default auth_router;
