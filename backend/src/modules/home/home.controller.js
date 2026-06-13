import { prisma } from "../../configure/db";

export async function getHomeSummary(req, res) {
  try {
    const user_id = req.user.user_id;
    const user_email = req.user.email;

    const personalExpenses = await prisma.expenses.findMany({
      select: {
        amount: true,
      },
      where: {
        user: {
          id: user_id,
        },
        group_id: null,
      },
    });

    const totalPersonalExpense = personalExpenses.reduce((sum, expense) => {
      return sum + Number(expense.amount);
    }, 0);

    const oweParticipants = await prisma.expense_Participants.findMany({
      select: {
        share_amount: true,
      },
      where: {
        user_email: user_email,
        is_settled: false,
        expense: {
          paid_by: { not: user_email },
          group_id: { not: null },
        },
      },
    });

    const totalOwe = oweParticipants.reduce(
      (sum, p) => sum + p.share_amount,
      0,
    );

    const owedParticipants = await prisma.expense_Participants.findMany({
      select: {
        share_amount: true,
      },
      where: {
        is_settled: false,
        user_email: { not: user_email },
        expense: {
          paid_by: user_email,
          group_id: { not: null },
        },
      },
    });

    const totalOwed = owedParticipants.reduce(
      (sum, p) => sum + p.share_amount,
      0,
    );

    return res.status(200).json({
      total_expense: totalPersonalExpense,
      total_owe: totalOwe,
      total_owed: totalOwed,
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}
