import { prisma } from "../../configure/db.js";

export async function createProfile(req, res) {
  try {
    //validated data from validator
    const data = req.data;

    //update if exist else create
    const profile = await prisma.profile.upsert({
      where: { user_id: data.user_id },
      update: {
        name: data.name,
        email: data.email,
        phone_no: data.phone_no,
      },
      create: {
        user_id: data.user_id,
        name: data.name,
        email: data.email,
        phone_no: data.phone_no,
      },
    });

    return res.status(200).json({   
      success: true,
      message: "profile-saved",
      profile,
    });
  } catch (e) {

    return res.status(500).json({
      success: false,
      message: "server-error",
    });
  }
}

export async function getProfile(req,res) {
  try{
    const user = req.user;

    const profile = await prisma.profile.findUnique({ 
      where: {
        user_id: user.user_id
      }
    });

    if(!profile){
      return res.status(404).json({
        success: false,
        message: 'no-profile-found',
        profile: null
      })
    }
    return res.status(200).json({
      success: true,
      message: 'profile-found',
      profile: profile
    })
  }catch(e){
    return res.status(500).json({
      success: false,
      message: 'server-error'
    })
  }
}