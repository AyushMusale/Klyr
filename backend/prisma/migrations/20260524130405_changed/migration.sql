/*
  Warnings:

  - You are about to drop the column `description` on the `Expenses` table. All the data in the column will be lost.
  - Added the required column `title` to the `Expenses` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Expenses" DROP COLUMN "description",
ADD COLUMN     "title" TEXT NOT NULL;
