import { z } from "zod";

const ParticipantSchema = z.object({
  email: z.email(),
  share_amount: z.coerce.number().nonnegative(),
});

const Schema = z.object({
  amount: z.coerce.number().positive(),
  category: z.enum([
    "FOOD",
    "RENT",
    "TRANSPORT",
    "UTILITIES",
    "ENTERTAINMENT",
    "SHOPPING",
    "HEALTH",
    "EDUCATION",
    "TRAVEL",
    "SUBSCRIPTIONS",
    "OTHER",
  ]),
  title: z.string().max(255),
  currency: z.string().default("INR"),
  paid_by: z.email(),
  split_type: z.enum(["EQUAL", "CUSTOM"]),
  participants: z.array(ParticipantSchema).min(1),
});

export default function GroupexpenseValidator(req, res, next) {
  const result = Schema.safeParse(req.body);
  if (!result.success) {
    const error = result.error.issues[0].message;
    return res.status(400).json({
      message: error,
    });
  }

  req.validatedData = result.data;
  next();
}
