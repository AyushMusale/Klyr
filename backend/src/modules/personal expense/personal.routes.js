import express from "express";

import { authmiddleware } from "../auth/auth.middleware.js";
import expenseValidator from "./personal.validator.js";
import {
  deletePersonalExpenseController,
  editPersonalExpenseController,
  getExpenseById,
  getPersonalExpenseController,
  personalExpenseCreateController,
} from "./personal.controller.js";

const personal_Expense_router = express.Router();

//url: /klyr/api/expense/personal
personal_Expense_router.get("/", authmiddleware, getPersonalExpenseController);
personal_Expense_router.post(
  "/create",
  authmiddleware,
  expenseValidator,
  personalExpenseCreateController,
);
personal_Expense_router.delete(
  "/:id",
  authmiddleware,
  deletePersonalExpenseController,
);
personal_Expense_router.put(
  "/:id",
  authmiddleware,
  expenseValidator,
  editPersonalExpenseController,
);
personal_Expense_router.get("/:id", authmiddleware, getExpenseById);

export default personal_Expense_router;
