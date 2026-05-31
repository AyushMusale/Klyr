import { prisma } from "../../configure/db.js";

export async function personalExpenseCreateController(req, res) {
  try {
    const { amount, category, title, currency, created_at } = req.validatedData;
    const created_by = req.user.user_id; // from auth middleware

    const Expense = await prisma.expenses.create({
      //create the personal expense
      data: {
        amount: amount,
        category: category,
        title: title,
        created_by: created_by,
        group_id: null,
        currency: currency,
        created_at: created_at,
      },
    });

    return res.status(201).json({
      message: "expense added",
    });
  } catch (e) {
    console.log(e);
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function getPersonalExpenseController(req, res) {
  try {
    const created_by = req.user.user_id;

    const personalExpenses = await prisma.expenses.findMany({
      where: {
        created_by: created_by,
        group_id: null,
      },
      orderBy: {
        created_at: "desc",
      },
    });
    return res.status(200).json({
      message: "success",
      personalExpenses,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function editPersonalExpenseController(req, res) {
  try {
    const { amount, category, title, currency } = req.validatedData;
    const expense_id = parseInt(req.params.id);
    const created_by = req.user.user_id;

    const expense = await prisma.expenses.findFirst({
      where: {
        expense_id: expense_id,
        created_by: created_by,
      },
    });

    if (!expense) {
      return res.status(404).json({ message: "expense-not-found" });
    }

    await prisma.expenses.update({
      where: {
        expense_id: expense_id,
        created_by: created_by,
      },
      data: {
        amount: amount,
        category: category,
        title: title,
        created_by: created_by,
        group_id: null,
        currency: currency,
      },
    });
    return res.status(200).json({
      message: "expense updated",
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function deletePersonalExpenseController(req, res) {
  try {
    const expense_id = parseInt(req.params.id);
    const created_by = req.user.user_id;

    const expense = await prisma.expenses.findFirst({
      where: {
        expense_id: expense_id,
        created_by: created_by,
      },
    });

    if (!expense) {
      return res.status(404).json({ message: "expense-not-found" });
    }

    await prisma.expenses.delete({
      where: {
        expense_id: expense_id,
        created_by: created_by,
      },
    });

    return res.status(200).json({
      message: "expense deleted",
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

// get expense from id
export async function getExpenseById(req, res) {
  try {
    const expense_id = parseInt(req.params.id);
    const requsest_by = req.user.user_id;

    const expense = await prisma.expenses.findFirst({
      where: {
        expense_id: expense_id,
        created_by: requsest_by,
      },
    });

    if (!expense) {
      return res.status(404).json({
        message: "expense not found",
      });
    }

    return res.status(200).json({
      message: "success",
      expense,
    });
  } catch (e) {
    
    console.log(e);
    return res.status(500).json({
      message: "server-error",
    });
  }
}
