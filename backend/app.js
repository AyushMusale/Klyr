import express from "express";

const app = express();

app.use(express.json());

export default async function init() {
  const PORT = process.env.SERVER_PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server Started on ${PORT}`);
  });
}
