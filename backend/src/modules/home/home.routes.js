import { Router } from "express";
import { getHomeSummary } from "./home.controller.js";
import { authmiddleware } from "../auth/auth.middleware.js";

const home_router = new Router();

home_router.get("/", authmiddleware, getHomeSummary);


export default home_router;