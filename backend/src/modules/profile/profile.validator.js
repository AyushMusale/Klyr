import {z} from 'zod'

const profileSchema = z.object({
    user_id: z.string().min(1, "user id required").transform(Number),
    name: z.string().min(1, "name required"),
    email: z.string().email("invalid email"),
    phone_no: z.string().regex(/^\d{10,15}$/, "invalid phone number")
})

export default function profileValidator(req,res,next){
    const {user_id} = req.user
    const {name,email,phone_no} = req.body

    const data = {
        user_id :user_id,
        name : name,
        email: email,
        phone_no: phone_no
    }
    const result = profileSchema.safeParse(data);

    if(!result.success){
        const error  = result.error.issues[0].message
        return res.status(400).json({
            message: error
        })
    }

    req.data = result.data
    next()
}