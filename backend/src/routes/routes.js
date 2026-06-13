import auth_router from "../modules/auth/auth.router.js";
import { Router } from "express";
import profile_router from "../modules/profile/profile.router.js";
import personal_Expense_router from "../modules/personal expense/personal.routes.js";
import group_creation_router from "../modules/group/group.creation.routes.js";
import group_expense_router from "../modules/group expense/group.expense.routes.js";
import home_router from "../modules/home/home.routes.js";

const root_router = Router();
//root url: /klyr/api

root_router.use("/auth", auth_router);
root_router.use("/profile", profile_router);
root_router.use("/home", home_router);
root_router.use("/expense/personal", personal_Expense_router);
root_router.use("/expense/group", group_creation_router);
root_router.use("/expense/group/:id", group_expense_router);

export default root_router;
