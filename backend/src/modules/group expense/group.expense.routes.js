import express from "express";
import { authmiddleware } from "../auth/auth.middleware.js";
import { createGroupExpenseController } from "./group.expense.controller.js";
import GroupexpenseValidator from "./group.expense.validator.js";

const group_expense_router = new express.Router({ mergeParams: true });

//root url: /klyr/api/expense/group/:id/

group_expense_router.post(
  "/create-expense",
  authmiddleware,
  GroupexpenseValidator,
  createGroupExpenseController,
);

export default group_expense_router;
