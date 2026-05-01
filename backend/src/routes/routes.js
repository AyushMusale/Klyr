import auth_router from "../services/auth/auth.router.js"
import { Router } from "express";
import profile_router from "../services/profile/profile.router.js";

const root_router = Router();
//root url: /klyr/api

root_router.use('/auth', auth_router);
root_router.use('/profile', profile_router )

export default root_router;