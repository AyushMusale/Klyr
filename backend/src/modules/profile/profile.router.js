import {Router} from 'express'
import { authmiddleware } from '../auth/auth.middleware.js';
import profileValidator from './profile.validator.js';
import { createProfile, getProfile } from './profile.controller.js';

const profile_router = new Router();
// route: /klyr/api/profile

profile_router.post('/',authmiddleware,profileValidator, createProfile);
profile_router.get('/',authmiddleware,getProfile);


export default profile_router;