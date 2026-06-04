import { z } from "zod";

const Schema = z.object({
  group_id: z.string().transform(Number),
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
  participants: z.array(),
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
