import { prisma } from "../../configure/db.js";

//group creation
//get group name from body, first member would be the creator itself
//can add member later

export async function createGroupController(req, res) {
  try {
    const { group_name } = req.body;
    const created_by = req.user.id;

    if (!group_name) {
      return res.status(400).json({ message: "group_name is required" });
    }

    const group = await prisma.group.create({
      data: {
        group_name: group_name,
        created_by: created_by,
        groupMembers: {
          create: {
            user_id: created_by,
          },
        },
      },
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

    await prisma.group_Members.createMany({
      data: emails.map((emails) => ({
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
    const created_by = req.user.id;
    if (!group_id || !email) {
      return res
        .status(400)
        .json({ message: "group_id and emails are required" });
    }

    const group = await prisma.group.findFirst({
      where: {
        group_id: group_id,
        created_by: created_by,
      },
    });

		if(!group){
			return res
        .status(402)
        .json({ message: "permission denied" });
		}

    await prisma.group_Members.delete({
      where: {
        group_id: group_id,
        user_email: email,
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
