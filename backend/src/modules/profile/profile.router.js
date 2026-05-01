import {Router} from 'express'
import { authmiddleware } from '../auth/auth.middleware';
import profileValidator from './profile.validator';
import { createProfile } from './profile.controller';

const profile_router = new Router();
// route: /klyr/profile

profile_router.post('/',authmiddleware,profileValidator, createProfile);


export default profile_router;