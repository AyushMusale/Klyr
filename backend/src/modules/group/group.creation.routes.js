import express from "express";
import { authmiddleware } from "../auth/auth.middleware.js";
import {
  addmemerstoGroupController,
  createGroupController,
  getGroupsController,
  getOneGroupController,
  removemembersfromGroupController,
} from "./group.creation.controller.js";

const group_creation_router = new express.Router();
//root url: /klyr/api/expense/group
group_creation_router.post("/create", authmiddleware, createGroupController);
group_creation_router.post("/add", authmiddleware, addmemerstoGroupController);
group_creation_router.post(
  "/remove",
  authmiddleware,
  removemembersfromGroupController,
);
group_creation_router.get("/get", authmiddleware, getGroupsController);
group_creation_router.get("/get-one/:id", authmiddleware, getOneGroupController);

export default group_creation_router;
