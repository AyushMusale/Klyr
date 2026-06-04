import { prisma } from "../../configure/db.js";

//group creation
//get group name from body, first member would be the creator itself
//can add member later

export async function createGroupController(req, res) {
  try {
    const { group_name, emails = [] } = req.body;
    const created_by = req.user.user_id;
    const creator_email = req.user.email;

    if (!group_name) {
      return res.status(400).json({ message: "group_name is required" });
    }
    const allEmails = [...new Set([creator_email, ...emails])];
    const group = await prisma.group.create({
      data: {
        group_name: group_name,
        created_by: created_by,
        groupMembers: {
          create: {
            user_email: allEmails.map((email) => ({ user_email: email })),
          },
        },
      },
      include: { groupMembers: true },
    });

    return res.status(201).json({ message: "group-created", group });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function addmemerstoGroupController(req, res) {
  try {
    const { group_id, emails } = req.body;

    if (!group_id || !emails?.length) {
      return res
        .status(400)
        .json({ message: "group_id and emails are required" });
    }
    const group = await prisma.group.findFirst({
      where: { group_id, created_by: req.user.user_id },
    });

    if (!group) return res.status(403).json({ message: "permission denied" });

    await prisma.group_Members.createMany({
      data: emails.map((email) => ({
        group_id: group_id,
        user_email: email,
      })),
      skipDuplicates: true,
    });

    return res.status(201).json({
      message: "members-added",
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function removemembersfromGroupController(req, res) {
  try {
    const { group_id, email } = req.body;
    const created_by = req.user.user_id;
    if (!group_id || !email) {
      return res
        .status(400)
        .json({ message: "group_id and emails are required" });
    }

    if (email === req.user.email) {
      return res.status(400).json({ message: "creator cannot be removed" });
    }

    const group = await prisma.group.findFirst({
      where: {
        group_id: group_id,
        created_by: created_by,
      },
    });

    if (!group) {
      return res.status(403).json({ message: "permission denied" });
    }
    await prisma.group_Members.delete({
      where: {
        group_id_user_email: {
          group_id: group_id,
          user_email: email,
        },
      },
    });

    return res.status(201).json({
      message: "members-removed",
    });
  } catch (e) {
    return res.status(500).json({
      message: "server-error",
    });
  }
}

export async function getGroupsController(req, res) {
  try {
    const user_email = req.user.email;
    const groups = await prisma.group.findMany({
      where: {
        groupMembers: {
          some: user_email,
        },
      },
      include: {
        groupMembers: false,
      },
    });
  } catch (e) {
    return res.status(500).json({ message: "server-error" });
  }
}

export async function getOneGroupController(req, res) {
  try {
    const { group_id } = req.body;
    const user_email = req.user.email;

    const group = await prisma.group.findFirst({
      where: {
        group_id: Number(group_id),
        groupMembers: { some: { user_email } },
      },
      include: {
        groupMembers: true,
      },
    });

    if (!group) return res.status(404).json({ message: "group not found" });

    return res.status(200).json({ group });
  } catch (e) {
    return res.status(500).json({ message: "server-error" });
  }
}

export async function leaveGroupController(req, res) {
  try {
  } catch (e) {
    return res.status(500).json({ message: "server-error" });
  }
}
