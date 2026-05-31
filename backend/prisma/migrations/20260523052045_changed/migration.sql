/*
  Warnings:

  - You are about to drop the column `user_id` on the `Group_Members` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[group_id,user_email]` on the table `Group_Members` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_email` to the `Group_Members` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Group_Members" DROP CONSTRAINT "Group_Members_user_id_fkey";

-- DropIndex
DROP INDEX "Group_Members_group_id_user_id_key";

-- AlterTable
ALTER TABLE "Group_Members" DROP COLUMN "user_id",
ADD COLUMN     "user_email" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Group_Members_group_id_user_email_key" ON "Group_Members"("group_id", "user_email");
