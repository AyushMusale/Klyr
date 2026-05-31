import express from "express";
import { authmiddleware } from "../auth/auth.middleware.js";
import { addmemerstoGroupController, createGroupController, removemembersfromGroupController } from "./group.creation.controller.js";

const group_creation_router = new express.Router();

group_creation_router.post("/create", authmiddleware, createGroupController);
group_creation_router.post('/add', authmiddleware, addmemerstoGroupController);
group_creation_router.post('/remove', authmiddleware, removemembersfromGroupController);

export default group_creation_router;
