/*
  Warnings:

  - You are about to drop the column `user_id` on the `Expense_Participants` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[expense_id,user_email]` on the table `Expense_Participants` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_email` to the `Expense_Participants` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SplitType" AS ENUM ('EQUAL', 'CUSTOM', 'PERCENT');

-- DropForeignKey
ALTER TABLE "Expense_Participants" DROP CONSTRAINT "Expense_Participants_user_id_fkey";

-- DropIndex
DROP INDEX "Expense_Participants_expense_id_user_id_key";

-- AlterTable
ALTER TABLE "Expense_Participants" DROP COLUMN "user_id",
ADD COLUMN     "user_email" TEXT NOT NULL,
ALTER COLUMN "is_settled" SET DEFAULT false;

-- AlterTable
ALTER TABLE "Expenses" ADD COLUMN     "split_type" "SplitType" NOT NULL DEFAULT 'EQUAL';

-- CreateTable
CREATE TABLE "Settlement" (
    "id" SERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "paid_by" TEXT NOT NULL,
    "paid_to" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Settlement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Expense_Participants_expense_id_user_email_key" ON "Expense_Participants"("expense_id", "user_email");

-- AddForeignKey
ALTER TABLE "Settlement" ADD CONSTRAINT "Settlement_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "Group"("group_id") ON DELETE RESTRICT ON UPDATE CASCADE;
