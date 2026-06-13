//get group id, create expense, add expense to members provided, depending upon splitype

import { prisma } from "../../configure/db.js";

export async function createGroupExpenseController(req, res) {
  try {
    const {
      title,
      amount,
      category,
      currency = "INR",
      split_type = "EQUAL",
      paid_by,
      participants, 
    } = req.validatedData;

    const group_id = parseInt(req.params.id);

    const requester_email = req.user.email;

    if (!group_id || !title || !amount || !paid_by || !participants?.length) {
      return res.status(400).json({ message: "missing required fields" });
    }

    const isMember = await prisma.group_Members.findUnique({
      where: {
        group_id_user_email: { group_id, user_email: requester_email },
      },
    });
    if (!isMember)
      return res.status(403).json({ message: "permission denied" });

    
    const groupMembers = await prisma.group_Members.findMany({
      where: { group_id },
      select: { user_email: true },
    });
    const memberEmails = new Set(groupMembers.map((m) => m.user_email));

    const invalid = participants.filter((p) => !memberEmails.has(p.email));
    if (invalid.length) {
      return res.status(400).json({
        message: "some participants are not group members",
        invalid: invalid.map((p) => p.email),
      });
    }

    let participantData = [];

    if (split_type === "EQUAL") {
      const share = parseFloat((amount / participants.length).toFixed(2));
      participantData = participants.map((p) => ({
        email: p.email,
        share_amount: share,
      }));
    } else if (split_type === "CUSTOM") {
      const total = participants.reduce(
        (sum, p) => sum + (p.share_amount ?? 0),
        0,
      );
      if (Math.abs(total - amount) > 0.01) {
        return res.status(400).json({
          message: `share amounts must add up to ${amount}, got ${total}`,
        });
      }
      participantData = participants.map((p) => ({
        email: p.email,
        share_amount: p.share_amount,
      }));
    } else {
      return res
        .status(400)
        .json({ message: "invalid split_type, use EQUAL or CUSTOM" });
    }

    const expense = await prisma.$transaction(async (tx) => {
      const newExpense = await tx.expenses.create({
        data: {
          title,
          amount,
          category,
          currency,
          split_type,
          paid_by,
          group_id,
          created_by: req.user.user_id,
        },
      });

      await tx.expense_Participants.createMany({
        data: participantData.map((p) => ({
          expense_id: newExpense.expense_id,
          user_email: p.email,
          share_amount: p.share_amount,
          is_settled: p.email === paid_by,
        })),
      });

      return newExpense;
    });

    return res.status(201).json({ message: "expense-created", expense });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: "server-error" });
  }
}
